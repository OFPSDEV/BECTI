
waitUntil {!CTI_GameOver};
while {!CTI_GameOver} do {
	waitUntil {alive player};
	
	if (CTI_P_SideJoined ==west) then {
		player addAction ["<t color='#e67b09'>TOWN: Buy Offroad (500$)</t>","Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["B_Offroad_01_F",600,true], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Flatbed Transport Truck ($800)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["B_Truck_01_transport_F",800,true], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Weapons Box (1500$)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", [Box_NATO_Wps_F ,1500,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Speacial Weapons Box (2000$)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", [Box_NATO_WpsSpecial_F,2000,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Ammo Box ($1500)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_NATO_Ammo_F",1500,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Grenade Box ($1500)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_NATO_Grenades_F",1500,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Mine/Explosives Box ($3500)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_NATO_AmmoOrd_F",3500,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Support Box ($2500)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_NATO_Support_F ",2500,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	};
	if (CTI_P_SideJoined ==east) then {
		player addAction ["<t color='#e67b09'>TOWN: Buy Offroad (500$)</t>","Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["O_Offroad_01_F",600,true], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Flatbed Transport Truck ($800)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["O_Truck_03_transport_F",800,true], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Weapons Box (1500$)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", [Box_East_Wps_F  ,1500,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Speacial Weapons Box (2000$)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", [Box_East_WpsSpecial_F,2000,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Ammo Box ($1500)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_East_Ammo_F ",1500,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Grenade Box ($1500)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_East_Grenades_F",1500,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Mine/Explosives Box ($3500)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_East_AmmoOrd_F",3500,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Support Box ($2500)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["Box_East_Support_F  ",2500,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	};

	waitUntil {!alive player};
};