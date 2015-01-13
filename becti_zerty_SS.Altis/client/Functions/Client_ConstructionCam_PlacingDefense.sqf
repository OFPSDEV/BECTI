/*
  # HEADER #
	Script: 		Client\Functions\Client__ConstructionCam_PlacingDefense.sqf
	Alias:			CTI_CL_FNC_PlacingDefense
	Description:	Prepare the placement of a defense before the construction
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	14-10-2013

  # PARAMETERS #
    0	[String]: The defense variable name
    1	[Object]: The center (construction center)
    2	[Number]: The construction radius

  # RETURNED VALUE #
	None

  # SYNTAX #
	[DEFENSE VARIABLE, CENTER, RADIUS] spawn CTI_CL_FNC_ConstructionCam_PlacingDefense

  # DEPENDENCIES #
	Client Function: CTI_CL_FNC_ChangePlayerFunds
	Client Function: CTI_CL_FNC_GetPlayerFunds
	Common Function: CTI_CO_FNC_GetDirTo
	Common Function: CTI_CO_FNC_NetSend

  # EXAMPLE #
    [_selected, CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, CTI_BASE_CONSTRUCTION_RANGE] spawn CTI_CL_FNC_ConstructionCam_PlacingDefense;
*/

_variable = _this select 0;
_center = _this select 1;
_center_distance = _this select 2;

_buildingID = CTI_ConstructionCam_BuildingID;

CTI_P_KeyRotate = 0;
CTI_P_KeyDistance = 0;
CTI_P_KeyDistance_Min = -10;
CTI_P_KeyDistance_Max = 20;

while {(_buildingID == CTI_ConstructionCam_BuildingID)} do {
	_var = missionNamespace getVariable _variable;
	CTI_VAR_StructurePlaced = false;
	CTI_VAR_StructureCanceled = false;
	CTI_P_PreBuilding = true;

	_classname = _var select 1;
	_local = _classname createVehicleLocal getPos player;
	_direction_structure = (_var select 4) select 0;
	_distance_structure = (_var select 4) select 1;

	// {_local disableCollisionWith _x} forEach (_center nearEntities (_center_distance+500));

	_last_collision_update = -600;
	_condition = {true};
	{if (_x select 0 == "Condition") exitWith {_condition = _x select 1}} forEach (_var select 5);

	_dir = 0;
	_pos = [];
	while {!CTI_VAR_StructurePlaced && !CTI_VAR_StructureCanceled && (_buildingID == CTI_ConstructionCam_BuildingID)} do {
		//_pos = player modelToWorld [0, _distance_structure + CTI_P_KeyDistance, 0];
		_pos = CTI_ConstructionCam_MouseLoc;
		
		
	
		// CSM here is the checking for bad placing areas
		_areaFlatEmpty = true;
		_flatEmpty = _pos isFlatEmpty [2,0,0.7,2,0,true,_local];
		//if ((count _flatEmpty)  == 0) then {_areaFlatEmpty = false;};
		
		//CTI_P_PreBuilding_SafePlace = if (_pos distance (((CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic) getVariable "cti_hq") >15 && _pos distance ([_pos, CTI_P_SideJoined call CTI_CO_FNC_GetSideStructures] call CTI_CO_FNC_GetClosestEntity) >15 && _pos distance ( [_pos, ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic) getVariable "cti_structures_wip"] call CTI_CO_FNC_GetClosestEntity) >15 && _pos distance ( [_pos, ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic) getVariable "cti_fobs"] call CTI_CO_FNC_GetClosestEntity) >15 && !surfaceIsWater _pos && !(lineIntersects [ATLtoASL (player modelToWorld (player selectionPosition "pilot")),ATLtoASL (_local modelToWorld (_local selectionPosition "pilot")), player, _local])) then {true} else {false};
		CTI_P_PreBuilding_SafePlace = if (_pos distance (((CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic) getVariable "cti_hq") >15 && _pos distance ([_pos, CTI_P_SideJoined call CTI_CO_FNC_GetSideStructures] call CTI_CO_FNC_GetClosestEntity) >15 && _pos distance ( [_pos, ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic) getVariable "cti_structures_wip"] call CTI_CO_FNC_GetClosestEntity) >15 && _pos distance ( [_pos, ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic) getVariable "cti_fobs"] call CTI_CO_FNC_GetClosestEntity) >15 && !surfaceIsWater _pos && _areaFlatEmpty) then {true} else {false};
		if (time - _last_collision_update > 1.5) then {_last_collision_update = time;{_local disableCollisionWith _x} forEach (player nearObjects 150)};
		if (_center distance player > _center_distance || !alive _center) exitWith { CTI_VAR_StructureCanceled = true };

		_dir = CTI_ConstructionCam_Rotation;
		_pos set [2, 0];
		_local setPos _pos;
		_local setDir _dir;

		sleep .01;
	};

	CTI_P_PreBuilding = false;
	deleteVehicle _local;


	if (!(CTI_VAR_StructureCanceled) && (_buildingID == CTI_ConstructionCam_BuildingID)) then {
		if (call _condition) then {
			_funds = call CTI_CL_FNC_GetPlayerFunds;
			if (_funds >= (_var select 2)) then {
				-(_var select 2) call CTI_CL_FNC_ChangePlayerFunds;
				["SERVER", "Request_Defense", [_variable, CTI_P_SideJoined, [_pos select 0, _pos select 1], _dir, player, CTI_P_WallsAutoAlign, CTI_P_DefensesAutoManning]] call CTI_CO_FNC_NetSend;
			} else {
				player groupChat format ["HQ: Insufficient Funds."];
			};

			_fob = false;
			{if (_x select 0 == "FOB") exitWith {_fob = true}} forEach (_var select 5);
			if (_fob) then {CTI_P_TeamsRequests_FOB = 0};
		} else {
			player groupChat format ["HQ: Not all conditions are met to construct this defense."];
		};
	};
};
