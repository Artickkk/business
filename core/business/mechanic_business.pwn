// —— CREDITOS
// — Artic, 21/Abril

// — LIMITES
#define MAX_GAS_PRICE 5000
#define MIN_GAS_PRICE 100

#define MAX_OIL_PRICE 5000
#define MIN_OIL_PRICE 100

#define MAX_REPAIR_PRICE 5000
#define MIN_REPAIR_PRICE 100

#define MAX_COLOUR_PRICE 5000
#define MIN_COLOUR_PRICE 100


// —— FUNCIONES
UpdateMechanicLabel(business, destroy = false)
{
	new string[30];
	format(string, sizeof string, "Para reparar tu auto\nusa /reparar ($%d/L)", Business_Info[business][mechanic_price_gas]);

	if (destroy)
	{
		if (IsValidDynamic3DTextLabel(Business_Info[business][mechanic_label]))
			DestroyDynamic3DTextLabel(Business_Info[business][mechanic_label]);

		Business_Info[business][mechanic_label] =
		CreateDynamic3DTextLabel(string, 
			-1, 
			Business_Info[business][mechanic_repairX], Business_Info[business][mechanic_repairY], Business_Info[business][mechanic_repairZ], 
			20.0, .worldid = Business_Info[business][mechanic_world], .interiorid = Business_Info[business][mechanic_interior]
		);

		// — Uso del streamer

		new tmp_mechanic, tmp_infomechanic[2];
		tmp_mechanic = CreateDynamicPickup(0, 1, Business_Info[business][mechanic_repairX], Business_Info[business][mechanic_repairY], Business_Info[business][mechanic_repairZ],
		.worldid = Business_Info[business][mechanic_world], .interiorid = Business_Info[business][mechanic_interior]
		);
	
		tmp_infomechanic[0] = PICKUP_REPAIR_MECHANIC;
		tmp_infomechanic[1] = business;
		Streamer_SetArrayData(STREAMER_TYPE_PICKUP, tmp_mechanic, E_STREAMER_EXTRA_ID, tmp_infomechanic);
		return 1;
	}
	else 
		UpdateDynamic3DTextLabelText(Business_Info[business][mechanic_label], -1, string);
	return 1;
}

// —— COMANDOS ADMINISTRATIVOS
CMD:editartaller(playerid, params[])
{
	new option[10], business;
	if (sscanf(params, "s[32]is[12]", params, business, option)) 
 		return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /editartaller [ID] [Posicion - Precios (Pintura - Reparación - Gasolina)]");	

 	if (business > total_business)
		return SendClientMessage(playerid, 0x942B15FF, "ID inválida");

	if (!Business_Info[business][business_valid])
		return SendClientMessage(playerid, 0x942B15FF, "ID inválida");	

	if (Business_Info[business][business_type] != BUSINESS_MECHANIC)
		return SendClientMessage(playerid, 0x942B15FF, "Este no es un taller.");

	if (!strcmp(option, "posicion", true, 8))
	{
		GetPlayerPos(playerid, Business_Info[business][mechanic_repairX], Business_Info[business][mechanic_repairY], Business_Info[business][mechanic_repairZ]);
		Business_Info[business][mechanic_world] = GetPlayerVirtualWorld(playerid);
		Business_Info[business][mechanic_interior] = GetPlayerInterior(playerid);
		UpdateMechanicLabel(business);

		new string[80];
		format(string, sizeof string, "Editaste un taller mecánico. {D17145}(Posición de reparación, ID: %d)", business);
		SendClientMessage(playerid, 0xD1CCE7FF, string);
	}

	else if (!strcmp(option, "precios", true, 7) || !strcmp(option, "precio", true, 6))
	{
		new type[10], value;
		if (sscanf(option, "s[6]s[10]i", option, type, value)) 
			return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /editartaller [ID] Precio [Pintura - Reparación - Gasolina] [Valor]");	

		if (!strcmp(type, "gasolina", true, 7) || !strcmp(type, "gas", true, 3))
		{
			if (value > MAX_GAS_PRICE)
				return SendClientMessage(playerid, 0x942B15FF, "El valor máximo es de "MAX_GAS_PRICE"");

			if (value < MIN_GAS_PRICE)
				return SendClientMessage(playerid, 0x942B15FF, "El valor mínimo es de "MIN_GAS_PRICE"");

			Business_Info[business][mechanic_price_gas] = value;

			new string[80];
			format(string, sizeof string, "Editaste un taller mecánico. {D17145}(Precio gasolina: %d, ID: %d)", value, business);
			SendClientMessage(playerid, 0xD1CCE7FF, string);
		}

		else if (!strcmp(type, "pintura", true, 7))
		{
			if (value > MAX_COLOUR_PRICE)
				return SendClientMessage(playerid, 0x942B15FF, "El valor máximo es de "MAX_COLOUR_PRICE"");

			if (value < MIN_COLOUR_PRICE)
				return SendClientMessage(playerid, 0x942B15FF, "El valor mínimo es de "MIN_COLOUR_PRICE"");

			Business_Info[business][mechanic_price_colour] = value;

			new string[80];
			format(string, sizeof string, "Editaste un taller mecánico. {D17145}(Precio pintura: %d, ID: %d)", value, business);
			SendClientMessage(playerid, 0xD1CCE7FF, string);
		}

		else if (!strcmp(type, "reparacion", true, 10))
		{
			if (value > MAX_REPAIR_PRICE)
				return SendClientMessage(playerid, 0x942B15FF, "El valor máximo es de "MAX_REPAIR_PRICE"");

			if (value < MIN_REPAIR_PRICE)
				return SendClientMessage(playerid, 0x942B15FF, "El valor mínimo es de "MIN_REPAIR_PRICE"");

			Business_Info[business][mechanic_price_repair] = value;

			new string[80];
			format(string, sizeof string, "Editaste un taller mecánico. {D17145}(Precio reparación: %d, ID: %d)", value, business);
			SendClientMessage(playerid, 0xD1CCE7FF, string);
			UpdateMechanicLabel(business);
		}
	}
	return 1;
}

// —— COMANDOS GENERALES
CMD:reparar(playerid)
{
	new tmp_mechanic[2];
	Streamer_GetArrayData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_EXTRA_ID, tmp_mechanic);

	if (tmp_mechanic[0] == PICKUP_NONE_BIZZ || tmp_mechanic[0] != PICKUP_REPAIR_MECHANIC) // — Tiene k estar en un taller
		return 1;

	new Float:mechanicX, Float:mechanicY, Float:mechanicZ;
	Streamer_GetFloatData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_X, mechanicX);
	Streamer_GetFloatData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_Y, mechanicY);
	Streamer_GetFloatData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_Z, mechanicZ);
	new mechanicVW = Streamer_GetIntData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_WORLD_ID);
	new mechanicINT = Streamer_GetIntData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_INTERIOR_ID);

	if (!IsPlayerInRangeOfPoint(playerid, 5.0, mechanicX, mechanicY, mechanicZ) && GetPlayerInterior(playerid) != mechanicVW && GetPlayerVirtualWorld(playerid) != mechanicINT)
		return 1;

	if (!strcmp(option, "posicion", true, 8))
	{
		GetPlayerPos(playerid, Business_Info[business][mechanic_repairX], Business_Info[business][mechanic_repairY], Business_Info[business][mechanic_repairZ]);
		Business_Info[business][mechanic_world] = GetPlayerVirtualWorld(playerid);
		Business_Info[business][mechanic_interior] = GetPlayerInterior(playerid);
	}	
	return 1;
}