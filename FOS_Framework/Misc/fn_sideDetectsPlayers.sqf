/*
Author: 417

Description: Checks list and finds if any of them are known above a certain threshold.

Parameters:
_list (array): List of units that will be checked
_side (array): List of sides you want the group to be checked against. Default is ALL ENEMY sides of the currently tested unit
_threshold (scalar): knowsAbout number that the unit checked must be over or equal to for the funciton to return true

Example:
[allPlayers,4]
*/

params [["_list",allPlayers,[]],["_sides",[],[[]]],["_threshold",1.5,[224]]];
private ["_result"];

{
    _unit = _x;
    if (_sides isEqualTo []) then {_sides = _unit call BIS_fnc_enemySides};
    {
        _side = _x;
        if (_side knowsAbout _unit >= _threshold) exitWith {true};
        false
    } forEach _sides;
} forEach _list
