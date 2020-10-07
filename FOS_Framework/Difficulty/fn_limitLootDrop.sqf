
params ["_unit"];

#include "..\..\settings.hpp"
if !(DIFFICULTY) exitWith {};

_unit addEventHandler ["InventoryOpened", {
    params ["_unit", "_container"];

    //Check if the group has been deleted yet
    if (group _container isEqualTo grpNull) then {
        //Group is missing now. We will have to check the typename of the dead unit to find the side
        _side = ((configfile >> "CfgVehicles" >> (typeof _container) >> "side") call BIS_fnc_getCfgData) call BIS_fnc_sideType;
        //Exit if nothing was returned.
        if (isNil "_side") exitWith {};
        //Don't clear the inventory of non-enemy containers
        if ([side group _unit, _side] call BIS_fnc_sideIsFriendly) exitWith {};
    } else {
        //Don't clear the inventory of non-enemy containers
        if ([side group _unit, side group _container] call BIS_fnc_sideIsFriendly) exitWith {};
    };


    //Find every unique item
    _uniqueItems = [];
    {_uniqueItems pushBackUnique _x} forEach (magazines _container);

    //Reduce the amount of every unique item to only 2. (including the magazine already loaded)
    {
        //Store the _x variable for counting
        _item = _x;
        //Count how much of this item exists
        _amount = {_item == _x} count ((magazines _container));
        //If the amount is larger than LOOTAMOUNT; reduce the amount to LOOTAMOUNT
        if (_amount > LOOTAMOUNT) then {
            for "_i" from _amount to 2 step -1 do {
                _container removeMagazine _item;
            };
        };
    } forEach _uniqueItems;
}];
