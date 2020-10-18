#include "..\settings.hpp"

if (["loadParams"] call FOS_fnc_getParamValue isEqualTo 0) then {
    [] call FOS_fnc_saveParams;
};

FOS_difficulty = ["difficulty",1] call BIS_fnc_getParamValue;

//Increase mission played amount by one.
_playedAmount = profileNameSpace getVariable [missionName + "_playedAmount",0];
profileNameSpace setVariable [missionName + "_playedAmount",_playedAmount + 1];

if (MESSAGEADMIN) then {
    ["help",
    {
        _user = player;
        [("%1: ") + (_this select 0),false,name _user] remoteExec ["FOS_fnc_messageAdmin",2]
    },
    "all"] call CBA_fnc_registerChatCommand;
};

["PM",
{
    //Split up the text given so we can grab the first word written
    _text = (_this select 0) splitstring " ";
    //Select the first word written, which should be the player name if the admin typed it in right
    _name = _text select 0;

    //Get rid of the name from the main text
    _text deleteAt 0;
    //Put the main text back together into a string
    _text = _text joinString " ";

    //Find which player has the name provided by the admin
    _index = (call BIS_fnc_listPlayers) findIf {name _x == _name};
    //If the name provided does not match the name of anyone in our list, alert the admin
    if (_index == -1) exitWith {systemChat format ["PM ERROR: %1 NOT FOUND",_name]};

    //Select the player with the matching name
    _player = (call BIS_fnc_listPlayers) # _index;

    //Format the text with an Admin: prefix
    _format = format ["Admin: " + _text,objnull];
    //Send the message to the player with that given name
    _format remoteExec ["systemChat",_player];
},
PMPERMISSIONS] call CBA_fnc_registerChatCommand;

["revive",
{
    params ["_message"];
    private ["_type"];
    //List of elements to check
    _list = ((call BIS_fnc_listPlayers) + allGroups);
    //Convert array elements based on if they are an object or not and place it in the _strlist array for index searching
    _strList = [];
    {
        if (typeName _x == "OBJECT") then {
            _strList pushBack toLower name _x
        } else {
            _strList pushBack toLower groupId _x
        };
    } forEach _list;
    //Find which player or group has the name provided by the admin
    _index = _strlist findIf {
        _x isEqualTo toLower (_message)
        ||
        _x isEqualTo toLower (_message)
    };
    //If the name provided does not match the name of anyone in our list, alert the admin
    if (_index == -1) exitWith {systemChat format ["REVIVE ERROR: %1 NOT FOUND",_this select 0]};
    //Select the player with the matching name
    _target = _list # _index;
    [POINTSPAWN,POINTGEAR,POINTPROTECTION] remoteExec ["FOS_fnc_checkpointSystem",_target,false];
},
"adminlogged"] call CBA_fnc_registerChatCommand;
