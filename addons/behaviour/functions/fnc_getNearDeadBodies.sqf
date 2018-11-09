#include "script_component.hpp"
/*
 * Author: TheMagnetar
 * Returns an array of dead bodies within the given distance visible by the unit
 *
 * Arguments:
 * 0: Unit <OBJECT><ARRAY>
 * 1: Radius <NUMBER> (default: 50)
 *
 * Return Value:
 * Array of dead bodies <ARRAY>
 *
 * Example:
 * [player, 100] call mai_behaviour_fnc_getNearDeadBodies
 *
 * Public: No
 */

params ["_unit", ["_radius", 50]];

private _deadBodies = (_unit nearObjects ["Man", "_radius"]) select {!alive _x};
_deadBodies select {[_unit, _x, _radius, HUMAN_VIEW_ANGLE] call EFUNC(core,hasVisual)}
