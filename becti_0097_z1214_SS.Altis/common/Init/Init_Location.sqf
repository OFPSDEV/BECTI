private ["_sideID", "_town", "_town_name", "_town_side", "_town_value"];

_town = _this select 0;
_town_name = _this select 1;
_town_side = _this select 2;
_town_capture_rate = _this select 3;
_town_value = _this select 4;
_townRange = if (count _this > 5) then {_this select 5} else {550};

_town setVariable ["cti_town_name", _town_name];
_town setVariable ["cti_town_range",_townRange];

_CENTER_POS=getMarkerPos "CENTER_POS";
_CENTER_RADIUS=(getMarkerSize "CENTER_POS")select 0;

if ((_town distance _CENTER_POS)>_CENTER_RADIUS) exitwith {true};

if (count _this > 4) then {
	_forced_neigh= _this select 4;
	_town setVariable ["cti_town_fneigh", _forced_neigh];
};

_town setVariable ["cti_town_inactive", false];
if (_town_name in TownTemplate) exitWith {
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Common\Init\Init_Location.sqf", Format ["Removed town [%1] since it is disabled.", _town_Name]] Call CTI_CO_FNC_Log};
	_town setVariable ["cti_town_inactive", true];
};

if (isNull _town || (_town getVariable "cti_town_inactive")) exitWith {};


waitUntil {!isNil 'CTI_Init_JIP' && !isNil 'CTI_Init_Common'};

_sideID = _town_side call CTI_CO_FNC_GetSideID;

if (CTI_IsServer) then {
	_town setVariable ["cti_town_sideID", _sideID, true];
	_town setVariable ["cti_town_lastSideID", _sideID, true];
	_town setVariable ["cti_town_capture_rate", _town_capture_rate, true];
	_town setVariable ["cti_town_value", _town_value, true];
	
	(_town) execFSM "Server\FSM\town_capture.fsm";
	if (missionNamespace getVariable "CTI_TOWNS_RESISTANCE" > 0) then {(_town) execFSM "Server\FSM\town_resistance.fsm"};
	if (missionNamespace getVariable "CTI_TOWNS_OCCUPATION" > 0) then {(_town) execFSM "Server\FSM\town_occupation.fsm"};

	Private ["_camps", "_synced"];
	_camps = [];
	_defenses = [];
	_mortars = [];
		
	for '_i' from 0 to count(synchronizedObjects _town)-1 do {
		_synced = (synchronizedObjects _town) select _i;
		if (typeOf _synced == "LocationCamp_F" && (missionNamespace getVariable "CTI_TOWNS_CAMPS_CREATE") > 0) then {
			[_camps, _synced] Call CTI_CO_FNC_ArrayPush;
			_synced setVariable ["town", _town];
		};
		if (!isNil {_synced getVariable "cti_defense_kind"}) then {[_defenses, _synced] Call CTI_CO_FNC_ArrayPush};
		if (!isNil {_synced getVariable "cti_mortar"}) then {[_mortars, _synced] Call CTI_CO_FNC_ArrayPush};
	};
			
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Common\Init\Init_Location.sqf", format ["Found [%1] synchronized camps in [%2].", count _camps, _town getVariable "cti_town_name"]] call CTI_CO_FNC_Log};
	
	if (count _mortars > 0) then {
		_town setVariable ["cti_town_mortars", _mortars];
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Common\Init\Init_Location.sqf" ,Format ["Found [%1] synchronized mortar position in [%2].", count _mortars, _town getVariable "cti_town_name"]] Call CTI_CO_FNC_Log};
	};
	
	_town setVariable ["camps", _camps, true];
	_town setVariable ["cti_town_defenses", _defenses];

	[_town, _town_side] spawn {
		Private ["_camps","_defenses","_marker","_size","_town","_townModel"];
		_town = _this select 0;
		_town_side = _this select 1;
		_sideID = _town_side call CTI_CO_FNC_GetSideID;
		_camps = _town getVariable "camps";

		//--- Create the depot model
		_townModel = createVehicle [missionNamespace getVariable "CTI_CO_DEPOT", getPos _town, [], 0, "NONE"];
		_townModel setDir ((getDir _town) + (missionNamespace getVariable "CTI_CO_DEPOT_RDIR"));
		_townModel setPos (getPos _town);
		_townModel addEventHandler ["handleDamage", {false}];

		if (isNil {_town getVariable "cti_town_sideID"}) then {_town setVariable ["cti_town_sideID",_sideID,true]};
		sleep (random 1);
		
		waitUntil {!isNil 'CTI_Init_Server'};
	
		{
			Private ["_camp_health","_flag","_pos","_townModel"];
			//--- Create the camp model.
			_townModel = createVehicle [missionNamespace getVariable "CTI_CO_CAMP", getPos _x, [], 0, "NONE"];
			_townModel setDir ((getDir _x) + (missionNamespace getVariable "CTI_CO_CAMP_RDIR"));
			_townModel setPos (getPos _x);
			_townModel addEventHandler ["handleDamage", {false}]; //--- Seems the camp models are indestructable in A3 :/
			//_townModel addEventHandler ["killed", {(_this select 0) Spawn CTI_SE_FNC_OnBuildingDestroyed}];
			
			
			//--- Create a flag near the camp location & position it.
			_flag = createVehicle [missionNamespace getVariable "CTI_CO_CAMP_FLAG", getPos _x, [], 0, "NONE"];
			_flag setFlagTexture (missionNamespace getVariable Format["CTI_%1FLAG", _town_side]);
			_pos = _x modelToWorld (missionNamespace getVariable "CTI_CO_CAMP_FLAG_POS");
			_pos set [2, 0];
			_flag setPos _pos;
			
			_x setVariable ["CTI_flag", _flag];
			
			//--- Initialize the camp.
			if (isNil {_x getVariable "cti_town_sideID"}) then {_x setVariable ["cti_town_sideID",_sideID, true]};
			if (isNil {_x getVariable "cti_camp_value"}) then {
				waitUntil {!isNil {missionNamespace getVariable "CTI_TOWNS_CAPTURE_VALUE_CEIL"}};
				_x setVariable ["cti_camp_value", (CTI_TOWNS_CAPTURE_VALUE_CEIL/6), true]; 
				_x setVariable ["CTI_CO_CAMP_BUNKER", _townModel, true];
				[_x, _town, _flag] Spawn {sleep random 2; _this execFSM 'Server\FSM\town_camp.fsm'};
			};
		} forEach _camps;	
		
		waitUntil {!isNil 'CTI_Init_TownMode'};
		
		//--- Prepare the default defenses (if needed and if occupation or defender is present).	
		if ((_town getVariable "cti_town_sideID") != CTI_UNKNOWN_ID && ((missionNamespace getVariable "CTI_TOWNS_RESISTANCE") > 0 || (missionNamespace getVariable "CTI_TOWNS_OCCUPATION") > 0)) then {
			[_town, (_town getVariable "cti_town_sideID") Call CTI_CO_FNC_GetSideFromID, -1] Call CTI_SE_FNC_ManageTownDefenses;
		};
	};
	_current_side = _sideID call CTI_CO_FNC_GetSideFromID;
	_town setFlagTexture ( _current_side call CTI_CO_FNC_GetSideFlag);
};

