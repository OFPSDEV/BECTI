//SS83 TFR Updates
tf_radio_channel_password = "ofpstfrradio";
tf_no_auto_long_range_radio = true;
tf_give_personal_radio_to_regular_soldier = true;
tf_defaultWestPersonalRadio = "tf_rf7800str";
tf_defaultEastPersonalRadio = "tf_pnr1000a";
player setVariable ["tf_force_radio_active", true, true];

//#include "\task_force_radio\functions\common.sqf";

if ((isServer) or (isDedicated)) then {
    tf_no_auto_long_range_radio = true;
    publicVariable "tf_no_auto_long_range_radio";
    tf_same_sw_frequencies_for_side = true;
    publicVariable "tf_same_sw_frequencies_for_side";
    tf_same_lr_frequencies_for_side = true;
    publicVariable "tf_same_lr_frequencies_for_side";

    _settingsSwWest = false call TFAR_fnc_generateSwSettings;
    _settingsSwWest set [2, ["311","312","313","314","315","316","317","318"]];
    tf_freq_west = _settingsSwWest;

     _settingsLrWest = false call TFAR_fnc_generateLrSettings;
     _settingsLrWest set [2, ["30","41","42","43","44","45","46","47","48"]];
     tf_freq_west_lr = _settingsLrWest;

};

if ((isServer) or (isDedicated)) then {
    tf_no_auto_long_range_radio = true;
    publicVariable "tf_no_auto_long_range_radio";
    tf_same_sw_frequencies_for_side = true;
    publicVariable "tf_same_sw_frequencies_for_side";
    tf_same_lr_frequencies_for_side = true;
    publicVariable "tf_same_lr_frequencies_for_side";

    _settingsSwEast = false call TFAR_fnc_generateSwSettings;
    _settingsSwEast set [2, ["311","312","313","314","315","316","317","318"]];
    tf_freq_east = _settingsSwEast;

     _settingsLrEast = false call TFAR_fnc_generateLrSettings;
     _settingsLrEast set [2, ["30","41","42","43","44","45","46","47","48"]];
     tf_freq_east_lr = _settingsLrEast;

};

//--- Initial View Distance and Object View Distance for both clients and server
setViewDistance 1750;
setObjectViewDistance 1750;



MADE_FOR_STRATIS=false;
//--- Early definition, will be override later on in the init files.
CTI_P_SideJoined = civilian;


//CTI_DEBUG = true;
CTI_DEBUG = false;

//--- Log levels
CTI_Log_Debug = 3;
CTI_Log_Information = 2;
CTI_Log_Warning = 1;
CTI_Log_Error = 0;

//--- Log level to use
CTI_Log_Level =CTI_Log_Warning;

//--- We define the log function early so that we can use it
CTI_CO_FNC_Log = compile preprocessFileLineNumbers "Common\Functions\Common_Log.sqf";

//--- Global gameplay variables
CTI_GameOver = false;
CTI_Init_Client=false;
CTI_Init_Server =false;
CTI_Init_Strat=false;
//--- Determine which machine is running this init script
CTI_IsHostedServer = if (isServer && !isDedicated) then {true} else {false};
CTI_IsServer = if (isDedicated || CTI_IsHostedServer) then {true} else {false};
CTI_IsClient = if (CTI_IsHostedServer || !isDedicated) then {true} else {false};
CTI_IsHeadless = if !(hasInterface || isDedicated) then {true} else {false};

if (CTI_Log_Level >= CTI_Log_Information) then { //--- Information
	["INFORMATION", "FILE: init.sqf", format["Environment is Multiplayer? [%1]", isMultiplayer]] call CTI_CO_FNC_Log;
	["INFORMATION", "FILE: init.sqf", format["Current Actor is: Hosted Server [%1]? Dedicated [%2]? Client [%3]? Headless [%4]?", CTI_IsHostedServer, isDedicated, CTI_IsClient, CTI_IsHeadless]] call CTI_CO_FNC_Log
};



