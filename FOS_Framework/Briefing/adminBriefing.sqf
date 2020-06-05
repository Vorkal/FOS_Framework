_customText = "";

_briefing = "
<br/>
<font size='18'>ADMIN SECTION</font><br/>
This briefing section can only be seen by the current admin.
<br/><br/>
";

if (_customText != "") then {
	_briefing = _briefing + "<br/><font size='18'>MISSION-MAKER NOTES</font><br/>";
	_briefing = _briefing + _customText + "<br/><br/>";
};

//Grab all ending types listed in mission cfgDebriefing
_title = [];
_ending = [];
_endings = [];

{
	_title = (missionconfigfile >> "CfgDebriefing" >> _x >> "title") call BIS_fnc_getCfgData;
	_description = (missionconfigfile >> "CfgDebriefing" >> _x >> "description") call BIS_fnc_getCfgData;
	_state = (missionconfigfile >> "CfgDebriefing" >> _x >> "win") call BIS_fnc_getCfgDataBool;
	if (isNil "_title") exitWith {};
	_ending = [_x,_title,_description,_state];
	_endings append ([_ending])
} forEach ((missionConfigFile >> "CfgDebriefing") call BIS_fnc_getCfgSubClasses);


_briefing = _briefing + "
<font size='18'>ENDINGS</font><br/>
These endings are available. To trigger an ending click on its link.<br/><br/>
";

{
	_end = _this select 0;
	_briefing = _briefing + format ["
	<execute expression='[%1] remoteExec [""FOS_fnc_endMission"",0];'>'%1'</execute> - %2:<br/>
	%3<br/><br/>
	"
	,_x select 0,_x select 1,_x select 2,_x select 3];
} forEach _endings;

_briefing = _briefing + "
<font size='18'>ZEUS</font><br/>
<br/>
<execute expression=""
if !(isNull (getAssignedCuratorLogic player)) then {hintsilent 'ZEUS already assigned!'} else {
    [player] remoteExec ['FOS_fnc_zeusInit',2]; hintsilent 'Curator assigned.';
};"">Assign ZEUS to admin</execute>.<br/><br/>
";


_briefing = _briefing + "
<font size='18'>SAFE START</font><br/><br/>
<execute expression='[true] remoteExec [""FOS_fnc_safeStartToggleServer"",2]'>start safe start mode</execute>
<br/><br/>
<execute expression='[false] remoteExec [""FOS_fnc_safeStartToggleServer"",2]'>end safe start mode</execute>
";

player createDiaryRecord ["Diary", ["FOS Admin Menu",_briefing]];
