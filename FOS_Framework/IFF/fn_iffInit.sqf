#include "..\..\settings.hpp"
if !(IFF) exitWith {};

addMissionEventHandler ["EachFrame", {
    if (IFFNEEDGLASSES && goggles player in ["G_Tactical_Black","G_Tactical_Clear"] isEqualTo false) exitWith {};
    //Find all units that are not the player's group and are friendly
    private ["_targets"];
    switch (IFFDEFAULTTARGET) do {
        case (0): {
            _targets = [];
        };
        case (1): {
            _targets = allUnits select {
                leader _x != leader player
                &&
                side _x isEqualTo side player
            };
        };
        case (2);
        default {
            _targets = allUnits select {
                leader _x != leader player
                &&
                [side group player, side group _x] call BIS_fnc_sideIsFriendly
            };
        };
    };
    //Do not draw IFF icons if the need glasses parameter is added and they do not have glasses equipped
    if (NEEDGLASSES && goggles player in ["G_Tactical_Black","G_Tactical_Clear"] isEqualTo false) exitWith {};
	{[_x] call FOS_fnc_setIFF} forEach _targets;
}];
