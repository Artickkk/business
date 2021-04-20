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