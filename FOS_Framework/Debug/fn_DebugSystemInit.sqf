/*
Author: 417

Description: looking for a message in the RPT is like trying to find a needle in a haystack.
And posting to systemchat causes you to miss important info as it flies by
This script will post messages to the systemchat at a delayed pace. (Default is 5 seconds between each message)
You can also run a different fuction to copy all debug messages to your clipboard.

*/



scriptName "FOS_debugSystem";
params [["_debug",true,[true]],["_frequency",0.75,[123]]];

//Exit if player isn't admin
if (player != (call FOS_fnc_getAdmin)) exitWith {};


if (is3denPreview) then { //Executes test file if preview
    execVM "testfile.sqf";
};


_originalState = missionNamespace getVariable ["FOS_debugSystem",[false,-1]];
_scriptName = missionNamespace getVariable ["FOS_debugSystemName",nil];

//find if this system is already running and has the exact same _frequency
if (_originalState # 0 isEqualTo true && _originalState # 1 isEqualTo _frequency) exitWith {
    //TODO: run error
    if !(isMultiplayer) then
    {
    	/* code */
    };
};

//kill past script if older version exists
if !(isNil "_scriptName") then {
	terminate _scriptName
};

//Tag this script into a variable name so that it may be terminated later
missionNamespace setVariable ["FOS_debugSystemName",_thisScript];

missionNameSpace setVariable ["FOS_debugSystemMessages",[]];
missionNameSpace setVariable ["FOS_debugSystemMessageArchive",[]];

_messages = missionNameSpace getVariable ["FOS_debugSystemMessages",[]];

//create loop that pushes out a debug message on a loop(parameter)
while {true} do {
    waitUntil {sleep 1;count _messages > 0};
    sleep _frequency;
    _nextMessage = _messages # 0;
    _channelID = missionNameSpace getVariable ["FOS_debugChannelID",0];
    if (_channelID isEqualTo 0) then {
        systemChat _nextMessage;
    } else {
        player customChat [_channelID, _nextMessage];
    };


    _messages deleteAt 0;
};
