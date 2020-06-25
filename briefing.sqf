//////////////////////
/// BRIEFING MENU ///
////////////////////

/*
This is file contains all you need to edit the briefing
 Place into the strings your briefing information. The framework will structure it for you.
<br/> can be used to create a new line
 */

//Set this to true if you want the briefing file to auto detect dobule line breaks
//NOTE: You will need to hit enter twice to do a new line. Not once. Because reasons.
_autolinebreak = false;


////////////////////////
/// PLAYER BRIEFING ///
///////////////////////

//Describe the situation revolving around this mission
_situation = "*** Insert general information about the situation here.***";
//Give some info on the enemy forces. Equipment, threat level, stuff like that.
_enemyForces = "";
//Give some info on who the players are. If friendly forces are in this mission be sure to clarify it here.
_friendlyForces = "";
//Explain the mission.
_mission = "*** Insert the mission here. ***";
//Explain how the players should go about completing the mission
_Execution = "*** Insert the general plan on how to accomplish this mission. ***";
//Give some mission specific details.
_intel = "*** Insert information about details critical for the player to be aware of***";
//Give details on mission specific changes that a player may not expect. Maybe all transports have extra smokes or there is a script that makes paruchutes work different etc.
_Administration = "*** Insert information on mission specific changes the player might not expect here. ***";
//Who made the mission
_credits = "
*** Insert mission credits here. ***

Made with FOS Framework";
//////////////////////
/// Admin Briefing ///
/////////////////////

//Details that only the admin can see
_adminText = "";

/////////////////////
/// Zeus Briefing ///
/////////////////////

//Details that only admin OR zeus can see
_zeusText = "";
