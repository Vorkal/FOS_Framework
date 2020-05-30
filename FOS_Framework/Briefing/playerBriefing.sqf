_credits = player createDiaryRecord ["diary", ["Credits","
<br/>
*** Insert mission credits here. ***
<br/><br/>
Made with FOS Framework
"]];

_Administration = player createDiaryRecord ["Diary",["Administration","
<br/>
*** Insert information on mission specific changes the player might not expect here. ***
"]];

_Intel = player createDiaryRecord ["Diary",["Intel","
<br/>
*** Insert information about details critical for the player to be aware of***
"]];

_Execution = player createDiaryRecord ["Diary",["Execution","
<br/>
*** Insert the general plan on how to accomplish this mission. ***
"]];

_Mission = player createDiaryRecord ["Diary",["Mission","
<br/>
*** Insert the mission here. ***
"]];

_Situation = player createDiaryRecord ["Diary",["Situation","

<br/>
*** Insert general information about the situation here.***
<br/><br/>
<font size='18'>ENEMY FORCES</font>
<br/>
*** Insert information about enemy forces here.***
<br/><br/>
<font size='18'>FRIENDLY FORCES</font>
<br/>
*** Insert information about friendly forces here.***
"]];

//NOTE: DO NOT DELETE THIS
_checkpointSystem = player createDiarySubject ["Checkpoint system","Call checkpoint"];
_Checkpoint = player createDiaryRecord ["Checkpoint system",["Call checkpoint","
		<font color='#FF8C00'>CHECKPOINT SYSTEM</font color>
		<br/><br/>
		<font color='#ffff00'><execute expression='[""spawnsLeft""] call FOS_fnc_checkpointPointsSystem'>Amount of checkpoints left</execute></font color>.
		<br/><br/><br/><br/>
		<font color='#ADFF2F'><execute expression='[""activated""] call FOS_fnc_checkpointPointsSystem'>Activate checkpoint</execute></font color>!
		<br/><br/><br/><br/>
		Clicking the number will call a checkpoint and respawn all dead players. The one who initiated the checkpoint call will be broadcasted to the server in a hint.
		<br/><br/>
		Complete optional tasks to increase the amount of checkpoints available to call!
		"
]];


