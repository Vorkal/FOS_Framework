/*
	Author: 417

	Description:
		Send a message from the server (where you will probably be scripting your mission flow) to the current admin

	Parameters:
		_hint (BOOLEAN): True to send the message as a hint. False to send the message as a systemChat message.
		_message (STRING): Your message
		_values (ANY): Any variables you want to appear in the message. Refer to your values in _message as %1, %2, and so forth.

	Examples:
		[true,"my message"] call FOS_fnc_messageAdmin; - Sends "my message" to the admin as a hint
		[false,"The meaning to life is %1",42] call FOS_fnc_messageAdmin; - Sends "The meaning to life is 42" to the admin as a chat message
	Returns:
		String - _message after it has been formatted with the inputed _values
*/


if !(isServer) exitWith {};
params [["_hint",false],["_string","default message",["string"]],["_values",nil]];

_admin = call FOS_fnc_getAdmin;

if (_hint) then {
	format [_string,_values] remoteExec ["hint",_admin];
} else {
	format [_string,_values] remoteExec ["systemChat",_admin];
};

format [_string,_values]