/*
Author: 417

Description: Finds admin and alerts them when they leave the safe start zone

Example:
[] spawn FOS_fnc_adminSafezoneAlert;
*/

params [["_safeZone",getPos (call FOS_fnc_getAdmin),[[0,0,0]]]];

if !(isServer) exitWith {};


waitUntil {call FOS_fnc_getAdmin distance _safeZone > 50};

if (missionNamespace getVariable ["FOS_Safemode",true]) exitWith {
    ["Alert! Admin appears to have left safezone with safemode still enabled!"] call FOS_fnc_debugSystemAdd;
};
