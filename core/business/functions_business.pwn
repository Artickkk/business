// —— CREDITOS
// — Artic, 18/Abril

// —— PUBLIC CALLBACKS
public OnGameModeInit()
{
	
	handle_business = mysql_connect("localhost", "root", "", "business");
	if (handle_business == MYSQL_INVALID_HANDLE || mysql_errno(handle_business) != 0)
	{
		print("Connection error (Business)");
		return 1;
	}

	mysql_tquery(handle_business, "SELECT * FROM business", "LoadBusiness");

	#if defined bizz_OnGameModeInit
		return bizz_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit bizz_OnGameModeInit
#if defined bizz_OnGameModeInit
	forward bizz_OnGameModeInit();
#endif

public OnGameModeExit()
{
	if (handle_business != MYSQL_INVALID_HANDLE)
		mysql_close(handle_business);

	#if defined bizz_OnGameModeExit
		return bizz_OnGameModeExit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeExit
	#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif

#define OnGameModeExit bizz_OOnGameModeExit
#if defined bizz_OnGameModeExit
	forward bizz_OnGameModeExit();
#endif


// —— FORWARDED FUNCTIONS (QUERIES)
forward LoadBusiness();
public LoadBusiness()
{
	new rows = cache_num_rows();
	if (rows)
	{
		for (new i; i < rows; i++)
		{
			cache_get_value_int(i, "ID", Business_Info[i][business_ID]);
			cache_get_value_int(i, "type", Business_Info[i][business_type]);
			cache_get_value_int(i, "owner", Business_Info[i][business_owner]);
			cache_get_value_int(i, "money", Business_Info[i][business_money]);
			cache_get_value_int(i, "price", Business_Info[i][business_price]);

			cache_get_value_float(i, "int_x", Business_Info[i][business_IntX]);
			cache_get_value_float(i, "int_y", Business_Info[i][business_IntY]);
			cache_get_value_float(i, "int_z", Business_Info[i][business_IntZ]);
			cache_get_value_float(i, "ext_x", Business_Info[i][business_ExtX]);
			cache_get_value_float(i, "ext_y", Business_Info[i][business_ExtY]);
			cache_get_value_float(i, "ext_z", Business_Info[i][business_ExtZ]);

			cache_get_value_int(i, "int_interior", Business_Info[i][business_IntInterior]);
			cache_get_value_int(i, "int_world", Business_Info[i][business_IntWorld]);
			cache_get_value_int(i, "ext_interior", Business_Info[i][business_ExtInterior]);
			cache_get_value_int(i, "ext_world", Business_Info[i][business_ExtWorld]);
			Business_Info[i][business_valid] = true;

			UpdateBusinessLabel(i, true);
			total_business++;
		}
		printf("Total business loaded: %d.", total_business);
	}
	return 1;
}

forward OnBusinessInsert(business);
public OnBusinessInsert(business)
{
	Business_Info[business][business_ID] = cache_insert_id();
	return 1;
}

// —— OnGameModeInitS
SearchFreeBusinessID()
{
	new id = INVALID_BUSINESS_ID;
	for (new i; i < MAX_BUSINESS; i++)
	{
		if (!Business_Info[i][business_valid])
		{
			id = i;
			break;
		}
	}
	return id;
}

GetBusinessType(type)
{
	new text[30];
	switch (type)
	{
		case BUSINESS_MECHANIC: text = "Taller mecánico";
		case BUSINESS_CARDEALER: text = "Concesionario";
		case BUSINESS_LICENCES: text = "Licenciero";
		case BUSINESS_SECURITY: text = "Seguridad";
		case BUSINESS_NEWSLETTER: text = "Periódico";
		case BUSINESS_FUNERAL: text = "Funeraria";
		case BUSINESS_ASEGURADOR: text = "Aseguradora";
		default: text = "No especificado";
	}
	return text;
}

UpdateBusinessLabel(business, bool:destroy = false)
{

	// — desbug
	if (Business_Info[business][business_type] != BUSINESS_MECHANIC && IsValidDynamic3DTextLabel(Business_Info[business][mechanic_label]))
		DestroyDynamic3DTextLabel(Business_Info[business][mechanic_label]);

	new string[80];
	if (destroy)
	{
		if (IsValidDynamic3DTextLabel(Business_Info[business][business_ExtLabel]))
			DestroyDynamic3DTextLabel(Business_Info[business][business_ExtLabel]);

		format(string, sizeof string, "{00AE57}%s #%d\nEntrada", GetBusinessType(Business_Info[business][business_type]), business);
		Business_Info[business][business_ExtLabel] =
		CreateDynamic3DTextLabel(string, 
			-1, 
			Business_Info[business][business_ExtX], Business_Info[business][business_ExtY], Business_Info[business][business_ExtZ], 
			20.0, .worldid = Business_Info[business][business_ExtWorld], .interiorid = Business_Info[business][business_ExtInterior]
		);

		if (IsValidDynamic3DTextLabel(Business_Info[business][business_IntLabel]))
			DestroyDynamic3DTextLabel(Business_Info[business][business_IntLabel]);

		string[0] = EOS;
		format(string, sizeof string, "{00AE57}%s #%d\nSalida", GetBusinessType(Business_Info[business][business_type]), business);
		Business_Info[business][business_IntLabel] =
		CreateDynamic3DTextLabel(string, 
			-1, 
			Business_Info[business][business_IntX], Business_Info[business][business_IntY], Business_Info[business][business_IntZ], 
			20.0, .worldid = Business_Info[business][business_IntWorld], .interiorid = Business_Info[business][business_IntInterior]
		);	

		// —— USO DE STREAMER PARA GUARDAR ID Y TIPO DE PICKUP
		// — Pickup interior
		new tmp_interiorbizz, tmp_infointerior[2];
		tmp_interiorbizz = CreateDynamicPickup(0, 1, Business_Info[business][business_IntX], Business_Info[business][business_IntY], Business_Info[business][business_IntZ] + 0.2,
	 	Business_Info[business][business_IntWorld], Business_Info[business][business_IntInterior]);

		tmp_infointerior[0] = PICKUP_INTERIOR_BIZZ;
		tmp_infointerior[1] = business;
		Streamer_SetArrayData(STREAMER_TYPE_PICKUP, tmp_interiorbizz, E_STREAMER_EXTRA_ID, tmp_infointerior);

		// — Pickup Exterior
		new tmp_exteriorbizz, tmp_infoexterior[2];
		tmp_exteriorbizz = CreateDynamicPickup(0, 1, Business_Info[business][business_ExtX], Business_Info[business][business_ExtY], Business_Info[business][business_ExtZ] + 0.2,
	 	Business_Info[business][business_ExtWorld], Business_Info[business][business_ExtInterior]);

		tmp_infoexterior[0] = PICKUP_EXTERIOR_BIZZ;
		tmp_infoexterior[1] = business;
		Streamer_SetArrayData(STREAMER_TYPE_PICKUP, tmp_exteriorbizz, E_STREAMER_EXTRA_ID, tmp_infoexterior);

	}
	else
	{
		format(string, sizeof string, "{00AE57}%s #%d\nEntrada", GetBusinessType(Business_Info[business][business_type]), business);
		UpdateDynamic3DTextLabelText(Business_Info[business][business_ExtLabel], -1, string);

		string[0] = EOS;
		format(string, sizeof string, "{00AE57}%s #%d\nSalida", GetBusinessType(Business_Info[business][business_type]), business);
		UpdateDynamic3DTextLabelText(Business_Info[business][business_IntLabel], -1, string);	
	}
	return 1;
}

CreateBusiness(business)
{
	static sql_query[128];
	mysql_format(handle_business, sql_query, sizeof sql_query, 
		"INSERT INTO business (ext_x, ext_y, ext_Z, ext_interior, ext_world, price) VALUES (%f, %f, %f, %d, %d, %d, %d)", 
		Business_Info[business][business_ExtX], Business_Info[business][business_ExtY], Business_Info[business][business_ExtZ],
		Business_Info[business][business_ExtInterior], Business_Info[business][business_ExtWorld], Business_Info[business][business_price]
	);

	mysql_tquery(handle_business, sql_query, "OnBusinessInsert", "d", business);
	return 1;
}

SetBusinessDefaultValues(business)
{
	new clean_business[business_info];
	Business_Info[business] = clean_business;

	Business_Info[business][business_price] = random(500000) + 10000;

	UpdateBusinessLabel(business, true);
	return 1;
}

DestroyBusiness(business)
{
	if (IsValidDynamic3DTextLabel(Business_Info[business][business_ExtLabel]))
		DestroyDynamic3DTextLabel(Business_Info[business][business_ExtLabel]);

	if (IsValidDynamic3DTextLabel(Business_Info[business][business_IntLabel]))
		DestroyDynamic3DTextLabel(Business_Info[business][business_IntLabel]);

	if (IsValidDynamicPickup(Business_Info[business][business_ExtPickup]))
		DestroyDynamicPickup(Business_Info[business][business_ExtPickup]);

	if (IsValidDynamicPickup(Business_Info[business][business_ExtPickup]))
		DestroyDynamicPickup(Business_Info[business][business_ExtPickup]);

	if (IsValidDynamic3DTextLabel(Business_Info[business][mechanic_label]))
		DestroyDynamic3DTextLabel(Business_Info[business][mechanic_label]);

	Business_Info[business][business_valid] = false;
	return 1;
}