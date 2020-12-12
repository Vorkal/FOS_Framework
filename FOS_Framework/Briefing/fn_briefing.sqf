if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

#include "..\..\Briefing.sqf";

private ["_situation"];

player createDiarySubject ["FOS_Options","Mission Options"];

_enemyForcesHeader = "<br/><br/>
<font size='16'>ENEMY FORCES</font>
<br/>";

_friendlyForcesHeader = "<br/><br/>
<font size='16'>FRIENDLY FORCES</font>
<br/>";

//SMEAC headers
_SituationHeader = "<br/><br/>
<font size='18'>Situation</font>
<br/>";
_MissionHeader = "<br/><br/>
<font size='18'>Mission</font>
<br/>";
_ExecutionHeader = "<br/><br/>
<font size='18'>Execution</font>
<br/>";
_IntelHeader = "<br/><br/>
<font size='18'>Intel</font>
<br/>";
_AdministrationHeader = "<br/><br/>
<font size='18'>Administration</font>
<br/>";
_creditsHeader = "<br/><br/>
<font size='18'>Credits</font>
<br/>";

//Remove the formating text if mission maker did not add any details
if (_enemyForces == "") then {_enemyForcesHeader = ""};
if (_friendlyForces == "") then {_friendlyForcesHeader = ""};
if (_situation == "") then {_SituationHeader = ""};
if (_mission == "") then {_MissionHeader = ""};
if (_Execution == "") then {_ExecutionHeader = ""};
if (_Intel == "") then {_IntelHeader = ""};
if (_Administration == "") then {_AdministrationHeader = ""};
if (_credits == "") then {_creditsHeader = ""};

//Merge situation details
_situation = _situation + _enemyForcesHeader + _enemyForces + _friendlyForcesHeader + _friendlyForces;

//Private function to convert line breaks into readable linebreaks for the briefing
_autoBreak = {
    if !(_this isEqualType "string") exitWith {_this};
    //Convert string into array
    _convertedString = toArray _this;
    //If no line break detected, return original parameter
    if (10 in _convertedString isEqualTo false) exitWith {_this};
    //Run for each line break detected
    while {10 in _convertedString} do {
        //find and delete the line break
        _index = _convertedString findIf {10 == _x};
        _convertedString deleteAt (_convertedString findIf {10 == _x});
        //Insert a linebreak in the location of the line break
        _convertedString = [_convertedString, [60,98,114,47,62], _index] call BIS_fnc_arrayInsert;
    };
    //Convert the array back into a string that includes the linebreaks
    toString _convertedString
};

if (_autolinebreak) then {
    _Administration = _Administration call _autoBreak;
    _Intel = _Intel call _autoBreak;
    _Execution = _Execution call _autoBreak;
    _mission = _mission call _autoBreak;
    _situation = _situation call _autoBreak;
    _credits = _credits call _autoBreak;

    _westsituation = _westsituation call _autoBreak;
    _westenemyForces = _westenemyForces call _autoBreak;
    _westfriendlyForces = _westfriendlyForces call _autoBreak;
    _westmission = _westmission call _autoBreak;
    _westExecution = _westExecution call _autoBreak;
    _westintel = _westintel call _autoBreak;
    _westAdministration = _westAdministration call _autoBreak;
    _westcredits = _westcredits call _autoBreak;

    _eastsituation = _eastsituation call _autoBreak;
    _eastenemyForces = _eastenemyForces call _autoBreak;
    _eastfriendlyForces = _eastfriendlyForces call _autoBreak;
    _eastmission = _eastmission call _autoBreak;
    _eastExecution = _eastExecution call _autoBreak;
    _eastintel = _eastintel call _autoBreak;
    _eastAdministration = _eastAdministration call _autoBreak;
    _eastcredits = _eastcredits call _autoBreak;

    _indsituation = _indsituation call _autoBreak;
    _indenemyForces = _indenemyForces call _autoBreak;
    _indfriendlyForces = _indfriendlyForces call _autoBreak;
    _indmission = _indmission call _autoBreak;
    _indExecution = _indExecution call _autoBreak;
    _indintel = _indintel call _autoBreak;
    _indAdministration = _indAdministration call _autoBreak;
    _indcredits = _indcredits call _autoBreak;
};


