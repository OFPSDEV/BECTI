

CTI_P_SideJoined = side player;

CTI_P_SideID = CTI_P_SideJoined call CTI_CO_FNC_GetSideID;
CTI_P_SideLogic = CTI_P_SideJoined call CTI_CO_FNC_GetSideLogic;

player setPos ([getMarkerPos format["CTI_%1Respawn", CTI_P_SideJoined], 3, 15] call CTI_CO_FNC_GetRandomPosition); //--- Preplace

CTI_CL_FNC_AddMissionActions = compileFinal preprocessFile "Client\Functions\Client_AddMissionActions.sqf";
CTI_CL_FNC_ChangePlayerFunds = compileFinal preprocessFile "Client\Functions\Client_ChangePlayerFunds.sqf";
CTI_CL_FNC_Commander_VoteStart = compileFinal preprocessFile "Client\Functions\Client_Commander_VoteStart.sqf";
CTI_CL_FNC_Commander_VoteEnd = compileFinal preprocessFile "Client\Functions\Client_Commander_VoteEnd.sqf";
CTI_CL_FNC_DisplayMessage = compileFinal preprocessFile "Client\Functions\Client_DisplayMessage.sqf";
CTI_CL_FNC_GetAIDigit = compileFinal preprocessFile "Client\Functions\Client_GetAIDigit.sqf";
CTI_CL_FNC_GetAIOrderLabel = compileFinal preprocessFile "Client\Functions\Client_GetAIOrderLabel.sqf";
CTI_CL_FNC_GetIncomes = compileFinal preprocessFile "Client\Functions\Client_GetIncomes.sqf";
CTI_CL_FNC_GetOrderLabel = compileFinal preprocessFile "Client\Functions\Client_GetOrderLabel.sqf";
CTI_CL_FNC_GetPlayerFunds = compileFinal preprocessFile "Client\Functions\Client_GetPlayerFunds.sqf";
CTI_CL_FNC_GetPlayerIncome = compileFinal preprocessFile "Client\Functions\Client_GetPlayerIncome.sqf";
CTI_CL_FNC_GetMissionTime = compileFinal preprocessFile "Client\Functions\Client_GetMissionTime.sqf";
CTI_CL_FNC_HasAIOrderChanged = compileFinal preprocessFile "Client\Functions\Client_HasAIOrderChanged.sqf";
CTI_CL_FNC_HookVehicle = compileFinal preprocessFile "Client\Functions\Client_HookVehicle.sqf";
CTI_CL_FNC_IsPlayerCommander = compileFinal preprocessFile "Client\Functions\Client_IsPlayerCommander.sqf";
CTI_CL_FNC_InitializeStructure = compileFinal preprocessFile "Client\Functions\Client_InitializeStructure.sqf";
CTI_CL_FNC_JoinRequestAnswer = compileFinal preprocessFile "Client\Functions\Client_JoinRequestAnswer.sqf";
CTI_CL_FNC_PlacingBuilding = compileFinal preprocessFile "Client\Functions\Client_PlacingBuilding.sqf";
CTI_CL_FNC_PlacingDefense = compileFinal preprocessFile "Client\Functions\Client_PlacingDefense.sqf";
CTI_CL_FNC_OnExplosivePlaced = compileFinal preprocessFile "Client\Functions\Client_OnExplosivePlaced.sqf";
CTI_CL_FNC_OnHQDestroyed = compileFinal preprocessFile "Client\Functions\Client_OnHQDestroyed.sqf";
CTI_CL_FNC_OnFriendlyStructureDestroyed = compileFinal preprocessFile "Client\Functions\Client_OnFriendlyStructureDestroyed.sqf";
CTI_CL_FNC_OnJailed = compileFinal preprocessFile "Client\Functions\Client_OnJailed.sqf";
CTI_CL_FNC_OnMissionEnding = compileFinal preprocessFile "Client\Functions\Client_OnMissionEnding.sqf";
CTI_CL_FNC_OnPlayerFired = compileFinal preprocessFile "Client\Functions\Client_OnPlayerFired.sqf";
CTI_CL_FNC_OnPlayerKilled = compileFinal preprocessFile "Client\Functions\Client_OnPlayerKilled.sqf";
CTI_CL_FNC_OnPurchaseDelegationReceived = compileFinal preprocessFile "Client\Functions\Client_OnPurchaseDelegationReceived.sqf";
CTI_CL_FNC_OnPurchaseOrderReceived = compileFinal preprocessFile "Client\Functions\Client_OnPurchaseOrderReceived.sqf";
CTI_CL_FNC_OnStructureConstructed = compileFinal preprocessFile "Client\Functions\Client_OnStructureConstructed.sqf";
CTI_CL_FNC_OnTownCaptured = compileFinal preprocessFile "Client\Functions\Client_OnTownCaptured.sqf";
CTI_CL_FNC_PurchaseUnit = compileFinal preprocessFile "Client\Functions\Client_PurchaseUnit.sqf";
CTI_CL_FNC_RemoveRuins = compileFinal preprocessFile "Client\Functions\Client_RemoveRuins.sqf";
CTI_CL_FNC_ConstructionCam_PlacingBuilding = compileFinal preprocessFile "Client\Functions\Client_ConstructionCam_PlacingBuilding.sqf";
CTI_CL_FNC_ConstructionCam_PlacingDefense = compileFinal preprocessFile "Client\Functions\Client_ConstructionCam_PlacingDefense.sqf";
JRG_welcomeScreen= compileFinal preprocessFileLineNumbers "Addons\fn_welcomeScreen.sqf";
Addon_Simple_Earplugs = compileFinal preprocessFile "addons\ear_plugs\simpleEP.sqf";

