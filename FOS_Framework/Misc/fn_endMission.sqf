params ["_end"];
//No one needs to run this except server
if !(isServer) exitWith {};

_state = (missionconfigfile >> "CfgDebriefing" >> _x >> "state") call BIS_fnc_getCfgDataBool;
[_end,_state,true,true,true] remoteExec ["BIS_fnc_endMission",0];
