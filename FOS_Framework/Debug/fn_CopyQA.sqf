
_players = if (isMultiplayer) then {playableUnits} else {switchableUnits};

_tab = toString [9];
_br = toString [10];


//Initialize  text
_str = "";

_addHeader = {
    _str = _str + _br  + _br + _this + _br + _br;
};

_addText = {
    _str = _str + _br + _tab + _this + _br;
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


_AOCheck = "zoneBorderInner" in allMapMarkers;
if (_AOCheck) then {"AO Marker is detected!" call _addText} else {};




"NOTES: " call _addHeader;

_aiCount = {!isPlayer _x} count allUnits;
_playableSlots = {isPlayer _x} count allUnits;
_unitRatio = _aiCount / _playableSlots;
if (_unitRatio > 15) then {"There are about " + str round _unitRatio + " units per player unit. This could be a bit high, depending on your mission design."  call _addText};


copyToClipboard _str;
