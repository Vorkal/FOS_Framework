#include "..\..\settings.hpp"
if !(IFF) exitWith {};

addMissionEventHandler ["EachFrame", {
    _targets = allUnits select {leader _x != leader player};
    if (NEEDGLASSES && goggles player in ["G_Tactical_Black","G_Tactical_Clear"] isEqualTo false) exitWith {};
	{[_x] call FOS_fnc_setIFF} forEach _targets;
}];
