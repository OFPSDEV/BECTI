/*disabled due to script errors
SM_PATROLS=[];
SM_MAX_PATROLS=missionNamespace getVariable "CTI_SM_PATROLS_NUMBER";
SM_PATROL_RATIO=0;
SM_PATROL_UNITS=["GUER_VEHICLES_PATROL"];
SM_PATROLS_TO=300;
PATROL_server_WD ={ //server loop to create  patrols
	private ["_ai_func","_purge_func","_group","_to_create","_resistance_towns","_starting_town","_pos"];
	while { !CTI_GameOver} do
	{
		//SM_MAX_PATROLS =count ((CTI_RESISTANCE_ID) call CTI_CO_FNC_GetFriendlyTowns) /SM_PATROL_RATIO;
		//==============================================
	   if (count SM_PATROLS < SM_MAX_PATROLS) then{ //we need to create patrols
	   	_nbp = count  SM_PATROLS;
	   	_to_create= SM_MAX_PATROLS-_nbp;
	   	_veh=[];
	   	for "_i" from 1 to _to_create do {
	   		_resistance_towns=((CTI_RESISTANCE_ID) call CTI_CO_FNC_GetFriendlyTowns);
	   		_possible_town=[];
	   		{ if ((_x getVariable "cti_town_capture") == CTI_TOWNS_CAPTURE_VALUE_CEIL && ! (_x in (CTI_WEST getVariable ["CTI_ACTIVE",[]]) || _x in (CTI_EAST getVariable ["CTI_ACTIVE",[]])  )) then {_possible_town set [count _possible_town,_x]};true} count _resistance_towns;
	   		if (count _possible_town == 0) exitWith {false};
	    	_starting_town=(_possible_town select floor random count _possible_town);

	    	_pos=[_starting_town,400,600] call CTI_CO_FNC_GetRandomPosition;
	    	_roads=_pos nearRoads 500;
	    	_pos = _roads select floor random count _roads;
	    	if (count _roads >0 ) then {
	    		_pos = _roads select floor random count _roads;
		   		_group=createGroup resistance;
		   		_veh=[];
		    	{
		    		_units=(missionNamespace getVariable _x);
		    		_unit= _units select floor random count _units;
		    		_unitspos=[_pos, 50 , 100]call CTI_CO_FNC_GetRandomPosition;
		    		_unitspos=[_unitspos, 50] call CTI_CO_FNC_GetEmptyPosition;
		    		//[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED, PUBLIC, HANDLED,
						_v=[_unit, _unitspos, random(360), resistance, true, false, true] call CTI_CO_FNC_CreateVehicle;
						_v allowDammage false;
						[_v,_group] call bis_fnc_spawncrew;
						if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [([_v]),true];};
						if !( isNil "ADMIN_ZEUS") then { ADMIN_ZEUS addCuratorEditableObjects [(units _group),true];};
						//if !( isNil "GUER_ZEUS") then { GUER_ZEUS addCuratorEditableObjects [([_v]),true];};
						//if !( isNil "GUER_ZEUS") then { GUER_ZEUS addCuratorEditableObjects [(units _group),true];};
						[_v] spawn CTI_SE_FNC_HandleEmptyVehicle;
						_veh=_veh	+ [_v];
						sleep 4;
						_v allowDammage true;
		    	} forEach SM_PATROL_UNITS;
		    	SM_PATROLS = SM_PATROLS + [_group];
		    	diag_log format ["Patrols :: Creating %1 :: %2",_group,_veh];
		    	[_group,_starting_town,_veh] spawn PATROL_patrol_AI;
		    	[_group,SM_PATROLS_TO] spawn PATROL_purge_patrol;
		    	//[_group] spawn PATROL_track_patrol;
		    };
	    };
	   };
	  //==============================================
		sleep 60;
	};
};


PATROL_track_patrol={
	_group = _this select 0;
	_color = "ColorRed";
	_offset = 0;
	_lp = getPos leader _group;
	_pos= getPos (leader  _group);
	_marker2 = createMarker [format ["SM_Patrol_%1",random (1000)], _pos];
	_marker2 setMarkerType "mil_destroy";
	_marker2 setMarkerSize [0.5,0.5];
	_marker2 setMarkerColor  "ColorGreen";
	_marker2 setMarkerText format ["%1", _group];
	_marker2 setMarkerAlpha 0.7;


	while {{alive _x} count (units _group) >0 && !CTI_GameOver&& !(isNull _group)} do
	{
		_np=getPos leader _group;
		_marker2 setMarkerPos _np;
		_xdif = (_lp select 0) - (_np select 0);
		if (_xdif == 0 ) then {_xdif =1;};
		_ydif = (_lp select 1) - (_np select 1);
		if (_ydif == 0 ) then {_ydif =1;};

		_xpos = (_lp select 0) - _xdif / 2;
		_ypos = (_lp select 1) - _ydif / 2;

		_pos	= [_xpos,_ypos,0];
		_dir	= atan ( _xdif / _ydif );

		_name 	= format ["CM_%1_%2",floor(time),floor(random(1000))];
		_type	= "RECTANGLE";

		_marker = CreateMarkerLocal [_name, _pos];
		_marker setMarkerShapeLocal "RECTANGLE";
		_marker setMarkerBrushLocal "Solid";
		_marker setMarkerDirLocal _dir;
		_marker setMarkerSizeLocal [10, (((_lp distance _np)-_offset) / 2) ];
		_marker setMarkerColorLocal _color;
		_marker setMarkerAlphaLocal 1;
		_lp=_np;
		sleep 20;
	};

	deleteMarker _marker;
};

PATROL_purge_patrol={ //function to remove a patrol group if blocked or dead
	_group=_this select 0;
	_timeout= _this select 1;
	_unitclear={
		_unit=_this;
		waitUntil {(vehicle _unit == _unit) || !(alive _unit)};
		if !(alive _unit ) exitWith {false};
		_to=time+600;
		waitUntil {time > _to || !(alive _unit)};
		_unit setDamage 1;
	};
	_last_pos = getPos leader _group;
	_to_delete = false;
	_timeout_time=time + _timeout;
	{_x spawn _unitclear; true} count (units _group);

	while {({alive _x} count (units _group) >0 && !CTI_GameOver && ! _to_delete)} do
	{
	    sleep 10;
	    if (time >_timeout_time) then{
	    	diag_log format ["Patrols ::  %1 timeout %2 -- %3",_group,time,_timeout_time];
	    	if ((_last_pos distance (getPos leader _group))<300) then {_to_delete = true;};
	    	_timeout_time=time + _timeout;
	    	_last_pos = getPos leader _group;
	    };
	};
	if !(isNull _group) then {
		{(vehicle _x) setDamage 1;} forEach units _group;
		diag_log format ["Patrols :: Deleting %1",_group];
		deleteGroup _group;

		SM_PATROLS=SM_PATROLS-[_group];
	};
	SM_PATROLS=SM_PATROLS-[objNull];
};

PATROL_patrol_AI ={ // loop for each patrol group (cap town), move to next town

	_group = _this select 0;
	_current_town= _this select 1;
	_previous=objNull;
	_veh= _this select 2;
	while {!CTI_GameOver && {alive _x} count (units _group) >0 && !(isNull _group)  } do
	{
		if (_current_town getVariable "cti_town_sideID" == CTI_RESISTANCE_ID &&  !(_current_town getVariable "cti_town_occupation_active") && !(_current_town getVariable "cti_town_resistance_active") &&( (currentWaypoint _group)+1 > count (waypoints _group))) then {
			_next_target=objNull;
			_neigh=_current_town getVariable "CTI_Neigh";
			_not_valid=[];
			_priority = [];
			{
				if (count (_x nearRoads 100) <1 ) then {_not_valid=_not_valid+[_x];};
				if (_x getVariable "cti_town_sideID" != CTI_RESISTANCE_ID ) then {_priority=_priority+[_x];};
			} forEach _neigh;
			_neigh=_neigh- _not_valid -[_previous] ;
			if (count _neigh >0) then {	_next_target = _neigh select floor random (count _neigh);};
			if (count _priority >0) then {_next_target = _priority select floor random (count _priority);};
			if (isNull _next_target) then {_next_target= CTI_Towns select floor random (count CTI_Towns)};
			{deleteWaypoint _x } count (waypoints _group);
			_wp=_group addWaypoint [(getPos _next_target),0];
			_wp setWaypointType "MOVE";
			_wp  setWaypointBehaviour "AWARE" ;
			_wp  setWaypointFormation "COLUMN";
			_wp setWaypointCombatMode "RED";
			_wp setWaypointSpeed "NORMAL";
			_wp setWaypointTimeout [0,0, 0];
			if (count _priority >0) then {
				_wp setWaypointSpeed "FULL";
				_wp  setWaypointBehaviour "COMBAT" ;
			};
			_wp setWaypointCompletionRadius 150;
			_previous=_current_town;
			_current_town = _next_target;
			_group setCurrentWaypoint _wp;
			diag_log format ["Patrols :: %1 moving to %2",_group,(_current_town getVariable "cti_town_name")];
		};
		sleep 10;
	};
};
sleep 1;

0 spawn PATROL_server_WD;

*/