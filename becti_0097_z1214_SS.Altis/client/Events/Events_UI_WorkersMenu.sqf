private ["_action"];
_action = _this select 0;
switch (_action) do {
	case "onLoad": {
		_logic = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;
		_workers = _logic getVariable "cti_workers";
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_workers", _workers];
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_sellmode", 0];
		
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
	case "onMapButtonDown": {
		_event = _this select 1;
		_button = _event select 1;
		_mx = _event select 2;
		_my = _event select 3;
		if (_button == 0 && (uiNamespace getVariable "cti_dialog_ui_workersmenu_sellmode") == 1) then {
			_logic = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;
			_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
			_ruins = _logic getVariable "cti_structures_wip";
			_total_structures = _structures;
			if !(isNil '_ruins') then {_total_structures = _structures + _ruins};
			_mappos = ((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001) ctrlMapScreenToWorld [_mx, _my];
			_nearest = [_mappos, _total_structures] call CTI_CO_FNC_GetClosestEntity;
			
			// csm
			_can_sell = true;
			_sold_base = false;
			_updated_base_array = [];
			_updated_base_counter = 0;
			_old_base_counter = 0;
			_building_counter = 0;
			_areas = CTI_P_SideLogic getVariable "cti_structures_areas";
			{//For each top 
			
				_add_base = true;
				_y = _x; // _y is for structure areas
				if((_mappos distance _y)<=15) then { // if it is a base we are trying to sell, check for buildings inside
					{
						if(_y distance _x <= CTI_BASE_AREA_RANGE) then { // if there is a built building inside the base we cannot sell it
							
							_can_sell = false;
							_building_counter = _building_counter + 1;
						};
					}forEach (_total_structures);
					if(_building_counter == 1) then {
						_can_sell = true;
						_sold_base = true;
						_add_base = false;
					} else {
						hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You Must Sell All Structures Before Selling A Base";
					};
				};
				if(_add_base) then {
				
				// The base gets sold and the array goes away but the marker is not removed.
					_updated_base_array set [_updated_base_counter, _areas select _old_base_counter];
					_updated_base_counter = _updated_base_counter + 1;
				};
				_old_base_counter = _old_base_counter +1;
			}forEach(CTI_P_SideLogic getVariable "cti_structures_areas");
			if(_sold_base) then {
				CTI_P_SideLogic setVariable ["cti_structures_areas", _updated_base_array];
			};
			//end csm
			
			if ((_nearest distance _mappos < 15) && _can_sell) then {
				if (isNil {_nearest getVariable "cti_sell"}) then {
					_nearest setVariable ["cti_sell", true, true];
					//todo bcast
					if (_nearest in _structures) then {
						_nearest setDammage 1;
					} else {
						["SERVER", "Ruin_Removed", [mapGridPosition _nearest, CTI_P_SideJoined]] call CTI_CO_FNC_NetSend;;
						deleteVehicle _nearest;
					};
				};
			};
			uiNamespace setVariable ["cti_dialog_ui_workersmenu_sellmode", 0];
		};
	};
};