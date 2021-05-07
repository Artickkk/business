// —— CREDITOS
// — Artic, 19/Abril

// —— ADMINISTRATIVOS
CMD:adminempresa(playerid, params[])
{
	if (!IsPlayerAdmin(playerid))
		return 0;

	if (sscanf(params, "s[32]", params)) 
		return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa [crear - borrar - editar]");

	if (!strcmp(params, "crear", true, 5))
	{
		new freeid = SearchFreeBusinessID();
		if (freeid == INVALID_BUSINESS_ID)
			return SendClientMessage(playerid, 0x942B15FF, "No hay mas slots.");

		SetBusinessDefaultValues(freeid);

		GetPlayerPos(playerid, Business_Info[freeid][business_ExtX], Business_Info[freeid][business_ExtY], Business_Info[freeid][business_ExtZ]);
		Business_Info[freeid][business_ExtInterior] = GetPlayerInterior(playerid);
		Business_Info[freeid][business_ExtWorld] = GetPlayerVirtualWorld(playerid);

		UpdateBusinessLabel(freeid, true);
		Business_Info[freeid][business_valid] = true;

		CreateBusiness(freeid);
		total_business++;

		new string[80];
		format(string, sizeof string, "Creaste una empresa. {D17145}(/adminempresa editar %d)", freeid);
		SendClientMessage(playerid, 0xD1CCE7FF, string);
	}
	else if (!strcmp(params, "borrar", true, 6))
	{
		new business;
		if (sscanf(params, "s[12]i", params, business)) 
			return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa borrar [ID]");

		if (business > total_business)
			return SendClientMessage(playerid, 0x942B15FF, "ID inválida");

		if (!Business_Info[business][business_valid])
			return SendClientMessage(playerid, 0x942B15FF, "ID inválida");			

		DestroyBusiness(business);
		new string[80];
		format(string, sizeof string, "Borraste una empresa. (/adminempresa borrar %d)", business);
		SendClientMessage(playerid, 0x9D2121FF, string);
	}
	else if (!strcmp(params, "editar", true, 6))
	{
		new business, type_s[25];
		if (sscanf(params, "s[32]is[25]", params, business, type_s)) 
			return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa editar [ID] [Exterior - interior - precio - tipo - mapicon]");	

		if (business > total_business)
			return SendClientMessage(playerid, 0x942B15FF, "ID inválida");

		if (!Business_Info[business][business_valid])
			return SendClientMessage(playerid, 0x942B15FF, "ID inválida");			

		if (!strcmp(type_s, "interior", true, 8))
		{
			GetPlayerPos(playerid, Business_Info[business][business_IntX], Business_Info[business][business_IntY], Business_Info[business][business_IntZ]);
			Business_Info[business][business_IntInterior] = GetPlayerInterior(playerid);
			Business_Info[business][business_IntWorld] = GetPlayerVirtualWorld(playerid);
			UpdateBusinessLabel(business, true);

			new query[150];
			mysql_format(handle_business, query, sizeof query, "UPDATE business SET int_x = %f, int_y = %f, int_z = %f, int_interior = %d, int_world = %d WHERE ID = %d;", 
				Business_Info[business][business_IntX], Business_Info[business][business_IntY], Business_Info[business][business_IntZ],
				Business_Info[business][business_IntInterior], Business_Info[business][business_IntWorld], Business_Info[business][business_ID]
			);
			mysql_tquery(handle_business, query);

			new string[80];
			format(string, sizeof string, "Editaste una empresa. {D17145}(Interior, ID: %d)", business);
			SendClientMessage(playerid, 0xD1CCE7FF, string);
		}
		else if (!strcmp(type_s, "exterior", true, 8))
		{
			GetPlayerPos(playerid, Business_Info[business][business_ExtX], Business_Info[business][business_ExtY], Business_Info[business][business_ExtZ]);
			Business_Info[business][business_ExtInterior] = GetPlayerInterior(playerid);
			Business_Info[business][business_ExtWorld] = GetPlayerVirtualWorld(playerid);
			UpdateBusinessLabel(business, true);

			new query[150];
			mysql_format(handle_business, query, sizeof query, "UPDATE business SET ext_x = %f, ext_y = %f, ext_z = %f, ext_interior = %d, ext_world = %d WHERE ID = %d;", 
				Business_Info[business][business_ExtX], Business_Info[business][business_ExtY], Business_Info[business][business_ExtZ],
				Business_Info[business][business_ExtInterior], Business_Info[business][business_ExtWorld], Business_Info[business][business_ID]
			);
			mysql_tquery(handle_business, query);

			new string[80];
			format(string, sizeof string, "Editaste una empresa. {D17145}(Exterior, ID: %d)", business);
			SendClientMessage(playerid, 0xD1CCE7FF, string);
		}
		else if (!strcmp(type_s, "precio", true, 6))
		{
			new cant;
			if (sscanf(type_s, "s[6]i", type_s, cant)) 
				return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa editar [ID] precio [cantidad]");				

			if (cant > 1000000)
				return SendClientMessage(playerid, 0x942B15FF, "Precio no mayor a $1,000,000.");

			Business_Info[business][business_price] = cant;
			new query[60];
			mysql_format(handle_business, query, sizeof query, "UPDATE business SET price = %d WHERE ID = %d;", Business_Info[business][business_price], Business_Info[business][business_ID]);
			mysql_tquery(handle_business, query);

			new string[80];
			format(string, sizeof string, "Editaste una empresa. {D17145}(Precio: %d, ID: %d)", cant, business);
			SendClientMessage(playerid, 0xD1CCE7FF, string);
		}
		else if (!strcmp(type_s, "tipo", true, 4))
		{
			new type;
			if (sscanf(type_s, "s[6]i", type_s, type)) 
				return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa editar [ID] tipo [número (/tiposempresa)]");				

			if (type > BUSINESS_ASEGURADOR)
				return SendClientMessage(playerid, 0x942B15FF, "Número muy grande.");

			if (type < BUSINESS_MECHANIC)
				return SendClientMessage(playerid, 0x942B15FF, "Número muy pequeño.");

			Business_Info[business][business_type] = type;
			new query[60];
			mysql_format(handle_business, query, sizeof query, "UPDATE business SET type = %d WHERE ID = %d;", Business_Info[business][business_type], Business_Info[business][business_ID]);
			mysql_tquery(handle_business, query);

			UpdateBusinessLabel(business);

			new string[80];
			format(string, sizeof string, "Editaste una empresa. {D17145}(Tipo: %s, ID: %d)", GetBusinessType(type), business);
			SendClientMessage(playerid, 0xD1CCE7FF, string);
		}
		else if (!strcmp(type_s, "mapicon", true, 7))
		{
			new mapicon;
			if (sscanf(type_s, "s[10]i", type_s, mapicon))
				return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa editar [ID] mapicon [número]");

			Business_Info[business][business_iconid] = mapicon;
			new query[60];
			mysql_format(handle_business, query, sizeof query, "UPDATE business SET mapicon = %d WHERE ID = %d;", Business_Info[business][business_iconid], Business_Info[business][business_ID]);
			mysql_tquery(handle_business, query);
			UpdateBusinessLabel(business);
		}
		else return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa editar [ID] [Exterior - interior - precio - tipo]");	
	}
	else return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa [crear - borrar - editar]");
	return 1;
}

