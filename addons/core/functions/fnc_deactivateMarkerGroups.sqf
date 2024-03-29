/*
 * Author: TheMagnetar
 * Disables all groups assigned to a marker (groups are hidden).
 *
 * Arguments:
 * 0: Marker <STRING> (default: "")
 * 1: Filter <CODE> (default: {})
 *
 * Return Value:
 * None
 *
 * Example:
 * ["marker1", {true}] call mai_core_fnc_deactivateMarkerGroups
 *
 * Public: Yes
 */
#include "script_component.hpp"

params [
    ["_marker", "", [""]],
    ["_filter", {}, [{}]]
];

private _groups = [_marker, _filter] call FUNC(getMarkerGroups);

{
    [_x] call EFUNC(caching,cacheFullGroup);
} forEach _groups;
