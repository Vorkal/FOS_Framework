if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

private ["_credits"];

#include "..\..\Briefing.sqf";

_situation = _situation + _enemyForces + _friendlyForces;


_autoBreak = {
    if (!_autolinebreak) exitWith {_this};
    _text = _this splitString endl;

    _text = _text joinstring "<br/>";

    _text
};

_credits = _credits call _autoBreak;
_Administration = _Administration call _autoBreak;
_Intel = _Intel call _autoBreak;
_Execution = _Execution call _autoBreak;
_mission = _mission call _autoBreak;
_situation = _situation call _autoBreak;


systemChat _credits;

player createDiaryRecord ["diary", ["Credits",_credits]];

player createDiaryRecord ["Diary",["Administration",_Administration]];

player createDiaryRecord ["Diary",["Intel",_Intel]];

player createDiaryRecord ["Diary",["Execution",_Execution]];

player createDiaryRecord ["Diary",["Mission",_mission]];

player createDiaryRecord ["Diary",["Situation",_Situation]];


if (serverCommandAvailable "#kick" || !(isMultiplayer)) then {
	#include "adminBriefing.sqf";
};

if (!isMultiplayer) then {systemChat "FOS: briefing system initialized"};
