/*
Author: 417

Description: This will add the given message into the debug message queue

parameter:
  _message (STRING): String that you want to appear in systemChat
*/

params [["_message","debug message",["string"]],["_format",[],[11,22]]];

_messageQueue = missionNameSpace getVariable ["FOS_debugSystemMessages",[]];
_messageArchive = missionNameSpace getVariable ["FOS_debugSystemMessageArchive",[]];




_messageQueue pushBack format ([_message] + _format);
_messageArchive pushBack format ([_message] + _format);
([_message] + _format) call BIS_fnc_logFormat;
