// �� CREDITOS
// � Artic, 18/Abril

// �� DEFINES
#define MAX_BUSINESS 50
#define INVALID_BUSINESS_ID -1

// �� ENUM
enum 
{
	BUSINESS_NONE,
	BUSINESS_MECHANIC,
	BUSINESS_CARDEALER,
	BUSINESS_LICENCES,
	BUSINESS_SECURITY,
	BUSINESS_NEWSLETTER,
	BUSINESS_FUNERAL,
	BUSINESS_ASEGURADOR,
	BUSINESS_INVALID
}

// � TIPOS DE PICKUP
enum
{
	PICKUP_NONE_BIZZ = 0,
	PICKUP_INTERIOR_BIZZ,
	PICKUP_EXTERIOR_BIZZ,
	PICKUP_SHOP_BIZZ,
	PICKUP_REPAIR_MECHANIC,
}

enum business_info
{
	// ��������������� INFORMACI�N GENERAL
	// � SQL
	business_ID,								// � ID SQL
	bool:business_valid,						// � Empresa v�lida y creada
	business_type,								// � Tipo de empresa
	business_name[32],							// � Nombre de la empresa
	// � Informaci�n de la empresa
	business_owner,								// � ID sql del propietario
	business_money,								// � Dinero en caja fuerte
	business_sold,								// � Vendido o no
	business_price,								// � Precio de la venta
	// � Posiciones
	Float:business_IntX,						// � Coordenada Interior de X
	Float:business_IntY,						// � Coordenada Interior de Y
	Float:business_IntZ,						// � Coordenada Interior de Z
	Float:business_ExtX,						// � Coordenada Exterior de X
	Float:business_ExtY,						// � Coordenada Exterior de Y
	Float:business_ExtZ,						// � Coordenada Exterior de Z
	// � Interior y Virtual World
	business_IntInterior,						// � ID del Interior Interior (XD)
	business_IntWorld,							// � ID del Virtual World Interior (XD)
	business_ExtInterior,						// � ID del Interior Exterior (XD)
	business_ExtWorld,							// � ID del Virtual World Exterior (XD)
	// � Pickup interior y exterior
	business_IntPickup,							// � ID Pickup interior compra
	business_ExtPickup,							// � ID Pickup exterior compra
	// � Label interior y Exterior
	Text3D:business_IntLabel,					// � Label interior
	Text3D:business_ExtLabel					// � Label exterior
	// ��������������� DISTRIBUCI�N SEG�N EL TIPO DE EMPRESA
	// ����� MEC�NICO
	// �� Label reparaci�n
	Text3D:mechanic_label,						// � Label reparaci�n
	// �� Posiciones de reparaci�n
	Float:mechanic_repairX,						// � Coordenada reparaci�n X
	Float:mechanic_repairY,						// � Coordenada reparaci�n Y
	Float:mechanic_repairZ,						// � Coordenada reparaci�n Z
	Float:mechanic_repairR,						// � Coordenada reparaci�n R
	mechanic_interior,
	mechanic_world,	
	// �� Precios
	mechanic_price_repair,						// � Precio de reparaci�n
	mechanic_price_colour,						// � Precio de pintura
	mechanic_price_gas,							// � Precio de gasolina
	mechanic_price_oil							// � Precio de aceite
}
new Business_Info[MAX_BUSINESS][business_info];

// � others
new 
	MySQL:handle_business,
	total_business
;

// �� M�DULOS
// � General
#include "../core/business/player_business.pwn"
#include "../core/business/commands_business.pwn"
#include "../core/business/functions_business.pwn"
// � Taller mec�nico
#include "../core/business/mechanic_business.pwn"