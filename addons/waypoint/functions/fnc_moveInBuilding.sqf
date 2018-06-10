/*
 * Author: TheMagnetar
 * Move the some of all the unitss of the group to the near buildings.
 *
 * Arguments:
 * 0: Group <OBJECT> (default: objNull)
 * 1: Perform patrol <BOOL> (default: true)
 *
 * Return Value:
 * None
 *
 * Example:
 * [nearestBuilding player] call mai_waypoint_fnc_moveInBuilding
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_group"];

private _unitsToMove = [];
private _rejectedUnits = [];

// Exclude the leader in patrolling the buildings
private _leader = leader _group;
private _units = (units _group) deleteAt ((units _group) find _leader);

{
    if (_x isKindOf "Man" && {alive _x} && {unitReady _x} && {_x == vehicle _x} && {canMove _x} && {canStand _x}) then {
        _unitsToMove pushBack _x;
    } else {
        if (_x != vehicle _x && {!(_x in (crew (vehicle _x)))}) then {
            _unitsToMove pushBack _x;
        } else {
            _rejectedUnits pushBack _x;
        };
    };
} foreach (units _group);

if (_unitsToMove isEqualTo []) exitWith {};

private _buildings = [leader _group] call FUNC(getNearBuildings);
if (_buildings isEqualTo []) exitWith {};

private _inBuilding = false;
{
    private _buildingPos = [_x] call FUNC(getBuildingPos);
    private _building = _x;

    if !(_buildingPos isEqualTo []) then {
        private _maxUnits = round (2 * (1 + count (_buildingPos/5)));
        private _assignedUnits = [];
        private _unitCount = 0;
        {
            if (_unitCount == _maxUnits) exitWith {};
            _x setVariable [GVAR(inBuilding), [true, _building, _buildingPos]];
            _assignedUnits pushBack _x;

            _unitsToMove deleteAt (_unitsToMove find _x);
            _inBuilding = true;
        } forEach _unitsToMove;
    };

    if (_unitsToMove isEqualTo []) exitWith {};
} forEach _buildings;

_inBuilding
