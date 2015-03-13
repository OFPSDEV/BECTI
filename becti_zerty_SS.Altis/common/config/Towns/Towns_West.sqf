with missionNamespace do {
	//--- Infantry
	WEST_SOLDIER = ["rhsusf_army_ocp_rifleman", 1];
	WEST_SOLDIER_AA = ["rhsusf_army_ocp_machinegunner", 1];  //replaced aa with mg
	WEST_SOLDIER_AR = ["rhsusf_army_ocp_javelin", 1];
	WEST_SOLDIER_AT = ["rhsusf_army_ocp_javelin", 1];  //replaced lat with MG
	WEST_SOLDIER_CREW = ["rhsusf_army_ocp_combatcrewman", 1];
	WEST_SOLDIER_LAT = ["rhsusf_army_ocp_riflemanat", 1];
	WEST_SOLDIER_HAT = ["rhsusf_army_ocp_riflemanat", 1];  //replaced AT with LAT
	WEST_SOLDIER_ENGINEER = ["rhsusf_army_ocp_engineer", 1];
	WEST_SOLDIER_GL = ["B_Soldier_GL_F", 1];
	WEST_SOLDIER_MEDIC = ["rhsusf_army_ocp_medic", 1];
	// WEST_SOLDIER_MG = "soldiermg";
	WEST_SOLDIER_PILOT = ["rhsusf_army_ocp_helipilot", 1];
	WEST_SOLDIER_SQUADLEADER = ["rhsusf_army_ocp_autorifleman", 1];
	WEST_SOLDIER_SNIPER = ["rhsusf_army_ocp_sniper", 1];
	WEST_SOLDIER_TEAMLEADER = ["rhsusf_army_ocp_squadleader", 1];
	
	//--- Vehicles
	WEST_MOTORIZED_MG = ["rhsusf_m1025_d_m2", 2];
	WEST_MOTORIZED_GL = ["rhsusf_m1025_w_s_mk19", 2];

	//--- Infantry - Mixed
	// WEST_SOLDIERS_MG = [WEST_SOLDIER_MG, WEST_SOLDIER_AR];
	WEST_SOLDIERS_MG = ["rhs_vdv_machinegunner",1];
	WEST_SOLDIERS_AT_LIGHT = [WEST_SOLDIER_LAT, WEST_SOLDIER_AT];
	WEST_SOLDIERS_AT_MEDIUM = [WEST_SOLDIER_AT, WEST_SOLDIER_AT, WEST_SOLDIER_HAT];
	WEST_SOLDIERS_AT_HEAVY = [WEST_SOLDIER_AT, WEST_SOLDIER_HAT];
	WEST_SOLDIERS_SPECOPS = [["B_soldier_AA_F", 1]];
	WEST_SOLDIERS_ENGINEER = [WEST_SOLDIER_ENGINEER, ["rhsusf_army_ocp_engineer", 1]];
	WEST_SOLDIERS_SNIPERS = [WEST_SOLDIER_SNIPER, ["rhsusf_army_ocp_marksman", 1], ["rhsusf_army_ocp_machinegunnera", 1]];

	//--- Vehicles
	WEST_VEHICLE_AA = [["RHS_M6", 1]];
	WEST_VEHICLE_APC = [["rhsusf_m113d_usarmy", 2], ["RHS_M2A3_BUSKIII", 2]];
	// WEST_VEHICLE_ARMORED_HEAVY = ["armoheavy1","armoheavy2"];
	WEST_VEHICLE_ARMORED_LIGHT = [["rhsusf_m1a2sep1tuskiwd_usarmy", 2], ["rhsusf_m1a1fep_od", 2]];   
	// WEST_VEHICLE_MECHANIZED = ["mechanized1","mechanized2"];
	WEST_VEHICLE_MOTORIZED = [WEST_MOTORIZED_MG, WEST_MOTORIZED_GL, WEST_MOTORIZED_MG];

	//--- Vehicles - Mixed
	WEST_VEHICLES_AA_LIGHT = WEST_VEHICLE_AA;
	// WEST_VEHICLES_LIGHT = WEST_VEHICLE_MECHANIZED + WEST_VEHICLE_MOTORIZED;
	WEST_VEHICLES_LIGHT = WEST_VEHICLE_MOTORIZED;
	WEST_VEHICLES_MEDIUM = WEST_VEHICLE_APC + WEST_VEHICLE_ARMORED_LIGHT;
	WEST_VEHICLES_HEAVY = WEST_VEHICLE_ARMORED_LIGHT;
};