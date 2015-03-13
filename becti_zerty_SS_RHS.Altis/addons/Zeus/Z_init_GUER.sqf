_log=true;
_Z_Object=GUER_ZEUS;
if (isNil "_Z_Object" ) exitWith {false};

GUER_Vspawns=[];
GUER_Vehicles=[["I_Heli_light_03_unarmed_F",600],["I_G_Offroad_01_F",120],["I_G_Offroad_01_armed_F",120]];




Z_RESP_VEH={
	_veh=_this select 0;
	_class = _this select 1;
	_pos= _this select 2;
	_rot= _this select 3;
	_timeout = _this select 4;
	waitUntil {!isNull _veh};
	waitUntil {!alive _veh};
	_ctime = time;
	waitUntil {time > (_ctime + _timeout)};
	[_class,_pos,_rot,_timeout] spawn Z_CREA_VEH;
};

Z_CREA_VEH={
	_class = _this select 0;
	_pos = _this select 1;
	_rot = _this select 2;
	_timeout = _this select 3;
	_veh = _class createVehicle _pos;
	_veh setDir _rot;
	["", [0,0,0], 0, resistance, false, true, true, "FORM",_veh ] call CTI_CO_FNC_CreateVehicle ;
	GUER_ZEUS addCuratorEditableObjects [[_veh],true] ;
	[_veh,_class,_pos,_rot,_timeout] spawn Z_RESP_VEH;
};

Z_GUER_Prices={
	_price_full=0;
	if (_this isKindOf "Plane" && ! (_this isKindOf "UAV")) then {_price_full=1;};
	if (_this isKindOf "UAV") then {_price_full=0.8;};
	if (_this isKindOf "Man") then {_price_full=0.1;};
	if (_this isKindOf "Helicopter") then {_price_full=0.7;};
	if (_this isKindOf "Wheeled_APC_F") then {_price_full=0.4;};
	if (_this isKindOf "Truck_F") then {_price_full=0.2;};
	if (_this isKindOf "Offroad_01_base_F") then {_price_full=0.2;};
	if (_this isKindOf "Quadbike_01_base_F") then {_price_full=0.15;};
	if (_this isKindOf "MRAP_01_base_F") then {_price_full=0.2;};
	if (_this isKindOf "MRAP_02_base_F") then {_price_full=0.2;};
	if (_this isKindOf "MRAP_03_base_F") then {_price_full=0.2;};
	if (_this isKindOf "UGV_01_base_F") then {_price_full=0.3;_show=false;};
	if (_this isKindOf "Tank") then {_price_full=0.6;};
	if (_this isKindOf "Ship") then {_price_full=0.4;};
	if (_this isKindOf "StaticWeapon") then {_price_full=0.4;_show=false;};
	//if (_this isKindOf "Strategic") then {_price_full=0.1;};
	if (_this isKindOf "IND_Box_Base") then {_price_full=1;};
	if ( _this isKindOf "BagFence_base_F"|| _this isKindOf "BagBunker_base_F"|| _this isKindOf "HBarrier_base_F" ) then {_price_full=0.05;};
	_price_full
};

Z_GUER_HANDLER={
		0 spawn {
			waitUntil {! isNull curatorCamera};
			diag_log [curatorCamera,local curatorCamera];
			curatorCamera setPos [position player select 0,position player select 1,30];
			curatorCamera setVectorDirAndUp [[0,1,-0.5],[0,0,1]];
		};
		_classes = _this select 1;
		_costs = [];
		{
			_show=false;
			_price_full=1;
			_empty_ratio=0.9;
			_side=(configFile >> "CfgVehicles" >> _x >> "side") call bis_fnc_getcfgdata;
			if ( (_side == 2 || _x isKindOf "IND_Box_Base"  ||  _x isKindOf "BagFence_base_F"|| _x isKindOf "BagBunker_base_F"|| _x isKindOf "HBarrier_base_F") && ! (_x isKindOf "UGV_01_base_F" ||_x isKindOf "StaticWeapon" || _x isKindOf "Plane" || _x isKindOf "Tank")   )then {_show=true;};
			_price_full=(_x) call Z_GUER_Prices;
			//if (((unitAddons _x) select 0) in Z_GUER_REM) then {_show=false};
			_costs set [count _costs,[_show,(_price_full*_empty_ratio),_price_full]];
		} forEach _classes; // Go through all classes and assign cost for each of them
		_costs
};



