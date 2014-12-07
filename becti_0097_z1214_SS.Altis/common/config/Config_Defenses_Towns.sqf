/*
	Define the defenses type in towns by side.
*/

Private ["_classes","_def_kinds","_def_kinds_content","_headers","_side"];

_side = _this select 0;
_classes = _this select 1;
_headers = _this select 2;

_def_kinds = [];
_def_kinds_content = [];
for '_i' from 0 to count(_classes)-1 do {
	_find = _def_kinds find (_headers select _i);
	if (_find != -1) then {
		_def_kinds_content set [_find, (_def_kinds_content select _find) + [_classes select _i]];
	} else {
		if (_headers select _i != "") then {
			[_def_kinds, _headers select _i] Call CTI_CO_FNC_ArrayPush;
			[_def_kinds_content, [_classes select _i]] Call CTI_CO_FNC_ArrayPush};
	};
};

for '_i' from 0 to (count _def_kinds)-1 do {missionNamespace setVariable [Format ["CTI_%1_Defenses_%2", _side,_def_kinds select _i], _def_kinds_content select _i]};

if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Common\Config\config_Defenses_Towns.sqf", format ["[%1] [%2] Category defined.", _side, count _def_kinds]] call CTI_CO_FNC_Log};
	