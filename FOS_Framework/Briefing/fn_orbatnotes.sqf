/*
Author: F3 (Modified by 417)

Description: initializes the ORBAT notes

*/

#include "..\..\settings.hpp"
if !(ORBAT) exitWith {};
if (!hasInterface) exitWith {}; //Exit if not a player.

private ["_sides","_orbatText","_refreshNote","_perfectInfoNote"];

if (CANREFRESH) then {
    _refreshNote = "<execute expression='[] spawn FOS_fnc_orbatnotes'>refresh</execute>";
} else {
    _refreshNote = "ORBAT is only accurate at player join";
};

if (PERFECTINFO && CANREFRESH) then {
    _perfectInfoNote = "";
} else {
    _perfectInfoNote = "Note: Dead units are not removed from list until they are reported";
};


_orbatText = "
<font size='22'>ORBAT</font><br/><br/>" + _perfectInfoNote + "<br/><br/>" + _refreshNote + "<br/><br/> ";

_findGroup = {
    params ["_group"];
    mapAnimAdd [0.5, 0.1, getPos leader _group];
    mapAnimCommit;
};

//Parameter that determines which sides are shown
if (SHOWALL) then {
    _sides = [west,east,independent,civilian];
} else {
    _sides = [side player];
};

{
    //Define the _x variable into a private one so we can use it later
    _side = _x;
    if ([side group player, _side] call BIS_fnc_sideIsFriendly && {side _x == _side} count playableUnits > 0) then {
        _color = switch (_side) do {
			 case west: {"#007fff"};
			 case east: {"#ff0000"};
			 case independent: {"#41ff00"};
			 default {"#FFFFFF"};
 		};
        //Create side header
        _orbatText = _orbatText + format ["<font color='%1' size='20' face=''>%2</font>",_color, str _side] + "<br/>";
        //Find all player groups
        _groups = allGroups select {side _x == _side && isPlayer leader _x};
        _groups = _groups - HIDEGROUPS;
        {
            //Define the _x variable into a private one so we can use it later
            _group = _x;
            _leader = leader _group;
            //Create group ID section with embeded expression
            if (CLICKTOFIND) then {
                _orbatText = _orbatText + "     " + format [
                "<font color='#FFFFFF' size='18' face=''><execute expression='mapAnimAdd [0.5, 0.05, %2];mapAnimCommit'>%1</execute></font>",
                groupID _group,
                getpos _leader
                ] + "<br/>"
            } else {
                _orbatText = _orbatText + "     " + format ["<font color='#FFFFFF' size='18' face=''>%1</font>",groupID _group] + "<br/>"
            };

            {
                _unit = _x;
                //Create unit information under the group header
                if (alive _unit || !(PERFECTINFO)) then {
                    _orbatText = _orbatText + "          " + format [
                    "   <img image='%2' width='16' height='16'/>   <img image='%3' width='16' height='16'/>  <font color='%4' size='14' face=''>%1</font>",
                    name _unit,
                    [rank _unit, "texture"] call BIS_fnc_rankParams,
                    [_unit] call FOS_fnc_getRoleIcon,
                    ([_unit] call FOS_fnc_getTeamColor) call BIS_fnc_colorRGBAtoHTML
                    ] + "<br/>";
                };
            } forEach units _group;
        } forEach _groups;
    };
} forEach _sides;

_ORBATRecord = missionNameSpace getVariable ["FOS_ORBAT",nil];

if !(isNil "_ORBATRecord") then {
    player setDiaryRecordText [["diary", _ORBATRecord], ["ORBAT",_orbatText]];
} else {
    _ORBATRecord = player createDiaryRecord ["diary", ["ORBAT", _orbatText]];
};


missionNameSpace setVariable ["FOS_ORBAT",_ORBATRecord];