call compile preprocessFileLineNumbers "Client\Functions\FSM\Functions_FSM_UpdateClientAI.sqf";
call compile preprocessFileLineNumbers "Client\Functions\FSM\Functions_FSM_UpdateOrders.sqf";

CTI_P_SideColor = switch (CTI_P_SideJoined) do { case west: {CTI_WEST_COLOR}; case east: {CTI_EAST_COLOR}; case resistance: {CTI_RESISTANCE_COLOR}; default {"ColorBlack"} };
CTI_P_MarkerPrefix = switch (CTI_P_SideJoined) do { case west: {"b_"}; case east: {"o_"}; case resistance: {"n_"}; default {""} };
CTI_P_ChatID = [CTI_P_SideJoined,"HQ"];
CTI_P_MarkerIterator = 0;
CTI_P_PurchaseRequests = [];
CTI_P_Commander = grpNull;
CTI_P_TeamsRequests = [];
CTI_P_TeamsRequests_FOB = 0;
CTI_P_TeamsRequests_FOB_Dismantle = 0;
CTI_P_TeamsRequests_Last = -5000;
CTI_P_PreBuilding = false;
CTI_P_LastDefenseBuilt = objNull;
CTI_P_LastStructurePreBuilt = objNull;
CTI_P_Respawning = false;
CTI_P_CurrentTasks = [];
CTI_P_CanJoin = false;
CTI_P_Jailed = false;
CTI_P_LastTeamkill = time;
CTI_P_LastFireMission = -1200;
CTI_P_HookVehicle = objNull;
CTI_P_LastRootMenu = "";
CTI_P_LastRepairTime = -600;
CTI_P_WallsAutoAlign = true;
CTI_P_DefensesAutoManning = true;
CTI_P_RapidDefence_Actions=[];
CTI_P_RapidDefence=-1;
CTI_P_Coloration_Money = "#BAFF81";
CTI_P_Voted = false;
CTI_P_VotePopUp = true;
CTI_P_CanGearAutosave = true; 
CTI_CMDR_BuildCam = true; //-- Used in Action_BuildMenu
CTI_ConstructionCam_DownwardAngle = -0.8;



//--- Artillery Computer is only enabled on demand
enableEngineArtillery true;
if ((missionNamespace getVariable "CTI_ARTILLERY_SETUP") != -1) then {enableEngineArtillery false};

