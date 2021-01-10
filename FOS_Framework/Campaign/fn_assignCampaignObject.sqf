params [["_object",nil,[objnull]]];

if !(isServer) exitWith {};
//Could not find an object with the variable name given
if (isNil "_object") exitWith {["FOS_CAMPAIGN: %1 is not a defined object",[_object]] call FOS_fnc_debugSystemAdd};

if !(isNull _object) then { //Valid object
    //Get object data
    _campaignObjects = missionNameSpace getVariable ["FOS_CampaignObjects",[]];
    //Pushback if object not already in list
    _campaignObjects pushBackUnique _object;
    //Update variable with object
    missionNameSpace setVariable ["FOS_CampaignObjects",_campaignObjects];
} else { //Invalid null object
    ["FOS_CAMPAIGN: %1 is a null object",[_object]] call FOS_fnc_debugSystemAdd;
};
