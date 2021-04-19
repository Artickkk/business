// —— CREDITOS
// — Artic, 19/Abril

// —— ADMINISTRATIVOS
CMD:adminempresa(playerid, params[])
{
	if (sscanf(params, "s[32]", params)) 
		return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa [crear - borrar - editar]");

	if (!strcmp(params, "crear", true, 5))
	{
		new freeid = SearchFreeBusinessID();
		if (freeid == INVALID_ID)
			return SendClientMessage(playerid, 0x942B15FF, "No hay mas slots.");

		Business_Info[freeid][business_valid] = true;
		GetPlayerPos(playerid, Business_Info[freeid][business_ExtX], Business_Info[freeid][business_ExtY], Business_Info[freeid][business_ExtZ]);
		Business_Info[freeid][business_ExtInterior] = GetPlayerInterior(playerid);
		Business_Info[freeid][business_ExtWorld] = GetPlayerVirtualWorld(playerid);

		SetBusinessDefaultValues(freeid);
		new string[80];
		format(string, sizeof string, "Creaste una empresa con éxito. (/adminempresa editar %d)", freeid);
		SendClientMessage(playerid, 0x9D2121FF, string);

		format(string, sizeof string, "Editaste una empresa. {D17145}(Precio: %d, ID: %d)", cant, business);
		SendClientMessage(playerid, 0xD1CCE7FF, string);

	}
	else if (!strcmp(params, "borrar", true, 6))
	{
		new business;
		if (sscanf(params, "s[6]i", params, business)) 
			return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa borrar [ID]");

		if (business > MAX_BUSINESS)
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
		new business, type_s[12];
		if (sscanf(params, "s[32]is[12]", params, business, type_s)) 
			return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa editar [ID] [Exterior - interior - precio - tipo]");	

		if (business > MAX_BUSINESS)
			return SendClientMessage(playerid, 0x942B15FF, "ID inválida");

		if (!Business_Info[business][business_valid])
			return SendClientMessage(playerid, 0x942B15FF, "ID inválida");			

		if (!strcmp(type_s, "interior", true, 8))
		{
			GetPlayerPos(playerid, Business_Info[business][business_IntX], Business_Info[business][business_IntY], Business_Info[business][business_IntZ]);
			Business_Info[business][business_IntInterior] = GetPlayerInterior(playerid);
			Business_Info[business][business_IntWorld] = GetPlayerVirtualWorld(playerid);
			UpdateBusinessLabel(business, true);

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
			UpdateBusinessLabel(business);

			new string[80];
			format(string, sizeof string, "Editaste una empresa. {D17145}(Tipo: %s, ID: %d)", GetBusinessType(type), business);
			SendClientMessage(playerid, 0xD1CCE7FF, string);
		}
		else return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa editar [ID] [Exterior - interior - precio - tipo]");	
	}
	else return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /adminempresa [crear - borrar - editar]");
	return 1;
}

CMD:tiposempresa(playerid)
{
	// — iteración sobre el enum, para automatizar según la cantidad de tipos.
	new str[20], totalstr[144];
	SendClientMessage(playerid, 0xD9D361FF, "TIPOS DE EMPRESAS");
	for (new i; i < sizeof enum_business_types; i++) 
	{
		format(str, sizeof str, "— %d. %s ", i, GetBusinessType(i));
		strcat(totalstr, str);
	}
	SendClientMessage(playerid, 0xD9D361FF, totalstr);
	return 1;
}
