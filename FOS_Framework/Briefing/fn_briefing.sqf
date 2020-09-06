if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

#include "..\..\Briefing.sqf";

private ["_situation"];

_enemyForcesHeader = "<br/><br/>
<font size='18'>ENEMY FORCES</font>
<br/>";

_friendlyForcesHeader = "<br/><br/>
<font size='18'>FRIENDLY FORCES</font>
<br/>";

//Remove the formating text if mission maker did not add any details
if (_enemyForces == "") then {_enemyForcesHeader = ""};
if (_friendlyForces == "") then {_friendlyForcesHeader = ""};


//Merge situation details
_situation = _situation + _enemyForcesHeader + _enemyForces + _friendlyForcesHeader + _friendlyForces;

//Private function to convert line breaks into readable linebreaks for the briefing
_autoBreak = {
    if !(_this isEqualType "string") exitWith {_this};
    //Convert string into array
    _convertedString = toArray _this;
    //If no line break detected, return original parameter
    if (10 in _convertedString isEqualTo false) exitWith {_this};
    //Run for each line break detected
    while {10 in _convertedString} do {
        //find and delete the line break
        _index = _convertedString findIf {10 == _x};
        _convertedString deleteAt (_convertedString findIf {10 == _x});
        //Insert a linebreak in the location of the line break
        _convertedString = [_convertedString, [60,98,114,47,62], _index] call BIS_fnc_arrayInsert;
    };
    //Convert the array back into a string that includes the linebreaks
    toString _convertedString
};

if (_autolinebreak) then {
    _Administration = _Administration call _autoBreak;
    _Intel = _Intel call _autoBreak;
    _Execution = _Execution call _autoBreak;
    _mission = _mission call _autoBreak;
    _situation = _situation call _autoBreak;
    _credits = _credits call _autoBreak;
};

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

"FOS: briefing system initialized" call FOS_fnc_debugSystemAdd;
