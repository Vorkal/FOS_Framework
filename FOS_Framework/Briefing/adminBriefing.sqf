
if (isNil "FOS_AlertRecord") then {
	_AlertRecord = player createDiaryRecord ["Diary", ["FOS Admin Menu", "It's under Mission Options now. Not Briefing"]];
	missionNameSpace setVariable ["FOS_AlertRecord",_AlertRecord];
};

_briefing = "
<br/>
<font size='18'>ADMIN SECTION</font><br/>
This can only be seen by the current admin.
<br/><br/>
";

if (_adminText != "") then {
	_briefing = _briefing + "<br/><font size='18'>MISSION-MAKER NOTES</font><br/>";
	_briefing = _briefing + _adminText + "<br/><br/>";
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
<font color='#32CD32' size='18' face='PuristaBold'>ENDINGS</font><br/>
These endings are available. To trigger an ending click on its link.<br/><br/>
";

{
	_end = _this select 0;
	_briefing = _briefing + format ["
	<execute expression='[%1] remoteExec [""FOS_fnc_endMission"",0];'>'%1'</execute> - %2:<br/>
	%3<br/>
	"
	,str (_x # 0),(_x # 1),(_x # 2),(_x # 3)];
} forEach _endings;

_briefing = _briefing + "
<font color='#48D1CC' size='18' face='PuristaBold'>Zeus</font><br/>
<execute expression=""
if !(isNull (getAssignedCuratorLogic player)) then {hintsilent 'ZEUS already assigned!'} else {
    [player] remoteExec ['FOS_fnc_zeusInit',2]; hintsilent 'Curator assigned.';
};"">Assign ZEUS to admin</execute>.<br/><br/>
";

_briefing = _briefing + "
<font color='#6A5ACD' size='18' face='PuristaBold'>SAFE START</font><br/>
<execute expression='[true] remoteExec [""FOS_fnc_safeStartToggleServer"",2]'>start safe start mode</execute>
<br/>
<execute expression='[false] remoteExec [""FOS_fnc_safeStartToggleServer"",2]'>end safe start mode</execute>
<br/><br/>
";

if (isMultiplayer) then {
	_briefing = _briefing + "
	<font color='#FFA500' size='18' face='PuristaBold'>CHECKPOINT SYSTEM</font><br/>
	<execute expression='[true,""INIT"",1] remoteExec [""FOS_fnc_checkpointSystem"",0]'>spawn all players with starting gear</execute>
	<br/>
	<execute expression='[true,""SAVED"",1] remoteExec [""FOS_fnc_checkpointSystem"",0]'>spawn all players with on-death gear</execute>
	<br/><br/>
	<execute expression='[true,""INIT"",1] remoteExec [""FOS_fnc_checkpointSystem"",west]'>west only with starting gear</execute>
	<br/>
	<execute expression='[true,""SAVED"",1] remoteExec [""FOS_fnc_checkpointSystem"",west]'>west only players with on-death gear</execute>
	<br/><br/>
	<execute expression='[true,""INIT"",1] remoteExec [""FOS_fnc_checkpointSystem"",east]'>east only with starting gear</execute>
	<br/>
	<execute expression='[true,""SAVED"",1] remoteExec [""FOS_fnc_checkpointSystem"",east]'>east only players with on-death gear</execute>
	<br/><br/>
	<execute expression='[true,""INIT"",1] remoteExec [""FOS_fnc_checkpointSystem"",independent]'>independent only with starting gear</execute>
	<br/>
	<execute expression='[true,""SAVED"",1] remoteExec [""FOS_fnc_checkpointSystem"",independent]'>independent only players with on-death gear</execute>
	<br/><br/>
	<execute expression='[1] remoteExec [""FOS_fnc_checkpointPointsSystem"",2]'>add a point</execute>
	<br/>
	<execute expression='[-1] remoteExec [""FOS_fnc_checkpointPointsSystem"",2]'>remove a point</execute>
	<br/><br/>
	";
};

_adminRecord = missionNameSpace getVariable ["FOS_AdminRecord",nil];

_nullRecord = objNull createDiaryRecord []; // wrong parameters = failure to create a record = null value

if (!isNil "_adminRecord") then {
	if !(_adminRecord isEqualTo _nullRecord) then {
    	player setDiaryRecordText [["FOS_Options", _adminRecord], ["FOS Admin Menu",_briefing]];
	} else {
		_adminRecord = player createDiaryRecord ["FOS_Options", ["FOS Admin Menu",_briefing]];
		missionNameSpace setVariable ["FOS_AdminRecord",_adminRecord];
	};
} else {
    _adminRecord = player createDiaryRecord ["FOS_Options", ["FOS Admin Menu",_briefing]];
	missionNameSpace setVariable ["FOS_AdminRecord",_adminRecord];
};
