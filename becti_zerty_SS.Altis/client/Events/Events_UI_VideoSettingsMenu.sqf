private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		//--- View distance
		// csm
		//infantry
		_distance = profileNamespace getVariable "CTI_PERSISTENT_INF_VIEW_DISTANCE";
		_distance_max = missionNamespace getVariable "CTI_GRAPHICS_VD_MAX";
		if (isNil '_distance') then { _distance = viewDistance };
		
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150002) sliderSetRange [1, _distance_max];
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150002) sliderSetPosition _distance;
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150001) ctrlSetText format ["Infantry View Distance: %1", _distance];
		
		//ground
		_distance = profileNamespace getVariable "CTI_PERSISTENT_GROUND_VIEW_DISTANCE";
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150011) sliderSetRange [1, _distance_max];
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150011) sliderSetPosition _distance;
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150010) ctrlSetText format ["Ground Vehicle & Ship View Distance: %1", _distance];
		//air
		_distance = profileNamespace getVariable "CTI_PERSISTENT_AIR_VIEW_DISTANCE";
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150013) sliderSetRange [1, _distance_max];
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150013) sliderSetPosition _distance;
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150012) ctrlSetText format ["Aircraft View Distance: %1", _distance];
		
		// auto view button setup
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150014) ctrlSetText (if (profileNamespace getVariable "CTI_PERSISTENT_AUTODISTANCE") then {"Auto View Distance: On"} else {"Auto View Distance: Off"});
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150014) ctrlSetToolTip (if (profileNamespace getVariable "CTI_PERSISTENT_AUTODISTANCE") then {"The automatic view distance system is currently enabled"} else {"The automatic view distance system is currently disabled"});
		
		// end csm
		
		
		//--- Object distance
		_distance = profileNamespace getVariable "CTI_PERSISTENT_OBJECT_PERCENT";
		_distance_max = missionNamespace getVariable "CTI_GRAPHICS_VD_MAX";
		
		if (isNil '_distance') then { _distance = (viewDistance * 75) };
		if (_distance > 100) then { _distance = 100 };
		
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150004) sliderSetRange [1, 100];
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150004) sliderSetPosition _distance;
		
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150003) ctrlSetText format ["Object Distance Percentage: %1", _distance];
		
		//--- Shadows Distance. (doesn't even work anyway)
		_distance = profileNamespace getVariable "CTI_PERSISTENT_SHADOWS_DISTANCE";
		// if (isNil '_distance') then { _distance = getShadowDistance }; //--- This command is bistified, do not use it yet.
		if (isNil '_distance') then { _distance = 100 };
		
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150006) sliderSetRange [50, 200];
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150006) sliderSetPosition _distance;
		
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150005) ctrlSetText format ["Shadows Distance: %1", _distance];
		
		//--- Terrain Grid
		_grid = profileNamespace getVariable "CTI_PERSISTENT_TG";
		_grid_max = missionNamespace getVariable "CTI_GRAPHICS_TG_MAX";
		
		if (isNil '_grid') then { _grid = 25 };
		if (typeName _grid != "SCALAR") then { _grid = 0 };
		if (_grid > _grid_max) then { _grid = _grid_max };
		
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150008) sliderSetRange [0, _grid_max];
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150008) sliderSetPosition _grid;
		
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150007) ctrlSetText format ["Terrain Grid: %1", _grid];
		
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150009) ctrlSetText (if (profileNamespace getVariable "CTI_PERSISTENT_HINTS") then {"Hints: On"} else {"Hints: Off"});
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150009) ctrlSetToolTip (if (profileNamespace getVariable "CTI_PERSISTENT_HINTS") then {"The hint system is currently enabled"} else {"The hint system is currently disabled"});
	};
	case "onViewSliderChanged": {
		_changeto = round(_this select 1);
		
		profileNamespace setVariable ["CTI_PERSISTENT_INF_VIEW_DISTANCE", _changeto];
		saveProfileNamespace;
//csm
		if(profileNamespace getVariable "CTI_PERSISTENT_AUTODISTANCE") then {
			if((vehicle player) isKindOf "Man") then {
				((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150001) ctrlSetText format ["Infantry View Distance: %1", _changeto];
				
				_objectView = profileNamespace getVariable "CTI_PERSISTENT_OBJECT_PERCENT";
				setObjectViewDistance (_changeto * (_objectView/100));
				setViewDistance _changeto;
			};
		} else {
			((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150001) ctrlSetText format ["View Distance: %1", _changeto];
			
			_objectView = profileNamespace getVariable "CTI_PERSISTENT_OBJECT_PERCENT";
			setObjectViewDistance (_changeto * (_objectView/100));
			setViewDistance _changeto;
		};
		
	};
	case "onGroundViewSliderChanged": {
		_changeto = round(_this select 1);
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150010) ctrlSetText format ["Ground Vehicle & Ship View Distance: %1", _changeto];
		profileNamespace setVariable ["CTI_PERSISTENT_GROUND_VIEW_DISTANCE", _changeto];
		saveProfileNamespace;
		//csm
		if(profileNamespace getVariable "CTI_PERSISTENT_AUTODISTANCE") then {
			if(((vehicle player) isKindOf "LandVehicle") || ((vehicle player) isKindOf "Ship")) then {
				
				_objectView = profileNamespace getVariable "CTI_PERSISTENT_OBJECT_PERCENT";
				setObjectViewDistance (_changeto * (_objectView/100));
				setViewDistance _changeto;
			};
			
		};
	};
	case "onAirViewSliderChanged": {
		_changeto = round(_this select 1);
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150012) ctrlSetText format ["Aircraft View Distance: %1", _changeto];
		profileNamespace setVariable ["CTI_PERSISTENT_AIR_VIEW_DISTANCE", _changeto];
		saveProfileNamespace;
		//csm
		if(((vehicle player) isKindOf "Air") && (profileNamespace getVariable "CTI_PERSISTENT_AUTODISTANCE")) then {
			_objectView = profileNamespace getVariable "CTI_PERSISTENT_OBJECT_PERCENT";
			setObjectViewDistance (_changeto * (_objectView/100));
			setViewDistance _changeto;
		};
	};
	case "onObjectSliderChanged": { 
		_changeto = round(_this select 1);
		if (_changeto > 100) then {_changeto = 100};
		profileNamespace setVariable ["CTI_PERSISTENT_OBJECT_PERCENT", _changeto];
		saveProfileNamespace;
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150003) ctrlSetText format ["Object Distance Percentage: %1", _changeto];
		//csm
		setObjectViewDistance (viewDistance * (_changeto / 100));
	};
	case "onAutoViewDistancePressed": { // csm
		_changeto = !(profileNamespace getVariable "CTI_PERSISTENT_AUTODISTANCE");
		profileNamespace setVariable ["CTI_PERSISTENT_AUTODISTANCE", _changeto];
		
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150014) ctrlSetText (if (_changeto) then {"Auto View Distance: On"} else {"Auto View Distance: Off"});
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150014) ctrlSetToolTip (if (_changeto) then {"The automatic view distance system is currently enabled"} else {"The automatic view distance system is currently disabled, and Infantry View Distance is Primary"});
		
		saveProfileNamespace;
	}; // csm
	case "onShadowsSliderChanged": {
		_changeto = round(_this select 1);
		
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150005) ctrlSetText format ["Shadows Distance: %1", _changeto];
		profileNamespace setVariable ["CTI_PERSISTENT_SHADOWS_DISTANCE", _changeto];
		setShadowDistance _changeto;
	};
	case "onGridSliderChanged": {
		_changeto = round(_this select 1);
		
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150007) ctrlSetText format ["Terrain Grid: %1", _changeto];
		profileNamespace setVariable ["CTI_PERSISTENT_TG", _changeto];
		setTerrainGrid _changeto;
	};
	case "onHintsPressed": {
		_changeto = !(profileNamespace getVariable "CTI_PERSISTENT_HINTS");
		profileNamespace setVariable ["CTI_PERSISTENT_HINTS", _changeto];
		
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150009) ctrlSetText (if (_changeto) then {"Hints: On"} else {"Hints: Off"});
		((uiNamespace getVariable "cti_dialog_ui_videosettingsmenu") displayCtrl 150009) ctrlSetToolTip (if (profileNamespace getVariable "CTI_PERSISTENT_HINTS") then {"The hint system is currently enabled"} else {"The hint system is currently disabled"});
		
		saveProfileNamespace;
	};
	case "onUnload": {
		saveProfileNamespace;
	};
};
