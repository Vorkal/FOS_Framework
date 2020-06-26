//////////////////////
/// BRIEFING MENU ///
////////////////////

/*
    This is file contains all you need to edit the briefing
    Place into the strings your briefing information.
    <br/> can be used to create a new line
 */

//Set this to true if you want the briefing file to auto detect dobule line breaks
//NOTE: You will need to hit enter twice to do a new line. Not once. Because reasons.
_autolinebreak = false; //-- Doesn't work properly yet! You should leave it false


////////////////////////
/// PLAYER BRIEFING ///
///////////////////////

//Describe the situation revolving around this mission
_situation = "";
//Give some info on the enemy forces. Equipment, threat level, stuff like that.
_enemyForces = "";
//Give some info on who the players are. If friendly forces are in this mission be sure to clarify it here.
_friendlyForces = "";
//Explain the mission.
_mission = "";
//Explain how the players should go about completing the mission
_Execution = "";
//Give some mission specific details.
_intel = "";
//Give details on changes that a player may not expect. Maybe there is a script that makes paruchutes work different. Or extra smokes are in transports.
_Administration = "";
//Who made the mission
_credits = "";

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