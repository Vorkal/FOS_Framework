#include "..\settings.hpp"

if (["loadParams"] call FOS_fnc_getParamValue isEqualTo 0) then {
    [] call FOS_fnc_saveParams;
};

FOS_difficulty = ["difficulty",1] call BIS_fnc_getParamValue;

//Increase mission played amount by one.
_playedAmount = profileNameSpace getVariable [missionName + "_playedAmount",0];
profileNameSpace setVariable [missionName + "_playedAmount",_playedAmount + 1];

if (MESSAGEADMIN) then {
    if !(CUSTOMCHATCOMMANDS) exitWith {};
    ["help",
    {
        _user = player;
        [("%1: ") + (_this select 0),false,name _user] remoteExec ["FOS_fnc_messageAdmin",2]
    },
    "all"] call CBA_fnc_registerChatCommand;
};

["PM",
{
    if !(CUSTOMCHATCOMMANDS) exitWith {};
    params ["_message"];
    private ["_text","_name"];

    if (_message select [0,1] == "'") then {
        //Split up the text given so we can grab the command wrapped in ''
        _text = _message splitString "'";
        //Select the string wrapped in ''
        _name = _text select 0;
        //Get rid of the name wrapped in '' from the main text
        _text deleteAt 0;
        //Join the string, split it, then join again to remove that first space if it exists
        _text = _text joinString " ";
        _text = _text splitString " ";
        _text = _text joinString " ";
    } else {
        //Split up the text given so we can grab the first word written
        _text = _message splitstring " ";
        //Select the first word written, which should be the player name if the admin typed it in right
        _name = _text select 0;
        //Get rid of the name from the main text
        _text deleteAt 0;
        //Put the main text back together into a string
        _text = _text joinString " ";
    };

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
    if !(CUSTOMCHATCOMMANDS) exitWith {};
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
"admin"] call CBA_fnc_registerChatCommand;

["tp",
{
    if !(CUSTOMCHATCOMMANDS) exitWith {};
    params ["_message"];
    private ["_text","_name","_firstParam","_secondParam","_messageArray"];

    //Check if either parameter is using a '
    if (_message select [0,1] == "'" || _message select [count _message - 1,9999] == "'") then {
        //Split string based on ' instead
        _messageArray = _message splitString "'";
        //Select the first parameter
        _firstString = _messageArray # 0;
        //In case it wasn't in in single quotes, split and join to remove the hanging space
        _firstString = _firstString splitString " ";
        _firstString = _firstString joinString " ";

        //Remove the first parameter so it won't be added back in
        _messageArray deleteAt 0;

        //Join the string, split it, then join again to remove that first space if it exists
        _secondString = _messageArray joinString " ";
        _secondString = _secondString splitString " ";
        _secondString = _secondString joinString " ";
        //update _messageArray with both strings
        _messageArray = [_firstString,_secondString];
    } else {
        _messageArray = _message splitString " ";
    };

    //handling for user error
    if (count _messageArray > 2) exitWith {systemChat format ["TP ERROR: %1 IS TOO MANY PARAMETERS",_messageArray]};
    if (count _messageArray == 1) exitWith {systemChat format ["TP ERROR: %1 IS TOO FEW PARAMETERS",_messageArray]};
    //list of elements to check
    //_playerList = (call BIS_fnc_listPlayers) apply {name _x};
    _playerList = allUnits apply {name _x};
    _groupList = allGroups apply {groupID _x};
    _strList = _playerList + _groupList;
    _list = allUnits + allGroups;

    //Search for a match for first parameter
    _firstParam = _strList findIf {(_messageArray # 0) == _x};
    if (_firstParam == -1) exitWith {systemChat format ["TP ERROR: %1 NOT FOUND",(_messageArray # 0)]};
    _firstParam = _list # _firstParam;

    //Search for a match for second parameter
    _secondParam = _strList findIf {(_messageArray # 1) == _x};
    if (_secondParam == -1) exitWith {systemChat format ["TP ERROR: %1 NOT FOUND",(_messageArray # 1)]};
    _secondParam = _list # _secondParam;

    //Check if first param is a group
    if (typeName _firstParam == "GROUP") then {
        if (typeName _secondParam == "GROUP") then {
            //If second param is a group then move the group in first param to leader of the group in second param
            {_x setPos getPos leader _secondParam} forEach units _firstParam;
        } else {
            //If second param is a player then move the group in first param to player in second param
            {_x setPos getPos _secondParam} forEach units _firstParam;
        };
    } else {
        if (typeName _secondParam == "GROUP") then {
            //If second param is a group then move the player in first param to leader of the group in second param
            _firstParam setPos getPos leader _secondParam;
        } else {
            //If second param is a player then move the player in first param to player in second param
            _firstParam setPos getPos _secondParam;
        };
    };
},"admin"] call CBA_fnc_registerChatCommand;
