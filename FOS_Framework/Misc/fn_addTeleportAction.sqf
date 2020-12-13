/*
Author: 417

Description: Makes an object an interactable object that allows people to teleport to selected areas on the map

Parameters:
_object (OBJECT): The object you wish to be the action point
_Blacklist (ARRAY): Black list area the player is not allowed to teleport to. Check BIS_fnc_getArea for more information on this formatting
_moveSquad (BOOL): Controls if the player moves his entire team when position is selected.
_safeStartOnly (BOOL): Player can only use this object when safe start is detected on.
_TeleAfterSafeStart (BOOL): If a player uses the action during safe start then the teleport will occur after safe start ends

Example:
[] spawn FOS_fnc_addTeleportAction;
[flag,[[position player, 200]],true,false,true] spawn FOS_fnc_addTeleportAction;
*/
#include "..\..\settings.hpp"
if !(MISSIONTELEPORT) exitWith {};
if (isNil {TELEOBJECT}) exitWith {};

params [
    ["_object",TELEOBJECT,[objNull]],
    ["_Blacklist",TELEBLACKLIST],
    ["_moveSquad",TELEMOVESQUAD],
    ["_safeStartOnly",TELESAFESTARTONLY],
    ["_TeleAfterSafeStart",TELEAFTERSAFESTART]
];

_addAction = {

    (_this select 3) params ["_object","_Blacklist","_moveSquad","_safeStartOnly","_TeleAfterSafeStart"];
    private ["_pos"];

    //private function that clears all variables used in the script so that it doesn't overlap with other instances
    _clearVar = {
        params ["_mapClickId"];
        player setVariable ["FOS_TeleportPos",nil];
        player setVariable ["FOS_validStart",nil];
        removeMissionEventHandler ["MapSingleClick", _mapClickId];
    };

    //If a position was assigned before, delete it
    deleteMarker (name player + "_TeleMarker");

    //Initialize variable. Used to detect if script was called again while waiting
    player setVariable ["FOS_validStart",false];

    //Open map and instruct player
    openMap true;
    hint "select a spot to teleport to";
    //Add event handler that tracks player click in map
    _mapClickId = addMissionEventHandler ["MapSingleClick", {
        params ["_units", "_pos", "_alt", "_shift"];
        player setVariable ["FOS_TeleportPos",_pos];
    }];

    //Check whenever player chooses a position that is valid
    while {player getVariable ["FOS_validStart",false] isEqualTo false && visibleMap} do {
        //Find player's currently picked location
        _pos = player getVariable ["FOS_TeleportPos",[0,0,0]];
        //Check if a position on the map has been clicked yet
        if !(_pos isEqualTo [0,0,0]) then {
            //If the player's picked location is not within a blacklist area then set valid start to true. Or just set to true if blacklist has no entry
            if (isNil "_Blacklist") then {
                player setVariable ["FOS_validStart",true];
            } else {
                if ({_pos inArea (_x call BIS_fnc_getArea)} count _Blacklist == 0) then {
                    player setVariable ["FOS_validStart",true];
                };
            };
        };
    };
    waitUntil {!visibleMap || player getVariable ["FOS_validStart",false]};
    if !(visibleMap) exitWith {removeMissionEventHandler ["MapSingleClick", _mapClickId];hint "teleportation canceled"};
    if (isNil "_pos") exitWith {removeMissionEventHandler ["MapSingleClick", _mapClickId];hint "invalid behaviour detected"};

    //Check if code should execute as soon as valid or after safe start is disabled
    if (_TeleAfterSafeStart) then {
        //If a position was assigned before, delete it
        deleteMarker (name player + "_TeleMarker");
        _text = "";
        if (_moveSquad) then {
            _text = groupId group player + ": Start Marker"
        } else {
            _text = name player + ": Start Marker"
        };
        _mrk = createMarker [(name player + "_TeleMarker"), _pos];
        _mrk setMarkerShape "ICON";
        _mrk setMarkerType "hd_dot";
        _mrk setMarkerText _text;

        [_mapClickId] call _clearVar;

        waitUntil {!isNil "FOS_validStart" ||missionNamespace getVariable ["FOS_Safemode",true] isEqualTo false};
        if (player setVariable ["FOS_validStart",true] isEqualTo false) exitWith {};
        if (_moveSquad) then {

            {
                //Due to some really weird issue, AI are teleported slower because they keep snapping back to their original position otherwise
                if !(isPlayer _x) then {sleep 1};
                vehicle _x setPos ([getMarkerPos _mrk, 0, 30, 2.5,0,0,0,[],getMarkerPos _mrk] call BIS_fnc_findSafePos)
            } forEach units group player;
            [_mapClickId] call _clearVar;
        } else {
            vehicle player setPos getMarkerPos _mrk;
            [_mapClickId] call _clearVar;
        };

    } else {
        //Should the whole squad move or just the player
        if (_moveSquad) then {
            {
                //Due to some really weird issue, AI are teleported slower because they keep snapping back to their original position otherwise
                if !(isPlayer _x) then {sleep 1};
                vehicle _x setPos ([_pos, 0, 30, 2.5,0,0,0,[],_pos] call BIS_fnc_findSafePos);
            } forEach units group player;
            [_mapClickId] call _clearVar;
        } else {
            vehicle player setPos _pos;
            [_mapClickId] call _clearVar;
        };
    };
};

_cond = "";
if (_safeStartOnly) then {
    _cond = _cond + "FOS_Safemode isEqualTo true";
};
if (_moveSquad) then {
    if (_cond == "FOS_Safemode isEqualTo true") then {
        _cond = _cond + " && ";
    };
    _cond = _cond + "leader group player == player";
};
if (_cond == "") then {
    _cond = "true";
};
_object addAction ["Teleport", _addAction, [_object,_Blacklist,_moveSquad,_safeStartOnly,_TeleAfterSafeStart], 1.5, true, true, "", _cond, 10, false, "", ""];
