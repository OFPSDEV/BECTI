with missionNamespace do {
	//--- Infantry
	EAST_SOLDIER = ["rhs_vdv_rifleman", 1];
	EAST_SOLDIER_AA = ["rhs_vdv_strelok_rpg_assist", 1];  //aa soldiers replaced with MG
	EAST_SOLDIER_AR = ["rhs_vdv_machinegunner_assistant", 1];
	EAST_SOLDIER_AT = ["rhs_vdv_at", 1];  //replaced lat w/MG
	EAST_SOLDIER_CREW = ["rhs_vdv_crew", 1];
	EAST_SOLDIER_LAT = ["rhs_vdv_LAT", 1];
	EAST_SOLDIER_HAT = ["rhs_vdv_RShG2", 1];  //replaced heavy AT with LAT
	EAST_SOLDIER_ENGINEER = ["rhs_vdv_engineer", 1];
	EAST_SOLDIER_GL = ["rhs_vdv_grenadier", 1];
	EAST_SOLDIER_MEDIC = ["rhs_vdv_medic", 1];
	// EAST_SOLDIER_MG = "soldiermg";
	EAST_SOLDIER_PILOT = ["O_helipilot_F", 1];
	EAST_SOLDIER_SQUADLEADER = ["rhs_vdv_officer", 1];
	EAST_SOLDIER_SNIPER = ["rhs_vdv_marksman", 1];
	EAST_SOLDIER_TEAMLEADER = ["rhs_vdv_sergeant", 1];//
	
	//--- Vehicles
	EAST_MOTORIZED_MG = ["rhs_btr60_vdv", 2];
	EAST_MOTORIZED_GL = ["rhs_btr60_vdv", 2];

	//--- Infantry - Mixed
	// EAST_SOLDIERS_MG = [EAST_SOLDIER_MG, EAST_SOLDIER_AR];
	EAST_SOLDIERS_MG = ["rhs_vdv_machinegunner",1];
	EAST_SOLDIERS_AT_LIGHT = [EAST_SOLDIER_LAT, EAST_SOLDIER_AT];
	EAST_SOLDIERS_AT_MEDIUM = [EAST_SOLDIER_AT, EAST_SOLDIER_AT, EAST_SOLDIER_HAT];
	EAST_SOLDIERS_AT_HEAVY = [EAST_SOLDIER_AT, EAST_SOLDIER_HAT];
	EAST_SOLDIERS_SPECOPS = [["rhs_vdv_aa", 1]];
	EAST_SOLDIERS_ENGINEER = [EAST_SOLDIER_ENGINEER, ["rhs_vdv_engineer", 1]];
	EAST_SOLDIERS_SNIPERS = [EAST_SOLDIER_SNIPER, ["rhs_vdv_machinegunner_assistant", 1], ["rhs_vdv_marksman", 1]];

	//--- Vehicles
	EAST_VEHICLE_AA = [["rhs_zsu234_aa", 1]];
	EAST_VEHICLE_APC = [["rhs_btr80a_vdv", 2], ["rhs_bmd4m_vdv", 2]];
	// EAST_VEHICLE_ARMORED_HEAVY = ["armoheavy1","armoheavy2"];
	EAST_VEHICLE_ARMORED_LIGHT = [["rhs_t80u", 2]];
	// EAST_VEHICLE_MECHANIZED = ["mechanized1","mechanized2"];
	EAST_VEHICLE_MOTORIZED = [EAST_MOTORIZED_MG, EAST_MOTORIZED_GL, EAST_MOTORIZED_MG];

	//--- Vehicles - Mixed
	EAST_VEHICLES_AA_LIGHT = EAST_VEHICLE_AA;
	// EAST_VEHICLES_LIGHT = EAST_VEHICLE_MECHANIZED + EAST_VEHICLE_MOTORIZED;
	EAST_VEHICLES_LIGHT = EAST_VEHICLE_MOTORIZED;
	EAST_VEHICLES_MEDIUM = EAST_VEHICLE_APC + EAST_VEHICLE_ARMORED_LIGHT;
	EAST_VEHICLES_HEAVY = EAST_VEHICLE_ARMORED_LIGHT;
};