

CTI_UI_Gear_LoadAvailableUnits = nil;
CTI_UI_Gear_LoadAvailableUnits = {
	_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
	_list = [];
	_fobs = CTI_P_SideLogic getVariable ["cti_fobs", []];
	_vh=[];
	{
		_v=_x;
		if ( ({_x== (vehicle _v)} count _vh) <1  && ! ((vehicle _v) == _v)) then {_vh =_vh+[vehicle _v];};
	} forEach ((group player) call CTI_CO_FNC_GetLiveUnits);
	_u=_vh+((group player) call CTI_CO_FNC_GetLiveUnits);
	{
		_nearest = [CTI_BARRACKS, _x, _structures, CTI_BASE_GEAR_RANGE] call CTI_CO_FNC_GetClosestStructure;
		_ammo_trucks = [_x, CTI_SPECIAL_AMMOTRUCK, CTI_BASE_GEAR_RANGE/4] call CTI_CO_FNC_GetNearestSpecialVehicles;
		_fob_in_range = false;
		if (count _fobs > 0) then {
			_fob = [_x, _fobs] call CTI_CO_FNC_GetClosestEntity;
			if (_fob distance _x <= (CTI_BASE_GEAR_FOB_RANGE*2)) then {_fob_in_range = true};
		};
		if (!isNull _nearest || _x == player || count _ammo_trucks > 0 || _fob_in_range) then {//todo add fob
			[_list, _x] call CTI_CO_FNC_ArrayPush;
			if (_x isKindOf "Man") then {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70201) lbAdd Format["[%1] %2", _x call CTI_CL_FNC_GetAIDigit, getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName")];
			} else {
				((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70201) lbAdd Format["%1", getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName")];
			};
		};
	} forEach _u;
	//} forEach ((group player) call CTI_CO_FNC_GetLiveUnits);

	uiNamespace setVariable ["cti_dialog_ui_gear_units", _list];

	((uiNamespace getVariable "cti_dialog_ui_gear") displayCtrl 70201) lbSetCurSel 0;
};

