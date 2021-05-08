// —— CREDITOS
// — Artic, 20/Abril

// —— ENUM
enum temp_player_business
{
	tbusiness_pickup,
	tmechanic_taller,
	tmechanic_vehid,
	tmechanic_color_one,
	tmechanic_color_two,
	tbusiness_listitem[MAX_BUSINESS],
}
new TempBusiness[MAX_PLAYERS][temp_player_business];

#if defined DESBUG_PLAYER_BUSINESS
enum enum_player_business
{
	player_employee,
	player_rank,
	player_name[MAX_PLAYER_NAME]
}
new PlayerBusiness[MAX_PLAYERS][enum_player_business];
#endif 

// —— PUBLIC CALLBACKS

public OnPlayerConnect(playerid)
{
	#if defined DESBUG_PLAYER_BUSINESS
	PlayerBusiness[playerid][player_employee] = INVALID_BUSINESS_ID;
	GetPlayerName(playerid, PlayerBusiness[playerid][player_name], MAX_PLAYER_NAME);
	#endif


	#if defined bizz_OnPlayerConnect
		return bizz_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect bizz_OnPlayerConnect
#if defined bizz_OnPlayerConnect
	forward bizz_OnPlayerConnect(playerid);
#endif

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	TempBusiness[playerid][tbusiness_pickup] = pickupid;

	
	#if defined bz_OnPlayerPickUpDynamicPickup
		return bz_OnPlayerPickUpDynamicPickup(playerid, pickupid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerPickUpDynPickup
	#undef OnPlayerPickUpDynamicPickup
#else
	#define _ALS_OnPlayerPickUpDynPickup
#endif

#define OnPlayerPickUpDynamicPickup bz_OnPlayerPickUpDynamicPickup
#if defined bz_OnPlayerPickUpDynamicPickup
	forward bz_OnPlayerPickUpDynamicPickup(playerid, pickupid);
#endif

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch (dialogid)	
	{
		case DIALOG_BUSINESS:
		{
			if (!response)
				return 0;

			new
				business = TempBusiness[playerid][tbusiness_listitem][listitem],
				totalstr[1024], 
				str[35], 
				count 
			;
			strcat(totalstr, "Nombre\tPuesto\n");
			for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++) if (IsPlayerConnected(i))
			{
				if (GetPlayerBusiness(i) != business)
					continue;

				format(str, sizeof str, "{C0C0C0}(%d) %s\t%s\n", playerid, PlayerBusiness[playerid][player_name], Business_Ranks[business][PlayerBusiness[playerid][player_rank]]);
				strcat(totalstr, str);
				count++;
			}
			if (!count)
				return 0;
			
			ShowPlayerDialog(playerid, DIALOG_MEMBERS, DIALOG_STYLE_TABLIST_HEADERS, "Miembros", totalstr, "Aceptar", "Salir");
		}
	}
	#if defined bz_OnDialogResponse
		return bz_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse bz_OnDialogResponse
#if defined bz_OnDialogResponse
	forward bz_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

// —— FUNCIONES