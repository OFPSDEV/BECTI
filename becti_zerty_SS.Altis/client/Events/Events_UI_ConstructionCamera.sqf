// Construction Camera

private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		if !(alive player) exitWith {closeDialog 0};
		
		CTI_ConstructionCam_BuildingID = -1;
		CTI_ConstructionCam_MouseLoc = [0,0,0];
		CTI_ConstructionCam_Theta = 0;
		CTI_ConstructionCam_Rotation = 0;
		CTI_P_WallsAutoAlign = true;
		CTI_ConstructionCam_DownwardAngle = -0.222222;
		
		CTI_ConstructionCam_HQ = (side player) call CTI_CO_FNC_GetSideHQ;
		
		if (CTI_P_WallsAutoAlign) then { ctrlSetText [600005, "Auto-Align Walls: On"] } else { ctrlSetText [600005, "Auto-Align Walls: Off"] };
		if (CTI_P_DefensesAutoManning) then { ctrlSetText [600006, "Defenses Auto-Manning: On"] } else { ctrlSetText [600006, "Defenses Auto-Manning: Off"] };
		if (isNil {uiNamespace getVariable "cti_dialog_ui_constructioncam_showmap"}) then {uiNamespace setVariable ["cti_dialog_ui_constructioncam_showmap", true]};
		if (uiNamespace getVariable "cti_dialog_ui_constructioncam_showmap") then {
			((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600018) ctrlSetText "Hide Map";
		} else {
			((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600018) ctrlSetText "Show Map";
			{((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl _x) ctrlShow false} forEach [600019, 600020];
		};
		
		
		{
			_var = missionNamespace getVariable _x;
			_row = ((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600009) lnbAddRow [format ["$%1", _var select 2], (_var select 0) select 1];
			((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600009) lnbSetData [[_row, 0], _x];
		} forEach (missionNamespace getVariable format ["CTI_%1_STRUCTURES", CTI_P_SideJoined]);
		
		{
			_var = missionNamespace getVariable _x;

			_condition = {true};
			{if (_x select 0 == "Condition") exitWith {_condition = _x select 1}} forEach (_var select 5);

			if (call _condition) then {
				_row = ((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600015) lnbAddRow [format ["$%1", _var select 2], _var select 0];
				((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600015) lnbSetData [[_row, 0], _x];
			};
		} forEach (missionNamespace getVariable format ["CTI_%1_DEFENSES", CTI_P_SideJoined]);
		
		_pos = getPos CTI_ConstructionCam_HQ;
		_pos set [2, 15];
		showCinemaBorder false;
		CTI_ConstructionCamera = "camera" camCreate _pos;
		CTI_ConstructionCamera camSetFov 1.1;
		_deg = (deg CTI_ConstructionCam_Theta) + 90;
		//_deg =_deg;
		_cos = cos _deg;
		_sin = sin _deg;
		CTI_ConstructionCamera setVectorDirAndUp [[_cos,_sin,-0.222222],[0,0,1]];


		(uiNamespace getVariable "cti_dialog_ui_constructioncam") displayAddEventHandler ["KeyDown", "nullReturn = _this spawn CTI_UI_ConstructionKeyHandler_ConstructionCamera"];
		((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600001) ctrlAddEventHandler ["MouseButtonDown", "nullReturn = _this call CTI_UI_ConstructionKeyHandler_ConstructionCamera_MouseButtonDown"];
		((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600001) ctrlAddEventHandler ["MouseButtonUp", "nullReturn = _this call CTI_UI_ConstructionKeyHandler_ConstructionCamera_MouseButtonUp"];
		((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600001) ctrlAddEventHandler ["MouseZChanged", "nullReturn = _this call CTI_UI_ConstructionKeyHandler_ConstructionCamera_MouseZChanged"];
		((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600001) ctrlAddEventHandler ["MouseMoving", "nullReturn = _this call CTI_UI_ConstructionKeyHandler_ConstructionCamera_MouseMoving"]; 
		((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600001) ctrlAddEventHandler ["MouseHolding", "nullReturn = _this call CTI_UI_ConstructionKeyHandler_ConstructionCamera_MouseMoving"];


		ctrlSetFocus ((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600001);
		
		((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600014) sliderSetRange [-180, 180];
		((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600014) sliderSetPosition CTI_ConstructionCam_Rotation;
		
		if (isNil {uiNamespace getVariable "cti_dialog_ui_constructioncam_viewmode"}) then {uiNamespace setVariable ["cti_dialog_ui_constructioncam_viewmode", 0]};
		_mode = "Normal";
		switch (uiNamespace getVariable "cti_dialog_ui_constructioncam_viewmode") do { case 1: {_mode = "NVG"; camUseNVG true }; };
		((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600013) ctrlSetText _mode;
		
		CTI_ConstructionCamera cameraEffect ["Internal", "back"];
		

		if (profileNamespace getVariable "CTI_PERSISTENT_HINTS") then 
		{ 
			player groupChat format ["Construction:"]; 
			player groupChat format ["W,A,S,D :Move Around,"]; 
			player groupChat format ["LeanLeft,LeanRight :Rotate Left / Right,"]; 
			player groupChat format ["Left Click :Build Selected Building,"]; 
			player groupChat format ["Right Click :Cancel Building Selection,"]; 
			player groupChat format ["Slider Bar to Rotate Buildings."]; 
		};
		execVM "Client\GUI\GUI_ConstructionCamera.sqf";
	};
	case "onUndoStructure": {
		if !(isNull CTI_P_LastStructurePreBuilt) then {
			deleteVehicle CTI_P_LastStructurePreBuilt;
		};
	};
	case "onUndoDefense": {
		if !(isNull CTI_P_LastDefenseBuilt) then {
			deleteVehicle CTI_P_LastDefenseBuilt;
		};
	};
	case "onAutoAlign": {
		CTI_P_WallsAutoAlign = !CTI_P_WallsAutoAlign;
		if (CTI_P_WallsAutoAlign) then { ctrlSetText [600005, "Auto-Align Walls: On"] } else { ctrlSetText [600005, "Auto-Align Walls: Off"] };
	};
	case "onAutoManning": {
		CTI_P_DefensesAutoManning = !CTI_P_DefensesAutoManning;
		if (CTI_P_DefensesAutoManning) then { ctrlSetText [600006, "Defenses Auto-Manning: On"] } else { ctrlSetText [600006, "Defenses Auto-Manning: Off"] };
	};
	case "onBuildDefense": {
		_selected = _this select 1;
		CTI_ConstructionCam_BuildingID = CTI_ConstructionCam_BuildingID + 1;
		

		if (typeName _selected == "SCALAR") then {
			_selected = lnbData[600015, [_selected, 0]];
		};
		_var = missionNamespace getVariable _selected;
		_funds = call CTI_CL_FNC_GetPlayerFunds;

		if (_funds >= (_var select 2)) then { //--- Check if we have enough funds to go in the construction mode.
			CTI_VAR_StructurePlaced = false;
			[_selected, CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, CTI_BASE_CONSTRUCTION_RANGE] spawn CTI_CL_FNC_ConstructionCam_PlacingDefense;
		} else {
			player groupChat format ["HQ: Insufficient Funds: %1", _funds];
		};
	};
	case "onBuildStructure": {
		_selected = _this select 1;
		CTI_ConstructionCam_BuildingID = CTI_ConstructionCam_BuildingID + 1;
		
		if (_selected != -1) then {
			_selected = lnbData[600009, [_selected, 0]];

			_var = missionNamespace getVariable _selected;
			_funds = call CTI_CL_FNC_GetPlayerFunds;

			if (_funds >= (_var select 2)) then { //--- Check if we have enough funds to go in the construction mode.
				CTI_VAR_StructurePlaced = false;
				[_selected, CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, CTI_BASE_CONSTRUCTION_RANGE] spawn CTI_CL_FNC_ConstructionCam_PlacingBuilding;
			} else {
				player groupChat format ["HQ: Insufficient Funds: %1", _funds];
			};
		};
	};
	case "onViewModeChanged": {
		_mode = (uiNamespace getVariable "cti_dialog_ui_constructioncam_viewmode") + 1;
		if (_mode > 1) then { _mode = 0 };
		uiNamespace setVariable ["cti_dialog_ui_constructioncam_viewmode", _mode];
		switch (_mode) do { 
			case 1: {_mode = "NVG"; camUseNVG true}; 
			default {_mode = "Normal"; camUseNVG false};
		};
		((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600013) ctrlSetText _mode;
	};
	case "onCancelSelected" : {
		CTI_ConstructionCam_BuildingID = CTI_ConstructionCam_BuildingID + 1;
	};
	case "onViewSliderChanged": {
		_changeto = round(_this select 1);
		CTI_ConstructionCam_Rotation = _changeto;
	};
	case "onToggleMap": {
		_changeto = !(uiNamespace getVariable "cti_dialog_ui_constructioncam_showmap");
		uiNamespace setVariable ["cti_dialog_ui_constructioncam_showmap", _changeTo];
		
		if (_changeto) then {
			((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600018) ctrlSetText "Hide Map";
			{((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl _x) ctrlShow true} forEach [600019, 600020];
		} else {
			((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl 600018) ctrlSetText "Show Map";
			{((uiNamespace getVariable "cti_dialog_ui_constructioncam") displayCtrl _x) ctrlShow false} forEach [600019, 600020];
		};
	};
	case "onUnload": {
		CTI_ConstructionCam_BuildingID = -1;
		CTI_ConstructionCamera cameraEffect["TERMINATE","BACK"];
		camDestroy CTI_ConstructionCamera;
		showCinemaBorder true;
	};
};