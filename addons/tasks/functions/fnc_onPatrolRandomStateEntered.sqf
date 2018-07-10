/*
 * Author: TheMagnetar
 * Executed when units enter the Patrol Random state.
 *
 * Arguments:
 * 0: Group <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [group player] call mai_tasks_fnc_onPatrolRandomStateEntered
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_group", "_state"];

private _settings = _group getVariable [QEGVAR(core,settings), []];
private _reachedDistance = [_settings, "reachedDistance"] call CBA_fnc_hashGet;
private _execStatements = "";
private _condition = "true";

if ([_settings, "waitAtWaypoint"] call CBA_fnc_hashGet) then {
    private _unitType = [_settings, "type"] call CBA_fnc_hashGet;

    if (_unitType isEqualTo "infantry") then {
        _execStatements = QUOTE([ARR_2(QQGVAR(wait), group this)] call CBA_fnc_localEvent);
    } else {
        private _vehicle = vehicle (leader _group);
        _execStatements = QUOTE([ARR_2(QQGVAR(disembark), [ARR_4(group this, true, true, false)])] call CBA_fnc_localEvent);
        _condition = QUOTE(speed (vehicle (leader this)) == 0);
    };
} else {
    _execStatements = QUOTE([ARR_2(QQGVAR(doTask), group this)] call CBA_fnc_localEvent);
};

systemChat format ["_execStatements", _execStatements];
private _marker = [_settings, "marker"] call CBA_fnc_hashGet;
private _targetPos = [_group, _marker, ["MOVE", _execStatements, _condition]] call EFUNC(waypoint,generateWaypoint);
_group setVariable [QGVAR(distance), (getPos (leader _group)) distance2D _targetPos];
