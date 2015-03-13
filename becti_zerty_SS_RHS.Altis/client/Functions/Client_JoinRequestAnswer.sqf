/*
  # HEADER #
	Script: 		Client\Functions\Client_JoinRequestAnswer.sqf
	Alias:			CTI_CL_FNC_JoinRequestAnswer
	Description:	Determine whether the client can join a game in progress
					Note that this function is called by a PVF "CTI_PVF_Client_JoinRequestAnswer"
					which is defined in:
					 - Client\Init\Init_Client.sqf
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	09-04-2014 (sari)
	
  # PARAMETERS #
    0	[int]: This is the server answer about the JIP validity
    1	[Boolean]: Determine if the client was removing kebab in jail or not
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[JIP ANSWER, JAILED] call CTI_CL_FNC_JoinRequestAnswer
	
  # EXAMPLE #
    [-1, false] call CTI_CL_FNC_JoinRequestAnswer
	  -> The client can join, he wasn't jailed
	[-1, true] call CTI_CL_FNC_JoinRequestAnswer
	  -> The client can join, he was jailed
	[>0, false] call CTI_CL_FNC_JoinRequestAnswer
	  -> The client cannot join
  # EXAMPLE #
    [true, false] call CTI_CL_FNC_JoinRequestAnswer
	  -> The client can join, he wasn't jailed
	[true, true] call CTI_CL_FNC_JoinRequestAnswer
	  -> The client can join, he was jailed
	[false, false] call CTI_CL_FNC_JoinRequestAnswer
	  -> The client cannot join
*/

_end_message = _this select 0;
_was_jailed = _this select 1;

if (_was_jailed) then { //--- The player left while removing kebab? remove more kebab!
	CTI_P_Jailed = true;
};

if (_end_message < 0) then {
	CTI_P_CanJoin = true;
} else {
	_mission_message = format["End%1",_end_message];
	failMission _mission_message;
};