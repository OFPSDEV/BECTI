Private ["_hookable","_lifter","_vehicle","_vehicles"];

_lifter = _this select 0;
_hookable = [];

for '_i' from 0 to (count CTI_VEHICLES_HOOKERS) do {
	if (typeOf _lifter in (CTI_VEHICLES_HOOKERS select _i)) then {_hookable = _hookable + (CTI_VEHICLES_HOOKABLE select _i)};
};

if (alive _lifter) then {
	_lifter addAction [("<t color='#86F078'>" +  'Lift Vehicle' + "</t>"), "Client\Module\ZetaCargo\Zeta_Hook.sqf", ["LIFT", _hookable], 99, true, true, "", "(driver _target == player) && CTI_LIFT_MENU"]; //ss83 changed from 6 to 99
	_lifter addAction [("<t color=""#86F078"">" +  'Drop Vehicle' + "</t>"), "Client\Module\ZetaCargo\Zeta_Hook.sqf", ["DROP"], 99, true, true, "", "(driver _target == player) && CTI_DROP_MENU"]; //ss83 changed from 6 to 99
};

while {true} do { // --- loop to keep refreshing the Lift_menu_Appear condition
	if (driver _lifter == player) then { // --- without a player as pilot, the loop sits idle otherwise it interferes with other airlifters owned by the player
		_vehicle = _lifter getVariable "Attached";
		if (isNil "_vehicle") then {
			_lifter setVariable ["Attached", objNull, false];
		};
		CTI_LIFT_MENU = (driver _lifter == player && ({_x != _lifter } count (nearestObjects [_lifter, _hookable, 10]) > 0) && isNull (_lifter getVariable "Attached") && (getDammage _lifter < 0.3) && (getPos _lifter select 2 > 1 ));	
		CTI_DROP_MENU = (!isNull (_lifter getVariable "Attached"));
	};
	sleep 0.3;
};

