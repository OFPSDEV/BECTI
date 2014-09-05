/*****************************************************************************************
 * File: fn_welcomeScreen.sqf
 * Author: -[EUTW]- jrog
 * Usage: compilled in cfgFunctions
 *        [] call JRG_welcomeScreen;  // from init.sqf
 
 Thank you EUTW for the script!  If you have problems with us using this please let us know.  -SS
 * ***************************************************************************************/

#define CSAT_LIST_DOT_PLAIN "<img size='0.7' image='a3\ui_f\data\map\Diary\Icons\playereast_ca.paa'/>"
#define NATO_LIST_DOT_PLAIN "<img size='0.7' image='a3\ui_f\data\map\Diary\Icons\playerwest_ca.paa'/>"
#define AAF_LIST_DOT_PLAIN "<img size='0.7' image='a3\ui_f\data\map\Diary\Icons\playerguer_ca.paa'/>"

#define CSAT_FLAG "<img size='1.7' image='a3\ui_f\data\map\Markers\Flags\csat_ca.paa'/>"
#define NATO_FLAG "<img size='1.7' image='a3\ui_f\data\map\Markers\Flags\nato_ca.paa'/>"
#define AAF_FLAG "<img size='1.7' image='a3\ui_f\data\map\Markers\Flags\aaf_ca.paa'/>"

#define TITLE_NATO format["<t  align='left' size='1.3' color='#002AFF'>  Welcome %1!</t>", name player]
#define TITLE_CSAT format["<t  align='left' size='1.3' color='#FF0000'>  Welcome %1!</t>", name player]
#define TITLE_AAF format["<t  align='left' size='1.3' color='#00FF00'>  Welcome %1!</t>", name player]

#define ARMA_III_LOGO  "<img align='right' size='1.3' image='a3\ui_f\data\gui\cfg\LoadingScreens\a3_loadinglogo_ca.paa'/>"

#define H2_NATO(header2) format["<t  align='left' size='1' color='#002AFF'>%1</t>", header2]
#define H2_CSAT(header2) format["<t  align='left' size='1' color='#FF0000'>%1</t>", header2]
#define H2_AAF(header2) format["<t  align='left' size='1' color='#00FF00'>%1</t>", header2]   

EUTW_WELCOME_MSG_READ = false;

