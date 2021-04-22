// —— CREDITOS
// — Artic, 20/Abril

// —— ENUM
enum temp_player_business
{
	tbusiness_pickup,
}
new TempBusiness[MAX_PLAYERS][temp_player_business];

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


// —— FUNCIONES