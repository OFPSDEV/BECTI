/*
  # HEADER #
	Script: 		Common\Functions\Common_EquipVehicleCargoSpace.sqf
	Alias:			CTI_CO_FNC_EquipVehicleCargoSpace
	Description:	Equip the cargo space of a vehicle (Weapons/Magazines/Backpacks)
	Author: 		Benny
	Creation Date:	16-10-2013
	Revision Date:	16-10-2013

  # PARAMETERS #
    0	[Object]: The vehicle to equip
    1	[Array]: The loadout (Type/Count)

  # RETURNED VALUE #
	None

  # SYNTAX #
	[UNIT, ARRAY] call CTI_CO_FNC_EquipVehicleCargoSpace

  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetItemBaseConfig

  # EXAMPLE #
	_gear = [["PaperRifle", 2], ["PaperMagazine", 4]];

	[vehicle player, _gear] call CTI_CO_FNC_EquipVehicleCargoSpace;
	  -> This will add the content of gear on the player's vehicle
*/

private ["_count", "_get", "_item",
	"_loadout", "_loadout_count", "_loadout_index",
	"_previous_item_counts", "_previous_item_names", "_purchase", "_purchase_count", "_purchase_type",
	"_remove_item", "_type", "_vehicle"];

_vehicle = _this select 0;
_loadout = _this select 1;

if !(alive _vehicle) exitWith {};
//if (count _loadout == 0) exitWith {};

// Don't duplicate items that we already have.
// Normally we would just clear the cargo before setting it, but:
// 1. Clearing the vehicle's cargo looses track of all items that are in backpacks/launchers/guns/vests/etc in the cargo
// 2. BIS doesn't provide a way to remove specific cargo items, so we can't determine what the new buy does not have, and remove just those
// To work around this, we look at each item we already have, and remove one from the purchase list if it's present.

// Each item in old loadout
_loadout_count = count _loadout;
{
	_previous_item_names = _x select 0;
	_previous_item_counts = _x select 1;
	{
		_remove_item = _x;
		_remove_count = _previous_item_counts select _forEachIndex;
		_loadout_index = 0;
		// Step through new loadout
		while { _loadout_index < _loadout_count and _remove_count > 0 } do {
			_purchase = _loadout select _loadout_index;
			_purchase_type = _purchase select 0;
			_purchase_count = _purchase select 1;
			// Does this item match something we are buying?
			if(_remove_item == _purchase_type and _purchase_count > 0 ) then {
				_purchase set [1, _purchase_count - 1];  // Don't buy that item
				_remove_count = _remove_count - 1;
			}else{
				_loadout_index = _loadout_index + 1; // Check the next item
			};
		}
	} forEach _previous_item_names;
} forEach [getItemCargo(_vehicle)] + [getBackpackCargo(_vehicle)] + [getMagazineCargo(_vehicle)] + [getWeaponCargo(_vehicle)];

//--- Buggy way to clear vehicle that loses items in items.
//clearBackpackCargoGlobal _vehicle;
//clearItemCargoGlobal _vehicle;
//clearMagazineCargoGlobal _vehicle;
//clearWeaponCargoGlobal _vehicle;

//--- Start loading up stuff
{
	_item = _x select 0;
	_count = _x select 1;
	_get = (missionNamespace getVariable _item);
	if (isNil '_get') then {
		_vehicle addItemCargoGlobal [_item, _count]; // If we don't know what kind of a thing it is, try adding it anyway
	}else{
		_type = if (typeName (_get select 1) == "STRING") then {_get select 1} else {(_get select 1) select 0};		
		if(_type=="Backpack") then{
			_vehicle addBackpackCargoGlobal [_item, _count];
		}else{
			_vehicle addItemCargoGlobal [_item, _count];
		};
	};
	
	/*switch (_item call CTI_CO_FNC_GetItemBaseConfig) do { //todo figure out bout that goggle mystery
		case "CfgMagazines": { _vehicle addMagazineCargoGlobal [_item, _count] };
		case "CfgWeapons": { _vehicle addWeaponCargoGlobal [_item, _count] };
		case "Item": { _vehicle addItemCargoGlobal [_item, _count] };
	};*/
} forEach _loadout;