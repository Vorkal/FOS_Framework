/*{_x enableSimulationGlobal false} forEach entities "";

[] spawn {
	 waitUntil {(playersNumber west + playersNumber east + playersNumber independent + playersNumber civilian isEqualTo count playableUnits) || time > 180 || missionNameSpace getVariable ["FOS_SafeStart_Phase1",false] isEqualTo true};
	 {_x enableSimulationGlobal true} forEach entities "";
};*/
 params ["_mode"];


if !(isServer) exitWith {};

//Block code execution if override variable is set to false
#include "..\..\settings.hpp"
if !(SAFESTART) exitWith {};

switch (_mode) do
{
	case "init":
	{
		_time = missionNamespace getVariable ["FOS_SafeStartTimer",SAFESTARTTIMER];
		["FOS_SafeStartTimer",[floor (_time / 60), _time % 60]] remoteExec ["BIS_fnc_showNotification",0];
		missionNamespace setVariable ["FOS_Safemode",true,true];
		[true] remoteExec ["FOS_fnc_safeStartClientInit",0,"FOS_SafeStart"];
	};
	case true:
	{
		["FOS_SafeStartBegin",[]] remoteExec ["BIS_fnc_showNotification",0];
		missionNamespace setVariable ["FOS_Safemode",true,true];
		[true] remoteExec ["FOS_fnc_safeStartClientInit",0,"FOS_SafeStart"];
	};
	case false;
	default
	{
		["FOS_SafeStartEnd",[]] remoteExec ["BIS_fnc_showNotification",0];
		missionNamespace setVariable ["FOS_Safemode",false,true];
		[false] remoteExec ["FOS_fnc_safeStartClientInit",0,"FOS_SafeStart"];
	};
};
