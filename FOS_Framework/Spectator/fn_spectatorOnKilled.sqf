#include "..\..\settings.hpp"
if !(SPECTATOR) exitWith {};

//Make array to push side relations into.
_friendList = [];
{
    if (side group (_this select 0) getFriend _x >= 0.6) then {_friendList pushback _x};
} forEach [WEST,EAST,INDEPENDENT,CIVILIAN];

//Start Spectator, no free cam and only player side
if (!alive player) then {
    ["Initialize", [player, _friendList, true, false, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
};
