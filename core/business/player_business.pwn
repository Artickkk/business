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
	return 1;
}


// —— FUNCIONES