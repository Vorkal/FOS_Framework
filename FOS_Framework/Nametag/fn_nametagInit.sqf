#include "..\..\settings.hpp"
if !(NAMETAG) exitWith {};

missionNamespace setVariable ["FOS_nametagTargets",units group player - [player]];

addMissionEventHandler ["EachFrame", {
    _targets = missionNamespace getVariable ["FOS_nametagTargets",units group player - [player]];
	{[_x] call FOS_fnc_setNametag} forEach _targets;
}];
