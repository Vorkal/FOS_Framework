/*
Author: 417

Description:
Assigns persistent campaign variable. Variable will exist in later missions of the campaign

Parameter(s):
_key: Identifier of variable so that it can be retrieved later.
_defaultValue: Value to use when key does not exist

Returns:
Value when key exists
*/

params [["_key",nil,["OnlyString"]], ["_defaultValue",nil]];

if (isNil "_key") exitWith {"No key given" call FOS_fnc_debugSystemAdd}; //Debug message
//Get the current campaign variable table. If it exists.
_campaignCustomVars = missionNameSpace getVariable ["FOS_CampaignVariables",createHashMap];
//Key didn't exist and no default value was passed as a parameter
if (_key in _campaignCustomVars isEqualTo false && isNil "_defaultValue") exitWith {_key + " not found. No default value given" call FOS_fnc_debugSystemAdd}; //Debug message

//Return the value attached to key or default value
_campaignCustomVars getOrDefault [_key,_defaultValue];
