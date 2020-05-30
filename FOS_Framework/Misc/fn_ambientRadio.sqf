/*
Author: 417

Description: makes the object play ambient radio sounds. It creates an add action option and hit event handler to make it turn off.

Parameters:
_object (OBJECT): The object you wish to be the radio

Example:
[this] spawn FOS_fnc_ambientRadio;
*/

params ["_object"];

//Must be able to suspend
if (!canSuspend) exitWith {this spawn FOS_fnc_ambientRadio};

//Set variable that signifies that this radio should be looping
_object setVariable ["FOS_radioLoop",true,true];

//Add action that makes this radio shut off
_object addAction ["Turn off radio", {
    params ["_target", "_caller", "_actionId", "_arguments"];
    _target setVariable ["FOS_radioLoop",false,true];
    _target setDamage 1;
    _target removeAction _actionID
},nil,0,true,true,"","_target getVariable ['FOS_radioLoop',true]",3,false,"",""];


//Add event handler that makes this radio shut off if player shoots it
_object addEventHandler ["HitPart", {
    params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
    if (isPlayer _shooter) then {
        _target setVariable ["FOS_radioLoop",false];
    };
}];

//Looping function only needs to be played on server
if (isServer) then {
    while {_object getVariable ["FOS_radioLoop",true]} do {
        _soundType = selectRandom ["2","6","8"];
        [_object,"RadioAmbient" + _soundType] remoteExec ["say3D",0];
        sleep (random [1,20,90]);
    };
};
