if (CTI_P_SideJoined == resistance) then {missionNamespace setVariable ["CTI_GAMEPLAY_3P",2]};
sleep 1;
if (missionNamespace getVariable "CTI_GAMEPLAY_3P"<1) exitWith {false};

while {! CTI_GameOver} do {
		if (!(cameraView in ["GUNNER","INTERNAL"]) && cameraOn == vehicle (player) &&( (vehicle player) == player && ! (weaponLowered player || speed player > 15.007)&& (missionNamespace getVariable "CTI_GAMEPLAY_3P"<2) || (missionNamespace getVariable "CTI_GAMEPLAY_3P"==2))) then { (vehicle player) switchCamera "INTERNAL";};
		sleep 0.05;
};