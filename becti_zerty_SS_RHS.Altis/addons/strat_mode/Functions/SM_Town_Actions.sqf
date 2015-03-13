
waitUntil {!CTI_GameOver};
while {!CTI_GameOver} do {
	waitUntil {alive player};
	//player addAction ["<t color='#e67b09'>TOWN: Buy Offroad (500$)</t>","Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["C_Offroad_01_F",600,true], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	if (CTI_P_SideJoined ==west) then {
		player addAction ["<t color='#e67b09'>TOWN: Buy Flatbed Transport Truck ($800)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["B_Truck_01_transport_F",800,true], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		//player addAction ["<t color='#e67b09'>TOWN: Buy Random Box (500$)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", [CTI_WEST_AMMOS,100,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	//	player addAction ["<t color='#e67b09'>TOWN: Buy Ammo Box ($1000)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_NATO_Ammo_F",1000,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	//	player addAction ["<t color='#e67b09'>TOWN: Buy Grenade Box ($1000)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_NATO_Grenades_F",1000,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	//	player addAction ["<t color='#e67b09'>TOWN: Buy Mine/Explosives Box ($3000)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_NATO_AmmoOrd_F",3000,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	};
	if (CTI_P_SideJoined ==east) then {
		player addAction ["<t color='#e67b09'>TOWN: Buy Flatbed Transport Truck ($800)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["O_Truck_03_transport_F",800,true], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		//player addAction ["<t color='#e67b09'>TOWN: Buy Random Box (500$)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", [CTI_EAST_AMMOS,100,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	//	player addAction ["<t color='#e67b09'>TOWN: Buy Ammo Box ($1000)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_East_Ammo_F",1000,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	//	player addAction ["<t color='#e67b09'>TOWN: Buy Grenade Box ($1000)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_East_Grenades_F",1000,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	//	player addAction ["<t color='#e67b09'>TOWN: Buy Mine/Explosives Box ($3000)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_East_AmmoOrd_F",3000,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	};

	waitUntil {!alive player};
};