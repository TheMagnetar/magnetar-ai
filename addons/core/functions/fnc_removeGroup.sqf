/*
 * Author: TheMagnetar
 * Removes a group from the AI management addon
 *
 * Arguments:
 * 0: Group <OBJECT> (default: objNull)
 *
 * Return Value:
 * None
 *
 * Example:
 * [group player] call mai_core_fnc_removeGroup
 *
 * Public: Yes
 */
#include "script_component.hpp"

params ["_group"];

if (!local _group) exitWith {};

if ((_group getVariable [QGVAR(settings), []]) isEqualTo []) exitWith {
    ERROR_1("Group %1 has not been initialised",_group);
};

_group setVariable [QGVAR(enabled), false];
