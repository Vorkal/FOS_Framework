#include "..\..\settings.hpp"
if !(IFF) exitWith {};

if (missionNameSpace getVariable ["ace_nametags_showplayernames",0] > 0) exitWith {"ACE nametags is enabled. Disabling FOS iff" call FOS_fnc_debugSystemAdd};

addMissionEventHandler ["EachFrame", {
    //Check if mission maker requests for glasses to be required.  Also check for whitelisted goggles
    if (IFFNEEDGLASSES && goggles player in IFFGOGGLESNEEDED isEqualTo false) exitWith {};
    private ["_targets"];
    switch (IFFDEFAULTTARGET) do {
        case (0): { //off
            missionNameSpace setVariable ["FOS_iffTargets",[]];
        };
        case (1): { //group only
            _targets = allUnits select {
                group _x isEqualTo group player
            };
            missionNameSpace setVariable ["FOS_iffTargets",_targets];
        };
        case (2): { //side only
            _targets = allUnits select {
                side group player isEqualTo side group _x
            };
            missionNameSpace setVariable ["FOS_iffTargets",_targets];
        };
        case (3): { //friendly only
            _targets = allUnits select {
                [side group player, side group _x] call BIS_fnc_sideIsFriendly
            };
            missionNameSpace setVariable ["FOS_iffTargets",_targets];
        };
        case (4): { //friendly players only
            _targets = allUnits select {
                [side group player, side group _x] call BIS_fnc_sideIsFriendly
                &&
                isPlayer _x
            };
            missionNameSpace setVariable ["FOS_iffTargets",_targets];
        };
        default {
            _targets = allUnits select {
                group _x isEqualTo group player
            };
            missionNameSpace setVariable ["FOS_iffTargets",_targets];
        };
    };
    /* if (IFFTHROUGHWALLS isEqualTo false) then { //Don't draw behind objects
        if ([_x,[player],0] call FOS_fnc_canSee) exitWith {}; //unit can't be seen by player
        _targets = _targets select {[_x,[player],5] call FOS_fnc_canSee};
        missionNameSpace setVariable ["FOS_iffTargets",_targets];
    }; */
	{
        switch (IFFMODE) do { //Choose mode based on mission maker preference
            case (0): {

            };
            case (1): {
                [_x] call FOS_fnc_setNametag
            };
            case (2): {
                [_x] call FOS_fnc_setIFF
            };
        };
    } forEach _targets;
}];
