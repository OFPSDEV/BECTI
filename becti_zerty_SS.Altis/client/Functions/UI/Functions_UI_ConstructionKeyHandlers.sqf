// CSM here
CTI_UI_ConstructionKeyHandler_ConstructionCamera = {
	// WASD - Move camera laterally
	private ["_alt", "_control", "_key", "_shift"];
	
	_key = _this select 1;
	_shift = _this select 2;
	_control = _this select 3;
	_alt = _this select 4;
	
	_twopi = pi*2;
	_newPos = [0,0,0];
	_rotation = pi/24; // 15 deg of rotation 
	
	switch (true) do {
		case (_key in (actionKeys "MoveForward")): {

			_deg = deg CTI_ConstructionCam_Theta;
			_cos = cos _deg;
			_sin = sin _deg;
			
			_pos = getPos CTI_ConstructionCamera;
			_newPos set [0, (_pos select 0) + _cos];
			_newPos set [1, (_pos select 1) + _sin];
			_newPos set [2, (_pos select 2)];
			
			if !(((getPos CTI_ConstructionCam_HQ) distance _newPos) > (CTI_BASE_CONSTRUCTION_RANGE)) then {
				CTI_ConstructionCamera setPos _newPos;
			};
		};
		case (_key in (actionKeys "MoveBack")): {
			
			_deg = deg CTI_ConstructionCam_Theta;
			_cos = cos _deg;
			_sin = sin _deg;
			
			_pos = getPos CTI_ConstructionCamera;
			_newPos set [0, (_pos select 0) - _cos];
			_newPos set [1, (_pos select 1) - _sin];
			_newPos set [2, (_pos select 2)];
			
			if !(((getPos CTI_ConstructionCam_HQ) distance _newPos) > (CTI_BASE_CONSTRUCTION_RANGE) ) then {
				CTI_ConstructionCamera setPos _newPos;
			};
		};
		case (_key in (actionKeys "TurnLeft")): {
		
			_deg = deg (CTI_ConstructionCam_Theta + (pi/2));
			_cos = cos _deg;
			_sin = sin _deg;
			
			_pos = getPos CTI_ConstructionCamera;
			_newPos set [0, (_pos select 0) + _cos];
			_newPos set [1, (_pos select 1) + _sin];
			_newPos set [2, (_pos select 2)];
			
			if !(((getPos CTI_ConstructionCam_HQ) distance _newPos) > (CTI_BASE_CONSTRUCTION_RANGE) ) then {
				CTI_ConstructionCamera setPos _newPos;
			};
		};
		case (_key in (actionKeys "TurnRight")): {
		
			_deg = deg (CTI_ConstructionCam_Theta - (pi/2));
			_cos = cos _deg;
			_sin = sin _deg;
			
			_pos = getPos CTI_ConstructionCamera;
			_newPos set [0, (_pos select 0) + _cos];
			_newPos set [1, (_pos select 1) + _sin];
			_newPos set [2, (_pos select 2)];
			
			if !(((getPos CTI_ConstructionCam_HQ) distance _newPos) > (CTI_BASE_CONSTRUCTION_RANGE) ) then {
				CTI_ConstructionCamera setPos _newPos;
			};
		};
		case (_key in (actionKeys "LeanLeft")) : {

			CTI_ConstructionCam_Theta = CTI_ConstructionCam_Theta + _rotation;
			
			if (CTI_ConstructionCam_Theta > _twopi) then 
			{
				CTI_ConstructionCam_Theta = CTI_ConstructionCam_Theta - _twopi;
			};
			_deg = deg CTI_ConstructionCam_Theta;
			_cos = cos _deg;
			_sin = sin _deg;
			CTI_ConstructionCamera setVectorDirAndUp [[_cos, _sin, -0.66],[0,0,1]];

		};
		case (_key in actionKeys "LeanRight") : {

			CTI_ConstructionCam_Theta = CTI_ConstructionCam_Theta - _rotation;

			if (CTI_ConstructionCam_Theta < 0) then 
			{
				CTI_ConstructionCam_Theta = CTI_ConstructionCam_Theta + _twopi;
			};
			_deg = deg CTI_ConstructionCam_Theta;
			_cos = cos _deg;
			_sin = sin _deg;
			CTI_ConstructionCamera setVectorDirAndUp [[_cos, _sin, -0.66],[0,0,1]];
		};
	}; 
};

//--- Change the zoom level of the satelitte camera
CTI_UI_ConstructionKeyHandler_ConstructionCamera_MouseZChanged = {
	_change = _this select 1;
	
	_pos = getPos CTI_ConstructionCamera;
	_level = _pos select 2;
	
	_change = if (_change > 0) then { _level - (_level * 0.2) } else { _level + (_level * 0.2) };
	if (_change > CTI_CONSTRUCTIONCAM_ZOOM_MAX) then { _change = CTI_CONSTRUCTIONCAM_ZOOM_MAX };
	if (_change < CTI_CONSTRUCTIONCAM_ZOOM_MIN) then { _change = CTI_CONSTRUCTIONCAM_ZOOM_MIN };
	
	if (_change != _level) then {
		_pos set [2, _change];
		CTI_ConstructionCamera setPos _pos;
	};
};

//--- The mouse is in a "down" state
CTI_UI_ConstructionKeyHandler_ConstructionCamera_MouseButtonDown = {
	_button = _this select 1;
	_coord_x = _this select 2;
	_coord_y = _this select 3;
	
	switch (_button) do {
		case 0: { //--- Left clicked
			CTI_VAR_StructurePlaced = true;
		};
		case 1: { //--- Right clicked 
			CTI_ConstructionCam_BuildingID = CTI_ConstructionCam_BuildingID + 1;
		};
		
	};
};

//--- The mouse is in a "up" state
CTI_UI_ConstructionKeyHandler_ConstructionCamera_MouseButtonUp = {
	_button = _this select 1;
	
	if (_button == 0) then { //--- Left clicked
	};
	if (_button == 1) then { //--- Right clicked
	};
};

//--- The mouse is being moved
CTI_UI_ConstructionKeyHandler_ConstructionCamera_MouseMoving = {
	_screenToWorld = screenToWorld [_this select 1, _this select 2];
	if ((_screenToWorld distance (getPos CTI_ConstructionCam_HQ)) <= CTI_BASE_CONSTRUCTION_RANGE) then {
		CTI_ConstructionCam_MouseLoc set [0, _screenToWorld select 0];
		CTI_ConstructionCam_MouseLoc set [1, _screenToWorld select 1];
		CTI_ConstructionCam_MouseLoc set [2, getTerrainHeightASL _screenToWorld];
	};

};

// End csm