if (isMultiplayer) then {
	//--- Can I join?
		missionNamespace setVariable ["CTI_PVF_Client_JoinRequestAnswer", {_this spawn CTI_CL_FNC_JoinRequestAnswer}]; //--- Early PVF, do not spoil the game with the others.

	_last_req = -100;
	while {!CTI_P_CanJoin} do {
		if (time - _last_req > 15) then {_last_req = time; ["SERVER", "Request_Join", [player, CTI_P_SideJoined]] call CTI_CO_FNC_NetSend};
		sleep 1;
	};

	//Sari Anti stack, ss83
	["SERVER", "First_Time", [player]] call CTI_CO_FNC_NetSend; //--- Tell server that the player has successfully loaded in.
	
	
	12452 cutText ["Receiving mission intel... If you are getting an error press ESC and respawn and then reconnect.", "BLACK IN", 5];

	if (CTI_P_Jailed) then {
		hintSilent "The ride never ends!";
		0 spawn CTI_CL_FNC_OnJailed;
	};
};

//--- Initialize the client PV
call compile preprocessFile "Client\Init\Init_PublicVariables.sqf";

//--- Call the UI Functions
call compile preprocessFile "Client\Functions\UI\Functions_UI_AIMicromanagementMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_ArtilleryMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_GearMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_KeyHandlers.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_ConstructionKeyHandlers.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_MapCommanding.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_PurchaseMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_RequestMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_RespawnMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_SatelliteCamera.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_ServiceMenu.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_UnitsCamera.sqf";
call compile preprocessFile "Client\Functions\UI\Functions_UI_UpgradeMenu.sqf";

if (CTI_P_SideJoined == west) then {
	(west) call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_West.sqf";
	(west) call compile preprocessFileLineNumbers "Common\Config\Units\Units_West.sqf";
};
if (CTI_P_SideJoined == east) then {
	(east) call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_East.sqf";
	(east) call compile preprocessFileLineNumbers "Common\Config\Units\Units_East.sqf";
};

CTI_InitClient = true;

//--- Wait for a proper overall init (disabled slot?)
waitUntil {!isNil {(group player) getVariable "cti_funds"} || (CTI_P_SideJoined == resistance)} ;

player addEventHandler ["killed", {_this spawn CTI_CL_FNC_OnPlayerKilled}];
if !(CTI_IsServer) then {[player, missionNamespace getVariable format ["CTI_AI_%1_DEFAULT_GEAR", CTI_P_SideJoined]] call CTI_CO_FNC_EquipUnit}; //--- Equip pure clients

if (isNil {profileNamespace getVariable "CTI_PERSISTENT_HINTS"}) then { profileNamespace setVariable ["CTI_PERSISTENT_HINTS", true]; saveProfileNamespace };

//---Welcome Screen ss83
if (!isDedicated) then {
    if (isNull findDisplay 72) then {
        [true] call JRG_welcomeScreen;
    }; 
};

//--- Vote System, define whether a vote is already running or not 
waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_votetime"}};
if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "File: Client\Init\Init_client.sqf", "Vote system is initialized."] call CTI_CO_FNC_Log };
if ((CTI_P_SideLogic getVariable "cti_votetime") > 0) then {createDialog "CTI_RscVoteMenu"};

//--- Marker init thread
0 spawn {
	if (CTI_P_SideJoined == resistance) exitWith {false};
	waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_teams"}};
	//execFSM "Client\FSM\update_markers_team.fsm";
	execFSM "Client\FSM\update_netunits_team.fsm";
};

//strat mode
//0 execVM "Addons\Strat_mode\init.sqf";

//--- Town init thread

0 spawn {
	waitUntil {!isNil 'CTI_InitTowns'};
	if (missionNamespace getVariable "CTI_SM_STRATEGIC" == 0 && !(side group player == resistance)) then {
		execFSM "Client\FSM\town_markers.fsm";
	};
};

//--- HQ / Base markers thread
0 spawn {

	waitUntil {!isNil 'CTI_Init_CommanderClient'};
	waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_structures"} && !isNil {CTI_P_SideLogic getVariable "cti_hq"}};

	//--- Initialize the structures (JIP or prefab) along with HQ.
	execVM "Client\Init\Init_JIP.sqf";
	//if (CTI_P_SideJoined == resistance) exitWith {false};


	//--- Place the player the "best" location (if not jailed!).
	if !(CTI_P_Jailed) then {
		_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
		_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;

		_spawn_at = _hq;
		if (count _structures > 0) then { _spawn_at = [_hq, _structures] call CTI_CO_FNC_GetClosestEntity };

		_spawn_at = [_spawn_at, 8, 30] call CTI_CO_FNC_GetRandomPosition;
		player setPos _spawn_at;
	};
	//--- Execute the client update context
	execFSM "Client\FSM\update_actions.fsm";
};

