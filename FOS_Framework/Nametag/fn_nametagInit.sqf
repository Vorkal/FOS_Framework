#include "..\..\settings.hpp"
if !(NAMETAG) exitWith {};

addMissionEventHandler ["EachFrame", {
    //Check if mission maker requests for glasses to be required.  Also check for whitelisted goggles
    if (NAMETAGNEEDGLASSES && goggles player in ["G_Tactical_Black","G_Tactical_Clear"] isEqualTo false) exitWith {};
    private ["_targets"];
    //Run drawing on different groups of units based on NAMETAGDEFAULTTARGET
    switch (NAMETAGDEFAULTTARGET) do {
        case (0): {
            _targets = missionNamespace getVariable ["FOS_nametagTargets",[]];
        };
        case (1): {
            _targets = missionNamespace getVariable ["FOS_nametagTargets",units group player - [player]];
        };
        case (2): {
            _targets = missionNamespace getVariable ["FOS_nametagTargets",allUnits select {[side group player, side group _x] call BIS_fnc_sideIsFriendly}];
        };
        default {
            _targets = missionNamespace getVariable ["FOS_nametagTargets",units group player - [player]];
        };
    };
	{[_x] call FOS_fnc_setNametag} forEach _targets;
}];
