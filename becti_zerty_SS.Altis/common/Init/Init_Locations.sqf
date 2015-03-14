private ["_town"];

CTI_Towns = [];
_CENTER_POS=getMarkerPos "CENTER_POS";
_CENTER_RADIUS=(getMarkerSize "CENTER_POS")select 0;

for '_i' from 0 to 1000 do {
	if (isNil Format ["Town%1", _i]) exitWith {};

	_town = call compile Format ["Town%1", _i];
	if ((_town distance _CENTER_POS)<_CENTER_RADIUS) then {
		waitUntil {!isNil {_town getVariable "cti_town_value"}};
		[CTI_Towns, _town] call CTI_CO_FNC_ArrayPush;
	};
};
CTI_InitTowns = true;
