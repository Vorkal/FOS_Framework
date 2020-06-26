/*
* Welcome to the FOS Framework!
* This file will include all the configurable settings of this framework
* (Init,Description.ext, and function specific params)
* Almost all lines in this file will look like this: #define name value
* To change a setting, change the value part (The 3rd portion of the line)
* CHANGING #DEFINE OR THE MIDDLE TEXT WILL CAUSE A PARSING ERROR
*/

///////////////////////////////////////////////////////////////////////
/*NOTE: NONE OF THIS WORKS YET. YOU STILL HAVE TO EDIT THE CORE FILES*/
///////////////////////////////////////////////////////////////////////




//NOTE: These settings will not restrict player count or alter functionality. They are purely server browser info.
#define GAMETYPE "TEST" // the gametype of your mission
#define MINPLAYERS 1 // min players
#define MAXPLAYERS 32 // max players

#define AUTHOR "Mission Maker" //Name of the mission maker

#define onLoadName "onLoadName" //Title of the mission seen on load screen
#define LOADSCREENDESCRIPTON "LOADSCREENDESCRIPTON" //Description of the mission seen on load screen
#define LOADSCREENIMAGE "" //Image seen on load screen
#define BRIEFINGNAME "TEST"

#define OverviewDescription "OVERVIEWDESCRIPTION" //Description of the mission listed below the overview picture on mission select screen
#define OverviewPicture "" //Image seen on mission select screen

#define RespawnType 3 //set to 3 for MP respawn. set to 0 for no respawn.
#define RespawnTime 1e10 //Respawn delay for players in seconds
#define VehicleRespawnDelay 30 // respawn delay for vehicles in seconds
#define RespawnButton 1 //Allows players to respawn themselves in the menu
#define RespawnPrompt 1 //show scoreboard dialog and respawn timer on death. RespawnType must be set to 3
#define RespawnOnSpawn -1 // -1 = don't respawn on start. Don't run respawn script || 0 = don't respawn on start. Run respawn script || 1 = respawn on start. Run respawn script.

//////////////////////
/// VANILLA REVIVE ///
//////////////////////

#define	reviveEnabled 1

//////////////////
/// MISSION AO ///
//////////////////

#define MissionAO true //use the marker named "AO" to block off the area outside of it.
#define MissionAO_PunishPlayers true //Punish players for leaving the mission AO
#define MissionAO_ignoreAir true //Ignore air vehicles outside AO
#define MissionAO_punishDelayTime 30 //Time before players are damaged for leaving AO
#define MissionAO_CacheOutsideAO false //Cache all objects outside missionAO at mission start
