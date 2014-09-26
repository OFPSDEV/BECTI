/*
  # HEADER #
	Script: 		Common\Functions\Common_GetUnitsPerSide.sqf
	Alias:			CTI_CO_FNC_GetUnitsPerSide
	Description:	Sorts the passed units by side
	Author: 		Benny (ported form WFBE by Sari)
	Creation Date:	28-05-2014
	Revision Date:	28-05-2014
	
  # PARAMETERS #
    0	[Array]: The units
	1	[array]: The sides
	
  # RETURNED VALUE #
	[Array]:
	
  # SYNTAX #
	[Array, Array] call CTI_CO_FNC_GetUnitsPerSide
	
  # EXAMPLE #
    _units = ["Man", [east, west]] call CTI_CO_FNC_GetUnitsPerSide
*/

Private ["_count","_sides","_sideFriendly","_sideIgnored","_units"];

_units = _this select 0;
_sides = _this select 1;

_return = [];
for '_i' from 1 to count _sides do {[_return, []] Call CTI_CO_FNC_ArrayPush};

{
	_find = _sides find (side _x);
	if (_find != -1) then {[_return select _find, _x] Call CTI_CO_FNC_ArrayPush};
} forEach _units;

_return