if (!isDedicated) then 
{
    private["_blackScreen", "_nvgDisabledMsg"];
    
    _blackScreen = [_this,0,true] call BIS_fnc_param;
     
    0 = [_blackScreen] spawn {
        private ["_blackScreen","_ws","_sidePlayer","_playerMsg"];
        
        EUTW_WELCOME_MSG_READ = false;
        
        _blackScreen = [_this,0,true] call BIS_fnc_param;

        if (_blackScreen) then {cutText [" ","BLACK FADED",1]; };
        /* Radioman TODO - EUTW_ABOUT_MISSION_MSG is undefined
        if (EUTW_ABOUT_MISSION_MSG == "") then 
        {
            EUTW_ABOUT_HEADER = ""; EUTW_ABOUT_MSG = "";
        } else {
            EUTW_ABOUT_HEADER = "About this mission:"; EUTW_ABOUT_MSG = EUTW_ABOUT_MISSION_MSG;
        };
        */
  
        waitUntil { getClientState == "BRIEFING READ" || player == player };    
        
        _sidePlayer = side player;
        
        if (_sidePlayer == west) then {EUTW_FLAG = NATO_FLAG; EUTW_LIST_DOT =  NATO_LIST_DOT_PLAIN; EUTW_TITLE = TITLE_NATO; EUTW_H2 = H2_NATO("Don't forget:"); };
        if (_sidePlayer == east) then {EUTW_FLAG = CSAT_FLAG; EUTW_LIST_DOT =  CSAT_LIST_DOT_PLAIN; EUTW_TITLE = TITLE_CSAT;  EUTW_H2 = H2_CSAT("Don't forget:"); };
        if (_sidePlayer == resistance) then {EUTW_FLAG = AAF_FLAG; EUTW_LIST_DOT =  AAF_LIST_DOT_PLAIN; EUTW_TITLE = TITLE_AAF; EUTW_H2 = H2_AAF("Don't forget:"); };
   
        if (_blackScreen) then { sleep 1.1; };

        _playerMsg = []; 
        
        _playerMsg = composeText [      	
        parseText EUTW_FLAG, 
        parseText EUTW_TITLE,
        lineBreak, 
        lineBreak,
        parseText format["<t  align='left' size='1' color='#FFFF00'>Mission Basics</t>"],
		lineBreak,
        parseText "<t  align='left' size='1' color='#00FFFF'>Goal:</t><t align='left' size='0.9'> Capture all towns or destroy enemy bases (max of 2 at a time) and MHQ to win this round. You can only capture points that are connected to the ones you already own. Remember that defending is just as important as attacking.</t>",
        lineBreak,
        parseText "<t  align='left' size='1' color='#00FFFF'>Money:</t><t align='left' size='0.9'> Killing enemies and capturing towns will yield immediate payouts. The more towns you hold, the more base income your team will earn every minute.  Bigger numbered towns produce more money and more infantry and armoured units.</t>",
        lineBreak,
        parseText "<t  align='left' size='1' color='#00FFFF'>Buying:</t><t align='left' size='0.9'> Scroll mouse wheel in a base area or captured flags to access the factory, equipment, and defense menu. There are limited purchase options available directly at a captured  town flag. Repair trucks allow the ability for ANY player to purchase defensive structures and statics.</t>",
        lineBreak,
        parseText "<t  align='left' size='1' color='#00FFFF'>(Re)-Spawning:</t><t align='left' size='0.9'> After you have died, you will be taken to the respawn map. You are able to spawn in the HQ, any factory, an FOB, a respawn truck/helicopter, or the nearest town flag.  Some re spawn locations are dependant on your range from them.</t>",
        lineBreak,
        parseText "<t  align='left' size='1' color='#00FFFF'>Teleporting:</t><t align='left' size='0.9'> You can HALO jump (no chute required) to any friendly town given that your team has an Air Factory nearby, the upgrade has been completed, and you have at least $1000 for the jump.</t>",
        lineBreak,
        lineBreak,
        parseText EUTW_H2,
        lineBreak,
        lineBreak,
        parseText EUTW_LIST_DOT,
        parseText "<t align='left' size='.9'> The MHQ is not a personal transport device, but one to help your Commander build bases, static weapons, defensive structures, and WORKERS.</t>",
        lineBreak,
        parseText EUTW_LIST_DOT,	
        parseText "<t align='left' size='.9'> Please speak English in Sidechat and Command channels. DO NOT use voice comms Global.</t>",
        lineBreak,
        parseText EUTW_LIST_DOT,	
        parseText "<t align='left' size='.9'> The mission has an extensive logistics system implemented. You can load weapons into crates (via equipment menu), crates onto mohawks/transport trucks/UGVs, and load static weapons onto the back of offroads.</t>",
        lineBreak,
        parseText EUTW_LIST_DOT,	
        parseText "<t align='left' size='.9'> Spend a few minutes examining the ENTIRE menu system.  There are tons of hidden gems such as: option to unflip AI vehicles remotely (unit cam), transfer money to other players, and TONS more.</t>",
        lineBreak,
        parseText EUTW_LIST_DOT,	
        parseText "<t align='left' size='.9'> If you are unsure how to play, scroll your mouse wheel ingame, click MENU: Options, then click on ONLINE HELP to learn the basics.  There are also YouTube tutorial videos created by SpanishSurfer.</t>",
        lineBreak,
        lineBreak,	
        parseText "<t align='left' size='.9'>Visit </t><t align='left' size='0.9' color='#F8A11C'>http://www.ofps.net</t><t align='left' size='0.9'> for more information. </t>",
        lineBreak,
        lineBreak,
        parseText "<t align='left' size='.9'>Interested in supporting us? Visit our website to help keep the server running!</t>",
        parseText ARMA_III_LOGO
        ];
        
           
        sleep 0.1;
             
        "How To Play" hintC _playerMsg;

     	disableSerialization;
     
        if (!isNull findDisplay 72) then {
            
            for "_i" from 101 to 106 do {      
                if (!isNull (findDisplay 72 displayCtrl _i)) then {         
                    _ws = findDisplay 72 displayCtrl _i;
                    _ws ctrlSetBackgroundColor [0.08, 0.08, 0.08, 0.7];
                    // diag_log format ["WELCOME SCREEN HINTC CTRL : %1 IDC, TEXT: %2", ctrlIDC _ws, ctrlText _ws];
                   
                };
            };
            
            hintC_arr_EH = findDisplay 72 displayAddEventHandler ["unload", {
                0 = _this spawn {
                    _this select 0 displayRemoveEventHandler ["unload", hintC_arr_EH];
                    hintSilent "";
                    EUTW_WELCOME_MSG_READ = true;
                    cutText ["","PLAIN"];
                };
            }]; 
        }; 
        //cutText ["","BLACK FADED"];
    };      
    //playSound "myIntro";   
};

        
/* Parsed:
 * "WELCOME SCREEN HINTC CTRL : 101 IDC, TEXT: "
 * "WELCOME SCREEN HINTC CTRL : 102 IDC, TEXT: Welcome
 * "WELCOME SCREEN HINTC CTRL : 103 IDC, TEXT: How To Play"
 * "WELCOME SCREEN HINTC CTRL : 104 IDC, TEXT: Continue"
 * "WELCOME SCREEN HINTC CTRL : 105 IDC, TEXT: "
 * "WELCOME SCREEN HINTC CTRL : 106 IDC, TEXT: "*/

/*
#define CSAT_LIST_DOT "<img size='1' image='a3\ui_f\data\map\Diary\Icons\playerbriefeast_ca.paa'/>"
#define NATO_LIST_DOT "<img size='1' image='a3\ui_f\data\map\Diary\Icons\playerbriefwest_ca.paa'/>"
#define AAF_LIST_DOT "<img size='1' image='a3\ui_f\data\map\Diary\Icons\playerbriefguer_ca.paa'/>"
*/
        