[] Spawn {
	Private ["_commander"];
	waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_commander"}};
	//--- Commander Handling
	[] ExecFSM "Client\FSM\update_client.fsm";
};

//--- Commander thread
0 spawn {
	//if (CTI_P_SideJoined == resistance) exitWith {call CTI_CL_FNC_AddMissionActions; CTI_Init_CommanderClient = true; false};
	waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_commander"} && !isNil {CTI_P_SideLogic getVariable "cti_hq"} && !isNil {CTI_P_SideLogic getVariable "cti_salvagers"}};

	_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
	if (!(side player == resistance) &&typeOf player == (missionNamespace getVariable format["CTI_%1_Commander", CTI_P_SideJoined])) then {
		CTI_P_SideLogic setVariable ["cti_commander", group player, true];

		if (alive _hq) then {
			player reveal _hq;
			if (isMultiplayer) then {["SERVER", "Request_HQLocality", [CTI_P_SideJoined, player]] call CTI_CO_FNC_NetSend};
			waitUntil {local _hq};
			_hq lock 2;
			_hq addAction ["<t color='#86F078'>Unlock</t>","Client\Actions\Action_ToggleLock.sqf", [], 98, false, true, '', 'alive _target && locked _target == 2'];  //ss83 lock priority reduced
			_hq addAction ["<t color='#86F078'>Lock</t>","Client\Actions\Action_ToggleLock.sqf", [], 98, false, true, '', 'alive _target && locked _target == 0']; //ss83 lock priority reduced
		};
 		{_x addAction ["<t color='#1111cc'>Delete defense</t>", "deleteVehicle (_this select 0)", "", -1, false, true, "", "vehicle player == player && !CTI_P_PreBuilding "]; } forEach (CTI_P_SideLogic getVariable ["cti_defences", []]);

	};
	CTI_Init_CommanderClient = true;

	if !(call CTI_CL_FNC_IsPlayerCommander ||(side player == resistance))  then {
		//--- Execute the client orders context
		execFSM "Client\FSM\update_orders.fsm";
	};

	call CTI_CL_FNC_AddMissionActions;

	if (alive _hq) then {
		//--- Pure clients
		if (CTI_IsClient && !CTI_IsServer) then {
			_hq addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CL_FNC_OnHQDestroyed", CTI_P_SideID]];

			if (CTI_BASE_NOOBPROTECTION == 1) then {
				_hq addEventHandler ["handleDamage", format["[_this select 2, _this select 3, %1] call CTI_CO_FNC_OnHQHandleDamage", CTI_P_SideID]]; //--- You want that on public
			};
		};
	};
};

//--- Gear templates (persitent)
if !(CTI_P_SideJoined == resistance) then {if (isNil {profileNamespace getVariable format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined]}) then {call CTI_UI_Gear_InitializeProfileTemplates};
// profileNamespace setVariable [format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined], nil];
// saveProfileNamespace;
if !(isNil {profileNamespace getVariable format["CTI_PERSISTENT_GEAR_TEMPLATE_%1", CTI_P_SideJoined]}) then {execVM "Client\Init\Init_Persistent_Gear.sqf"};};

