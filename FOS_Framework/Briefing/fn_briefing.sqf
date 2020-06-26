if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

#include "..\..\Briefing.sqf";

_enemyForcesHeader = "<br/><br/>
<font size='18'>FRIENDLY FORCES</font>
<br/>";

_friendlyForcesHeader = "<br/><br/>
<font size='18'>FRIENDLY FORCES</font>
<br/>";

//Remove the formating text if mission maker did not add any details
if (_enemyForces == "") then {_enemyForcesHeader = ""};
if (_friendlyForces == "") then {_friendlyForcesHeader = ""};


//Merge situation details
_situation = _situation + _enemyForcesHeader + _enemyForces + _friendlyForcesHeader + _friendlyForces;


//TODO: WHY DOES THIS WORK IN DEBUG CONSOLE BUT NOT SCRIPT FILES?
_autoBreak = {
    if (!_autolinebreak) exitWith {_this};
    _text = _this splitString endl;
    systemChat str _text;
    _test = _text joinstring "<br/>";
    systemChat str _text;
    _test
};


_Administration = _Administration call _autoBreak;
_Intel = _Intel call _autoBreak;
_Execution = _Execution call _autoBreak;
_mission = _mission call _autoBreak;
_situation = _situation call _autoBreak;
_credits = _credits call _autoBreak;


if (_credits != "") then {
    player createDiaryRecord ["diary", ["Credits",_credits]];
};
if (_Administration != "") then {
    player createDiaryRecord ["Diary",["Administration",_Administration]];
};
if (_Intel != "") then {
    player createDiaryRecord ["Diary",["Intel",_Intel]];
};
if (_Execution != "") then {
    player createDiaryRecord ["Diary",["Execution",_Execution]];
};
if (_mission != "") then {
    player createDiaryRecord ["Diary",["Mission",_mission]];
};
if (_Situation != "") then {
    player createDiaryRecord ["Diary",["Situation",_Situation]];
};

if (serverCommandAvailable "#kick" || !(isMultiplayer)) then {
	#include "adminBriefing.sqf";
};

if (!isMultiplayer) then {systemChat "FOS: briefing system initialized"};
