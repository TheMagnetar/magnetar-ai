/*
 * Author: TheMagnetar
 * Task patrol.
 *
 * Arguments:
 * 0: Group <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [group player] call mai_tasks_fnc_onWaypointStateEntered
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_group", "_state"];

if (!_group getVariable[QGVAR(taskInit), false]) then {
    _group getVariable[QGVAR(taskInit), true];
};

private _settings = _group getVariable [QEGVAR(core,settings), []];

// TODO make the reached distance depend on marker size?
[_settings, "reachedDistance", 10] call CBA_fnc_hashSet;
[_settings, "checkingDistance", 150] call CBA_fnc_hashSet;

if ([_settings, "task"] call CBA_fnc_hashGet == "Patrol") then {
    [_settings, "behaviour", ["safe"]] call CBA_fnc_hashSet;
    [_settings, "speed", ["limited"]] call CBA_fnc_hashSet;
};

if ([_settings, "forceRoads"] call CBA_fnc_hashGet) then {
    (leader _group) forceFollowRoad true;
};

systemChat format ["task init %1", [_settings, "marker"] call CBA_fnc_hashGet];