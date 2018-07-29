/*
 * Author: TheMagnetar
 * Selects a marker randomly.
 *
 * Arguments:
 * 0: Group <STRING><ARRAY> (default: "")
 *
 * Return Value:
 * None
 *
 * Example:
 * [group player] call mai_waypoint_fnc_organizeMarkers
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_markers"];

if (_markers isEqualType "") exitWith {
    _markers
};

private _totalWeight = 0;

{
    _totalWeight = _totalWeight + (_markers # _forEachIndex # 1);
} forEach _markers;

{
    _x set [1, (_x # _forEachIndex # 1)/_totalWeight*100];
} forEach _markers;

_markers
