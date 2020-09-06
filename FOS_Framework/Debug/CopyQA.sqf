_tab = toString [9];
_br = toString [10];


//Initialize  text
_str = "";

_addHeader = {
    _str = _str + _br  + _br + _this + _br + _br;
};

_addText = {
    _str = _str + _br + _tab + _this;
};


"MISSION DETAILS:" call _addHeader;

//Get unit count
_unitCount = count allUnits;
"unit count: " + str _unitCount call _addText;

//get group count
_grpCount = count allGroups;
"group count: " + str _grpCount call _addText;

//get running sqf scripts
_sqfCount = count diag_activeSQFScripts;
"SQF script count: " + str _sqfCount call _addText;

//get running fsm scripts
_fsmCount = count diag_activeMissionFSMs;
"FSM count: " + str _sqfCount call _addText;




/////////////////////
/// FEATURE CHECK ///
////////////////////
_checkFeature = {
    
};

"FEATURE CHECK: " call _addHeader;

//does the checkpoint briefing exist
_checkpointPointsCheck = player diarySubjectExists "Checkpoint system";
if (_checkpointPointsCheck) then {
    "Checkpoint point system is detected!" call _addText
    } else {
    "Checkpoint point system NOT detected!" call _addText
};

//TODO: check if FOS admin menu exists
/* _checkpointPointsCheck = player diarySubjectExists "Checkpoint system";
if (_checkpointPointsCheck) then {
    "Checkpoint point system is detected!" call _addText
    } else {
    "Checkpoint point system NOT detected!" call _addText
}; */
_AOCheck = "zoneBorderInner" in allMapMarkers;
if (_AOCheck) then {"AO Marker is detected!" call _addText} else {};
copyToClipboard _str;
