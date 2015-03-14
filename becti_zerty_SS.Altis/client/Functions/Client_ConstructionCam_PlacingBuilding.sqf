/*
  # HEADER #
	Script: 		Client\Functions\Client_ConstructionCam_PlacingBuilding.sqf
	Alias:			CTI_CL_FNC_ConstructionCam_PlacingBuilding
	Description:	Prepare the placement of a structure before the construction
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    0	[String]: The structure variable name
    1	[Object]: The center (construction center)
    2	[Number]: The construction radius

  # RETURNED VALUE #
	None

  # SYNTAX #
	[STRUCTURE VARIABLE, CENTER, RADIUS] spawn CTI_CL_FNC_ConstructionCam_PlacingBuilding

  # DEPENDENCIES #
	Client Function: CTI_CL_FNC_ChangePlayerFunds
	Client Function: CTI_CL_FNC_GetPlayerFunds
	Common Function: CTI_CO_FNC_GetDirTo
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
    [_selected, CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, CTI_BASE_CONSTRUCTION_RANGE] spawn CTI_CL_FNC_ConstructionCam_PlacingBuilding;
*/

_variable = _this select 0;
_center = _this select 1;
_center_distance = _this select 2;

CTI_VAR_StructureCanceled = false;
CTI_P_PreBuilding = true;
CTI_P_PreBuilding_SafePlace = false;

_buildingID = CTI_ConstructionCam_BuildingID;
_var = missionNamespace getVariable _variable;
_local = ((_var select 1) select 0) createVehicleLocal CTI_ConstructionCam_MouseLoc;
_direction_structure = (_var select 4) select 0;
_distance_structure = (_var select 4) select 1;
_last_collision_update = -600;
_pos = [];
_dir = 0;
_helper_blue = "Sign_Arrow_Large_Blue_F" createVehicleLocal CTI_ConstructionCam_MouseLoc;
_helper_red = "Sign_Sphere100cm_F" createVehicleLocal CTI_ConstructionCam_MouseLoc;

while {!CTI_VAR_StructurePlaced && !CTI_VAR_StructureCanceled && (call CTI_CL_FNC_IsPlayerCommander) && (_buildingID == CTI_ConstructionCam_BuildingID)} do {

	_pos = CTI_ConstructionCam_MouseLoc;
	
	if (time - _last_collision_update > 1.5) then {_last_collision_update = time;{_local disableCollisionWith _x} forEach (_helper_blue nearObjects 150)};
	CTI_P_PreBuilding_SafePlace = if (_pos distance ([_pos, CTI_P_SideJoined call CTI_CO_FNC_GetSideStructures] call CTI_CO_FNC_GetClosestEntity) >20 && _pos distance ( [_pos, ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic) getVariable "cti_structures_wip"] call CTI_CO_FNC_GetClosestEntity) >20 && !surfaceIsWater _pos && !(lineIntersects [ATLtoASL (_helper_blue modelToWorld (_helper_blue selectionPosition "pilot")),ATLtoASL (_local modelToWorld (_local selectionPosition "pilot")), player, _local])) then {true} else {false};
	
	_dir = CTI_ConstructionCam_Rotation;
	_pos set [2, 0];
	_local setPos _pos;
	_local setDir _dir;
	_helper_pos = _local modelToWorld [(sin (360 -_direction_structure) * _distance_structure), (cos (360 -_direction_structure) * _distance_structure), 0];
	_helper_pos set [2, 0];
	
	_helper_blue setPos _helper_pos;
	_helper_blue setDir _dir;
	
	if !(CTI_P_PreBuilding_SafePlace) then {
		_helper_pos set [2, 0.5];
		_helper_red setPos _helper_pos;
		_helper_red setDir _dir;
	} else {
		_helper_pos set [0, 0];
		_helper_pos set [1, 0];
		_helper_pos set [2, -1];
		_helper_red setPos _helper_pos;
	};
	sleep .01;
};

CTI_P_PreBuilding = false;

detach _helper_blue;
detach _helper_red;
deleteVehicle _helper_blue;
deleteVehicle _helper_red;
deleteVehicle _local;


