
#include "..\..\settings.hpp"
if !(DIFFICULTY) exitWith {};

player addEventHandler ["InventoryOpened", {
    params ["_unit", "_container"];

    //Don't run clear the inventory of non-enemy containers
    if !([side group _unit, side group _container] call BIS_fnc_sideIsEnemy) exitWith {};

    //Find every unique item
    _uniqueItems = [];
    {_uniqueItems pushBackUnique _x} forEach (magazines _container);

    //Reduce the amount of every unique item to only 2. (including the magazine already loaded)
    {
        //Store the _x variable for counting
        _item = _x;
        //Count how much of this item exists
        _amount = {_item == _x} count ((magazines _container));
        //If the amount is larger than two; reduce the amount to 2
        if (_amount > 2) then {
            for "_i" from _amount to 2 step -1 do {
                _container removeMagazine _item;
            };
        };
    } forEach _uniqueItems;
}];
