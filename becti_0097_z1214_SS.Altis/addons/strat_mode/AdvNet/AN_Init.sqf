AN_Check_Connection=compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_CheckConn.sqf";
AN_Disconnect=compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_Disconnect.sqf";
AN_Reconfigure=compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_Reconfigure.sqf";
AN_Launch=compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_Launch.sqf";
AN_Update_Connection=compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_Update_Connection.sqf";

AN_Switchable = compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_Switchable.sqf";
AN_Reconfigure_loop=compile preprocessfilelinenumbers "Addons\Strat_mode\AdvNet\AN_Reconfigure_Loop.sqf";
with missionNamespace do {
	CTI_PVF_Server_Run_Net={
		_this spawn AN_Launch;
	};
};

0  execVM "Addons\Strat_mode\AdvNet\AN_Ex_Intrusion.sqf";

if (CTI_IsClient) then {

	0 spawn {
		while {!CTI_GameOver} do{
			waitUntil {! (isNull player) && alive player};
			[player,CTI_P_SideID] spawn AN_Launch;
			waitUntil {! (isNil {player getVariable "CTI_Net"} || isNil {player getVariable "AN_iNet"})};
			while {alive player} do {
				if (!(player getVariable "CTI_Net"==player getVariable "AN_iNet" && player getVariable "CTI_Net" == CTI_P_SideID) || player getVariable "CTI_Net" <= -1) then{Client_AN_Connected=False;} else {Client_AN_Connected=true;} ;
				sleep 0.2;
			};
		};
	};
};




if (CTI_IsServer) then {
	//waitUntil {CTI_Init_Server};
	//{ (_x) spawn AN_Switchable; true } count switchableUnits;

	{ [_x,-1]  spawn AN_Launch ;true }count CTI_Towns;
};