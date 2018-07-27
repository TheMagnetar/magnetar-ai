/*
 * Author: TheMagnetar
 * Filters the given buildings
 *
 * Arguments:
 * 0: Unit or position <OBJECT><ARRAY>
 * 1: Radius <NUMBER> (default: 25)
 * 2: Return only the nearest building <BOOL> (default: false)
 *
 * Return Value:
 * Array of buildings <ARRAY> or the nearest building <OBJECT>
 *
 * Example:
 * [nearestBuilding player] call mai_building_fnc_getNearBuildings
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_buildings", "_filter"];

private _filteredBuildings = [];

{
    params ["_key", "_value"];
    private _filteredBuildings = [];
    switch (_key) do {
        case "area": {
            _filteredBuildings = _buildings select {_x inArea _value};
            };
        };
        case "enterable": {
            // Enterable buildings are those that a) can be entered b) do not have occupied positions
            _filteredBuildings = _buildings select {count (_x buildingPos -1) > 0 && {_x getVariable [QGVAR(freePositions), -1] == -1 || {_x getVariable [QGVAR(freePositions), -1] > 0}}};
        };
    };

    _building = _filteredBuildings;
} forEach _filter;

_buildings