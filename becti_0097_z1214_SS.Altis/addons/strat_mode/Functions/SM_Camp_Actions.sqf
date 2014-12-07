
waitUntil {!CTI_GameOver};
while {!CTI_GameOver} do {
	waitUntil {alive player};
	if (CTI_P_SideJoined ==west) then {
		player addAction ["<t color='#e67b09'>TOWN: Buy Ammo Box ($1500)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Camp.sqf", ["Box_NATO_Ammo_F",1000,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Camp_InRange)"];
	};
	if (CTI_P_SideJoined ==east) then {
		player addAction ["<t color='#e67b09'>TOWN: Buy Ammo Box ($1500)</t>", "Addons\Strat_mode\Functions\SM_Action_Buy_Camp.sqf", ["Box_East_Ammo_F ",1000,false], 99, false, true, "", " !CTI_P_PreBuilding && (CTI_Camp_InRange)"];
	};

	waitUntil {!alive player};
};