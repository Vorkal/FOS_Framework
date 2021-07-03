/*{_x enableSimulationGlobal false} forEach entities "";

[] spawn {
	 waitUntil {(playersNumber west + playersNumber east + playersNumber independent + playersNumber civilian isEqualTo count playableUnits) || time > 180 || missionNameSpace getVariable ["FOS_SafeStart_Phase1",false] isEqualTo true};
	 {_x enableSimulationGlobal true} forEach entities "";
};*/

params [["_mode",true],["_notification",true]];
if !(isServer) exitWith {};

//Block code execution if override variable is set to false
#include "..\..\settings.hpp"
if !(SAFESTART) exitWith {};

switch (_mode) do
{
	case "init":
	{
		_time = missionNamespace getVariable ["FOS_SafeStartTimer",SAFESTARTTIMER];
		if (_notification) then {
			//Change _time to array of strings ["MM","SS"];
			_time = [_time,"MM:SS",true] call BIS_fnc_secondsToString;
			//Convert string of number to number
			_time = _time apply {parseNumber _x};
			["FOS_SafeStartTimer", [_time # 0, _time # 1]] remoteExec ["BIS_fnc_showNotification",0]
		};
		missionNamespace setVariable ["FOS_Safemode",true,true];
		[true] remoteExec ["FOS_fnc_safeStartClientInit",0,"FOS_SafeStart"];
	};
	case true:
	{
		if (_notification) then {["FOS_SafeStartBegin",[]] remoteExec ["BIS_fnc_showNotification",0]};
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
