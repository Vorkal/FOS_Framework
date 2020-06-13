params ["_end"];
private ["_state"];
//No one needs to run this except server
if !(isServer) exitWith {};


_state = (missionconfigfile >> "CfgDebriefing" >> _x >> "win") call BIS_fnc_getCfgDataBool;
if (isNil "_state") then {_state = true};
[_end,_state,true,true,true] remoteExec ["BIS_fnc_endMission",0];
saveProfileNamespace;
