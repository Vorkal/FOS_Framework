private ["_time"];

if (uiNamespace getVariable ["FOS_FirstLaunch", true]) then {
    systemChat "Welcome to the FOS Framework!";
    systemChat "Check out the Settings.hpp and briefing.sqf file for most configurable options";
};

uiNamespace setVariable ["FOS_FirstLaunch", false];
