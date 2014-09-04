/*
  # HEADER #
	Script: 		Common\Functions\Common_CreateVehicle.sqf
	Alias:			CTI_CO_FNC_CreateVehicle
	Description:	Create an empty vehicle
					Note that making a vehicle public with the _net variable will make it
					undergo the function CTI_CO_FNC_InitializeNetVehicle
					A public vehicle is initialized for all (+JIP) but the server
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	16-09-2013

  # PARAMETERS #
    0	[String]: The type of vehicle to create
    1	[Array/Object]: The 2D/3D position where the vehicle should be created at
    2	[Integer]: The Azimuth direction (0-360?) of the vehicle
    3	[Side/Integer]: The Side or Side ID of the vehicle
    4	{Optionnal} [Boolean]: Determine if the vehicle should be created locked or not
    5	{Optionnal} [Boolean]: Determine if the vehicle should be "public" or not
    6	{Optionnal} [Boolean]: Determine if the vehicle should be handled upon destruction or not (bounty...tk...)
    7	{Optionnal} [String]: Set a special spawn mode for the vehicle

  # RETURNED VALUE #
	[Object]: The created vehicle

  # SYNTAX #
	[CLASSNAME, POSITION, DIRECTION, SIDE] call CTI_CO_FNC_CreateVehicle
	[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED] call CTI_CO_FNC_CreateVehicle
	[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED, PUBLIC] call CTI_CO_FNC_CreateVehicle
	[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED, PUBLIC, HANDLED] call CTI_CO_FNC_CreateVehicle
	[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED, PUBLIC, HANDLED, SPECIAL] call CTI_CO_FNC_CreateVehicle

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_OnUnitGetOut
	Common Function: CTI_CO_FNC_OnUnitHit
	Common Function: CTI_CO_FNC_OnUnitKilled

  # EXAMPLE #
	_vehicle = ["B_Quadbike_01_F", getPos player, 0, CTI_P_SideJoined] call CTI_CO_FNC_CreateVehicle;
	  -> Create a "B_Quadbike_01_F" at the player's position facing North on the player's initial side
	_vehicle = ["B_Quadbike_01_F", getPos player, 180, CTI_P_SideJoined, true, true] call CTI_CO_FNC_CreateVehicle;
	  -> Create a locked and handled "B_Quadbike_01_F" at the player's position facing South on the player's initial side
*/

private ["_direction", "_handle", "_locked", "_net", "_position", "_side", "_special", "_type", "_vehicle"];

_type = _this select 0;
_position = _this select 1;
_direction = _this select 2;
_side = _this select 3;
_locked = if (count _this > 4) then {_this select 4} else {false};
_net = if (count _this > 5) then {_this select 5} else {false};
_handle = if (count _this > 6) then {_this select 6} else {false};
_special = if (count _this > 7) then {_this select 7} else {"FORM"};
_created = if (count _this > 8) then {_this select 8} else {objNull};
_t_side=if (typeName _side == "SCALAR") then {(_side call CTI_CO_FNC_GetSideFromID)} else {_side};
if (typeName _position == "OBJECT") then {_position = getPos _position};
if (typeName _side == "SIDE") then {_side = (_side) call CTI_CO_FNC_GetSideID};


