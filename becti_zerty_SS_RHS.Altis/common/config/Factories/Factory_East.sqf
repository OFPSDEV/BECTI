private ["_side", "_u"];

_side = _this;

missionNamespace setVariable [format["CTI_%1_Commander", _side], "rhs_vdv_officer"];
missionNamespace setVariable [format["CTI_%1_Worker", _side], "rhs_vdv_engineer"];

missionNamespace setVariable [format["CTI_%1_Diver", _side], "rhs_vdv_rifleman"];
missionNamespace setVariable [format["CTI_%1_Soldier", _side], "rhs_vdv_rifleman"];
missionNamespace setVariable [format["CTI_%1_Crew", _side], "rhs_vdv_armoredcrew"];
missionNamespace setVariable [format["CTI_%1_Pilot", _side], "O_Helipilot_F"];

missionNamespace setVariable [format["CTI_%1_Vehicles_Startup", _side], [
	["rhs_gaz66o_vdv", [
		["rhs_weap_svdp", 1], ["rhs_30Rnd_762x39mm", 50],
		["rhs_weap_rpg7", 5], ["rhs_rpg7_PG7VL_mag", 20],
		["HandGrenade", 20],
		["rhs_weap_ak103", 15],
		["rhs_10Rnd_762x54mmR_7N1", 6],
		["1Rnd_HE_Grenade_shell", 24],
		["UGL_FlareRed_F", 27],
		["1Rnd_SmokeRed_Grenade_shell", 9],
		["SmokeShellRed", 8],
		["firstaidkit", 20],
		["Chemlight_red", 36],
		["acc_flashlight", 5],
		["optic_ACO_grn", 3],
		["optic_Holosight", 2],
		["optic_MRCO", 1],
		["Toolkit", 1],
		["B_Bergen_sgg_Exp", 4]
	]],
	["rhs_tigr_vdv", [	["Toolkit", 1],["firstaidkit", 10],["rhs_30Rnd_762x39mm", 15],["rhs_weap_rpg7", 5], ["rhs_rpg7_PG7VL_mag", 20]]]
]];

//--- Units - Barracks
_u 			= ['rhs_vdv_marksman'];
_u = _u		+ ['rhs_vdv_medic'];
_u = _u		+ ['rhs_vdv_officer'];
_u = _u		+ ['rhs_vdv_LAT'];
_u = _u		+ ['O_helipilot_F'];
_u = _u		+ ['rhs_vdv_sergeant'];
_u = _u		+ ['rhs_vdv_RShG2'];
_u = _u		+ ['rhs_vdv_rifleman'];
_u = _u		+ ['rhs_vdv_aa'];
_u = _u		+ ['rhs_vdv_crew'];
_u = _u		+ ['rhs_vdv_armoredcrew'];
_u = _u		+ ['rhs_vdv_engineer'];
_u = _u		+ ['rhs_vdv_at'];
_u = _u		+ ['rhs_vdv_junior_sergeant'];
_u = _u		+ ['rhs_vdv_machinegunner'];
_u = _u		+ ['rhs_vdv_grenadier'];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_BARRACKS], _u];

_u 			= ['O_Quadbike_01_F'];
_u = _u		+ ["rhs_tigr_vdv"];
_u = _u		+ ["rhs_btr60_vdv"];
_u = _u		+ ['rhs_btr70_vdv'];
_u = _u		+ ['rhs_btr80a_vdv'];
_u = _u		+ ['rhs_gaz66_ap2_vdv'];
_u = _u     + ['rhs_gaz66_vdv'];
_u = _u		+ ['rhs_typhoon_vdv'];
_u = _u		+ ['O_UGV_01_F'];
_u = _u		+ ['O_UGV_01_rcws_F'];
//_u = _u		+ ['O_APC_Wheeled_02_rcws_F'];
_u = _u		+ ['O_Truck_03_medical_F'];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_LIGHT], _u];

_u 			= ["rhs_brm1k_vdv"];
_u = _u		+ ['rhs_bmd4m_vdv'];
_u = _u		+ ["rhs_sprut_vdv"];
_u = _u		+ ["rhs_t80u"];
_u = _u		+ ["rhs_t80ue1"];
_u = _u		+ ["rhs_t80u45m"];
_u = _u		+ ["rhs_t80um"];
_u = _u		+ ["rhs_zsu234_aa"];
_u = _u		+ ["rhs_2s3_tv"];
_u = _u		+ ["RHS_BM21_VDV_01"];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_HEAVY], _u];

_u			= ["I_Heli_Transport_02_F"]; 
_u = _u		+ ["rhs_ka60_c"]; //ss83 added mobile respawn heli 
_u = _u     + ['RHS_Mi8mt_vdv'];
_u = _u		+ ["RHS_Mi8AMT_vvsc"];
_u = _u		+ ["RHS_Mi8AMTSh_vvsc"];
_u = _u		+ ["RHS_Mi24P_vdv"];
_u = _u		+ ['RHS_Mi24V_vvsc'];
_u = _u		+ ['RHS_Ka52_vvs'];
_u = _u		+ ['RHS_Ka52_vvsc'];
//_u = _u		+ ['O_UAV_01_F'];  Spawns with no gas and can't be controlled, have to fix this ss83
_u = _u		+ ['O_UAV_02_CAS_F'];
_u = _u		+ ['O_UAV_02_F']; 
_u = _u		+ ['I_Plane_Fighter_03_AA_F'];
_u = _u		+ ['RHS_Su25SM_vvsc'];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AIR], _u];

_u 			= ["O_Truck_03_repair_F"];
_u = _u		+ ["CTI_Salvager_East"];
_u = _u		+ ["O_Truck_03_fuel_F"];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_REPAIR], _u];

_u 			= ["O_Truck_03_Ammo_F"];
_u = _u		+ ["AGM_JerryCan"];  //only works with agm mod
_u = _u		+ ["O_supplyCrate_F"];
_u = _u		+ ["Box_East_AmmoVeh_F"];

missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AMMO], _u];

_u 			= ['O_Boat_Transport_01_F'];
_u = _u		+ ['O_Boat_Armed_01_hmg_F'];
_u = _u		+ ['O_SDV_01_F'];

missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_NAVAL], _u];