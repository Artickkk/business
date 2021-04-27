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

// —— VARIABLES

new ColorList[] = {
    0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
	0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
	0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
	0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
	0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
	0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
	0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
	0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
	0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
	0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
	0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
	0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
	0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF, 0x177517FF, 0x210606FF,
	0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF, 0xB7B7B7FF, 0x464C8DFF,
	0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF, 0x1E1D13FF, 0x1E1306FF,
	0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF, 0x992E1EFF, 0x2C1E08FF,
	0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF, 0x481A0EFF, 0x7A7399FF,
	0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF, 0x7B3E7EFF, 0x3C1737FF,
	0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF, 0x163012FF, 0x16301BFF,
	0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF, 0x2B3C99FF, 0x3A3A0BFF,
	0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF, 0x2C5089FF, 0x15426CFF,
	0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF, 0x995C52FF, 0x99581EFF,
	0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF, 0x96821DFF, 0x197F19FF,
	0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF, 0x8A653AFF, 0x732617FF,
	0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF, 0x561A28FF, 0x4E0E27FF,
	0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};

// —— FUNCIONES
UpdateMechanicLabel(business)
{

	if (IsValidDynamic3DTextLabel(Business_Info[business][mechanic_label]))
		DestroyDynamic3DTextLabel(Business_Info[business][mechanic_label]);

	Business_Info[business][mechanic_label] =
	CreateDynamic3DTextLabel("{C0C0C0}Para ver el menú\nusa {586BC5}/taller{C0C0C0}", 
		-1, 
		Business_Info[business][mechanic_repairX], Business_Info[business][mechanic_repairY], Business_Info[business][mechanic_repairZ], 
		20.0, .worldid = Business_Info[business][mechanic_world], .interiorid = Business_Info[business][mechanic_interior]
	);

	// — Uso del streamer (DESHABILITADO)
	/*
	new tmp_mechanic, tmp_infomechanic[2];
	tmp_mechanic = CreateDynamicPickup(0, 1, Business_Info[business][mechanic_repairX], Business_Info[business][mechanic_repairY], Business_Info[business][mechanic_repairZ],
	.worldid = Business_Info[business][mechanic_world], .interiorid = Business_Info[business][mechanic_interior]
	);

	tmp_infomechanic[0] = PICKUP_REPAIR_MECHANIC;
	tmp_infomechanic[1] = business;
	Streamer_SetArrayData(STREAMER_TYPE_PICKUP, tmp_mechanic, E_STREAMER_EXTRA_ID, tmp_infomechanic);*/
	return 1;
}

