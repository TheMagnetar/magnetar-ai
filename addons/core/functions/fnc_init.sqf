/*
 * Author: TheMagnetar
 * Initialises a group.
 *
 * Arguments:
 * 0: Unit <OBJECT> (Default: objNull)
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call mai_core_fnc_init
 *
 * Public: Yes
 */
#include "script_component.hpp"

params [["_unit", objNull], "_marker", ["_type", "infantry"], ["_options", []]];

// Only execute on the server
if (!isServer) exitWith {};

private _group = group _unit;

if (!local (leader _group)) exitWith {};

if (!GVAR(debugEnabled) && {markerAlpha _marker != 0}) then {
    _marker setMarkerAlpha 0;
};

// Create default values for the group
private _settings = [] call CBA_fnc_hashCreate;
_settings = [_settings, _marker, _type] call FUNC(setBasicSettings);

[_settings, "behaviour", [behaviour (leader _group)]] call CBA_fnc_hashSet;
[_settings, "combatMode", [combatMode _group]] call CBA_fnc_hashSet;
[_settings, "formation", [formation _group]] call CBA_fnc_hashSet;
[_settings, "speed", [speedMode _group]] call CBA_fnc_hashSet;

_settings = [_settings, _options] call FUNC(parseOptions);
_group setVariable [QGVAR(settings), _settings];
_group setVariable [QGVAR(enabled), true];

[_group, _settings] call FUNC(applyOptions);

// Register the group
[QGVAR(registerGroup), [_group, _marker]] call CBA_fnc_localEvent;
