

RPG_Gear_Cache = missionNamespace getVariable "cti_gear_all";
RPG_Fact_Cache = [
missionNamespace getVariable format ["CTI_%1_%2Units", CTI_P_SideJoined, CTI_BARRACKS],
missionNamespace getVariable format ["CTI_%1_%2Units", CTI_P_SideJoined, CTI_LIGHT],
missionNamespace getVariable format ["CTI_%1_%2Units", CTI_P_SideJoined, CTI_HEAVY],
missionNamespace getVariable format ["CTI_%1_%2Units", CTI_P_SideJoined, CTI_AIR],
missionNamespace getVariable format ["CTI_%1_%2Units", CTI_P_SideJoined, CTI_REPAIR],
missionNamespace getVariable format ["CTI_%1_%2Units", CTI_P_SideJoined, CTI_AMMO],
missionNamespace getVariable format ["CTI_%1_%2Units", CTI_P_SideJoined, CTI_NAVAL]];
RPG_Unit_Cache=[];

{
	_f=_x;
	{
		RPG_Unit_Cache=RPG_Unit_Cache +[missionNamespace getVariable _x];
	} forEach _f;
} forEach RPG_Fact_Cache;



RPG_Skill_Points=0;
RPG_Classes=[];