// if (_log) then {diag_log "Zeus :: Loading addons GUER"};
 // GUER_ZEUS  removeCuratorAddons Z_GUER_REM;
if (_log) then {diag_log "Zeus ::G:: Setting Handler"};
_Z_Object addEventHandler ["CuratorObjectRegistered",Z_GUER_HANDLER];
_Z_Object addEventHandler ["CuratorObjectPlaced",{
	["", [0,0,0], 0, resistance, false, true, true, "FORM",(_this select 1) ] call CTI_CO_FNC_CreateVehicle ;
}];

if (_log) then {diag_log "Zeus ::G:: Setting Coefs"};
_Z_Object setCuratorCoef ["place",-1];
_Z_Object setCuratorCoef ["edit",-0.33];
_Z_Object setCuratorCoef ["delete",-10000];
_Z_Object setCuratorCoef ["destroy",-10000];
_Z_Object setCuratorCoef ["group",0];
_Z_Object setCuratorCoef ["synchronize",0];


if (_log) then {diag_log "Zeus ::G:: Setting Attribute edit"};
[_Z_Object,"object",["UnitPos"]] call  BIS_fnc_setCuratorAttributes;
[_Z_Object,"player",[]]  call  BIS_fnc_setCuratorAttributes;
[_Z_Object,"group",["GroupID"]]  call  BIS_fnc_setCuratorAttributes;

if (_log) then {diag_log "Zeus ::G:: Setting Camera Ceilling"};
GUER_ZEUS setCuratorCameraAreaCeiling 15;
/*
if (_log) then {diag_log "Zeus ::G:: Setting Zones"};
{
	if (side group _x == resistance) then {
		_id=floor (11000+diag_frameno-random (1000));
 		[_x,_id] spawn {
			while {!CTI_GameOver} do {
			GUER_ZEUS addCuratorEditingArea [(_this select 1) ,getPos (_this select 0),50];
			GUER_ZEUS addCuratorCameraArea [(_this select 1) ,getPos (_this select 0),50];
			sleep 1;
			};
		};
	};
true} count playableUnits;*/
/*waitUntil {!isNil "CTI_TOWNS"};
{
		GUER_ZEUS addCuratorEditingArea [(CTI_TOWNS find _x) ,getPos _x,250];
	  GUER_ZEUS addCuratorCameraArea [(CTI_TOWNS find _x) ,getPos _x,100];

  true
} count CTI_TOWNS;*/


//spawn HQ -- logic init

if (CTI_IsClient && (CTI_P_SideJoined == resistance)) then {
	CTI_REDEPLOY=false;
	waitUntil {!isNull player&& alive player && ! isNil "CTI_UI_Gear_GetUnitEquipment"};
	CTI_AI_GUER_DEFAULT_GEAR=(player) call CTI_UI_Gear_GetUnitEquipment;
	waitUntil {!isNil "CTI_AI_GUER_DEFAULT_GEAR"};
	[player, CTI_AI_GUER_DEFAULT_GEAR] call CTI_CO_FNC_EquipUnit;
};


