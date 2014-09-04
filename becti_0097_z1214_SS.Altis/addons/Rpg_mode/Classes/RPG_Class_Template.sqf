_class_name="Template";
_restrict_gear=[];
_restrict_units=[];
_gear_changeprice=[["",100]]; //[classname,percent]
_unit_changeprice=[["",100]];
_special_func=[["",20]]; // [func,timeout]



// run restricted gear
_run_restrict_gear={
	while {({_x == _class_name} count RPG_Classes) == 0} do {
		{
			_g=_x;
		} forEach _restrict_gear;
	};
};