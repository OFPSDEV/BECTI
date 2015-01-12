
while { true } do {
	CTI_ConstructionCam_HQ = (side player) call CTI_CO_FNC_GetSideHQ;
	if (isNil {uiNamespace getVariable "cti_dialog_ui_constructioncam"}) exitWith {CTI_ConstructionCam_BuildingID = -1;}; //--- Menu is closed.
	
	// -- The HQ has been detroyed or the player is no longer commander or the hq has moved outside of construction distance.
	if ((!alive player) || (!alive CTI_ConstructionCam_HQ) || (!(call CTI_CL_FNC_IsPlayerCommander)) || (((getPos CTI_ConstructionCam_HQ) distance CTI_ConstructionCamera) > (CTI_BASE_CONSTRUCTION_RANGE+5)) ) exitWith {closeDialog 0}; 

	sleep .01;
};