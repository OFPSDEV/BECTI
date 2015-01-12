createDialog "CTI_RscBuildMenu";

//_camera = BIS_CONTROL_CAM;
/*if (isNil "BIS_CONTROL_CAM") then {
	_camera = "camconstruct" camCreate [position player select 0,position player select 1,15];
	_camera cameraEffect ["internal","back"];
	_camera camPrepareFov 0.900;
	_camera camPrepareFocus [-1,-1];
	_camera camCommitPrepared 0;
	cameraEffectEnableHUD true;
	_camera setdir direction player;
	[_camera,-30,0] call BIS_fnc_setPitchBank;
	_camera camConstuctionSetParams ([_startPos] + (_logic getVariable "BIS_COIN_areasize"));
};
BIS_CONTROL_CAM = _camera;
BIS_CONTROL_CAM_LMB = false;
BIS_CONTROL_CAM_RMB = false;


CTI_CMDR_BuildCam = true;
[] Spawn {
	//createDialog "CTI_RscBuildMenu";
	//-- Construction view start
	diag_log format["Action_BuildMenu.sqf: Construction Thread Start"];
		_yaw = 0;
		_distance = 0;
		_playerPosArr = (getPos player);
		_playerX = 0;
		_playerY = 0;
		_playerZ = 25 + (_playerPosArr select 2);
		_playerPosArr set [2,_playerZ];
		
/*
		_camera = "camera" camCreate (position player);
		_camera camCommand "manual on";
		showCinemaBorder false;
		cameraEffectEnableHUD true;
		_camera camSetFocus [-1,-1];
		_camera camSetPos [_playerX, _playerY, _playerZ];
		_camera camSetFov 0.900;
		_camera camCommit 0;

		
		//_mySingleArray set [0,"Foo"];
		
		_camera = "camera" camCreate (position player);
		showCinemaBorder false;
		cameraEffectEnableHUD true;
		[_camera,-30,0] call BIS_fnc_setPitchBank;
		//_camera camCommand "manual on";
		_camera cameraEffect ["internal","back"];
		_camera camPrepareFov 0.900;
		_camera camPrepareFocus [-1,-1];
		_camera camPreparePos _playerPosArr;
		
		_camera camCommitPrepared 0;
		
		//_camera setDir
		player globalChat format["%1", getPos _camera];
		
	
	while{CTI_CMDR_BuildCam} do {
		_yaw = _yaw + 1;
		if (_yaw >= 360) then {_yaw = 0;};
		_camera setDir _yaw;
/*		
		_playerPosArr = (getPos player);
		_playerX = _playerPosArr select 0;
		_playerY = _playerPosArr select 1;
		_playerZ = 25;

		// Check if too far away from commander
		_posPlayer = getPos player;
		_posCamera = getPos _camera;
		if(_distance >= (CTI_BASE_AREA_RANGE/2)) then {
			CTI_CMDR_BuildCam = false; // Working
		};

		
		player globalChat format ["Player: %1", [_playerX, _playerY, _playerZ]];
		player globalChat format["Camera: %1", getPos _camera];
		
		diag_log format["Action_BuildMenu.sqf: Construction Thread LOOP"];
		diag_log getPos camTarget _camera;

		sleep 0.035; // old .1
		
					
/* Not working correctly			camDestroy _camera;
			_camera = "camera" camCreate _posCamera;
			showCinemaBorder false;
			cameraEffectEnableHUD true;
			[_camera,-30,0] call BIS_fnc_setPitchBank;
			_camera camCommand "manual on";
			_camera cameraEffect ["internal","back"];
			_camera camPrepareFov 0.900;
			_camera camPrepareFocus [-1,-1];
			_camera camPreparePos _playerPosArr;
		
			_camera camCommitPrepared 0; 

		
		//_camera camSetPos getPos player;
		//_camera camSetTarget player;
		//_camera camSetRelPos [0,20,10];
		//_camera camCommitPrepared 0;
		
	};
	
	//-- Construction view end
	_camera cameraEffect ["Terminate", "Back"];
	sleep 0.5;
    camDestroy _camera;

	diag_log format["Action_BuildMenu.sqf: Construction Thread End"];
};

