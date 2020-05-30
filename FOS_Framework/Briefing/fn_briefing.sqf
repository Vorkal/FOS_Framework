if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

#include "playerBriefing.sqf";

if (serverCommandAvailable "#kick" || !(isMultiplayer)) then {
	#include "adminBriefing.sqf";
};

if (!isMultiplayer) then {systemChat "FOS: briefing system initialized"};