if (_SMEAC) then {
    _SMEACBriefing = _SituationHeader + _situation + _MissionHeader + _mission + _ExecutionHeader + _Execution + _IntelHeader + _intel + _AdministrationHeader + _Administration + _creditsHeader + _credits;
    if (_SMEACBriefing != "") then {
        player createDiaryRecord ["Diary",["SMEAC",_SMEACBriefing]];
        missionNameSpace setVariable ["FOS_SMEACRecord",_SMEACBriefing];
    };
} else {
    if (_credits != "" && isNil "FOS_CreditRecord") then {
        player createDiaryRecord ["diary", ["Credits",_credits]];
        missionNameSpace setVariable ["FOS_CreditRecord",_credits];
    };
    if (_Administration != "" && isNil "FOS_AdministrationRecord") then {
        player createDiaryRecord ["Diary",["Administration",_Administration]];
        missionNameSpace setVariable ["FOS_AdministrationRecord",_Administration];
    };
    if (_Intel != "" && isNil "FOS_IntelRecord") then {
        player createDiaryRecord ["Diary",["Intel",_Intel]];
        missionNameSpace setVariable ["FOS_IntelRecord",_Intel];
    };
    if (_Execution != "" && isNil "FOS_ExecutionRecord") then {
        player createDiaryRecord ["Diary",["Execution",_Execution]];
        missionNameSpace setVariable ["FOS_ExecutionRecord",_Execution];
    };
    if (_mission != "" && isNil "FOS_MissionRecord") then {
        player createDiaryRecord ["Diary",["Mission",_mission]];
        missionNameSpace setVariable ["FOS_MissionRecord",_mission];
    };
    if (_Situation != "" && isNil "FOS_SituationRecord") then {
        player createDiaryRecord ["Diary",["Situation",_Situation]];
        missionNameSpace setVariable ["FOS_SituationRecord",_Situation];
    };
};

if (side player == west) then {
    _enemyForcesHeaderWest = "<br/><br/>
    <font size='18'>ENEMY FORCES</font>
    <br/>";

    _friendlyForcesHeaderWest = "<br/><br/>
    <font size='18'>FRIENDLY FORCES</font>
    <br/>";

    //SMEAC headers
    _westSituationHeader = "<br/><br/>
    <font size='18'>Situation</font>
    <br/>";
    _westMissionHeader = "<br/><br/>
    <font size='18'>Mission</font>
    <br/>";
    _westExecutionHeader = "<br/><br/>
    <font size='18'>Execution</font>
    <br/>";
    _westIntelHeader = "<br/><br/>
    <font size='18'>Intel</font>
    <br/>";
    _westAdministrationHeader = "<br/><br/>
    <font size='18'>Administration</font>
    <br/>";
    _westCreditHeader = "<br/><br/>
    <font size='16'>Credits</font>
    <br/>";

    //Remove the formating text if mission maker did not add any details
    if (_westenemyForces == "") then {_enemyForcesHeaderWest = ""};
    if (_westfriendlyForces == "") then {_friendlyForcesHeaderWest = ""};
    if (_westsituation == "") then {_westSituationHeader = ""};
    if (_westmission == "") then {_westMissionHeader = ""};
    if (_westExecution == "") then {_westExecutionHeader = ""};
    if (_westIntel == "") then {_westIntelHeader = ""};
    if (_westAdministration == "") then {_westAdministrationHeader = ""};

    //Merge situation details
    _westsituation = _westsituation + _enemyForcesHeaderWest + _westenemyForces + _friendlyForcesHeaderWest + _westfriendlyForces;

    if (_westSMEAC) then {
        _SMEACBriefing = _westSituationHeader + _westsituation + _westMissionHeader + _westmission + _westExecutionHeader + _westExecution + _westIntelHeader + _westintel + _westAdministrationHeader + _westAdministration;
        if (isNil "FOS_SMEACRecord" && _SMEACBriefing != "") then {player createDiaryRecord ["Diary",["SMEAC",_SMEACBriefing]]};
        missionNameSpace setVariable ["FOS_SMEACRecord",_SMEACBriefing];
    } else {
        if (_westcredits != "" && isNil "FOS_CreditRecord") then {
            player createDiaryRecord ["diary", ["Credits",_westcredits]];
            missionNameSpace setVariable ["FOS_CreditRecord",_westcredits];
        };
        if (_westAdministration != "" && isNil "FOS_AdministrationRecord") then {
            player createDiaryRecord ["Diary",["Administration",_westAdministration]];
            missionNameSpace setVariable ["FOS_AdministrationRecord",_westAdministration];
        };
        if (_westintel != "" && isNil "FOS_IntelRecord") then {
            player createDiaryRecord ["Diary",["Intel",_westintel]];
            missionNameSpace setVariable ["FOS_IntelRecord",_westintel];
        };
        if (_westExecution != "" && isNil "FOS_ExecutionRecord") then {
            player createDiaryRecord ["Diary",["Execution",_westExecution]];
            missionNameSpace setVariable ["FOS_ExecutionRecord",_westExecution];
        };
        if (_westmission != "" && isNil "FOS_MissionRecord") then {
            player createDiaryRecord ["Diary",["Mission",_westmission]];
            missionNameSpace setVariable ["FOS_MissionRecord",_westmission];
        };
        if (_westsituation != "" && isNil "FOS_SituationRecord") then {
            player createDiaryRecord ["Diary",["Situation",_westsituation]];
            missionNameSpace setVariable ["FOS_SituationRecord",_westsituation];
        };
    };
};

