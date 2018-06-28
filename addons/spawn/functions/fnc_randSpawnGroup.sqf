/*
 * Author: TheMagnetar
 * Spawns a random group of units.
 *
 * Arguments:
 * 0: Unit <OBJECT> (Default: objNull)
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call mai_spawn_fnc_randSpawnGroup
 *
 * Public: Yes
 */
#include "script_component.hpp"

params ["_configEntry", "_groupSize", "_marker", ["_sleep", 0.05], ["_position", []]];

private _side = getText (configFile >> "CfgGroupCompositions" >> _configEntry >> "side");

// Basic options should be always defined
private _options = [];
{
    private _values = getArray (configFile >> "CfgGroupCompositions" >> _configEntry >> _x);
    _options pushBack [_x, _values];
} forEach ["behaviour", "combatMode", "formation", "speed", "skill", "skillLeader"];

// Additional options defined in config
private _options =+ getArray (configFile >> "CfgGroupCompositions" >> _configEntry >> "options");

private _settings = [] call CBA_fnc_hashCreate;
private _type = getText (configFile >> "CfgGroupCompositions" >> _configEntry >> "type");
_settings = [_settings, _marker, _type] call EFUNC(core,setBasicSettings);

// Init all group options
_settings = [_settings, _options] call EFUNC(core,parseOptions);

private _determineSize = {
    params ["_grpSize"];

    private _size = 0;
    if (_grpSize isEqualTo []) then {
        _grpSize params ["_minSize", "_maxSize"];
        _size = _minSize + floor (random (_maxSize - _minSize));
    } else {
        _size = _grpSize;
    };

    _size
};

// Determine group size
private _size = 0;
if (_groupSize isEqualType []) then {
    if (_type isEqualTo "infantry") then {
        _size = [_groupSize] call _determineSize;
    } else {
        _groupSize params ["_gSize", "_cargoSize"];
        _size = [[_gSize] call _determineSize, [_cargoSize] call _determineSize];
    };
} else {
    _size = _groupSize;
};

// Generate units
[_configEntry, _settings, _side, _size, _marker, _sleep, _position] call (missionNamespace getVariable (format [QFUNC(helperSpawn%1), _type]));