if (CTI_isServer) then  {
	//GUER_ZEUS addCuratorPoints 0.3 ;
	if (_log) then {diag_log "Zeus ::G:: Setting HQ -- logic Variables "};
	_center= markerpos "CENTER_POS";
	_range=7000;
	_spwnposNew = [_center,random _range, random 360] call BIS_fnc_relPos;

	for "_i" from 1 to 10 /* step +1 */ do {_spwnposNew = [_spwnposNew , 0,3000] call CTI_CO_FNC_GetRandomPosition;};
	//_hq = ['Land_Chapel_V1_F', _spwnposNew, 0, resistance] call CTI_CO_FNC_CreateVehicle;
	_hq = 'Land_Chapel_V1_F' createVehicle _spwnposNew;
	_hq setPos( [_hq, 500,0.2] call CTI_CO_FNC_GetEmptyPosition);
	_hq setVectorUp [0,0,0];
	_hq setVariable ["cti_gc_noremove", true]; //--- HQ wreck cannot be removed nor salvaged
	_hq setVariable ["cti_ai_prohib", true]; //--- HQ may not be used by AI as a commandable vehicle
	_hq addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_SE_FNC_OnHQDestroyed", 2]];
	if (CTI_BASE_NOOBPROTECTION == 1) then {
		_hq addEventHandler ["handleDamage", format["[_this select 2, _this select 3, %1] call CTI_CO_FNC_OnHQHandleDamage", 2]]; //--- You want that on public
	};
	_supply= 'I_supplyCrate_F' createVehicle [ ((getPos _hq) select 0)-12.5 ,((getPos _hq) select 1)-2 ,(getPos _hq) select 2 ];
	//_supply= 'I_supplyCrate_F' createVehicle (_hq buildingPos 3);
	clearBackpackCargoGlobal _supply;
	clearItemCargoGlobal _supply;
	clearMagazineCargoGlobal _supply;
	clearWeaponCargoGlobal _supply;

	for "_i" from 1 to (count GUER_Vehicles) /* step +1 */ do {
		 GUER_Vspawns set [count GUER_Vspawns,'Sign_Sphere25cm_F' createVehicle _spwnposNew];
	};
	{
		_x setPos( [_hq, 25,0.2] call CTI_CO_FNC_GetEmptyPosition) ;
		_x setDir ([_hq, _x] call CTI_CO_FNC_GetDirTo) ;
		sleep 0.5;
	true
	} count GUER_Vspawns;
	for "_i" from 1 to (count GUER_Vehicles) /* step +1 */ do {
		_v = GUER_Vehicles select (_i -1 );
		_sp= GUER_Vspawns select (_i -1 );
		[_v select 0,getPos _sp,getDir _sp,_v select 1] spawn Z_CREA_VEH;
	};


	//"Land_FuelStation_Feed_F" createVehicle [ ((getPos _hq) select 0)-3 ,((getPos _hq) select 1)+10 ,(getPos _hq) select 2 ];
	CTI_GUER setVariable ["cti_active", objNull, true];
	CTI_GUER setVariable ["cti_hq", _hq, true];
	CTI_GUER setVariable ["cti_structures", [], true];
	CTI_GUER setVariable ["cti_commander", objNull, true];
	CTI_GUER setVariable ["cti_salvagers", objNull, true];
	CTI_GUER setVariable ["cti_teams", [], true];
	_Z_Object addCuratorEditingArea [10000 ,getPos _hq,250];
  _Z_Object addCuratorCameraArea [10000 ,getPos _hq,250];
  with missionNamespace do {
  	CTI_PVF_Server_Assign_Zeus= {
  		(_this select 1 ) assignCurator GUER_ZEUS;
  		 	_this spawn {
  		 		waitUntil {((getAssignedCuratorUnit GUER_ZEUS) == (_this select 1 ))};
  		 		waitUntil {!(side (_this select 1 ) == resistance) || (_this select 1 ) distance (_this select 0 ) > 10 || ! alive (_this select 1 ) || ! alive (_this select 0 ) || !((getAssignedCuratorUnit GUER_ZEUS) == (_this select 1 ))};
  		 		unassignCurator GUER_ZEUS;
  		 	};
		};
		CTI_PVF_Server_Unassign_Zeus= {

    	unassignCurator GUER_ZEUS;
		};
		CTI_PVF_Server_Addpoints_Zeus= {

    	GUER_ZEUS addCuratorPoints _this ;
    	diag_log format ["Zeus ::G:: Adding %1 points.",_this];
		};
		CTI_PVF_Server_Addeditable_Zeus= {

    	GUER_ZEUS addCuratorEditableObjects [[_this],true] ;
    	diag_log format ["Zeus ::G:: Adding editable %1 .",_this];
		};
		CTI_PVF_Server_Deleditable_Zeus= {

    	GUER_ZEUS removeCuratorEditableObjects  [[_this],false]  ;
    	diag_log format ["Zeus ::G:: Removing editable %1 .",_this];
		};
		CTI_PVF_Server_RegisterZone_Zeus= {
			_id=floor (11000+diag_frameno-random (1000));
 			[_this,_id] spawn {
 				diag_log format ["Zeus ::G:: Creating Zone around %1 :: %2",(_this select 0),(_this select 1)];
				while {!CTI_GameOver && alive (_this select 0) && isPlayer (_this select 0) } do {
					GUER_ZEUS addCuratorEditingArea [(_this select 1) ,getPos (_this select 0),50];
					GUER_ZEUS addCuratorCameraArea [(_this select 1) ,getPos (_this select 0),50];
					sleep 0.2;
				};
					GUER_ZEUS removeCuratorEditingArea (_this select 1);
					GUER_ZEUS removeCuratorCameraArea (_this select 1);
					diag_log format ["Zeus ::G:: Deleting Zone around %1 :: %2",(_this select 0),(_this select 1)];
			};
		};
	};
};

