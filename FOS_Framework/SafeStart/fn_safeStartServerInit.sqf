if !(isServer) exitWith {};

#include "..\..\settings.hpp"
if !(SAFESTART) exitWith {};
sleep 2;

_time = missionNamespace getVariable ["FOS_SafeStartTimer",330];

if (missionNamespace getVariable ["FOS_Safemode",true]) then {
	["init"] call FOS_fnc_safeStartToggleServer;
	waitUntil {time > _time || missionNamespace getVariable ["FOS_Safemode",true] isEqualTo false};
	[false] call FOS_fnc_safeStartToggleServer;

};
