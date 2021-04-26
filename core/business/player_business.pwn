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

	new tmp_mechanic[2];
	Streamer_GetArrayData(STREAMER_TYPE_PICKUP, TempBusiness[playerid][tbusiness_pickup], E_STREAMER_EXTRA_ID, tmp_mechanic);

	switch (tmp_mechanic[0])
	{
		case PICKUP_NONE_BIZZ: SendClientMessage(playerid, -1, "ninguno");
		case PICKUP_INTERIOR_BIZZ: SendClientMessage(playerid, -1, "interior");
		case PICKUP_EXTERIOR_BIZZ: SendClientMessage(playerid, -1, "exterior");
		case PICKUP_SHOP_BIZZ: SendClientMessage(playerid, -1, "shop");
		case PICKUP_REPAIR_MECHANIC: SendClientMessage(playerid, -1, "reparacion");
	}
	
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