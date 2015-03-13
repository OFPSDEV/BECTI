SM_CLEAN_REVIVES={
	while {!CTI_GameOver} do
	{
	    {if (!isnil {_x getVariable "FAR_isUnconscious"}) then  {if (!isPlayer _x && (_x getVariable "FAR_isUnconscious") == 1 ) then {_x setDammage 1;}};true}count playableUnits;
	    sleep 3;
	};
};

SM_CLEAN_GROUPS={

	private ["_g","_players","_unit"];
	while {!CTI_GameOver} do
	{
	    {
	    	_g=group _x;
	    	if ! (side _g == resistance) then {
		    	_players={isPlayer _x} count (units _g);
		    	if (_players==0) then {
		    		{
		    		 if !(vehicle _x == _x) then {
		    		 	(vehicle _x) lock false;
		    		 	unAssignVehicle _x;
							_x action ["eject", vehicle _unit];
							_x action ["getOut", (vehicle _unit)];
		    		 };
		    		 deleteVehicle _x; true
		    		} count (units _g)
		    	};
		    }; true
	    }count playableUnits;
	    sleep 3;
	};
};

SM_CLEAN_GCONT= {
	private ["_timeout","_time"];
	_timeout={
		_time=time;
		waitUntil {time > _time + 240};
		deleteVehicle (_this);
	};
	while {! CTI_GameOver} do {
		{
			if (isNil {_x getVariable "GC"}) then {
			 _x setVariable ["GC",true];
			 (_x) spawn _timeout;
			};
		} forEach allMissionObjects "GroundWeaponHolder";
		sleep 10;
	};
};

0 spawn SM_CLEAN_REVIVES;
if (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED" ==0)then { 0 spawn SM_CLEAN_GROUPS};
0 spawn SM_CLEAN_GCONT;