// Welcome to the party friends!
_last_campos = [0,0,0];
private ["_distance","_MAXD","_MAXH"];

_distance = 0;
_MAXD = CTI_BASE_CONSTRUCTION_RANGE;
_MAXH = CTI_CONSTRUCTIONCAM_ZOOM_MAX;


while { true } do {
	CTI_ConstructionCam_HQ = (side player) call CTI_CO_FNC_GetSideHQ;
	if (isNil {uiNamespace getVariable "cti_dialog_ui_constructioncam"}) exitWith {CTI_ConstructionCam_BuildingID = -1;}; //--- Menu is closed.
	
	//Fun math time!
	_distance = (sqrt ((_MAXD*_MAXD) + (_MAXH * _MAXH))) + 30;
	
	// -- The HQ has been destroyed or the player is no longer commander or the hq has moved outside of construction distance.
	if 
	(
		(!alive player) || 
		(!alive CTI_ConstructionCam_HQ) || 
		(!(call CTI_CL_FNC_IsPlayerCommander)) || 
		(
			(
				(getPos CTI_ConstructionCam_HQ) distance 
				CTI_ConstructionCamera
			) > (_distance)
		) 
	) exitWith {
		closeDialog 0; 
		CTI_ConstructionCam_BuildingID = -1; 
		player groupChat format["HQ: Disconnected."];
	}; 
	
	
	if (uiNamespace getVariable "cti_dialog_ui_constructioncam_showmap") then {
		if (CTI_ConstructionCamera distance _last_campos > 1) then { //--- Only move the camera when there is a change
			_zoffset = getPos CTI_ConstructionCamera select 2;
			((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600020) ctrlMapAnimAdd [0, _zoffset/1500, getPos CTI_ConstructionCamera]; //.35
			ctrlMapAnimCommit ((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600020);
			_last_campos = getPos CTI_ConstructionCamera;
		};
	};
	
	
	sleep .01;
};