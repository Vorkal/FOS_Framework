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

    waitUntil {!((findDisplay 60492) isEqualTo displayNull)};

    if (missionNameSpace getVariable ["FOS_PointsLeft",0] > 0) then {
        _ctrl = findDisplay 60492 ctrlCreate ["RscButton", -1];

        _ctrl ctrlSetPositionY -0.42;
        _ctrl ctrlSetPositionX 0.13;
        _ctrl ctrlSetPositionh 0.07;
        _ctrl ctrlSetPositionw 0.24;

        _ctrl ctrlCommit 0;
        _Ctrl ctrlSetText "Call Checkpoint";
        _ctrl ctrlAddEventHandler ["ButtonClick", {["spawnsLeft"] call FOS_fnc_checkpointPointsSystem}];

        _ctrl = findDisplay 60492 ctrlCreate ["RscButton", -1];

        _ctrl ctrlSetPositionY -0.42;
        _ctrl ctrlSetPositionX -0.12;
        _ctrl ctrlSetPositionh 0.07;
        _ctrl ctrlSetPositionw 0.24;

        _ctrl ctrlCommit 0;
        _Ctrl ctrlSetText "Checkpoints Left";
        _ctrl ctrlAddEventHandler ["ButtonClick", {["activated"] call FOS_fnc_checkpointPointsSystem}];

        _ctrl = findDisplay 60492 ctrlCreate ["RscButton", -1];
    };
    //TODO: Make this an alert to the admin that they were arma'd
    /* _ctrl ctrlSetPositionY -0.42;
    _ctrl ctrlSetPositionX 0.8;
    _ctrl ctrlSetPositionh 0.07;
    _ctrl ctrlSetPositionw 0.24;

    _ctrl ctrlCommit 0;
    _Ctrl ctrlSetText "I got ArmA'd";
    _ctrl ctrlSetTextColor [1,0,0,1];
    _ctrl ctrlAddEventHandler ["ButtonClick", {hint "Hurray!!! You pushed me!!!"}]; */
};
