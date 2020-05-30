/*
Author: 417

Description: This will add the given message into the debug message queue

parameter:
  _message (STRING): String that you want to appear in systemChat
*/

params ["_message"];

_messageQueue = missionNameSpace getVariable ["FOS_debugSystemMessages",[]];

_messageQueue pushBackUnique _message;
