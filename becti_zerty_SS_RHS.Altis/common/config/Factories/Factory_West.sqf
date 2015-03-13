private ["_side", "_u"];

_side = _this;

missionNamespace setVariable [format["CTI_%1_Commander", _side], "rhsusf_army_ocp_squadleader"];
missionNamespace setVariable [format["CTI_%1_Worker", _side], "rhsusf_army_ocp_riflemanl"];

missionNamespace setVariable [format["CTI_%1_Diver", _side], "rhsusf_army_ocp_rifleman_m16"];
missionNamespace setVariable [format["CTI_%1_Soldier", _side], "rhsusf_army_ocp_rifleman"];
missionNamespace setVariable [format["CTI_%1_Crew", _side], "rhsusf_army_ocp_combatcrewman"];
missionNamespace setVariable [format["CTI_%1_Pilot", _side], "rhsusf_army_ocp_helipilot"];

missionNamespace setVariable [format["CTI_%1_Vehicles_Startup", _side], [
	["B_Truck_01_transport_F", [
		["rhs_m4_m320", 2], ["30Rnd_65x39_caseless_mag", 50],
		["rhs_weap_sr25", 2],
		["rhs_weap_M136", 10], ["rhs_m136_mag", 10],
		["HandGrenade", 20],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag", 15],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 6],
		["rhs_mag_M433_HEDP", 8],
		["rhs_mag_M585_white", 9],
		["rhs_mag_M661_green", 9],
		["SmokeShellBlue", 8],
		["firstaidkit", 20],
		["Chemlight_blue", 36],
		["rhsusf_acc_EOTECH", 10],
		["rhsusf_acc_ELCAN", 3],
		["rhsusf_acc_ACOG", 2],
		["rhsusf_acc_ACOG3", 1],
		["Toolkit", 1],
		["B_Bergen_sgg", 4]
	]],
	["rhsusf_m1025_w", [["Toolkit", 1],["firstaidkit", 10],["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 15],["launch_NLAW_F", 5], ["NLAW_F", 20]]]
]];

//--- Units - Barracks
_u 			= ["rhsusf_army_ocp_autorifleman"];
_u = _u		+ ["rhsusf_army_ocp_crewman"];
_u = _u		+ ["rhsusf_army_ocp_rifleman_m16"];
_u = _u		+ ["rhsusf_army_ocp_combatcrewman"];
_u = _u		+ ["rhsusf_army_ocp_grenadier"];
_u = _u		+ ["rhsusf_army_ocp_helicrew"];
_u = _u		+ ["rhsusf_army_ocp_helipilot"];
_u = _u		+ ["rhsusf_army_ocp_machinegunner"];
_u = _u		+ ["rhsusf_army_ocp_machinegunnera"];
_u = _u		+ ["rhsusf_army_ocp_medic"];
_u = _u		+ ["rhsusf_army_ocp_squadleader"];
_u = _u		+ ["rhsusf_army_ocp_rifleman"];
_u = _u		+ ["rhsusf_army_ocp_riflemanl"];
_u = _u		+ ["rhsusf_army_ocp_engineer"];
_u = _u		+ ["rhsusf_army_ocp_sniper"];
_u = _u		+ ["rhsusf_army_ocp_marksman"];
_u = _u		+ ["rhsusf_army_ocp_javelin"];
_u = _u		+ ["rhsusf_army_ocp_riflemanat"];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_BARRACKS], _u];

_u 			= ["B_Quadbike_01_F"];
_u = _u		+ ["rhsusf_m998_w_4dr"];
_u = _u		+ ["rhsusf_m998_d_s_2dr_fulltop"];
_u = _u		+ ["B_Truck_01_transport_F"];
_u = _u		+ ["rhsusf_m1025_w"];
_u = _u		+ ["rhsusf_m1025_d_m2"];
_u = _u		+ ["rhsusf_m1025_w_s_mk19"];
_u = _u     + ["rhsusf_rg33_wd"];
_u = _u     + ["rhsusf_rg33_m2_usmc_d"];
_u = _u		+ ["B_UGV_01_F"];
_u = _u		+ ["B_UGV_01_rcws_F"];
//_u = _u  	+ ["B_APC_Wheeled_01_cannon_F"];
_u = _u  	+ ["B_Truck_01_medical_F"];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_LIGHT], _u];

_u 			= ["RHS_M2A2_wd"];
_u = _u  	+ ["RHS_M2A3_BUSKI"];
_u = _u		+ ["RHS_M2A3_BUSKIII"];
//_u = _u		+ ["B_APC_Tracked_01_CRV_F"]; <--new mhq (bobcat) ss83
_u = _u		+ ["rhsusf_m113d_usarmy"];  
_u = _u		+ ["rhsusf_m1a1aimwd_usarmy"];
_u = _u		+ ["rhsusf_m1a1aim_tuski_d"];
_u = _u		+ ["B_MBT_01_mlrs_F"];
_U = _u     + ["rhsusf_m1a2sep1wd_usarmy"];
_U = _u     + ["rhsusf_m1a2sep1tuskid_usarmy"];
_U = _u     + ["RHS_M6_wd"];
_U = _u     + ["rhsusf_m109_usarmy"];
_U = _u     + ["B_MBT_01_mlrs_F"];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_HEAVY], _u];

_u 			= ["B_Heli_Light_01_F"];
_u = _u		+ ["B_Heli_Transport_01_F"];
_u = _u		+ ["rhs_uh60m_d"];  
_u = _u		+ ["rhs_uh60m_mev"]; //ss83 added mobile respawn heli
_u = _u		+ ["I_Heli_Transport_02_F"];  
_u = _u		+ ["rhs_ch_47f"];
_u = _u		+ ["rhs_ch_47f_light"];  
_u = _u		+ ["B_Heli_Light_01_armed_F"];
_u = _u		+ ["rhs_ah64d_wd"];
_u = _u		+ ["RHS_AH64D_wd_GS"];
_u = _u		+ ["RHS_AH64D_CS"];
//_u = _u		+ ["B_UAV_01_F"];          Spawns with no gas and can't be controlled, have to fix this ss83
_u = _u		+ ["B_UAV_02_CAS_F"];
_u = _u		+ ["B_UAV_02_F"];
_u = _u     + ["RHS_C130J"];
_u = _u		+ ["I_Plane_Fighter_03_AA_F"];
_u = _u		+ ["rhs_a10"];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AIR], _u];

_u 			= ["B_Truck_01_Repair_F"];
_u = _u		+ ["CTI_Salvager_West"];
_u = _u		+ ["B_Truck_01_fuel_F"];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_REPAIR], _u];

_u 			= ["B_Truck_01_ammo_F"];
_u = _u		+ ["B_supplyCrate_F"];
_u = _u		+ ["AGM_JerryCan"];  //only works with agm mod
_u = _u		+ ["Box_Nato_AmmoVeh_F"];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AMMO], _u];

_u 			= ["B_Boat_Transport_01_F"];
_u = _u		+ ["B_Boat_Armed_01_minigun_F"];
_u = _u		+ ["B_SDV_01_F"];
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_NAVAL], _u];