if (side player == east) then {
    _enemyForcesHeadereast = "<br/><br/>
    <font size='16'>ENEMY FORCES</font>
    <br/>";

    _friendlyForcesHeadereast = "<br/><br/>
    <font size='16'>FRIENDLY FORCES</font>
    <br/>";

    //SMEAC headers
    _eastSituationHeader = "<br/><br/>
    <font size='18'>Situation</font>
    <br/>";
    _eastMissionHeader = "<br/><br/>
    <font size='18'>Mission</font>
    <br/>";
    _eastExecutionHeader = "<br/><br/>
    <font size='18'>Execution</font>
    <br/>";
    _eastIntelHeader = "<br/><br/>
    <font size='18'>Intel</font>
    <br/>";
    _eastAdministrationHeader = "<br/><br/>
    <font size='18'>Administration</font>
    <br/>";
    _eastCreditHeader = "<br/><br/>
    <font size='16'>Credits</font>
    <br/>";

    //Merge situation details
    _situation = _situation + _enemyForcesHeadereast + _eastenemyForces + _friendlyForcesHeadereast + _eastfriendlyForces;

    //Remove the formating text if mission maker did not add any details
    if (_eastenemyForces == "") then {_enemyForcesHeadereast = ""};
    if (_eastfriendlyForces == "") then {_friendlyForcesHeadereast = ""};
    if (_eastsituation == "") then {_eastSituationHeader = ""};
    if (_eastmission == "") then {_eastMissionHeader = ""};
    if (_eastExecution == "") then {_eastExecutionHeader = ""};
    if (_eastIntel == "") then {_eastIntelHeader = ""};
    if (_eastAdministration == "") then {_eastAdministrationHeader = ""};

    if (_eastSMEAC) then {
        _SMEACBriefing = _eastSituationHeader + _eastsituation + _eastMissionHeader + _eastmission + _eastExecutionHeader + _eastExecution + _eastIntelHeader + _eastintel + _eastAdministrationHeader + _eastAdministration;
        systemChat "Test";
        if (isNil "FOS_SMEACRecord" && _SMEACBriefing != "") then {player createDiaryRecord ["Diary",["SMEAC",_SMEACBriefing]]};
        missionNameSpace setVariable ["FOS_SMEACRecord",_SMEACBriefing];
    } else {
        if (_eastcredits != "" && isNil "FOS_CreditRecord") then {
            player createDiaryRecord ["diary", ["Credits",_eastcredits]];
            missionNameSpace setVariable ["FOS_CreditRecord",_eastcredits];
        };
        if (_eastAdministration != "" && isNil "FOS_AdministrationRecord") then {
            player createDiaryRecord ["Diary",["Administration",_eastAdministration]];
            missionNameSpace setVariable ["FOS_AdministrationRecord",_eastAdministration];
        };
        if (_eastintel != "" && isNil "FOS_IntelRecord") then {
            player createDiaryRecord ["Diary",["Intel",_eastintel]];
            missionNameSpace setVariable ["FOS_IntelRecord",_eastintel];
        };
        if (_eastExecution != "" && isNil "FOS_ExecutionRecord") then {
            player createDiaryRecord ["Diary",["Execution",_eastExecution]];
            missionNameSpace setVariable ["FOS_ExecutionRecord",_eastExecution];
        };
        if (_eastmission != "" && isNil "FOS_MissionRecord") then {
            player createDiaryRecord ["Diary",["Mission",_eastmission]];
            missionNameSpace setVariable ["FOS_MissionRecord",_eastmission];
        };
        if (_eastsituation != "" && isNil "FOS_SituationRecord") then {
            player createDiaryRecord ["Diary",["Situation",_eastsituation]];
            missionNameSpace setVariable ["FOS_SituationRecord",_eastsituation];
        };
    };
};

