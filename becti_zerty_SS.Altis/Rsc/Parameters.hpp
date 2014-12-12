class Params {
	class CTI_AI_TEAMS_ENABLED {
		title = "AI: Teams";
		values[] = {0};
		texts[] = {"Disabled"};
		default = 0;
	};
	class CTI_AI_COMMANDER_ENABLED {
		title = "AI: Commander";
		values[] = {0,1};
		texts[] = {"Disabled", "Enabled"};
		default = 0;
	};
	class CTI_ARTILLERY_SETUP {
		title = "ARTILLERY: Setup";
		values[] = {-1};
		texts[] = {"Ballistic Computer"};
		default = -1;
	};
	class CTI_BASE_HQ_REPAIR {
		title = "BASE: HQ Repairable";
		values[] = {1};
		texts[] = {"Enabled"};
		default = 1;
	};
	class CTI_BASE_FOB_MAX {
		title = "BASE: FOB Limit";
		values[] = {0,1,2,3,4,5,6,7,8,9,10};
		texts[] = {"Disabled","1","2","3","4","5","6","7","8","9","10"};
		default = 4;
	};
	class CTI_BASE_STARTUP_PLACEMENT {
		title = "BASE: Startup Placement";
		values[] = {10000,12000,15000,20000};
		texts[] = {"10 KM","12 KM","15 KM","20 KM"};
		default = 10000;
	};
	
	class CTI_MILITARY_INSTALLATION_PRICE {
		title = "Base: Military Installation Price";
		values[] = {10000,20000,30000};
		texts[] = {"$10000","$20000","$30000"};
		default = 30000;
	};
	
	class CTI_ECONOMY_INCOME_CYCLE {
		title = "INCOME: Delay";
		values[] = {60};
		texts[] = {"01:00 Minute"};
		default = 60;
	};

	class CTI_ECONOMY_STARTUP_FUNDS_EAST_COMMANDER {
		title = "INCOME: Starting Funds (East Commander)";
		values[] = {40000,50000,60000,70000,80000,90000,100000,125000,150000,200000};
		texts[] = {"$40000","$50000","$60000","$70000","$80000","$90000","$100000","$125000","$150000","$200000"};
		default = 80000;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_EAST {
		title = "INCOME: Starting Funds (East Players)";
		values[] = {6000,8000,10000,15000,20000,25000,30000,35000,40000};
		texts[] = {"$6000","$8000","$10000","$15000","$20000","$25000","$30000","$35000","$40000"};
		default = 6000;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_WEST_COMMANDER {
		title = "INCOME: Starting Funds (West Commander)";
		values[] = {40000,50000,60000,70000,80000,90000,100000,125000,150000,200000};
		texts[] = {"$40000","$50000","$60000","$70000","$80000","$90000","$100000","$125000","$150000","$200000"};
		default = 80000;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_WEST {
		title = "INCOME: Starting Funds (West Players)";
		values[] = {6000,8000,10000,15000,20000,25000,30000,35000,40000};
		texts[] = {"$6000","$8000","$10000","$15000","$20000","$25000","$30000","$35000","$40000"};
		default = 6000;
	};
	class CTI_ECONOMY_TOWNS_OCCUPATION {
		title = "INCOME: Towns Occupation";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
	};
	class CTI_RESPAWN_AI {
		title = "RESPAWN: AI Members";
		values[] = {0,1};
		texts[] = {"Disabled, Enabled"};
		default = 0;
	};
	class CTI_RESPAWN_FOB_RANGE {
		title = "RESPAWN: FOB Range";
		values[] = {1500,8000};
		texts[] = {"1.5 KM", "8 KM"};
		default = 1500;
	};
	class CTI_RESPAWN_MOBILE {
		title = "RESPAWN: Mobile";
		values[] = {1};
		texts[] = {"Enabled"};
		default = 1;
	};
	class CTI_RESPAWN_TIMER {
		title = "RESPAWN: Delay";
		values[] = {15,30};
		texts[] = {"15 Seconds","30 Seconds"};
		default = 30;
	};
	class CTI_GEAR_ON_SPECIAL_TRUCK {
		title = "GEAR MENU: Access On Special Trucks";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_TOWNS_OCCUPATION {
		title = "TOWNS: Occupation";
		values[] = {1};
		texts[] = {"Enabled"};
		default = 1;
	};
	class CTI_VEHICLES_AIR_AA {
		title = "UNITS: Aircraft AA Missiles";
		values[] = {2};
		texts[] = {"Enabled"};
		default = 2;
	};
	class CTI_VEHICLES_AIR_AT {
		title = "UNITS: Aircraft AT Missiles";
		values[] = {2};
		texts[] = {"Enabled"};
		default = 2;
	};
	class CTI_VEHICLES_AIR_CM {
		title = "UNITS: Aircraft Countermeasures";
		values[] = {2};
		texts[] = {"Enabled"};
		default = 2;
	};
	class CTI_MARKERS_INFANTRY {
		title = "UNITS: Show Map Infantry";
		values[] = {1};
		texts[] = {"Enabled"};
		default = 1;
	};
	class CTI_UNITS_FATIGUE {
		title = "UNITS: Fatigue";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_VEHICLES_EMPTY_TIMEOUT {
		title = "UNITS: Vehicles Recycling Delay";
		values[] = {1800};
		texts[] = {"30 Minutes"};
		default = 1800;
	};
	class CTI_GRAPHICS_TG_MAX {
		title = "VISUAL: Terrain Grid";
		values[] = {15,50};
		texts[] = {"Near","Far"};
		default = 15;
	};
	class CTI_GRAPHICS_VD_MAX {
		title = "VISUAL: View Distance";
		values[] = {1000,1500,2000,2500,3000};
		texts[] = {"1 KM","1.5 KM","2 KM","2.5 KM","3 KM"};
		default = 3000;
	};
	class CTI_WEATHER_FAST {
		title = "WEATHER: Fast Time";
		values[] = {0,2.4,3,4,6};
		texts[] = {"Disabled","24H = 10H","24H = 8H","24H = 6H","24H = 4H"};
		default = 0;
	};
		//Additionnal Parameter (Zerty)
	class SEPARATOR {
		title = "=======================================================================";
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class CTI_GAMEPLAY_TEAMSWAP_DISABLE {
		title = "Zerty:Team swap protection";
		values[] = {1, 0};
		texts[] = {"on", "off"};
		default = 0;
	};
	//sari fix, ss83, CSM
	class CTI_GAMEPLAY_TEAMSTACK_VARIABLE {
		title = "Sari: Kick Team Stackers";
		values[] = {0,1,2,3,4,5};
		texts[] = {"Disabled","+1 Player Advantage","+2 Player Advantage","+3 Player Advantage","+4 Player Advantage","+5 Player Advantage"};
		default = 2;
	};

	class CTI_SM_NONV {
		title = "Zerty: No NVs, No Thermal";
		values[] = {0,1};
		texts[] = {"false","true"};
		default = 0;
	};

	class CTI_AI_SKILL {
		title = "Zerty: AI: Skill (credit : Bl1p, fluit)";
		values[] = {3};
		texts[] = {"Good"};
		default = 3;
	};

	class CTI_MAX_MISSION_TIME {
		title = "Zerty: MISSION : Time Limit";
		values[] = {8, 10, 15, 20};
		texts[] = {"8h", "10h", "15h", "20h"};
		default = 15;
	};
	
	class CTI_VICTORY_HQ {
		title = "Zerty: MISSION : Victory on HQ Destroyed";
		values[] = {0};
		texts[] = {"False"};
		default = 0;
	};
	
	class CTI_BASE_WORKERS_RATIO {
		title = "Zerty: MISSION : Building speed ratio";
		values[] = {3};
		texts[] = {"75%"};
		default = 3;
	};

	class CTI_BASE_FOB_PERMISSION {
		title = "Zerty: MISSION : Need Commander permission for FOB";
		values[] = {1,0};
		texts[] = {"True","False"};
		default = 1;
	};
	/*
	class CTI_AI_TEAMS_GROUPSIZE { // Deprecated
		title = "Zerty: GROUPS: Size (AI) -- Resistance, West, East ";
		values[] = {8};
		texts[] = {"8"};
		default = 8;
	};*/

	class CTI_PLAYERS_GROUPSIZE {
		title = "Zerty: GROUPS: Size (Players)";
		values[] = {0,1,2,3,4,5,8,10,12,14,16};
		texts[] = {"0","1","2","3","4","5","8","10","12","14","16"};
		default = 4;
	};
	class CTI_GAMEPLAY_MISSILES_RANGE {
		title = "Zerty: GAMEPLAY: Missile Range";
		values[] = {0,500,1000,1500,2000,2500,3000};
		texts[] = {"Disabled","500m","1000m","1500m","2000m","2500m","3000m"};
		default = 0;
	};
	class CTI_GAMEPLAY_3P {
		title = "Zerty: GAMEPLAY: 3P view";
		values[] = {0,1,2};
		texts[] = {"All","Vehicle","None"};
		default = 1;
	};
	class CTI_ECONOMY_BASE_PLAYER_INCOME {
		title = "Zerty: INCOME: base income for players";
		values[] = {0,10,25,50,100,150,200,250};
		texts[] = {"0$","10$","25$","50$","100$","150$","200$","250$"};
		default = 100;
	};
	class CTI_VEHICLES_BOUNTY {
		title = "Zerty: INCOME: On kill";
		values[] = {0,25,75};
		texts[] = {"No value","25% of unit Value","75% of unit Value"};
		default = 25;
	};		
	class CTI_PLAYER_REEQUIP {
		title = "Zerty: RESPAWN : Reequip Gear";
		values[] = {0,1,2};
		texts[] = {"False","Last Purchase","Continuous"};
		default = 2;
	};
	class CTI_PLAYER_TOWN_RESPAWN {
		title = "Zerty: RESPAWN : On occupied towns";
		values[] = {1};
		texts[] = {"Closest"};
		default = 1;
	};	
	class CTI_TOWNS_INCOME_RATIO {
		title = "Zerty: TOWNS: Value Ratio";
		values[] = {1,2,3,4,5,10};
		texts[] = {"1","2","3","4","5","10"};
		default = 1;
	};
	class CTI_TOWNS_CAPTURE_RATIO {
		title = "Zerty: Town Reward: This value x Town value";
		values[] = {30};
		texts[] = {"30"};
		default = 30;
	};
	class CTI_TOWNS_RESISTANCE_DETECTION_RANGE {
		title = "Zerty: TOWNS: Detection Range";
		values[] = {1000};
		texts[] = {"1000m"};
		default = 1000;
	};
	class CTI_TOWNS_RESISTANCE_GROUPS_RATIO {
		title = "Zerty: TOWNS : Resistance Amount Multiplier";
		values[] = {50,75};
		texts[] = {"HARD","Very Hard"};
		default = 50;
	};
	class CTI_TOWNS_RESISTANCE_INACTIVE_MAX {
		title = "Zerty: TOWNS : Resistance despawn Timer";
		values[] = {1200};
		texts[] = {"1200sec"};
		default = 1200;
	};
	/*
		class CTI_UNITS_CLEANUP { // Deprecated
		title = "Zerty: UNITS: Cleanup on Disconnect";
		values[] = {1,0};
		texts[] = {"True","False"};
		default = 1;
	};*/
	class CTI_WEATHER_INITIAL {
		title = "Zerty: WEATHER: Inital time";
		values[] = {0,1,2,3,10};
		texts[] = {"Morning","Noon","Evening","Midnigth","Random"};
		default = 0;
	};
	class CTI_WEATHER_DYNAMIC {
		title = "Zerty: WEATHER: Dynamic";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};

   class initialWeatherParam {
    title = "Zerty: WEATHER:Starting Weather";
    values[] = {0,1,2,3,4};
    texts[] = {"Clear","Overcast","Rain","Fog","Random"};
    default = 4;
  };
  class CTI_FAST_TIME {
		title = "TIME: Fast Time";
		values[] = {1,2,2.4,3,4,6,12,24,48,96};
		texts[] = {"Normal","12H = 24H","10H = 24H","8H = 24H","6H = 24H","4H = 24H","2H = 24H","1H = 24H","30MIN = 24H","15MIN = 24H"};
		default = 1;
	};
	
	
	class SEPARATOR2 {
		title = "=======================================================================";
		values[] = {1};
		texts[] = {""};
		default = 1;
	};

	class CTI_SM_RADAR {
		title = "Zerty: Strategic: Air Radar";
		values[] = {1};
		texts[] = {"Enabled"};
		default = 1;
	};
	class CTI_SM_BASEP {
		title = "Zerty: Strategic: Base Protection";
		values[] = {0};
		texts[] = {"Disabled"};
		default = 0;
	};
	class CTI_SM_FAR {
		title = "Zerty: Strategic: FAR Revive Active";
		values[] = {1};
		texts[] = {"Enabled"};
		default = 1;
	};
	class FAR_ReviveMode {
		title = "Zerty: Strategic: FAR Revive mode";
		values[] = {0,1};
		texts[] = {"Only Medics","Everyone"};
		default = 1;
	};
	class CTI_SM_HALO {
		title = "Zerty: Strategic: Halo Jump";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_SM_PATROLS {
		title = "Zerty: Strategic: Patrols";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
	};
	class CTI_SM_REPAIR {
		title = "Zerty: Strategic: Repair/Forcelock";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_SM_MORTARS {
		title = "Zerty: Strategic: Town Mortars";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
	};
	class CTI_SM_STRATEGIC {
		title = "Zerty: Strategic: Town Links";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_SM_TCAS {
		title = "Zerty: Strategic: Town CAS if value above";
		values[] = {0,100,150,200,250,300,350,400,500,600};
		texts[] = {"0","100","150","200","250","300","350","400","500","600"};
		default = 600;
	};
	class CTI_TROPHY_APS {
		title = "Zerty: Trophy: Enabled";
		values[] = {0,1};
		texts[] = {"False","True"};
		default = 1;
	};

	class SEPARATOR3 {
		title = "=======================================================================";
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class CTI_EW_HUD {
		title = "Zerty: Electronic Warfare : Tactical HUD";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_EW_HUD_S {
		title = "Zerty: Electronic Warfare : Tactical HUD Sensitivity";
		values[] = {1,2,3,4};
		texts[] = {"high","medium high", "medium low", "low"};
		default = 2;
	};
	class CTI_EW_ANET {
		title = "Zerty: Electronic Warfare : Field Network Meshing";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
};
