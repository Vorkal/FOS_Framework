#include "..\..\settings.hpp"
if !(SPECTATOR) exitWith {};
params [["_mode",true]];

switch (_mode) do { //State of SPECTATOR
    case (true): { // Enable SPECTATOR

        //Get all friendly forces
        _friendList = [];
        {
            if (side group player getFriend _x >= 0.6) then {_friendList pushback _x};
        } forEach [WEST,EAST,INDEPENDENT,CIVILIAN];
        //blank out friend list if all units should be shown
        if (SHOWALLUNITS) then {_friendList = []};

        //Specatator
        ["Initialize", [player, _friendList, SHOWAI, FREECAM, THIRDPERSONCAM, SHOWFOCUSINFO, SHOWCAMERABUTTONS, SHOWCONTROLSHELPER, SHOWHEADER, SHOWENTITYLIST]] call BIS_fnc_EGSpectator;
    };
    case (false): {
        ["Terminate"] call BIS_fnc_EGSpectator;
    };
};
