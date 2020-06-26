/*
* Welcome to the FOS Framework!
* This file will include all the configurable settings of this framework
* (Init,Description.ext, and function specific params)
* Almost all lines in this file will look like this: #define name value
* To change a setting, change the value part (The 3rd portion of the line)
* CHANGING #DEFINE OR THE MIDDLE TEXT WILL CAUSE A PARSING ERROR
*/

//Just a catcher to make sure it is not overwriting settings
#ifndef FOSSETTINGS

///////////////////////
/// MISSION DETAILS ///
//////////////////////

//NOTE: These settings will not restrict player count or alter functionality. They are purely server browser info.
#define GAMETYPE "TEST" // the gametype of your mission
#define MINPLAYERS 1 // min players
#define MAXPLAYERS 32 // max players

#define AUTHOR "Mission Maker" //Name of the mission maker

#define MISSIONTITLE "onLoadName" //Title of the mission seen on load screen
#define LOADSCREENDESCRIPTON "LOADSCREENDESCRIPTON" //Description of the mission seen on load screen
#define LOADSCREENIMAGE "" //Image seen on load screen
#define BRIEFINGNAME "TEST"

#define OVERVIEWDESCRIPTION "OVERVIEWDESCRIPTION" //Description of the mission listed below the overview picture on mission select screen
#define OVERVIEWPICTURE "" //Image seen on mission select screen





////////////////////////
/// RESPAWN SETTINGS ///
///////////////////////


#define RESPAWNTYPE 3 //set to 3 for MP respawn. set to 0 for no respawn.
#define RESPAWNTIME 1e10 //Respawn delay for players in seconds
#define VEHICLERESPAWNDELAY 30 // respawn delay for vehicles in seconds
#define RESPAWNBUTTON 1 //Allows players to respawn themselves in the menu
#define RESPAWNPROMPT 1 //show scoreboard dialog and respawn timer on death. RespawnType must be set to 3
#define RESPAWNONSPAWN -1 // -1 = don't respawn on start. Don't run respawn script || 0 = don't respawn on start. Run respawn script || 1 = respawn on start. Run respawn script.

//////////////////////
/// VANILLA REVIVE ///
//////////////////////
#define	REVIVEENABLED 1 //This should turn off by default if ACE is detected


//////////////////
/// DIFFICULTY ///
//////////////////

#define DYNAMICSKILL true //Allow the AI skill level to be globaly adjusted based on player count. Increases and decreases as people connect and disconnect
#define DAMAGEREDUCER true //Reduces damage based on difficulty setting set in mission params

//////////////////////////
/// OVERRIDE FUNCTIONS ///
//////////////////////////
/*
Change any of these to false to completely turn off the functionality
Safer method than deleting files
*/

#define	MISSIONAO true
#define BRIEFING true
#define CHECKPOINTSYSTEM true
#define DEBUGMESSAGESYSTEM true
#define JIPMENU true
#define FTMARKERS true
#define GROUPTRACKER true
#define SAFESTART true
#define SPECTATOR true

#endif