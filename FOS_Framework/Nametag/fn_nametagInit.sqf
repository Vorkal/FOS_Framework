#include "..\..\settings.hpp"
if !(NAMETAG) exitWith {};

missionNamespace setVariable ["FOS_nametagTargets",units group player - [player]];

addMissionEventHandler ["EachFrame", {
    if (NEEDGLASSES && goggles player in ["G_Tactical_Black","G_Tactical_Clear"] isEqualTo false) exitWith {};
    _targets = missionNamespace getVariable ["FOS_nametagTargets",units group player - [player]];
	{[_x] call FOS_fnc_setNametag} forEach _targets;
}];