//--- First check if the surface is water based
if (surfaceIsWater _pos) exitWith {hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />The structure may not be placed here."};

//--- Check the distance 2D between our position and the potential areas
_in_area = false;
{if ([_pos select 0, _pos select 1] distance [_x select 0, _x select 1] <= CTI_BASE_AREA_RANGE) exitWith {_in_area = true}} forEach (CTI_P_SideLogic getVariable "cti_structures_areas");

//--- Check for empty base areas
if (!(_in_area) && !(CTI_VAR_StructureCanceled) && (((_var select 0) select 0) isEqualTo "MilitaryInstallation") && (_buildingID == CTI_ConstructionCam_BuildingID)) then {
	
	_logic = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;
	_total_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
	// Check for empty base areas.
	_updated_areas = [];
	_ruins = _logic getVariable "cti_structures_wip";
	if !(isNil '_ruins') then {_total_structures = _total_structures + _ruins};
	{
		_y = _x; // _y is base area
		_building_count = 0;
		{
			// Retrieve 2d distance
			// Let A = (Ax - Bx), B = (Ay - By)
			// D^2 = A^2 + B^2
			_aPos = getPos _x;
			_bPos = _y; // structure areas not an object.
			_abX = ((_aPos select 0) - (_bPos select 0));
			_abY = ((_aPos select 1) - (_bPos select 1));
			_d = sqrt ((_abX * _abX)+(_abY * _abY));

			if (_d <= CTI_BASE_AREA_RANGE) then {
				_building_count = _building_count + 1;
			};
		} forEach (_total_structures);
		if (_building_count > 0) then {
			_updated_areas = _updated_areas + [_x];
		};
	} forEach (CTI_P_SideLogic getVariable "cti_structures_areas");
	CTI_P_SideLogic setVariable ["cti_structures_areas", _updated_areas, true];
};

//--- Maybe we have no area in range?
if (!(_in_area) && ! CTI_VAR_StructureCanceled && (_buildingID == CTI_ConstructionCam_BuildingID)) then {
	//--- If we have none, then have we reached our limit?
	
	if (count (CTI_P_SideLogic getVariable "cti_structures_areas") < CTI_BASE_AREA_MAX) then {
	
		//--- We create a new area if we still have room for areas and of course, we allow the construction
		CTI_P_SideLogic setVariable ["cti_structure_building_canceled", 0];
		if(((_var select 0) select 0) isEqualTo "MilitaryInstallation") then {
			_in_area = true;
			CTI_P_SideLogic setVariable ["cti_structures_areas", (CTI_P_SideLogic getVariable "cti_structures_areas") + [[_pos select 0, _pos select 1]], true];
		} else {
			CTI_VAR_StructureCanceled = true;
			player groupChat format ["HQ: You Must Build Inside of an Established Military Installation."];
		}; 
	} else {
		CTI_VAR_StructureCanceled = true;
		player groupChat format ["HQ: The base area limit has been reached."];
	};
} else {

};

//--- Check to see if building inside of "Established" military installation...
if (_in_area && !CTI_VAR_StructureCanceled && (_buildingID == CTI_ConstructionCam_BuildingID)) then {
	// if in range but construction is another military installation... 
	if(!(((_var select 0) select 0) isEqualTo "MilitaryInstallation")) then {
		_check_in_range = false;
		{
			if ((_x getVariable "cti_structure_type") == "MilitaryInstallation") then {
				
				// Retrieve 2d distance
				// Let A = (Ax - Bx), B = (Ay - By)
				// D^2 = A^2 + B^2
				_aPos = getPos _x;
				_bPos = _pos;
				_abX = ((_aPos select 0) - (_bPos select 0));
				_abY = ((_aPos select 1) - (_bPos select 1));
				_d = sqrt ((_abX * _abX)+(_abY * _abY));
				// Check distance for build
				if (_d < CTI_BASE_AREA_RANGE) then {
					_check_in_range = true;
				};
				//diag_log format ["OLD!!!_x: %1 _pos : %2", (getPos _x), _pos];
				//diag_log format ["OLD!!!Distance: %1", (_x distance _pos)];
				//diag_log format ["_x: %1 _pos : %2", _aPos, _bPos];
				//diag_log format ["Distance: %1", _d];
			};
		} forEach ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures);
		CTI_VAR_StructureCanceled = !_check_in_range;
		if (!_check_in_range) then {
			player groupChat format ["HQ: You Must Build Inside of an Established Military Installation."];
		};
	};
};

// end csm


//--- If there's no problems then we place it.
if (!CTI_VAR_StructureCanceled && (call CTI_CL_FNC_IsPlayerCommander) && (_buildingID == CTI_ConstructionCam_BuildingID)) then {
	if ((call CTI_CL_FNC_GetPlayerFunds) >= (_var select 2)) then {
	
		
			_tracking_point = [_pos select 0, _pos select 1];
			_markerLocal = createMarkerLocal [Format ["cti_structure_%1", CTI_P_MarkerIterator], [_pos select 0, _pos select 1]];
			CTI_P_MarkerIterator = CTI_P_MarkerIterator + 1;
			_markerLocal setMarkerTypeLocal format["%1installation", CTI_P_MarkerPrefix];
			_markerLocal setMarkerColorLocal "ColorBlack";
			_markerLocal setMarkerSizeLocal [0.75, 0.75];
			_markerLocal setMarkerTextLocal ((_var select 0) select 0);
			// end csm
	
		// Place it
		-(_var select 2) call CTI_CL_FNC_ChangePlayerFunds;
		["SERVER", "Request_Building", [_variable, CTI_P_SideJoined, [_pos select 0, _pos select 1], _dir, player]] call CTI_CO_FNC_NetSend;
	
		sleep 5;
		
		
		// waitUntil[]
		
		_logic_placed_building = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;
		_ruins_placed_building = _logic_placed_building getVariable "cti_structures_wip";
		_keep_tracking = false;
		if (!(isNil '_ruins_placed_building')) then {
			// csm
			
			_keep_tracking = true;
			while{ _keep_tracking } do {
				sleep 5;
				_keep_tracking = false;
				_temp_logic_placingBuilding = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;
				_temp_ruins_placingBuilding = _temp_logic_placingBuilding getVariable "cti_structures_wip";
				{
					_distance_markerbuilding = (getPos _x) distance _tracking_point;
					if(_distance_markerbuilding <= 5)then { _keep_tracking = true };
				}forEach (_temp_ruins_placingBuilding);
			};
		};
		deleteMarkerLocal _markerLocal;
		// end csm
	} else {
		player groupChat format ["HQ: Insufficient Funds."];
		
	};
};

