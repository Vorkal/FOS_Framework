/*
Author: 417

Description: Grabs the current main frequency of the passed unit

Parameters:
_object (OBJECT): The player you wish to be scanned for frequency

Returns:
[sw frequency,Lr frequency, vehicle radio frequency] (Array): Returns an array of strings with the frequency of each radio type

Example:
[this] call FOS_fnc_tfarFindFrequency;
*/

params [["_object",player,[objnull]],["_display",false,[true]]];
private ["_swFreq","_lrFreq","_vFreq","_swInfo","_lrInfo","_vInfo"];

_frequencies = ["N/A","N/A","N/A"];

//Exit if TFAR not detected
if !(isClass(configfile >> "CfgPatches" >> "task_force_radio")) exitWith {};

//Not an existant object, exit.
if (_object isEqualTo objNull) exitWith {_frequencies};
//Not a player, exit.
if !(isPlayer _object) exitWith {_frequencies};

//Get assigned items
_objectItems = AssignedItems _object;
//Find if SW TFAR radio exists
_index = _objectItems findIf {"TFAR_" in _x};
//If it exists then select the TFAR radio and run function to find frequency then update  _frequencies.
if (_index != -1) then {
    _swradio = _objectItems # _index;
    _swFreq = [_swradio] call TFAR_fnc_getSwFrequency;
    _frequencies set [0,_swFreq];
};

_lrRadioSettings = unitbackpack _object getVariable ["radio_settings","none"];
if !(_lrRadioSettings isEqualTo "none") then {
    //Exit if the array has a different amount of elements than what was expected
    if (count _lrRadioSettings != 10) exitWith {};
    //Find frequency in array based on current channel selected in radio settings
    _lrFreq = ((_lrRadioSettings # 2) # (_lrRadioSettings # 0));
    _frequencies set [1,_lrFreq];
};

_vRadioSettings = vehicle _object getVariable ["driver_radio_settings","none"];
if !(_vRadioSettings isEqualTo "none") then {
    //Exit if the array has a different amount of elements than what was expected
    if (count _vRadioSettings != 10) exitWith {};
    //Find frequency in array based on current channel selected in radio settings
    _vFreq = ((_vRadioSettings # 2) # (_vRadioSettings # 0));
    _frequencies set [2,_vFreq];
};


if (_display) then {
    if !(isNil "_swFreq") then {
        _swInfo = format ["%1's SW: %2",name _object, _swFreq];
    };
    if !(isNil "_lrFreq") then {
        _lrInfo = format ["%1's LR: %2",name _object, _lrFreq];
    };
    if !(isNil "_vFreq") then {
        _vInfo = format ["%1's VR: %2",name _object, _vFreq];
    };
    {systemChat _x} forEach [_swInfo,_lrInfo,_vInfo];
};
//return frequency array
_frequencies
