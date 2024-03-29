/*
 * Author: TheMagnetar
 * Applies the settings to the group before units are spawned
 *
 * Arguments:
 * 0: Group <OBJECT> (Default: objNull)
 * 1: Settings <HASH>
 *
 * Return Value:
 * None
 *
 * Example:
 * [group player] call mai_core_fnc_applyOptionsPreSpawn
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_group", ["_settings", []]];

if (_settings isEqualTo []) then {
    _settings = _group getVariable [QGVAR(settings), []];
};

// PreSpawn code
[_group] call compile ([_settings, "preSpawn"] call CBA_fnc_hashGet);

// Prepare the marker configuration in order to spawn/select initial position
private _marker = [_settings, "marker"] call CBA_fnc_hashGet;
_marker = [_marker] call EFUNC(waypoint,organizeMarkers);

[_settings, "marker", _marker] call CBA_fnc_hashSet;

[_group, _settings] call FUNC(handleStartPosition);