//--- Graphics/video thread (persistent)
_temp_distance_max = missionNamespace getVariable "CTI_GRAPHICS_VD_MAX";
_temp_airdistance_max = missionNamespace getVariable "CTI_GRAPHICS_AIRD_MAX";
if (isNil {profileNamespace getVariable "CTI_PERSISTENT_AUTODISTANCE"}) then { profileNamespace setVariable ["CTI_PERSISTENT_AUTODISTANCE", true];};
if (isNil {profileNamespace getVariable "CTI_PERSISTENT_INF_VIEW_DISTANCE"}) then {profileNamespace setVariable ["CTI_PERSISTENT_INF_VIEW_DISTANCE", round((_temp_distance_max)/4)];};
if (isNil {profileNamespace getVariable "CTI_PERSISTENT_GROUND_VIEW_DISTANCE"}) then {profileNamespace setVariable ["CTI_PERSISTENT_GROUND_VIEW_DISTANCE", round((_temp_distance_max)/2)];};
if (isNil {profileNamespace getVariable "CTI_PERSISTENT_AIR_VIEW_DISTANCE"}) then {profileNamespace setVariable ["CTI_PERSISTENT_AIR_VIEW_DISTANCE", (_temp_airdistance_max * 0.75)];};
if (isNil {profileNamespace getVariable "CTI_PERSISTENT_OBJECT_PERCENT"}) then {profileNamespace setVariable ["CTI_PERSISTENT_OBJECT_PERCENT", 75]; };
saveProfileNamespace;
_temp_distance_max = nil;
_temp_airdistance_max = nil;

0 spawn {
	//--- Setup Init View Distance
	_distance = profileNamespace getVariable "CTI_PERSISTENT_INF_VIEW_DISTANCE";
	_distance_max = missionNamespace getVariable "CTI_GRAPHICS_VD_MAX";
	_airdistance_max = missionNamespace getVariable "CTI_GRAPHICS_AIRD_MAX";
	
	// infantry
	if (isNil "_distance") then { _distance = (_distance_max/4) };
	if (typeName _distance != "SCALAR") then { _distance = viewDistance };
	if (_distance < 1) then { _distance = 500 };
	if (_distance > _distance_max) then { _distance = _distance_max };
	profileNamespace setVariable ["CTI_PERSISTENT_INF_VIEW_DISTANCE", _distance];
	setViewDistance _distance;
	
	//csm
	
	// ground
	_distance = profileNamespace getVariable "CTI_PERSISTENT_GROUND_VIEW_DISTANCE";
	if (isNil "_distance") then { _distance = viewDistance };
	if (typeName _distance != "SCALAR") then { _distance = viewDistance };
	if (_distance < 1) then { _distance = 500 };
	if (_distance > _distance_max) then { _distance = _distance_max };
	profileNamespace setVariable ["CTI_PERSISTENT_GROUND_VIEW_DISTANCE", _distance];
	
	// air
	_distance = profileNamespace getVariable "CTI_PERSISTENT_AIR_VIEW_DISTANCE";
	if (isNil "_distance") then { _distance = viewDistance };
	if (typeName _distance != "SCALAR") then { _distance = viewDistance };
	if (_distance < 1) then { _distance = 500 };
	if (_distance > _airdistance_max) then { _distance = _airdistance_max };
	profileNamespace setVariable ["CTI_PERSISTENT_AIR_VIEW_DISTANCE", _distance];
	// end csm

	//--- Object Distance (scales to View Distance)
	_distance = profileNamespace getVariable "CTI_PERSISTENT_OBJECT_PERCENT";
	if (isNil "_distance") then { _distance = 75};
	if (typeName _distance != "SCALAR") then { _distance = 75 };
	if (_distance < 1) then { _distance = 75 };
	if (_distance > viewDistance) then { _distance = 100 };
	profileNamespace setVariable ["CTI_PERSISTENT_OBJECT_PERCENT", _distance];
	setObjectViewDistance ((_distance / 100) * viewDistance);
	saveProfileNamespace;

	//--- Shadows Distance.
	_distance = profileNamespace getVariable "CTI_PERSISTENT_SHADOWS_DISTANCE";
	if !(isNil "_distance") then {
		if (typeName _distance == "SCALAR") then {
			if (_distance < 50) then { _distance = 50 };
			if (_distance > 200) then { _distance = 200 };
			setShadowDistance _distance;
		};
	};

	[] Spawn {
		//waitUntil {!isNil player || (!isNil 'CTI_PERSISTENT_GROUND_VIEW_DISTANCE') || (!isNil 'CTI_PERSISTENT_AIR_VIEW_DISTANCE') || (!isNil 'CTI_PERSISTENT_VIEW_DISTANCE') || (!isNil 'CTI_PERSISTENT_OBJECT_PERCENT')};
		// Viewdistance tracker fsm
		[] ExecFSM "Client\FSM\update_view_distance.fsm";
	};
	
	//--- Terrain Grid
	_grid = profileNamespace getVariable "CTI_PERSISTENT_TG";
	_grid_max = missionNamespace getVariable "CTI_GRAPHICS_TG_MAX";

	if (isNil "_grid") then { _grid = 25 };
	if (typeName _grid != "SCALAR") then {
		_grid = 0;
	} else {
		if (_grid < 0) then { _grid = 0 };
	};
	if (_grid > _grid_max) then { _grid = _grid_max };
	setTerrainGrid _grid;

	if (CTI_WEATHER_FAST > 0) then {
		waitUntil {!isNil 'CTI_SERVERDATE'};
		execFSM "Client\FSM\weather_fast_client.fsm";
	};
};

