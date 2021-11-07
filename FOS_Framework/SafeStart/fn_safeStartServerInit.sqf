if !(isServer) exitWith {};

#include "..\..\settings.hpp"
if !(SAFESTART || SAFESTARTINIT) exitWith {};
sleep 2;

_time = missionNamespace getVariable ["FOS_SafeStartTimer",SAFESTARTTIMER];

if (missionNamespace getVariable ["FOS_Safemode",SAFESTARTINIT]) then {
	["init"] call FOS_fnc_safeStartToggleServer;
	waitUntil {time > _time || (missionNamespace getVariable ["FOS_Safemode",true]) isEqualTo false};
	[false] call FOS_fnc_safeStartToggleServer;

};
