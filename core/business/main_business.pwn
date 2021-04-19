// —— CREDITOS
// — Artic, 18/Abril

// —— MAX
#define MAX_BUSINESS 50
#define INVALID_ID -1

// —— ENUM
enum enum_business_types
{
	BUSINESS_NONE,
	BUSINESS_MECHANIC,
	BUSINESS_CARDEALER,
	BUSINESS_LICENCES,
	BUSINESS_SECURITY,
	BUSINESS_NEWSLETTER,
	BUSINESS_FUNERAL,
	BUSINESS_ASEGURADOR
}

enum business_info
{
	// — SQL
	business_ID,
	bool:business_valid,
	business_type,
	business_name[32],
	// — Información de la empresa
	business_owner,
	business_money,
	business_sold,
	business_price,
	// — Posiciones
	Float:business_IntX,
	Float:business_IntY,
	Float:business_IntZ,
	Float:business_ExtX,
	Float:business_ExtY,
	Float:business_ExtZ,
	// — Interior y Virtual World
	business_IntInterior,
	business_IntWorld,
	business_ExtInterior,
	business_ExtWorld,
	// — Pickup interior y exterior
	business_IntPickup,
	business_ExtPickup,
	// — Label interior y exterior
	Text3D:business_IntLabel,
	Text3D:business_ExtLabel
}
new Business_Info[MAX_BUSINESS][business_info];

// — Funcs
SearchFreeBusinessID()
{
	new id = INVALID_ID;
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
	new string[60];

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

SetBusinessDefaultValues(business)
{
	Business_Info[business][business_price] = random(500000) + 10000;
	Business_Info[business][business_owner] = 0;

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

	Business_Info[business][business_valid] = false;
	return 1;
}

// —— MÓDULOS
#include "../core/business/commands_business.pwn"