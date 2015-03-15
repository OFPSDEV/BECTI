/*
* Common_EnableLocation.sqf
* ex)
* boolean = [_town] call CTI_CO_FNC_EnableLocation
*
* Returns true if town should be included
* Returns false if town should not be included
*/

_returnBool = false;
private ["_mapAreaPortion","_townX","_townY","_returnBool","_town"];
/////////////
// do east west towns check vs list here
// use X coord of town to determine if the town should be initialized
// Using Anthrakia and Kalithea we obtain the eqn:: y = 1.86 * x - 14897.5
// random(0), all (1) , east(2), west(3), 
//_mapAreaPortion = missionNamespace getVariable "CTI_TOWNS_MAP_PORTION";
_mapAreaPortion =  CTI_TOWNS_MAP_PORTION;
_town = _this select 0;

_location = getPos _town;
_townX = (_location select 0);
_townY = (_location select 1);
// Use town's y to obtain the line's x...
_lineX = (_townY + 14897.5) / 1.86;

// All towns
if (_mapAreaPortion == 1) then {
	_returnBool = true;
};
// East towns
if (_mapAreaPortion == 2) then {
	if (_townX > _lineX) then {
		_returnBool = true;
	};
};
// West towns
if (_mapAreaPortion == 3) then {
	if (_townX < _lineX) then {
		_returnBool = true;
	};
};

//diag_log format ["X,Y: (%1,%2)  Town: %3", (_location select 0), (_location select 1), _town_name];
///////////

_returnBool;