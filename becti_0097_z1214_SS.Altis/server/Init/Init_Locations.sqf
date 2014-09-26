Private ['_boundaries','_camps','_eStart','_half','_initied','_limit','_minus','_near','_nearTownsE','_nearTownsW','_require','_resTowns','_total','_town','_towns','_wStart','_z'];

waitUntil {!isNil 'CTI_InitTowns'};

//--- Special Towns mode.
switch (missionNamespace getVariable "CTI_TOWNS_STARTING_MODE") do {
	//--- 50-50.
	case 1: {
		diag_log "Working";
		_half = round(count CTI_Towns)/2;
		_wStart = (west Call CTI_CO_FNC_GetSideLogic) getVariable "cti_start_pos";
		_eStart = (east Call CTI_CO_FNC_GetSideLogic) getVariable "cti_start_pos";
		diag_log _wstart;
		diag_log _estart;
		diag_log CTI_Towns;
		_nearTownsW = [];
		_nearTownsE = [];
		
		_near = [_wStart,CTI_Towns] Call CTI_CO_FNC_SortByDistance;
		if (count _near > 0) then {
			for [{_z = 0},{_z < _half},{_z = _z + 1}] do {_nearTownsW = _nearTownsW + [_near select _z]};
		};
		
		_nearTownsE = (CTI_Towns - _nearTownsW);
		
		{
			_x setVariable ['cti_town_sideID',CTI_WEST_ID,true];
			_camps = _x getVariable "camps";
			{_x setVariable ['cti_town_sideID',CTI_WEST_ID,true]} forEach _camps;
		} forEach _nearTownsW;
		{
			_x setVariable ['cti_town_sideID',CTI_EAST_ID,true];
			_camps = _x getVariable "camps";
			{_x setVariable ['cti_town_sideID',CTI_EAST_ID,true]} forEach _camps;
		} forEach _nearTownsE;
	};
	
	//--- Nearby Towns.
	case 2: {
		_total = count CTI_Towns;
		_wStart = (west Call CTI_CO_FNC_GetSideLogic) getVariable "cti_start_pos";
		_eStart = (east Call CTI_CO_FNC_GetSideLogic) getVariable "cti_start_pos";
		_limit = floor(_total / 6);
		_nearTownsW = [];
		_nearTownsE = [];
		
		_near = [_wStart,CTI_Towns] Call CTI_CO_FNC_SortByDistance;
		if (count _near > 0) then {
			for [{_z = 0},{_z < _limit},{_z = _z + 1}] do {_nearTownsW = _nearTownsW + [_near select _z]};
		};
		
		_near = [_eStart,(CTI_Towns - _nearTownsW)] Call CTI_CO_FNC_SortByDistance;
		if (count _near > 0) then {
			for [{_z = 0},{_z < _limit},{_z = _z + 1}] do {_nearTownsE = _nearTownsE + [_near select _z]};
		};
		
		{
			_x setVariable ['cti_town_sideID',CTI_WEST_ID,true];
			_camps = _x getVariable "camps";
			{_x setVariable ['cti_town_sideID',CTI_WEST_ID,true]} forEach _camps;
		} forEach _nearTownsW;
		{
			_x setVariable ['cti_town_sideID',CTI_EAST_ID,true];
			_camps = _x getVariable "camps";
			{_x setVariable ['cti_town_sideID',CTI_EAST_ID,true]} forEach _camps;
		} forEach _nearTownsE;
	};
	
	//--- Random Towns (25% East, 25% West, 50% Res).
	case 3: {
		_total = count CTI_Towns;
		_half = round(count CTI_Towns)/4;
		_minus = round(count CTI_Towns)/2;
		_nearTownsW = [];
		_resTowns = [];
		_towns = +CTI_Towns;

		//--- No boundaries defined, we use a random system.
		for '_z' from 0 to _minus-1 do {
			_town = _towns select round(random((count _towns)-1));
			_towns = _towns - [_town];
			if (count _nearTownsW < _half) then {
				_nearTownsW = _nearTownsW + [_town];
				_town setVariable ['cti_town_sideID',CTI_WEST_ID,true];
				_camps = _town getVariable "camps";
				{_x setVariable ['cti_town_sideID',CTI_WEST_ID,true]} forEach _camps;
			} else {
				_town setVariable ['cti_town_sideID',CTI_EAST_ID,true];
				_camps = _town getVariable "camps";
				{_x setVariable ['cti_town_sideID',CTI_EAST_ID,true]} forEach _camps;
			};
		};	
	};
};

/*--- Resistance Patrols. to be implemented.
if ((missionNamespace getVariable "CTI_TOWNS_STARTING_MODE") != 1 && ((missionNamespace getVariable "CTI_TOWNS_PATROLS") > 0)) then {
	_require = if ((missionNamespace getVariable "CTI_TOWNS_PATROLS") > count CTI_Towns) then {count CTI_Towns} else {missionNamespace getVariable "CTI_TOWNS_PATROLS"};
	_initied = 0;
	_towns = CTI_Towns;
	
	//--- Don't bother with the randomizer if the amount set in RESPATROLMAX is >= count towns.
	while {_initied < _require} do {
		if (_require == count CTI_Towns) then {
			// [_towns select _initied] ExecFSM "Server\FSM\respatrol.fsm";
			(_towns select _initied) setVariable ["cti_patrol_enabled", true];
			_initied = _initied + 1;
		} else {
			if (random 2 > 1) then {
				_town = _towns select floor (random count _towns);
				// _town = [_towns select (round(random((count _towns)-1)))] ExecFSM "Server\FSM\respatrol.fsm";
				_town setVariable ["cti_patrol_enabled", true];
				_towns = _towns - [_town];
				_initied = _initied + 1;
			};
		};
	};
};*/

CTI_Init_TownMode = true;

if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Init\Init_Locations.sqf", "Town starting mode is done."] Call CTI_CO_FNC_Log};