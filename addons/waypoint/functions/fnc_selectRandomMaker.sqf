/*
 * Author: TheMagnetar
 * Selects a marker randomly.
 *
 * Arguments:
 * 0: Marker(s) <STRING><ARRAY> (default: "")
 *
 * Return Value:
 * None
 *
 * Example:
 * [group player] call mai_waypoint_fnc_selectRandomMarker
 *
 * Public: No
 */
#include "script_component.hpp"

params [
    ["_markers", "", ["", []]]
];

if (_markers isEqualTo "" || {_markers isEqualTo []}) exitWith {
    ERROR("Empty markers");
};

if (_markers isEqualType "") exitWith {
    _markers
};

// Sum chances
private _rnd = (count _markers) random 100;
private _previousWeight = 0;
{
    _x params ["_marker", "_weight"];

    if (_rnd < _weight && {_rnd => _previousWeight}) exitWith {
        _marker;
    } else {
        _previousWeight = _weight;
    };
} forEach _markers;