// —— COMANDOS ADMINISTRATIVOS
CMD:editartaller(playerid, params[])
{
	new option[64], business;
	if (sscanf(params, "is[64]", business, option)) 
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

		new query[150];
		mysql_format(handle_business, query, sizeof query, "UPDATE business SET repair_x = %f, repair_y = %f, repair_z = %f, repair_interior = %d, repair_world = %d WHERE ID = %d;", 
			Business_Info[business][mechanic_repairX], Business_Info[business][mechanic_repairY], Business_Info[business][mechanic_repairZ],
			Business_Info[business][mechanic_interior], Business_Info[business][mechanic_world], Business_Info[business][business_ID]
		);
		mysql_tquery(handle_business, query);

		new string[80];
		format(string, sizeof string, "Editaste un taller mecánico. {D17145}(Posición de reparación, ID: %d)", business);
		SendClientMessage(playerid, 0xD1CCE7FF, string);
	}

	else if (!strcmp(option, "precios", true, 7) || !strcmp(option, "precio", true, 6))
	{
		new type[32], value;
		if (sscanf(option, "s[64]s[32]i", option, type, value)) 
			return SendClientMessage(playerid, 0xC0C0C0FF, "USO: /editartaller [ID] Precio [Pintura - Reparación - Gasolina] [Valor]");	

		if (!strcmp(type, "gasolina", true, 7) || !strcmp(type, "gas", true, 3))
		{
			if (value > MAX_GAS_PRICE)
				return SendClientMessage(playerid, 0x942B15FF, "El valor máximo es de "#MAX_GAS_PRICE"");

			if (value < MIN_GAS_PRICE)
				return SendClientMessage(playerid, 0x942B15FF, "El valor mínimo es de "#MIN_GAS_PRICE" ");

			Business_Info[business][mechanic_price_gas] = value;
			new query[60];
			mysql_format(handle_business, query, sizeof query, "UPDATE business SET price_gas = %d WHERE ID = %d;", Business_Info[business][mechanic_price_gas], Business_Info[business][business_ID]);
			mysql_tquery(handle_business, query);

			new string[80];
			format(string, sizeof string, "Editaste un taller mecánico. {D17145}(Precio gasolina: %d, ID: %d)", value, business);
			SendClientMessage(playerid, 0xD1CCE7FF, string);
		}

		else if (!strcmp(type, "pintura", true, 7))
		{
			if (value > MAX_COLOUR_PRICE)
				return SendClientMessage(playerid, 0x942B15FF, "El valor máximo es de "#MAX_COLOUR_PRICE"");

			if (value < MIN_COLOUR_PRICE)
				return SendClientMessage(playerid, 0x942B15FF, "El valor mínimo es de "#MIN_COLOUR_PRICE"");

			Business_Info[business][mechanic_price_colour] = value;
			new query[60];
			mysql_format(handle_business, query, sizeof query, "UPDATE business SET price_colour = %d WHERE ID = %d;", Business_Info[business][mechanic_price_colour], Business_Info[business][business_ID]);
			mysql_tquery(handle_business, query);

			new string[80];
			format(string, sizeof string, "Editaste un taller mecánico. {D17145}(Precio pintura: %d, ID: %d)", value, business);
			SendClientMessage(playerid, 0xD1CCE7FF, string);
		}

		else if (!strcmp(type, "reparacion", true, 10))
		{
			if (value > MAX_REPAIR_PRICE)
				return SendClientMessage(playerid, 0x942B15FF, "El valor máximo es de "#MAX_REPAIR_PRICE"");

			if (value < MIN_REPAIR_PRICE)
				return SendClientMessage(playerid, 0x942B15FF, "El valor mínimo es de "#MIN_REPAIR_PRICE"");

			Business_Info[business][mechanic_price_repair] = value;
			new query[60];
			mysql_format(handle_business, query, sizeof query, "UPDATE business SET price_repair = %d WHERE ID = %d;", Business_Info[business][mechanic_price_repair], Business_Info[business][business_ID]);
			mysql_tquery(handle_business, query);

			new string[80];
			format(string, sizeof string, "Editaste un taller mecánico. {D17145}(Precio reparación: %d, ID: %d)", value, business);
			SendClientMessage(playerid, 0xD1CCE7FF, string);
			UpdateMechanicLabel(business);
		}
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if (response)
	{
		switch (dialogid)
		{
			case DIALOG_MECHANIC_MENU:
			{
				switch (listitem)
				{
					case 0:
					{
						new
							vehicleid = TempBusiness[playerid][tmechanic_vehid],
							Float:health
						;

						GetVehicleHealth(vehicleid, health);
						if (health > 900.0)
							return SendClientMessage(playerid, 0x9D2121FF, "El estado del vehículo es muy bueno como para repararse.");

						new
							msg[80],
							mechanic = TempBusiness[playerid][tmechanic_taller]
						;

						if (GetPlayerMoney(playerid) < Business_Info[mechanic][mechanic_price_repair])
						{
							format(msg, sizeof msg, "El precio para reparar acá es de $%d.", Business_Info[mechanic][mechanic_price_repair]);
							return SendClientMessage(playerid, -1, msg);
						}

						GivePlayerMoney(playerid, -Business_Info[mechanic][mechanic_price_repair]);
						Business_Info[mechanic][business_money] += Business_Info[mechanic][mechanic_price_repair];
						new query[60];
						mysql_format(handle_business, query, sizeof query, "UPDATE business SET money = %d WHERE ID = %d;", Business_Info[mechanic][business_money], Business_Info[mechanic][business_ID]);
						mysql_tquery(handle_business, query);	

						format(msg, sizeof msg, "Gastaste $%d para reparar tu auto.", Business_Info[mechanic][mechanic_price_repair]);
						SendClientMessage(playerid, 0xC0C0C0FF, msg);

						SetVehicleHealth(vehicleid, 900.0);
						RepairVehicle(vehicleid);
					}
					case 1:
					{
						new color_string[3256];
						for(new i; i < sizeof(ColorList); i++) format(color_string, sizeof(color_string), "%s{%06x}%03d %s", color_string, ColorList[i] >>> 8, i, ((i+1) % 10 == 0) ? ("\n") : (""));
						ShowPlayerDialog(playerid, DIALOG_COLOR_ONE, DIALOG_STYLE_INPUT, "Elige el color 1", color_string, "Aceptar", "Cancelar");
					}
				}
			}
			case DIALOG_COLOR_ONE:
			{
				new color = strval(inputtext);
				if(!(0 <= color <= sizeof(ColorList)-1))
					return SendClientMessage(playerid, 0x9D2121FF, "Color inválido.");

				TempBusiness[playerid][tmechanic_color_one] = color;
				new color_string[3256];
				for(new i; i < sizeof(ColorList); i++) format(color_string, sizeof(color_string), "%s{%06x}%03d %s", color_string, ColorList[i] >>> 8, i, ((i+1) % 10 == 0) ? ("\n") : (""));
				ShowPlayerDialog(playerid, DIALOG_COLOR_TWO, DIALOG_STYLE_INPUT, "Elige el color 2", color_string, "Aceptar", "Cancelar");
			}
			case DIALOG_COLOR_TWO:
			{
				new color = strval(inputtext);
				if(!(0 <= color <= sizeof(ColorList)-1))
					return SendClientMessage(playerid, 0x9D2121FF, "Color inválido.");

				new string[80];
				if (GetPlayerMoney(playerid) < Business_Info[TempBusiness[playerid][tmechanic_taller]][mechanic_price_colour])
				{ 
					format(string, sizeof string, "No tienes suficiente dinero ($%d).", Business_Info[TempBusiness[playerid][tmechanic_taller]][mechanic_price_colour]); 
					SendClientMessage(playerid, 0xC0C0C0FF, string); 
					return 1; 
				}
				ChangeVehicleColor(TempBusiness[playerid][tmechanic_vehid], TempBusiness[playerid][tmechanic_color_one], color);
				GivePlayerMoney(playerid, -Business_Info[TempBusiness[playerid][tmechanic_taller]][mechanic_price_colour]);
				Business_Info[TempBusiness[playerid][tmechanic_taller]][business_money] += Business_Info[TempBusiness[playerid][tmechanic_taller]][mechanic_price_colour];

				new query[60];
				mysql_format(handle_business, query, sizeof query, "UPDATE business SET money = %d WHERE ID = %d;", Business_Info[TempBusiness[playerid][tmechanic_taller]][business_money], Business_Info[TempBusiness[playerid][tmechanic_taller]][business_ID]);
				mysql_tquery(handle_business, query);	

				format(string, sizeof string, "Gastaste $%d para pintar tu auto.", Business_Info[TempBusiness[playerid][tmechanic_taller]][business_money]);
				SendClientMessage(playerid, 0xC0C0C0FF, string);

			}
		}
	}
	#if defined bizz_OnDialogResponse
		return bizz_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse bizz_OnDialogResponse
#if defined bizz_OnDialogResponse
	forward bizz_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

// —— COMANDOS GENERALES
CMD:taller(playerid)
{
	new mechanic = INVALID_BUSINESS_ID;
	for (new i; i != total_business; i++)
	if (IsPlayerInRangeOfPoint(playerid, 25.0, Business_Info[i][mechanic_repairX], Business_Info[i][mechanic_repairY], Business_Info[i][mechanic_repairZ]))
	{
		mechanic = i;
		break;
	}

	if (mechanic == INVALID_BUSINESS_ID)
		return 1;

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return 1;

	TempBusiness[playerid][tmechanic_taller] = mechanic;
	TempBusiness[playerid][tmechanic_vehid] = GetPlayerVehicleID(playerid);

	new str[512];
	format(str, sizeof str, 
		"{C0C0C0}Reparación\t{54C822}$%d\n\
		{C0C0C0}Pintura\t{54C822}$%d\n\
		{C0C0C0}Gasolina\t{54C822}$%d", 
		Business_Info[mechanic][mechanic_price_repair], Business_Info[mechanic][mechanic_price_colour], Business_Info[mechanic][mechanic_price_gas]
	);

	#if defined _easyDialog_included
		Dialog_Show(playerid, ShowBusiness, DIALOG_STYLE_TABLIST, "Taller", str, "Aceptar", "");
	#else
		ShowPlayerDialog(playerid, DIALOG_MECHANIC_MENU, DIALOG_STYLE_TABLIST, "Taller", str, "Aceptar", "Cancelar");
	#endif 

	return 1;
}