/*
  # HEADER #
	Script: 		Client\Functions\Client_AddMissionActions.sqf
	Alias:			CTI_CL_FNC_AddMissionActions
	Description:	Add the contextual actions from the mission to the player
					Note that this filed is called at player init and upon respawn
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-09-2013

  # PARAMETERS #
    None

  # RETURNED VALUE #
	None

  # SYNTAX #
	call CTI_CL_FNC_AddMissionActions

  # EXAMPLE #
    call CTI_CL_FNC_AddMissionActions
*/
/*
if (CTI_P_SideJoined == resistance && ! isNil "GUER_ZEUS") then {
	if !(CTI_P_SideJoined == resistance) exitWith {false};
	["SERVER", "Server_Addeditable_Zeus", player] call CTI_CO_FNC_NetSend;
	waitUntil {! isNil {(CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ}};
	0 spawn {sleep 5; ["SERVER","Server_RegisterZone_Zeus",player] call CTI_CO_FNC_NetSend;};
	_hq=(CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
	waitUntil {! isNil "_hq"};
	for '_i' from 0 to 100 do { _hq removeAction _i };
	if (alive _hq) then {
		_hq  addAction ["<t color='#e67b09'>Save Gear</t>", "CTI_P_LastPurchase= (player) call CTI_UI_Gear_GetUnitEquipment;", [], 99, false, true, "", "isPlayer _this && alive _target "];
		//_hq  addAction ["<t color='#e67b09'>Redeploy</t>", "CTI_REDEPLOY=true;[_this select 1,_this select 1] spawn CTI_CL_FNC_OnPlayerKilled", [], 99, false, true, "", "isPlayer _this && alive _target && leader group _this ==_this"];
		_hq  addAction ["<t color='#e67b09'>Reequip Default</t>", "[player, CTI_AI_GUER_DEFAULT_GEAR] call CTI_CO_FNC_EquipUnit;", [], 99, false, true, "", "alive _target"];
		_hq  addAction ["<t color='#3333bb'>Connect to Zeus</t>", "['SERVER', 'Server_Assign_Zeus', _this] call CTI_CO_FNC_NetSend;", [], 99, false, true, "", "isPlayer _this && alive _target && isNull (getAssignedCuratorUnit GUER_ZEUS)"];
	_hq  addAction ["<t color='#3333bb'>Disconnect from Zeus</t>", "['SERVER', 'Server_Unassign_Zeus', _this] call CTI_CO_FNC_NetSend;", [], 99, false, true, "", "isPlayer _this && alive _target && (getAssignedCuratorUnit GUER_ZEUS) == _this"];
	};
	player addAction ["<t color='#a5c4ff'>MENU: Options</t>", "Client\Actions\Action_OptionsMenu.sqf", "", 95, false, true, "", ""];
	player addAction ["<t color='#3333bb'>Network : Vehicle Disconnect </t>", "(vehicle player) setVariable ['CTI_Net',-1,true];(vehicle player) setVariable ['AN_iNet',CTI_P_SideID,true];", "", -100, false, true, "", " ((vehicle player) getVariable 'CTI_Net')==CTI_P_SideID && !((vehicle player) == player)"];
	//{for '_i' from 0 to 10 do { _x removeAction _i };true}	count CTI_Towns;
	//{_x addAction ["<t color='#e67b09'>Redeploy</t>", "CTI_REDEPLOY=true;[_this select 1,_this select 1] spawn CTI_CL_FNC_OnPlayerKilled", [], 99, false, true, "", "isPlayer _this &&(_target getVariable 'cti_town_sideID' == 2) && (_target getVariable 'cti_town_capture'==CTI_TOWNS_CAPTURE_VALUE_CEIL) && leader group _this ==_this" ] ;true} count CTI_Towns;
};
if (CTI_P_SideJoined == resistance) exitWith {false};*/


//--- Commander related actions
if ((CTI_P_SideLogic getVariable "cti_commander") == group player) then {
	player addAction ["<t color='#a5c4ff'>MENU: Construction (HQ)</t>", "Client\Actions\Action_BuildMenu.sqf", "", 93, false, true, "", "_target == player && !CTI_P_PreBuilding && CTI_Base_HQInRange && _this == player "];
} else {
//player addAction ["<t color='#a5c4ff'>MENU: Defense (HQ)</t>", "Client\Actions\Action_DefenseMenu.sqf", "", 93, false, true, "", "_target == player && !CTI_P_PreBuilding &&CTI_Base_HQInRange && _this == player "];
};

//--- Mixed actions

player addAction ["<t color='#a5c4ff'>MENU: Commanding</t>", "Client\Actions\Action_CommandMenu.sqf", "", 95, false, true, "", "!CTI_P_PreBuilding && _this == player "];
player addAction ["<t color='#a5c4ff'>MENU: Factory</t>", "Client\Actions\Action_PurchaseMenu.sqf", "", 93, false, true, "", "_target == vehicle player && !CTI_P_PreBuilding &&Client_AN_Connected && (CTI_Base_BarracksInRange || CTI_Base_LightInRange || CTI_Base_HeavyInRange || CTI_Base_AirInRange || CTI_Base_AmmoInRange || CTI_Base_RepairInRange || CTI_Base_NavalInRange)&& _this == player "];
player addAction ["<t color='#a5c4ff'>MENU: Equipment</t>", "Client\Actions\Action_GearMenu.sqf", "", 93, false, true, "", "(CTI_Base_GearInRange || CTI_Base_GearInRange_Mobile || CTI_Base_GearInRange_FOB) && !CTI_P_PreBuilding&& _this == player "];
player addAction ["<t color='#a5c4ff'>MENU: Options</t>", "Client\Actions\Action_OptionsMenu.sqf", "", 95, false, true, "", "!CTI_P_PreBuilding && _this == player "];

