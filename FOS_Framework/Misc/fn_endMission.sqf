#define MISSIONPERSISTANCE false
#include "..\..\settings.hpp"
params ["_end"];
private ["_state","_missionSwitch"];
//No one needs to run this except server
if !(isServer) exitWith {};

if (MISSIONPERSISTANCE) then {
    [] call FOS_fnc_saveCampaign;
};

//Enable safe start on mission end
[true,false] call FOS_fnc_safeStartToggleServer;

saveProfileNamespace;

_state = (missionconfigfile >> "CfgDebriefing" >> _end >> "win") call BIS_fnc_getCfgDataBool;
_missionSwitch = (missionconfigfile >> "CfgDebriefing" >> _end >> "missionSwitch") call BIS_fnc_getCfgData;

if (_missionSwitch != "") then {
    [SERVERCOMMANDPASSWORD,"#mission " + _missionSwitch] remoteExec ["serverCommand",2];
} else {
    if (isNil "_state") then {_state = true};
    [_end,_state,true,true,true] remoteExec ["BIS_fnc_endMission",0];
};
