//////////////////////
/// BRIEFING MENU ///
////////////////////

/*
    This is file contains all you need to edit the briefing
    Place into the strings your briefing information.
    <br/> can be used to create a new line
*/

_autolinebreak = false; //Set this to true if you want the briefing file to auto detect line breaks
////////////////////////
/// PLAYER BRIEFING ///
///////////////////////

/* NOTE: Player briefing will overwrite side based briefings. Leave empty to use side based briefings */

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

//Places all sections above into a single briefing page if set to true
_SMEAC = false;
/////////////////////
/// WEST BRIEFING ///
/////////////////////

_westsituation = "";
_westenemyForces = "";
_westfriendlyForces = "";
_westmission = "";
_westExecution = "";
_westintel = "";
_westAdministration = "";
_westcredits = "";

//Places all sections above into a single briefing page if set to true
_westSMEAC = false;
/////////////////////
/// EAST BRIEFING ///
/////////////////////

_eastsituation = "";
_eastenemyForces = "";
_eastfriendlyForces = "";
_eastmission = "";
_eastExecution = "";
_eastintel = "";
_eastAdministration = "";
_eastcredits = "";
//Places all sections above into a single briefing page if set to true
_eastSMEAC = true;
////////////////////////////
/// INDEPENDENT BRIEFING ///
///////////////////////////

_indsituation = "";
_indenemyForces = "";
_indfriendlyForces = "";
_indmission = "";
_indExecution = "";
_indintel = "";
_indAdministration = "";
_indcredits = "";

//Places all sections above into a single briefing page if set to true
_indSMEAC = false;

//////////////////////
/// Admin Briefing ///
/////////////////////

//Details that only the admin can see
_adminText = "";