if (side player == independent) then {
    _enemyForcesHeaderindependent = "<br/><br/>
    <font size='18'>ENEMY FORCES</font>
    <br/>";

    _friendlyForcesHeaderindependent = "<br/><br/>
    <font size='18'>FRIENDLY FORCES</font>
    <br/>";

    //SMEAC headers
    _indSituationHeader = "<br/><br/>
    <font size='18'>Situation</font>
    <br/>";
    _indMissionHeader = "<br/><br/>
    <font size='18'>Mission</font>
    <br/>";
    _indExecutionHeader = "<br/><br/>
    <font size='18'>Execution</font>
    <br/>";
    _indIntelHeader = "<br/><br/>
    <font size='18'>Intel</font>
    <br/>";
    _indAdministrationHeader = "<br/><br/>
    <font size='18'>Administration</font>
    <br/>";
    _indCreditHeader = "<br/><br/>
    <font size='16'>Credits</font>
    <br/>";
    //Merge situation details
    _situation = _situation + _enemyForcesHeaderindependent + _indenemyForces + _friendlyForcesHeaderindependent + _indfriendlyForces;

    //Remove the formating text if mission maker did not add any details
    if (_indenemyForces == "") then {_enemyForcesHeaderindependent = ""};
    if (_indfriendlyForces == "") then {_friendlyForcesHeaderindependent = ""};
    if (_indsituation == "") then {_indSituationHeader = ""};
    if (_indmission == "") then {_indMissionHeader = ""};
    if (_indExecution == "") then {_indExecutionHeader = ""};
    if (_indIntel == "") then {_indIntelHeader = ""};
    if (_indAdministration == "") then {_indAdministrationHeader = ""};

    if (_indSMEAC) then {
        _SMEACBriefing = _indSituationHeader + _indsituation + _indMissionHeader + _indmission + _indExecutionHeader + _indExecution + _indIntelHeader + _indintel + _indAdministrationHeader + _indAdministration;
        if (isNil "FOS_SMEACRecord" && _SMEACBriefing != "") then {player createDiaryRecord ["Diary",["SMEAC",_SMEACBriefing]]};
        missionNameSpace setVariable ["FOS_SMEACRecord",_SMEACBriefing];
    } else {
        if (_indcredits != "" && isNil "FOS_CreditRecord") then {
            player createDiaryRecord ["diary", ["Credits",_indcredits]];
            missionNameSpace setVariable ["FOS_CreditRecord",_indcredits];
        };
        if (_indAdministration != "" && isNil "FOS_AdministrationRecord") then {
            player createDiaryRecord ["Diary",["Administration",_indAdministration]];
            missionNameSpace setVariable ["FOS_AdministrationRecord",_indAdministration];
        };
        if (_indintel != "" && isNil "FOS_IntelRecord") then {
            player createDiaryRecord ["Diary",["Intel",_indintel]];
            missionNameSpace setVariable ["FOS_IntelRecord",_indintel];
        };
        if (_indExecution != "" && isNil "FOS_ExecutionRecord") then {
            player createDiaryRecord ["Diary",["Execution",_indExecution]];
            missionNameSpace setVariable ["FOS_ExecutionRecord",_indExecution];
        };
        if (_indmission != "" && isNil "FOS_MissionRecord") then {
            player createDiaryRecord ["Diary",["Mission",_indmission]];
            missionNameSpace setVariable ["FOS_MissionRecord",_indmission];
        };
        if (_indsituation != "" && isNil "FOS_SituationRecord") then {
            player createDiaryRecord ["Diary",["Situation",_indsituation]];
            missionNameSpace setVariable ["FOS_SituationRecord",_indsituation];
        };
    };
};

if (serverCommandAvailable "#kick" || !(isMultiplayer)) then {
	#include "adminBriefing.sqf";
} else {
    _adminRecord = missionNameSpace getVariable ["FOS_AdminRecord",nil];
    if !(isNil "_adminRecord") then {
        player removeDiaryRecord ["FOS_Options", _adminRecord];
        missionNameSpace setVariable ["FOS_AdminRecord",nil];
    };
};

"FOS: briefing system initialized" call FOS_fnc_debugSystemAdd;
