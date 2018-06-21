/*
 * Author: TheMagnetar
 * Returns near vehicles the unit is aware of that can be used by the group.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Distance <NUMBER> (default )
 *
 * Return Value:
 * Nearest vehicles suitable for the group
 *
 * Example:
 * [leader group player] call mai_vehicle_fnc_selectUnitsDisembark
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_group", "_vehicle", ["_forceAll", false]];

private _units = [];

if (_forceAll) exitWith {
    {
        if (alive _x # 0) then {
            _units pushBack (_x # 0);
        };
    } forEach fullCrew [_vehicle, "", false];
};

if (_vehicle iskindof "TANK" || _vehicle iskindof "Wheeled_APC_F" || _vehicle isKindOf "Air" || _vehicle isKindOf "SHIP") then {
    // Only cargo units
    {
        if (alive _x # 0) then {
            if (_vehicle iskindof "TANK" || {_vehicle iskindof "Wheeled_APC_F"}) then {
                _units pushBack (_x # 0);
            };

            if (_vehicle isKindOf "SHIP" && {[_x] call EFUNC(core,hasRebreather)}) then {
                _units pushBack (_x # 0);
            };

            if (_vehicle isKindOf "Air" && {[_x] call EFUNC(core,hasParachute)}) then {
                _units pushBack (_x # 0);
            };
        };
    } forEach fullCrew [_vehicle, "cargo", false];
} else {
    // Only the driver stays in the vehicle
    {
        if (alive _x  && {_x != driver _vehicle}) then {
            _units pushBack _x;
        };
    } forEach crew _vehicle;
};