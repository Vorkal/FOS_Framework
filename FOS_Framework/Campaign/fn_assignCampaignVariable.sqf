/*
Author: 417

Description:
Assigns persistent campaign variable. Variable will exist in later missions of the campaign

Parameter(s):
_key: Identifier of variable so that it can be retrieved later.
_value: Anything you want to be associated with that key

Returns:
true on success
*/

params [["_key",nil,["OnlyString"]], ["_value",nil]];

//Parameters not correctly given. Exit
if (isNil "_key" || isNil "_value") exitWith {};

//Get the current campaign variable table. If it exists.
_campaignCustomVars = missionNameSpace getVariable ["FOS_CampaignVariables",createHashMap];

//Add key to table
_campaignCustomVars set [_key,_value];
//Update the table (May not be needed. Not sure)
_campaignCustomVars = missionNameSpace setVariable ["FOS_CampaignVariables",_campaignCustomVars,true];

true
