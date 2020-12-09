#define SERVERCOMMANDPASSWORD "password"

#include "..\..\settings.hpp"
if !(CAMPAIGNSYSTEM) exitWith {};

params ["_selectedMission"];

if (serverCommandExecutable "#mission") exitWith {
	serverCommand "#mission " + _selectedMission;
};

if !(serverCommandExecutable "#mission") exitWith {
	[SERVERCOMMANDPASSWORD,"#mission " + _selectedMission] remoteExec ["serverCommand",2];
};
