private _briefing = "
<br/>
<font size='18'>Player SECTION</font><br/>
This is a menu to quickly change personal player settings.
<br/><br/>
";

//Disable nametags
if !(NAMETAGLOCKSETTINGS) then {
    _briefing = _briefing +
    "<font color='#FFA500' size='18' face='PuristaBold'>Nametags</font><br/>
    	<execute expression='
            switch (missionNamespace getVariable [""FOS_nametagTargets"",[]]) do {
                case ([]): {
                    missionNameSpace setVariable [""FOS_nametagTargets"",units group player - [player]];
                    systemChat ""group only"";
                };
                case (units group player - [player]): {
                    missionNameSpace setVariable [""FOS_nametagTargets"",allUnits select {[side group player, side group _x] call BIS_fnc_sideIsFriendly}];
                    systemChat ""All friendlies"";
                };
                case (units group player - [player]): {
                    missionNameSpace setVariable [""FOS_nametagTargets"",[]];
                    systemChat ""Off"";
                };
                default {
                    missionNameSpace setVariable [""FOS_nametagTargets"",[]];
                    systemChat ""off"";
                };
            }
        '>Toggle Nametags</execute><br/><br/>
    ";
};
//IFF settings
if !(IFFLOCKSETTINGS) then {
    _briefing = _briefing +
    "<font color='#FFA500' size='18' face='PuristaBold'>IFF</font><br/>
    	<execute expression='
            switch (missionNamespace getVariable [""FOS_iffTargets"",[]]) do {
                case ([]): {
                    _targets = allUnits select {leader _x != leader player && side _x isEqualTo side player};
                    missionNameSpace setVariable [""FOS_iffTargets"",_targets];
                    systemChat ""Side only"";
                };
                case (allUnits select {leader _x != leader player && [side group player, side group _x] call BIS_fnc_sideIsFriendly}): {
                    _targets = allUnits select {leader _x != leader player && [side group player, side group _x] call BIS_fnc_sideIsFriendly};
                    missionNameSpace setVariable [""FOS_iffTargets"",_targets];
                    systemChat ""All friendlies"";
                };
                default {
                    missionNameSpace setVariable [""FOS_iffTargets"",[]];
                    systemChat ""off"";
                };
            }
        '>Toggle IFF</execute><br/><br/>
    ";
};

//toggle dynamic earplugs
_briefing = _briefing +
"<font color='#FFA500' size='18' face='PuristaBold'>Dynamic Earplugs</font><br/>
	<execute expression='
        [true] spawn FOS_fnc_dynamicEarplugs;
    '>set Dynamic Earplugs mode</execute><br/><br/>
";

_settingRecord = missionNameSpace getVariable ["FOS_settingsRecord",nil];

//Check if this is necessary anymore
_nullRecord = objNull createDiaryRecord []; // wrong parameters = failure to create a record = null value

if (!isNil "_settingRecord") then {
	if !(_settingRecord isEqualTo _nullRecord) then {
    	player setDiaryRecordText [["FOS_Options", _settingRecord], ["FOS Player Menu",_briefing]];
	} else {
		_settingRecord = player createDiaryRecord ["FOS_Options", ["FOS Player Menu",_briefing]];
		missionNameSpace setVariable ["FOS_settingsRecord",_settingRecord];
	};
} else {
    _settingRecord = player createDiaryRecord ["FOS_Options", ["FOS Player Menu",_briefing]];
	missionNameSpace setVariable ["FOS_settingsRecord",_settingRecord];
};
