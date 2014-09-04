
waitUntil {!CTI_GameOver};
while {!CTI_GameOver} do {
	waitUntil {alive player};
	if (CTI_P_SideJoined ==west) then {
		player addAction ["<t color='#e67b09'>TOWN: Buy Offroad (500$)</t>","Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["B_G_Offroad_01_F",500,true], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)&& (vehicle _this) == _this"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Offroad Armed (1000$)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["B_G_Offroad_01_armed_F",1000,true], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)&& (vehicle _this) == _this"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Random Box (500$)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", [CTI_WEST_AMMOS,100,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	};
	if (CTI_P_SideJoined ==east) then {
		player addAction ["<t color='#e67b09'>TOWN: Buy Offroad (500$)</t>","Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["O_G_Offroad_01_F",500,true], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)&& (vehicle _this) == _this"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Offroad Armed (1000$)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", ["O_G_Offroad_01_armed_F",1000,true], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)&& (vehicle _this) == _this"];
		player addAction ["<t color='#e67b09'>TOWN: Buy Random Box (500$)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Town.sqf", [CTI_EAST_AMMOS,100,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Town_InRange)"];
	};

	waitUntil {!alive player};
};