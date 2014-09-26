/*
	Defenses Definition, define the available town defenses.
*/

Private ["_classes","_headers","_side"];

_side = "GUER";
_headers = []; 
_classes = [];

//--- Defenses (Statics)

_headers = _headers 		+ ["MG"];
_classes = _classes 		+ ["I_HMG_01_F"];

_headers = _headers 		+ ["MG"];
_classes = _classes 		+ ["I_HMG_01_high_F"];

_headers = _headers 		+ ["GL"];
_classes = _classes 		+ ["I_GMG_01_F"];

_headers = _headers 		+ ["GL"];
_classes = _classes 		+ ["I_GMG_01_high_F"];

_headers = _headers 		+ ["AA"];
_classes = _classes 		+ ["I_static_AA_F"];

_headers = _headers 		+ ["AT"];
_classes = _classes 		+ ["I_static_AT_F"];

_headers = _headers 		+ ["Mortar"];
_classes = _classes 		+ ["I_Mortar_01_F"];


//--- Defenses management for towns.
if (isServer) then {[_side, _classes, _headers] Call Compile preprocessFile "Common\Config\Config_Defenses_Towns.sqf"};