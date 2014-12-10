///////////////////////////////////////////////////////////
//                =ATM= Airdrop       	 				    //
//         		 =ATM=Pokertour        		       		    //
//				version : 4.0							        //
//				date : 16/09/2013						   //
//                   visit us : atmarma.fr                 //
/////////////////////////////////////////////////////////

private ["_position","_cut","_dialog","_s_alt","_s_alt_text","_sound","_loadout"];

waitUntil { !isNull player };
[] execVM "Addons\ATM_airdrop\functions.sqf";

_funds = [group player, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds;
if (_funds < 1000) exitWith {hintsilent "Not enough funds"; sleep 1 ; hintsilent ""}; //ss83 changed from 500 to 1000

_position = GetPos player;
_z = _position select 2;
Altitude = CTI_HALO_ALTITUDE;


hint parseText "<t size='1.3' color='#2394ef'>HALO JUMP</t><br /><br />Select your destination ! <br /> <t color='#ccffaf'> You can only jump in the yellow circle around owned towns.</t>";

openMap true;
ATM_Jump_mapclick = false;
onMapSingleClick 'ATM_Jump_clickpos = _pos; _ct =[ATM_Jump_clickpos, CTI_P_SideJoined] call CTI_CO_FNC_GetClosestFriendlyTown; if (ATM_Jump_clickpos distance  _ct < CTI_MARKERS_TOWN_AREA_RANGE*CTI_HALO_RATIO) then { ATM_Jump_mapclick = true; onMapSingleClick ""; true;}';

//onMapSingleClick 'ATM_Jump_clickpos = _pos; ATM_Jump_mapclick = true; onMapSingleClick ""; true;';

waitUntil {ATM_Jump_mapclick or !(visiblemap)};
if (!visibleMap) exitwith {
	systemChat "Halo jump cancelled.";
	hintsilent "";
	breakOut "main";
};
[group player, CTI_P_SideJoined, - 1000] call CTI_CO_FNC_ChangeFunds; //ss83 changed from 500 to 1000
_pos = ATM_Jump_clickpos;

ATM_Jump_mapclick = if(true) then{
	call compile format ['
		mkr_halo = createMarkerLocal ["mkr_halo", ATM_Jump_Clickpos];
		mkr_halo setMarkerTypeLocal "hd_dot";
		mkr_halo setMarkerColorLocal "ColorGreen";
		mkr_halo setMarkerTextLocal "Jump";
	'];
};

_target = player;
CTI_P_LastPurchase=(player) call CTI_UI_Gear_GetUnitEquipment;
CTI_P_CanGearAutosave = false;


_posJump = getMarkerPos "mkr_halo";
_x = _posJump select 0;
_y = _posJump select 1;
_z = _posJump select 2;
_target setPos [_x,_y,_z+Altitude];

openMap false;


removeBackpack _target;
sleep 0,5;
_target addBackpack "B_Parachute";
if ((getPos _target select 2) >= 8000) then{
	removeHeadgear _target;
	_target addHeadgear "H_CrewHelmetHeli_B";
	sleep 0,5;
};



_height = getPos _target select 2;
_sound = "Vent";
while {(getPos _target select 2) > 2} do {
	if(isTouchingGround _target and player == vehicle player) then{
	}
	else{
	playSound _sound;
	sleep 2;
	};
};

hint parseText "<t size='1.3' color='#2394ef'>HALO JUMP</t><br /><br />Loading your gear back <br />";


deletevehicle (_target getvariable "lgtarray"); _target setvariable ["lgtarray",nil,true];

//0=[_target,_loadout] call Setloadout; // - Radioman - Replacing the ATM rearm function to use our pre-existing function, so that the formats for the gear can be used. 
CTI_P_CanGearAutosave = true;
[player, CTI_P_LastPurchase] call CTI_CO_FNC_EquipUnit;

if(!alive _target) then {
	_cut = nearestObjects [player, ["Steerable_Parachute_F"], 15];
	{
		deletevehicle _x;
	} foreach _cut;
	sleep 5;
};
deleteMarker "mkr_halo";
hint parseText "<t size='1.3' color='#2394ef'>HALO JUMP</t><br /><br />GEAR LOADED <br />";
sleep 3;
hintsilent "";