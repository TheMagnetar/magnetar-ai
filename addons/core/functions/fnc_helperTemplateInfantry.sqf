/*
 * Author: TheMagnetar
 * Helper function for cloning a group of infantry units.
 *
 * Arguments:
 * 0: Group to clone <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [gropu player1] call mai_spawn_fnc_helperCloneInfantry
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_modelGroup"];

// Generate units
private _unitsToSpawn = [];
private _loadout = [];
private _rank = [];
private _skill = [];

private _leader = leader _modelGroup;
_unitsToSpawn pushBack (typeOf _leader);
_loadout pushBack (getUnitLoadout _leader);
_rank pushBack (rank _leader);
_skill pushBack (skill _leader);

private _unitsGroup = units _modelGroup;
{
    _unitsToSpawn pushBack (typeOf _x);
    _loadout pushBack (getUnitLoadout _x);
    _rank pushBack (rank _x);
    _skill pushBack (skill _x)
} forEach (_unitsGroup deleteAt (_unitsGroup find _leader));

[_unitsToSpawn, _loadout, _rank, _skill]