_vehicle = if ( isNull _created) then {createVehicle [_type, _position, [], 7, _special]} else {_created};
if (isNull _created) then {
	_vehicle setDir _direction;
	if (_special == "FORM") then {_vehicle setPos [getPos _vehicle select 0, getPos _vehicle select 1, 1];}; //--- Make the vehicle spawn above the ground level to prevent any bisteries
	// --- Zerty edit
	if (_type isKindOf "UAV" || _type isKindOf "UGV_01_base_F") then {createVehicleCrew _vehicle};
	

	if (_special == "FLY" && _vehicle isKindOf "Plane") then {
		_vehicle setVelocity [75 * (sin _direction), 75 * (cos _direction), 0];
	} else {
		_vehicle setVelocity [0,0,1];
	};
};
if (missionNamespace getVariable "CTI_TROPHY_APS" == 1) then {
	if (_vehicle isKindOf "tank" || _vehicle isKindOf "Wheeled_APC_F") then {

		_ammo=if (! (count ((_t_side) call CTI_CO_FNC_GetSideUpgrades) == 0) ) then {2+2*(((_t_side) call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_TRA)} else {2};
		if (isNil "_ammo") then {_ammo = 2};
		_vehicle setVariable ["TROPHY_time_l",time-10000,true];
		_vehicle setVariable ["TROPHY_time_r",time-10000,true];
		_vehicle setVariable ["TROPHY_ammo_l",ceil(_ammo/2),true];
		_vehicle setVariable ["TROPHY_ammo_r",ceil(_ammo/2),true];

	};
};
if (_locked) then {_vehicle lock 2};
if (_net) then {_vehicle setVariable ["cti_net", _side, true]};
if (_handle) then {
	_vehicle addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CO_FNC_OnUnitKilled", _side]]; //--- Called on destruction
	_vehicle addEventHandler ["hit", {_this spawn CTI_CO_FNC_OnUnitHit}]; //--- Register importants hits
	//--- Track who get in or out of the vehicle so that we may determine the death more easily
	_vehicle addEventHandler ["getIn", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
	_vehicle addEventHandler ["getOut", {_this spawn CTI_CO_FNC_OnUnitGetOut}];
	_vehicle setVariable ["cti_occupant", _side call CTI_CO_FNC_GetSideFromID,true];
};
if (!(_vehicle isKindOf "I_G_Offroad_01_F") &&_net &&missionNamespace getVariable "CTI_EW_ANET" == 1 && !(_side == CTI_RESISTANCE_ID)) then {
	["SERVER","Server_Run_Net",[_vehicle,_side]] call CTI_CO_FNC_NetSend;
};
//disable net for offroads (JIP issue with BIS bug) + static load
if  (_vehicle isKindOf "I_G_Offroad_01_F") then {
	_vehicle spawn {
		waitUntil {!isNil "Action_Statics"};
		[_this] call Action_Statics;
	};
	_vehicle setVariable ["cti_net",-10, true];
};
//AdminZeus
if !( isNil "ADMIN_ZEUS") then {
	if !(_side == CTI_RESISTANCE_ID) then {
		["SERVER", "Server_Addeditable",[ADMIN_ZEUS,_vehicle]] call CTI_CO_FNC_NetSend;
	} else {
		ADMIN_ZEUS addCuratorEditableObjects [[_vehicle],true] ;
	};
};

//artillery radar revamp
if (missionNamespace getVariable "CTI_SM_RADAR" == 1) then {
	_vehicle addEventHandler["Fired","_this call ARTR_HANDLER;"];
	["SERVER", "Server_AIRR_handle",_vehicle] call CTI_CO_FNC_NetSend;
};

//SS83 Clear out the cargo of the vehicle
       clearItemCargoGlobal _vehicle;
       clearMagazineCargoGlobal _vehicle;
       clearWeaponCargoGlobal _vehicle;
		clearBackpackCargoGlobal _vehicle;
		
//SS83, redraw the mhq once it's rebuilt
if (typeOf _vehicle in (CTI_VEHICLES_RETEXTURE)) then { 
    switch (_side) do { 
		case west: { 
            _vehicle setObjectTextureGlobal  [0,"\A3\armor_f_beta\APC_Tracked_01\Data\apc_tracked_01_body_crv_co.paa"]; 
            _vehicle setObjectTextureGlobal  [1,"\A3\armor_f_beta\APC_Tracked_01\Data\apc_tracked_01_body_crv_co.paa"]; 
            _vehicle setObjectTextureGlobal  [2,"\A3\armor_f_beta\APC_Tracked_01\Data\apc_tracked_01_body_crv_co.paa"]; 
        }; 
		
		case east: { 
            _vehicle setObjectTextureGlobal [0,"\A3\armor_f_beta\APC_Tracked_01\Data\apc_tracked_01_crv_opfor_co.paa"]; 
            _vehicle setObjectTextureGlobal [1,"\A3\armor_f_beta\APC_Tracked_01\Data\apc_tracked_01_crv_opfor_co.paa"]; 
            _vehicle setObjectTextureGlobal [2,"\A3\armor_f_beta\APC_Tracked_01\Data\apc_tracked_01_crv_opfor_co.paa"]; 
			_vehicle setObjectTextureGlobal [3,"\A3\armor_f_beta\APC_Tracked_01\Data\apc_tracked_01_crv_opfor_co.paa"]; 
        };
		
    }; 
}; 		



//trophy system
if (missionNamespace getVariable "CTI_TROPHY_APS" == 1) then {
	_vehicle addEventHandler["Fired","_this call TR_HANDLER;"];
};
_vehicle