if (CTI_IsClient) then {
	//--- The client awaits for the MP variable to be available
	waitUntil {CTI_Init_Client};

	waitUntil {!(isNil {_town getVariable "cti_town_sideID"}) && !(isNil {_town getVariable "cti_town_lastSideID"})};
	
	_town setVariable ["cti_structure_type", CTI_DEPOT];
	missionNamespace setVariable [format["CTI_%1_DEPOT", (CTI_P_SideJoined)], [[CTI_DEPOT, "Depot"],[],[],[],[180,15]]];

	//--- We retrieve the current side
	_current_side = (_town getVariable "cti_town_sideID") call CTI_CO_FNC_GetSideFromID;

	_coloration = CTI_RESISTANCE_COLOR;

	if (CTI_P_SideID in [_town getVariable "cti_town_lastSideID", _town getVariable "cti_town_sideID"] && !(CTI_P_SideJoined == resistance)) then { //--- Environment awareness
		_coloration = _current_side call CTI_CO_FNC_GetSideColoration;
	};

	_camps = _town getVariable "camps";
	for '_i' from 0 to count(_camps)-1 do {
		_camp = _camps select _i;
		_camp setVariable ["CTI_Camp_Marker", Format ["CTI_%1_CityMarker_Camp%2", str _town, _i]];
		_camp setVariable ["town", _town];
	};

	
	//--- Area marker
	_marker = createMarkerLocal [format ["cti_town_areaMarker_%1", _town], getPos _town];
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerBrushLocal "SolidBorder";
	_marker setMarkerSizeLocal [CTI_MARKERS_TOWN_AREA_RANGE, CTI_MARKERS_TOWN_AREA_RANGE];
	_marker setMarkerColorLocal _coloration;
	_marker setMarkerAlphaLocal 0;

	//--- Center marker
	_marker = createMarkerLocal [format ["cti_town_marker_%1", _town], getPos _town];
	_marker setMarkerTypeLocal "mil_flag";
	_marker setMarkerTextLocal format["%1 :: %2",_town_name, _town_value];
	_marker setMarkerColorLocal _coloration;
	_marker setMarkerSizeLocal [0.3, 0.3];
	// _marker setMarkerAlphaLocal CTI_MARKERS_OPACITY;
	// --- ZertyWasHere basejumps

	_marker = createMarkerLocal [format ["cti_town_HALLOMarker_%1", _town], getPos _town];
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerBrushLocal "Border";
	_marker setMarkerSizeLocal [CTI_MARKERS_TOWN_AREA_RANGE*CTI_HALO_RATIO, CTI_MARKERS_TOWN_AREA_RANGE*CTI_HALO_RATIO];
	_marker setMarkerColorLocal "ColorYellow";
	_marker setMarkerAlphaLocal 0;
	
	//--- Camp markers
	{
		private ["_campMarker"];
		_campMarker = _x getVariable "CTI_Camp_Marker";
		createMarkerLocal [ _campmarker, getPos _x];
		_campmarker setMarkerTypeLocal "n_unknown";
		_campmarker setMarkerColorLocal _coloration;
		_campmarker setMarkerSizeLocal [0.35, 0.35]; 
	} forEach _camps;


};