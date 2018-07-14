/*
 * Author: TheMagnetar
 * Makes a unit patrol a building.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 *
 * Example:
 * [group player] call mai_building_fnc_patrolBuilding
 *
 * Public: Yes
 */
#include "script_component.hpp"

params ["_unit"];

private _buildingPatrol = _unit getVariable [QGVAR(inBuilding), [false]];

if !(_buildingPatrol # 0) exitWith {};

if (!alive _unit) exitWith {
    _unit setVariable [QGVAR(inBuilding), [false]];
};

_buildingPatrol params ["_inBuilding", "_building", ["_buildingPos", []], ["_waitUntilTime", CBA_missionTime], ["_returnLeader", false]];

if (_buildingPos isEqualTo []) exitWith {
    if (!_returnLeader) then {
        systemChat format ["return leader"];
        _unit doMove (formationPosition _unit);
        // Give the unit 10 seconds to go back to the leader
        _unit setVariable [QGVAR(inBuilding), [true, _building, _buildingPos, CBA_missionTime + 10, true]];
    } else {
        if (moveToCompleted _unit || {moveToFailed _unit} || {!alive _unit} || CBA_missionTime > _waitUntilTime) then {
            _unit setVariable [QGVAR(inBuilding), [false]];
        };
    };
};

if (moveToCompleted _unit || {moveToFailed _unit} || {!alive _unit} || {CBA_missionTime >= _waitUntilTime}) then {
    private _index = floor random (count _buildingPos);
    _unit doMove (_building buildingPos _index);
    _buildingPos deleteAt _index;
    // Give the unit 20 seconds before switching to the next building position
    _unit setVariable [QGVAR(inBuilding), [true, _building, _buildingPos, CBA_missionTime + 20, _returnLeader]];
};