player addAction ["<t color='#ff9900'>HALO jump (1000$)</t>", "Addons\ATM_airdrop\atm_airdrop.sqf","",100, false, true, "", "vehicle player == player && !CTI_P_PreBuilding && CTI_Base_HaloInRange && [CTI_P_SideJoined, CTI_UPGRADE_HALO, 1] call CTI_CO_FNC_HasUpgrade && ( (missionNamespace getVariable 'CTI_SM_HALO')==1) && _this == player "];  //ss83 halo jump action message
player addAction ["<t color='#bb3333'>(Admin) Connect to Zeus</t>", "['SERVER', 'Server_Assign_Zeus', player] call CTI_CO_FNC_NetSend;", [], -100000, false, true, "", "!((getAssignedCuratorUnit ADMIN_ZEUS) == _this) && (serverCommandAvailable '#shutdown' || !isMultiplayer)&& _this == player "]; //!((getAssignedCuratorUnit ADMIN_ZEUS) == _this) && (serverCommandAvailable '#shutdown' || !isMultiplayer)

if ! (missionNamespace getVariable "CTI_EW_ANET" == 1) exitWith {false}; //no Adv network

player addAction ["<t color='#3333bb'>Network : Disconnect </t>", "player setVariable ['CTI_Net',-1,true];player setVariable ['AN_iNet',CTI_P_SideID,true];", "", -100, false, true, "", "!CTI_P_PreBuilding && (player getVariable 'CTI_Net')==CTI_P_SideID && _this == player "];
player addAction ["<t color='#3333bb'>Network : Reconnect </t>", "player setVariable ['CTI_Net',CTI_P_SideID,true];", "", -101, false, true, "", "!CTI_P_PreBuilding &&!((player getVariable 'CTI_Net')==CTI_P_SideID) && _this == player "];
player addAction ["<t color='#3333bb'>Network : Vehicle Disconnect </t>", "(vehicle player) setVariable ['CTI_Net',-1,true];(vehicle player) setVariable ['AN_iNet',CTI_P_SideID,true];", "", -101, false, true, "", "!CTI_P_PreBuilding && ((vehicle player) getVariable 'CTI_Net')==CTI_P_SideID && !((vehicle player) == player)&& ((vehicle player)getVariable 'CTI_Net' > -10)&& _this == player "];
player addAction ["<t color='#3333bb'>Network : Vehicle Reconnect </t>", "(vehicle player) setVariable ['CTI_Net',CTI_P_SideID,true]; ['SERVER','Server_Run_Net',[vehicle player,CTI_P_SideJoined]] call CTI_CO_FNC_NetSend;", "", -101, false, true, "", "!CTI_P_PreBuilding&& !(((vehicle player)getVariable ['CTI_Net',-2])==CTI_P_SideID) && !((vehicle player) == player) && ((vehicle player)getVariable ['CTI_Net',-2] > -10)&& _this == player "];
player addAction ["<t color='#006400'>Intrusion :: Force public key</t>", "[(vehicle player),player] call AN_E_Intrusion_Start", [], 10000, false, true, "", "((vehicle player) getVariable ['CTI_Net',-10]) >= 0 && !((vehicle player) getVariable ['CTI_Net',-11] == CTI_P_SideID) && (speed (vehicle player)) <1 && (speed (vehicle player)) >-1 && !((vehicle player) == player )&& alive player && ((CTI_P_SideLogic getVariable 'cti_upgrades') select CTI_UPGRADE_EXPI) > 0 && ! AN_E_INTRU&& _this == player "];
player addAction ["<t color='#006400'>Intrusion :: Start Intrusion</t>", "(vehicle player) setVariable ['AN_Hack_started',true,true]", [], 10000, false, true, "", "((vehicle player) getVariable ['CTI_Net',-10]) >= 0 && !((vehicle player) getVariable ['CTI_Net',-11] == CTI_P_SideID) &&  !((vehicle player) == player )&& alive player && ((CTI_P_SideLogic getVariable 'cti_upgrades') select CTI_UPGRADE_EXPI) > 0 && _this == player && ((vehicle player) getVariable ['CTI_Net',-10]) == ((vehicle player) getVariable ['AN_inet',-11])&& ((vehicle player )getVariable ['AN_Hacked',0])>0 && !((vehicle player) getVariable ['AN_Hack_started',false])"];
//
// Radioman - init EtV_Actions on respawn.
if (isNil "EtVInitialized") then {
	execVM "Addons\EtV.sqf";
	waitUntil {!isNil "EtVInitialized"};
};
[player] call EtV_Actions;