CMD:tiposempresa(playerid)
{
	if (!IsPlayerAdmin(playerid))
		return 0;

	// — iteración sobre el enum, para automatizar según la cantidad de tipos.
	new str[30], totalstr[144];
	SendClientMessage(playerid, 0xD9D361FF, "TIPOS DE EMPRESAS");
	for (new i = 1; i < BUSINESS_INVALID; i++) 
	{
		format(str, sizeof str, "— %d. %s ", i, GetBusinessType(i));
		strcat(totalstr, str);
	}
	SendClientMessage(playerid, 0xD9D361FF, totalstr);
	return 1;
}

CMD:empresas(playerid)
{
	new totalstr[2048], string[80], count = 0;
	for(new i = 0; i < MAX_BUSINESS; i++ ) TempBusiness[playerid][tbusiness_listitem][i] = -1;

	for (new i; i < total_business; i++) if (Business_Info[i][business_valid])
	{
		format(string, sizeof string, "{C0C0C0}(%d) %s\t%s\n", i, GetBusinessType(Business_Info[i][business_type]), (Business_Info[i][business_owner]) ? ("{E81700}Comprada") : ("{54C822}En venta"));
		strcat(totalstr, string);
		TempBusiness[playerid][tbusiness_listitem][count] = i;
		count++;
	}
	if (!count)
		return SendClientMessage(playerid, 0x9D2121FF, "No hay empresas creadas.");

	#if defined _easyDialog_included
		Dialog_Show(playerid, ShowBusiness, DIALOG_STYLE_TABLIST, "Empresas", totalstr, "Aceptar", "");
	#else
		ShowPlayerDialog(playerid, DIALOG_BUSINESS, DIALOG_STYLE_TABLIST, "Empresas", totalstr, "Aceptar", "");
	#endif 
	return 1;
}

// —— LIDER
CMD:invitar(playerid, params[])
{
	new business = GetPlayerBusiness(playerid);

	if (business == INVALID_BUSINESS_ID)
		return 1;

	if (!IsPlayerOwner(playerid, business))
		return 1;

	if (sscanf(params, "ui", params[0], params[1]))
		return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /invitar (playerid)");

	if (!IsPlayerConnected(params[0]) || params[0] == playerid)
		return SendClientMessage(playerid, 0x9D2121FF, "Jugador inválido.");

	if (GetPlayerBusiness(params[0]) != INVALID_BUSINESS_ID)
		return SendClientMessage(playerid, 0x9D2121FF, "El jugador ya trabaja para una empresa.");

	PlayerBusiness[params[0]][player_rank] = 1;
	PlayerBusiness[params[0]][player_employee] = business;

	return 1;
}

