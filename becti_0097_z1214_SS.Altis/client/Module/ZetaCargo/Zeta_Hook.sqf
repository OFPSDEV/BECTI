Private ["_Action","_hookable","_info","_lifter","_position","_vehicle","_vehicles"];

_lifter = _this select 0;
_info = _this select 3;
_action = _info select 0;
_hookable = _info select 1;

switch (_action) do {
	case "LIFT": {
		//--- check to see if any airliftable cargo is in range
		_vehicles = _lifter nearentities [_hookable, 15]; //ss83 changed from 10 to 15
		if (_lifter in _vehicles) then {_vehicles = _vehicles - [_lifter]}; //--- Prevent lifter from trying to lift itself when lifting other air units.
		_vehicle = [_lifter,_vehicles] Call CTI_CO_FNC_GetClosestEntity;
		if (count crew(_vehicle) > 0) exitWith {hint ('Only empty vehicles can be lifted.')}; //--- Aborts if cargo has a unit inside

		_vehicle attachTo [_lifter, [0,0,-8]]; // ss83 changed from -4 to -8 normal loading position for choppers
		_lifter setVariable ["Attached", _vehicle, true];

		while {true} do { //--- loop that constantly checks for reasons to drop the cargo (airlifter damaged, pilot ejected etc.)
			sleep 0.5;
			if (!canMove _lifter || getDammage _lifter > 0.3 || isNull (driver _lifter) || isNull (_lifter getVariable "Attached") || count crew(_vehicle) > 0) exitWith { 
				if (isNull (driver _lifter) && (alive _lifter)) then {
					hint ("You must remain in the pilot seat to airlift. Detaching cargo...");
				};
				if (count crew(_vehicle) > 0) then {
					hint ( "The Vehicle must remain empty whilst being airlifted. Detaching cargo...");
				};
				detach _vehicle; // --- chopper unloading 
				_vehicle setVelocity (velocity _lifter); // --- supposed to make cargo match lifter's velocity and fall to the ground in an arc, but only works occasionally. No idea why. I blame BIS.
				_lifter setVariable ["Attached", objNull, false];
			};
		};
	};
	
	Case "DROP": {
		_lifter setVariable ["Attached",objNull, false];
	};
};