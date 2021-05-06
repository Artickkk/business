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
	player_rank
}
new PlayerBusiness[MAX_PLAYERS][enum_player_business];
#endif 

// —— PUBLIC CALLBACKS
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

			new business = TempBusiness[playerid][tbusiness_listitem][listitem];
			
			for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++) if (IsPlayerConnected(i))
			{
				if (GetPlayerBusiness(i) != business)
					continue;

				strcat(, const source[], maxlength=sizeof dest)
			}
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