CMD:darcargo(playerid, params[])
{
	new business = GetPlayerBusiness(playerid);

	if (business == INVALID_BUSINESS_ID)
		return 1;

	if (!IsPlayerOwner(playerid, business))
		return 1;

	if (sscanf(params, "ui", params[0], params[1]))
		return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /darcargo (playerid) (rango)");

	if (!IsPlayerConnected(params[0]) || params[0] == playerid)
		return SendClientMessage(playerid, 0x9D2121FF, "Jugador inválido.");

	if (GetPlayerBusiness(params[0]) != business)
		return SendClientMessage(playerid, 0x9D2121FF, "El jugador no trabaja para tí.");

	if (params[1] > Business_Info[business][business_maxranks])
		return SendClientMessage(playerid, 0x9D2121FF, "Rango inválido.");

	if (params[1] == 0)
	{
		PlayerBusiness[params[0]][player_rank] = 0;
		PlayerBusiness[params[0]][player_employee] = INVALID_BUSINESS_ID;
		SendClientMessage(params[0], 0x9D2121FF, "Fuiste despedido.");
	}
	else
	{
		PlayerBusiness[params[0]][player_rank] = params[1];
		SendClientMessage(params[0], 0xC0C0C0FF, "Te han dado otro cargo.");
		SendClientMessage(playerid, 0xC0C0C0FF, "Asignaste un cargo a un empleado.");
	}
	return 1;
}

// —— GENERALES
CMD:entrar(playerid)
{
	new info_bizz[2];
	Streamer_GetArrayData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_EXTRA_ID, info_bizz);

	if (info_bizz[0] == PICKUP_NONE_BIZZ || info_bizz[0] != PICKUP_EXTERIOR_BIZZ) // — Tiene k estar en el exterior
		return 1;

	new Float:bizzX, Float:bizzY, Float:bizzZ;
	Streamer_GetFloatData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_X, bizzX);
	Streamer_GetFloatData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_Y, bizzY);
	Streamer_GetFloatData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_Z, bizzZ);
	new bizzVW = Streamer_GetIntData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_WORLD_ID);
	new bizzINT = Streamer_GetIntData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_INTERIOR_ID);

	if (!IsPlayerInRangeOfPoint(playerid, 5.0, bizzX, bizzY, bizzZ) && GetPlayerInterior(playerid) != bizzINT && GetPlayerVirtualWorld(playerid) != bizzVW)
		return 1;

	if (Business_Info[info_bizz[1]][business_IntX] == 0.0)
		return SendClientMessage(playerid, 0x9D2121FF, "La empresa no tiene interior.");

	SetPlayerPos(playerid, Business_Info[info_bizz[1]][business_IntX], Business_Info[info_bizz[1]][business_IntY], Business_Info[info_bizz[1]][business_IntZ]);
	SetPlayerInterior(playerid, Business_Info[info_bizz[1]][business_IntInterior]);
	SetPlayerVirtualWorld(playerid, Business_Info[info_bizz[1]][business_IntWorld]);
	return 1;
}

CMD:salir(playerid)
{
	new info_bizz[2];
	Streamer_GetArrayData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_EXTRA_ID, info_bizz);

	if (info_bizz[0] == PICKUP_NONE_BIZZ || info_bizz[0] != PICKUP_INTERIOR_BIZZ) // — Tiene k estar en interior
		return 1;

	new Float:bizzX, Float:bizzY, Float:bizzZ;
	Streamer_GetFloatData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_X, bizzX);
	Streamer_GetFloatData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_Y, bizzY);
	Streamer_GetFloatData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_Z, bizzZ);
	new bizzVW = Streamer_GetIntData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_WORLD_ID);
	new bizzINT = Streamer_GetIntData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_INTERIOR_ID);

	if (!IsPlayerInRangeOfPoint(playerid, 5.0, bizzX, bizzY, bizzZ) && GetPlayerInterior(playerid) != bizzINT && GetPlayerVirtualWorld(playerid) != bizzVW)
		return 1;

	SetPlayerPos(playerid, Business_Info[info_bizz[1]][business_ExtX], Business_Info[info_bizz[1]][business_ExtY], Business_Info[info_bizz[1]][business_ExtZ]);
	SetPlayerInterior(playerid, Business_Info[info_bizz[1]][business_ExtInterior]);
	SetPlayerVirtualWorld(playerid, Business_Info[info_bizz[1]][business_ExtWorld]);
	return 1;
}
