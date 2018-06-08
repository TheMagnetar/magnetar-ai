/*
 * Author: TheMagnetar
 * Handles assigning the additional options to the group.
 *
 * Arguments:
 * 0: Unit <OBJECT> (Default: objNull)
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call mai_core_fnc_setSkill
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_group", "_skill"];

private _skillCategory = [];

if ((toLower (_skill # 0)) isEqualTo "general") then {
    _skillCategory = ["general"];
} else {
    _skillCategory = ["aimingShake", "aimingSpeed", "endurance", "spotDistance", "spotTime", "courage", "reloadSpeed", "commanding"];
};

{
    private _unit = _x;
    {
        private _val = 0;
        if (isArray (_skill # _forEachIndex)) then {
            (_skill # _forEachIndex) params ["_min", "_max"];

            _val = _min + random [_max - _min];
        } else {
            _val = (_skill # _forEachIndex);
        };
        _unit setSkill [_x, _val];
    } forEach _skillCategory;
} forEach (units _group);