//--- Hide first to prevent spoils
if (CTI_IsClient && isMultiplayer) then {
//	waitUntil {!(isNull player)};
	//if ((format["%1",side player]) == 'LOGIC' && ! (serverCommandAvailable '#shutdown')) then {failMission "END6"} ;
//	if (format["%1",side player] == 'LOGIC')  exitWith {false};

	0 spawn {
		waitUntil {!(isNull player)};
		12452 cutText ["Receiving mission intel...", "BLACK FADED", 50000];
		while {side player == civilian} do
		{
		 		player enableSimulation true;
		 		player allowDamage true;
				player setCaptive false;
				player setDammage 1;
		    12452 cutText ["Respawning wounded client...(if blocked there press ESC> RESPAWN, go back in the lobby and rejoin)", "BLACK FADED", 50000];
		    waitUntil {alive player};
				sleep 1;
		};
	};
};

//--- In MP, we get the parameters.
if (isMultiplayer) then {call Compile preprocessFileLineNumbers "Common\Init\Init_Parameters.sqf"};

//--- Server JIP/DC Handler
if (isMultiplayer && CTI_IsServer) then {
	CTI_SE_FNC_OnPlayerConnected = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnPlayerConnected.sqf";
	CTI_SE_FNC_OnPlayerDisconnected = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnPlayerDisconnected.sqf";

	onPlayerConnected {[_uid, _name, _id] spawn CTI_SE_FNC_OnPlayerConnected};
	onPlayerDisconnected {[_uid, _name, _id] call CTI_SE_FNC_OnPlayerDisconnected};
};

//--- JIP Part is over
CTI_Init_JIP = true;

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: init.sqf", "Running common initialization"] call CTI_CO_FNC_Log };

//--- Common Part execution
call compile preprocessFileLineNumbers "Common\Init\Init_CommonConstants.sqf";
call compile preprocessFileLineNumbers "Common\Init\Init_Common.sqf";
CTI_InitTowns = false;
//--- Towns init
execVM "Common\Init\Init_Locations.sqf";




if (missionNamespace getVariable "CTI_EW_ANET" == 1) then {
0 execVM "Addons\Strat_mode\AdvNet\AN_Init.sqf";
};

//--- Common Part is over
CTI_Init_Common = true;

//--- Server execution
if (CTI_IsServer) then {
	if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: init.sqf", "Running server initialization"] call CTI_CO_FNC_Log	};
	execVM "Server\Init\Init_Server.sqf";
};

//--- Pure client execution
if (CTI_IsClient && !CTI_IsHeadless) then {
	if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: init.sqf", "Running client initialization"] call CTI_CO_FNC_Log	};

	//waitUntil {!(isNull player)};

	execVM "Client\Init\Init_Client.sqf";
};

//--- Headless client execution
if (CTI_IsHeadless) then {
	if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: init.sqf", "Running headless client initialization"] call CTI_CO_FNC_Log };

	execVM "Client\Init\Init_Client_Headless.sqf";
};

//0 execVM "Addons\Zeus\Z_init_GUER.sqf";

//--- Set the group ID
execVM "Common\Init\Init_GroupsID.sqf";
waitUntil {CTI_Init_Client || CTI_Init_Server};
0 execVM "Addons\Strat_mode\init.sqf";
waitUntil {CTI_Init_Strat};


//---Igiload script
_igiload = execVM "IgiLoad\IgiLoadInit.sqf";

//---Fast Rope script 
[] execVM "Addons\Fast_rope\zlt_fastrope.sqf";

//---LoadUGV script ss83
//[] execVM "Addons\loadUGV\loadUGV.sqf"; // Radioman - Improper use of the LoadUGV script. It is to be executed upon vehicle creation. 

/*//---Welcome Screen ss83 -- Moved to init_client CSM
if (!isDedicated) then {
    if (isNull findDisplay 72) then {
        [true] call JRG_welcomeScreen;
    }; 
};*/

//--Drag Crates script
_logistic = execVM "=BTC=_logistic\=BTC=_logistic_Init.sqf";

//-- Weather Script

//-- Explosives on Vehicles Script
waitUntil {time > 0};
execVM "Addons\EtV.sqf";
waitUntil {!isNil "EtVInitialized"};
//[player] call EtV_Actions; -- Radioman - Not initialised correctly. Will not persist after respawn. Moved to CTI_CL_FNC_AddMissionActions