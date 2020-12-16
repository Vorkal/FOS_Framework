#include "..\..\settings.hpp"
if !(IFF) exitWith {};

addMissionEventHandler ["EachFrame", {
    //Check if mission maker requests for glasses to be required.  Also check for whitelisted goggles
    if (IFFNEEDGLASSES && goggles player in ["G_Tactical_Black","G_Tactical_Clear"] isEqualTo false) exitWith {};
    //Find all units that are not the player's group and are friendly
    private ["_targets"];
    switch (IFFDEFAULTTARGET) do {
        case (0): {
            _targets = missionNameSpace getVariable ["FOS_iffTargets",[]];
        };
        case (1): {
            _targets = allUnits select {
                leader _x != leader player
                &&
                side _x isEqualTo side player
            };
            _targets = missionNameSpace getVariable ["FOS_iffTargets",_targets];
        };
        case (2);
        default {
            _targets = allUnits select {
                leader _x != leader player
                &&
                [side group player, side group _x] call BIS_fnc_sideIsFriendly
            };
            _targets = missionNameSpace getVariable ["FOS_iffTargets",_targets];
        };
    };
    //Do not draw IFF icons if the need glasses parameter is added and they do not have glasses equipped
    if (NEEDGLASSES && goggles player in ["G_Tactical_Black","G_Tactical_Clear"] isEqualTo false) exitWith {};
	{[_x] call FOS_fnc_setIFF} forEach _targets;
}];
