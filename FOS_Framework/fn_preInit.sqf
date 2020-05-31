FOS_difficulty = ["difficulty",1] call FOS_fnc_getParamValue;

//Increase mission played amount by one.
_playedAmount = profileNameSpace getVariable [missionName + "_playedAmount",0];
profileNameSpace setVariable [missionName + "_playedAmount",_playedAmount + 1];
