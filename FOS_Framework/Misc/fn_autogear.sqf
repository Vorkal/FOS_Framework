/*
Author: 417

Description: Will automatically gear a unit as much as it can based on parameters given

Parameters:
_object (OBJECT): The object that will have gear added to it
_itemArray (ARRAY): list of items that should be added and the the

Example:
[_object,[["_itemName",maximum amount],["_itemName",maximum amount]]] call FOS_fnc_autogear;
*/

if !(isServer) exitWith {};

params [["_object",objNull,[objnull]],["_itemArray",[["FirstAidKit",2]]]];
//_object is invalid
if (_object isEqualTo objNull || isNil "_object") exitWith {format ["AUTOGEAR: %1 is an invalid object", _object] call FOS_fnc_debugSystemAdd};

//Complete the itemArray first before adding magazines
{
    _itemClass = _x # 0;
    _itemAmount = _x # 1;
    _currentItemAmount = {toLower _itemClass isEqualTo toLower _x} count items _object;
    //Don't allow anything that is not these typenames
    if !(_itemClass isEqualType "STRING") exitWith {format ["AUTOGEAR: %1 must be a string", _itemClass] call FOS_fnc_debugSystemAdd};
    if !(_itemAmount isEqualType 2) exitWith {format ["AUTOGEAR: %1 must be a number", _itemAmount] call FOS_fnc_debugSystemAdd};

    for "_i" from _currentItemAmount to _itemAmount do { //Run for the amount of items listed
        if (_i != _itemAmount) then {_object addItem _itemClass};
    };
} forEach _itemArray;

//Add magazines for each weapon
{

    if !(_x isEqualTo "") then { //Weapon exists
        //list of magazines that can be given
        _magazines = [_x] call BIS_fnc_compatibleMagazines;
        _currentMagazinesAmount = {toLower _x in _magazines} count itemsWithMagazines _object;
        _magazine = _magazines # 0;
        _canAddAmount = 0;

        //Find how many magazines can be added for this
        for "_i" from (1 + _currentMagazinesAmount) to 12 do {
            _canAdd = _object canAdd [_magazine,_i];
            if (_canAdd isEqualTo false) exitWith {}; //Can't add any more mags
            _canAddAmount = _canAddAmount + 1;
        };
        //Reduce the amount of magazines that could be added to 75%
        _canAddAmount = round (_canAddAmount * 0.75);

        if (_forEachIndex == 2) then { //Sidearm
            //No need to add more than 3 pistol mags
            if (_canAddAmount > 3) then {_canAddAmount = 3};
            //if there is already 3 mags then don't add any
            if (_currentMagazinesAmount >= 3) then {_canAddAmount = 0};
        };

        for "_i" from 1 to _canAddAmount do {
            _object addMagazine _magazine;
        };
    }
} forEach [primaryWeapon _object,secondaryWeapon _object,handgunWeapon _object];
