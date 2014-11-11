

if (typeName _this != "SIDE") exitWith {""};

switch (_this) do {
	case west: {"\A3\Data_F\Flags\Flag_nato_CO.paa"};  //ss83 change flags from blue, red, green to appropriate icons for flag poles.
	case east: {"\A3\Data_F\Flags\Flag_CSAT_CO.paa"};
	case resistance: {"\A3\Data_F\Flags\Flag_FIA_CO.paa"};
	default {""}
}