// CTI_PurchaseMenu = player addAction ["<t color='#a5c4ff'>DEBUG: Purchase Units</t>", "Client\Actions\Action_PurchaseMenu.sqf", "HQ", 1, false, true, "", "_target == player"];//debug
// player addAction ["<t color='#a5c4ff'>MENU debug: Factory</t>", "Client\Actions\Action_PurchaseMenu.sqf", "HQ", 93, false, true, "", "_target == player"];
// player addAction ["<t color='#a5c4ff'>MENU: Equipment</t>", "Client\Actions\Action_GearMenu.sqf", "HQ", 93, false, true, "", "true"];

// onMapSingleClick "{(vehicle leader _x) setPos ([_pos, 8, 30] call CTI_CO_FNC_GetRandomPosition)} forEach (CTI_P_SideJoined call CTI_CO_FNC_GetSideGroups)";
// onMapSingleClick "vehicle player setPos _pos";
// player addEventHandler ["HandleDamage", {if (player != (_this select 3)) then {(_this select 3) setDammage 1}; false}]; //--- God-Slayer mode.
// player addAction ["<t color='#a5c4ff'>MENU: Construction (HQ)</t>", "Client\Actions\Action_BuildMenu.sqf"];//debug
// player addAction ["<t color='#ff0000'>DEBUGGER 2000</t>", "debug_diag.sqf"];//debug

if (profileNamespace getVariable "CTI_PERSISTENT_HINTS") then {
	0 spawn {
		sleep 10;
		_uptime = call CTI_CL_FNC_GetMissionTime;
		hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t align='left'>Welcome to the battlefield <t color='#84e4ff'>%1</t>!<br /><br />If you've never played this scenario then you may want to check the <t color='#eaff96'>Online Help Menu</t> which is localted within the <t color='#eaff96'>Options Menu</t> (You may access it from your ingame action menu).<br /><br />Those help messages may be turned off from the <t color='#eaff96'>Video Settings Menu</t>.<br /><br />Mission Time: <t color='#d4ceff'>%2 Day(s) %3:%4:%5</t></t>", name player, _uptime select 0,_uptime select 1,_uptime select 2, _uptime select 3];
	};
};

if (CTI_BASE_NOOBPROTECTION == 1) then {player addEventHandler ["fired", {_this spawn CTI_CL_FNC_OnPlayerFired}]}; //--- Trust me, you want that

//trophy system
if (missionNamespace getVariable "CTI_TROPHY_APS" == 1) then {
	player addEventHandler["Fired","_this call TR_HANDLER;"];
};

if ((missionNamespace getVariable "CTI_UNITS_FATIGUE") == 0) then {player enableFatigue false}; //--- Disable the unit's fatigue
["SERVER", "Request_NoobLogger", [player,0]] call CTI_CO_FNC_NetSend;
if (CTI_DEBUG) then {
	// hint "DEBUG MODE IS ENABLED! DON'T FORGET TO TURN IT OFF!";
	// onMapSingleClick "vehicle player setPos _pos";
	// onMapSingleClick "a2 setPos _pos";
	player addAction ["<t color='#ff0000'>DEBUGGER 2000</t>", "debug_diag.sqf"];//debug
};
0 execVM "Addons\MapMarkersTitling.sqf";
CTI_Init_Client = true;

