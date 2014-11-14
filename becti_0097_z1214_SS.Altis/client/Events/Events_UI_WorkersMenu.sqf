private ["_action"];
_action = _this select 0;
switch (_action) do {
	case "onLoad": {
		_logic = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;
		_workers = _logic getVariable "cti_workers";
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_workers", _workers];
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_sellmode", 0];
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_sellcompletebase", 0];
		
		{
			if (typeName _x == "OBJECT") then {
				((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260002) lnbAddRow [format["%1", mapGridPosition _x], format["Worker %1",_forEachIndex+1]];
				((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260002) lnbSetValue [[_forEachIndex,0], _forEachIndex];
			};
		} forEach _workers;
		execVM "Client\GUI\GUI_WorkersMenu.sqf";
	};
	case "onWorkersListLBSelChanged": {
		_selected = _this select 1;
		
		_selected = lnbValue [260002, [_selected, 0]];
		_worker = (uiNamespace getVariable "cti_dialog_ui_workersmenu_workers") select _selected;
		
		//--- Focus the minimap on the worker
		if (alive _worker) then {
			ctrlMapAnimClear ((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001);
			((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001) ctrlMapAnimAdd [.65, .2, getPos _worker];
			ctrlMapAnimCommit ((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001);
		};
	};
	case "onWorkerDisbandPressed": {
		_selected = _this select 1;
		
		if (_selected > -1) then { //--- Disband and delete the entry
			_selected = lnbValue [260002, [_selected, 0]];
			_worker = (uiNamespace getVariable "cti_dialog_ui_workersmenu_workers") select _selected;
			_worker setDammage 1;
			((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260002) lnbDeleteRow _selected;
		};
	};
	case "onStructureSellPressed": {
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_sellmode", 1];
	};
	case "onSellCompleteBase" : {
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_sellcompletebase", 1];
	};
	case "onMapButtonDown" : {
		_event = _this select 1;
		_button = _event select 1;
		_mx = _event select 2;
		_my = _event select 3;

		// Sell only one building.
		if ((_button == 0) &&((uiNamespace getVariable "cti_dialog_ui_workersmenu_sellmode") == 1)) then {	
			_logic = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;
			_total_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
				
			_ruins = _logic getVariable "cti_structures_wip";
			if !(isNil '_ruins') then {_total_structures = _total_structures + _ruins};
			_ruins = nil;
			_mappos = ((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001) ctrlMapScreenToWorld [_mx, _my];
			_nearest = [_mappos, _total_structures] call CTI_CO_FNC_GetClosestEntity;
			
			// Test to remove the building you wish to sell into a temp list.
			_updated_structures = [];
			{
				if(!(_nearest isEqualTo _x)) then {
					_updated_structures = _updated_structures + [_x];
				};
			} forEach (_total_structures);

			_can_sell = false; // Sell the building.
			// But, if its a base area we are trying to sell...
			if ((_nearest getVariable "cti_structure_type") == "MilitaryInstallation") then {
				{
					// If thers a building inside of the base area we are trying to sell.. then,
					if ((_x distance _nearest)  <= CTI_BASE_AREA_RANGE) then {
						// If there is another military installation within the area
						if ((_x getVariable "cti_structure_type") == "MilitaryInstallation") then {
							_can_sell = true;
						};
					};
				} forEach (_updated_structures);
				if (!_can_sell) then {
					hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You Must Sell All Structures Before Selling A Base";
				};
			} else {
				_can_sell = true;
			};
			if ((_nearest distance _mappos < 30) && (_can_sell)) then {
				_nearest setVariable ["cti_sell", true, true];
				deleteVehicle _nearest; // remove sold building.
				uiNamespace setVariable ["cti_dialog_ui_workersmenu_buildings", _updated_structures]; // Update local variable;
				["SERVER", "Ruin_Removed", [mapGridPosition _nearest, CTI_P_SideJoined]] call CTI_CO_FNC_NetSend; // Tell players
				// maybe add refund here?
			};
			_selling_sructures = nil;
			_total_structures = nil;
			_nearest = nil;
			
		};
		
		// Sell all buildings in a given military installation area.
		if ((_button == 0) && ((uiNamespace getVariable "cti_dialog_ui_workersmenu_sellcompletebase") == 1)) then {
			_logic = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;
			_total_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
			_ruins = _logic getVariable "cti_structures_wip";
			if !(isNil '_ruins') then {_total_structures = _total_structures + _ruins;};
			_mappos = ((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001) ctrlMapScreenToWorld [_mx, _my];
			{
				if ((_x distance _mappos) <= CTI_BASE_AREA_RANGE) then {
					_x setVariable ["cti_sell", true, true];
					["SERVER", "Ruin_Removed", [mapGridPosition _x, CTI_P_SideJoined]] call CTI_CO_FNC_NetSend;
					deleteVehicle _x;
				};
			} forEach (_total_structures);
		};
		
		// cleanup
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_sellmode", 0];
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_sellcompletebase" , 0];
	};
};