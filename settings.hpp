/*
* Welcome to the FOS Framework!
* This file will include all the configurable settings of this framework
* (Init,Description.ext, and function specific params)
* Almost all lines in this file will look like this: #define name value
* To change a setting, change the value part (The 3rd portion of the line)
* CHANGING #DEFINE OR THE MIDDLE TEXT WILL CAUSE A PARSING ERROR
* Also do not delete an entire #define line for any reason.
*/


//Just a catcher to make sure it is not overwriting settings
#ifndef FOSSETTINGS

///////////////////////
/// MISSION DETAILS ///
//////////////////////

//NOTE: These settings will not restrict player count or alter functionality. They are purely server browser info.
#define GAMETYPE "COOP" // the gametype of your mission
#define MINPLAYERS 1    // min players
#define MAXPLAYERS 32   // max players

#define AUTHOR "Mission Maker" //Name of the mission maker

#define BRIEFINGNAME "BriefingName"//Name of mission when seen from mission selection screen
#define MISSIONTITLE "onLoadName" //Title of the mission seen on load screen
#define LOADSCREENDESCRIPTON "LOADSCREENDESCRIPTON" //Description of the mission seen on load screen
#define LOADSCREENIMAGE "" //Image seen on load screen

#define OVERVIEWDESCRIPTION "OVERVIEWDESCRIPTION" //Description of the mission listed below the overview picture on mission select screen
#define OVERVIEWPICTURE "" //Image seen on mission select screen

#define SHOWBRIEFING 1 //Set to 0 to skip the map and load instantly into the mission
#define SKIPLOBBY 0 //Set to 1 to skip the slot screen and assign players to random roles. Based on the mission context, this may be prefered

#define DISABLEAI 1 // Disables AI for playable slots

////////////////
/// Briefing ///
////////////////

    ////////////////////
    /// Ending types ///
    ///////////////////

        /////////////
        /// END 1 ///
        /////////////
        #define END1NAME END1 //Name of the win type as shown to the admin (NO SPACES!)
        #define END1TITLE "Mission accomplished!" //Title that appears to the players as this mission end type is triggered
        #define END1SUBTITLE "" //Subtitle that appears below the title as the mission end type is triggered. Leave blank to disable
        #define END1DESCRIPTION "" //Text that appears in the debriefing screen
        #define END1WIN 1  // 1 is a win state. 0 is a fail state
        #define END1MISSIONSWITCH "" //Swaps mission on end as long as SERVERCOMMANDPASSWORD is correct. USE DIRECT FILENAME

        /////////////
        /// END 2 ///
        /////////////
        #define END2NAME END2 //Name of the win type as shown to the admin (NO SPACES!)
        #define END2TITLE "Mission accomplished!" //Title that appears to the players as this mission end type is triggered
        #define END2SUBTITLE "" //Subtitle that appears below the title as the mission end type is triggered. Leave blank to disable
        #define END2DESCRIPTION "" //Text that appears in the debriefing screen
        #define END2WIN 1  // 1 is a win state. 0 is a fail state
        #define END2MISSIONSWITCH "" //Swaps mission on end as long as SERVERCOMMANDPASSWORD is correct. USE DIRECT FILENAME

        /////////////
        /// END 3 ///
        /////////////
        #define END3NAME END3 //Name of the win type as shown to the admin (NO SPACES!)
        #define END3TITLE "Mission accomplished!" //Title that appears to the players as this mission end type is triggered
        #define END3SUBTITLE "" //Subtitle that appears below the title as the mission end type is triggered. Leave blank to disable
        #define END3DESCRIPTION "" //Text that appears in the debriefing screen
        #define END3WIN 1  // 1 is a win state. 0 is a fail state
        #define END3MISSIONSWITCH "" //Swaps mission on end as long as SERVERCOMMANDPASSWORD is correct. USE DIRECT FILENAME

        //////////////
        /// END 4 ///
        /////////////
        #define END4NAME END4 //Name of the win type as shown to the admin (NO SPACES!)
        #define END4TITLE "Mission failed!" //Title that appears to the players as this mission end type is triggered
        #define END4SUBTITLE "" //Subtitle that appears below the title as the mission end type is triggered. Leave blank to disable
        #define END4DESCRIPTION "" //Text that appears in the debriefing screen
        #define END4WIN 0  // 1 is a win state. 0 is a fail state
        #define END4MISSIONSWITCH "" //Swaps mission on end as long as SERVERCOMMANDPASSWORD is correct. USE DIRECT FILENAME

        /////////////
        /// END 5 ///
        /////////////
        #define END5NAME END5 //Name of the win type as shown to the admin (NO SPACES!)
        #define END5TITLE "Mission failed!" //Title that appears to the players as this mission end type is triggered
        #define END5SUBTITLE "" //Subtitle that appears below the title as the mission end type is triggered. Leave blank to disable
        #define END5DESCRIPTION "" //Text that appears in the debriefing screen
        #define END5WIN 0  // 1 is a win state. 0 is a fail state
        #define END5MISSIONSWITCH "" //Swaps mission on end as long as SERVERCOMMANDPASSWORD is correct. USE DIRECT FILENAME

    /////////////
    /// ORBAT ///
    /////////////
    #define CANREFRESH true //Players can press the refresh button to get an update on the current ORBAT
    #define SHOWALL true //Lists all players friendly to you in ORBAT. Even if they are a different side.
    #define CLICKTOFIND false //Players can click on the group name to find the group on the map
    #define PERFECTINFO false //If true, clicking refresh removes dead players from ORBAT even if no one has seen the player as dead.
    #define FINDFREQ true //Lets you click on any unit in ORBAT in order to see their currently used frequencies (TFAR ONLY SETTING)
    #define HIDEGROUPS [] //List of groups you can tell the ORBAT to hide no matter what

    /////////////////////////
    /// CAMPAIGN SETTINGS ///
    /////////////////////////

    //NOTE: The mission must END in order to save. #missions doesn't count.

    #define MISSIONPERSISTANCE false // Set to true to activate all parameters listed in this category

    #define MISSIONKEY "" //The "key" that all missions within the same campaign must have. Case sensitive. Leave empty if you are not building a campaign
    #define MISSIONINDEX -1 //Index of this mission within your campaign.

    #define SERVERCOMMANDPASSWORD "password" //This string must match the server command password of the server you want to use this campaign on

    #define PERSISTENTPLAYERGEAR true //Player gear carries over to next mission. Setting must also be true in next mission
    #define REFILLPARTIALMAGS true //True makes partial mags refill. False does not refill partials.
    #define SAVEARRAY [] //List variable names of objects you would like to be saved.

/////////////////////////
/// CHECKPOINT SYSTEM ///
////////////////////////

#define HIDEBODIES true //Hide the body of respawned players
#define CLEARBODIES true //Clear the gear on the body of respawned players

#define CHECKPOINTPOINTSYSTEM true //Enables checkpoint point system where players can call a checkpoint
#define INITIALPOINTAMOUNT 0 //Amount of checkpoint calls the players have at the start.
#define POINTSPAWN true //True: Use default method of checkpoint Array: array of objects that respawned players will spawn at.  Example: [sphere1,sphere2]
#define POINTGEAR "SAVED" //String to control spawn gear. "": Do not edit gear "INIT": use starting gear "SAVED": Use gear on death
#define POINTPROTECTION 5 //Number: amount of spawn protection time

#define CALLCHECKPOINTPERMISSIONS 0 // 0: Everyone can call checkpoints 1: Squad leaders can call checkpoints 2: Only admin can

#define SPECTATORCHECKPOINTSLEFT true // Allows dead players to see checkpoints left
#define SPECTATORCALLCHECKPOINTS true // Allows dead players to call a checkpoint

#define ANNOUNCEUSER true //Alert the entire server who pressed the call checkpoint button. Only tells current admin if set to false

/////////////
/// DEBUG ///
/////////////

#define DEBUG false //Enable to have capability

//////////////////
/// DIFFICULTY ///
//////////////////

#define DYNAMICSKILL true //Allow the AI skill level to be globaly adjusted based on player count. Increases and decreases as people connect and disconnect
#define DAMAGEREDUCER true //Reduces damage based on difficulty setting set in mission params (Always off if Ace_Medical detected)

#define REDUCELOOT false //True will make every player see reduced amount of magazines per unit they kill.
#define LOOTAMOUNT 2 //What is the max amount the player can see on a unit per item type

//////////////////////////
/// DYNAMIC SIMULATION ///
/////////////////////////

#define ENABLEDYNAMICSIMULATION True

#define DYNAMICSIMDISTANCEINFANTRY 750 //Approximate distance from enemy units before dynamic simulationn will put infantry to sleep
#define DYNAMICSIMDISTANCEVEHICLE 350 //Approximate distance from enemy units before dynamic simulationn will put active vehicle to sleep
#define DYNAMICSIMDISTANCEEMPTYVEHICLE 250 //Approximate distance from enemy units before dynamic simulationn will put empty vehicle to sleep
#define DYNAMICSIMDISTANCEPROP 50 //Approximate distance from all units before dynamic simulationn will put props to sleep

#define DYNAMICSIMMOVEMENTCOEF 2 //Doubles the activation distances listed above if the unit is currently moving

#define DYNAMICSIMAUTOADDUNITS false //Automatically adds all AI into dynamic simulation manager
#define DYNAMICSIMCANAIWAKE true //Controls if AI can wake up enemy units in their presence

////////////////////////
/// FIRETEAM MARKERS ///
////////////////////////

#define FIRETEAM true //toggle fireteam markers
#define DEATHMARKER true //True for a skull to replace the FT marker.
#define DELETEONDEATH false //always delete the FT marker on death (Even if nobody has seen the death)
#define DRAWPLAYER true //Controls if a marker is drawn for the player.
#define DRAWTEAM true //Controls if a marker is drawn for the player's team

#define NEEDGPS false //Requires player to have a GPS in order to see fireteam markers

///////////////////////
/// GARBAGE MANAGER ///
///////////////////////

#define CORPSEMANAGERMODE  2
#define CORPSELIMIT  15
#define CORPSEREMOVALMINTIME  10
#define CORPSEREMOVALMAXTIME  3600
#define WRECKMANAGERMODE  2
#define WRECKLIMIT  15
#define WRECKREMOVALMINTIME  10
#define WRECKREMOVALMAXTIME  36000
#define MINPLAYERDISTANCE  250

/////////////////////
/// GROUP TRACKER ///
/////////////////////

#define GRPTRACKER true
#define GRPTRACKERLIST "FRIENDLY" //Options available are "FRIENDLY","SIDE","FRIENDLY PLAYERS", or "SIDE PLAYERS"
#define GRPTRACKERNEEDGPS false //Requires group to have GPS
#define GRPTRACKERGPSNEEDED ["itemGPS"] //Class name of GPS item required
#define GRPTRACKERIGNOREACE false // By default, group trackers will not be created if ACE_MAP is detected. You can alter this behaviour by setting this to true

///////////
/// IFF ///
///////////

#define IFF true // toggle IFF
#define IFFMODE 2 // 0 = no IFF. 1 = Nametag. 2 = group indicators
#define IFFDEFAULTTARGET 2 //Controls the targets for IFF. 1 = group only | 2 = side only | 3 = friendly only | 4 = players only
#define IFFMAXDISTANCE 1e10 //Max distance before IFF does not appear under any circumstances.
#define IFFMAXDISPLAYDISTANCE 50 //Max distance before nametag is no longer always displayed.
#define IFFPRECISETHRESHOLD 75 //At what distance past that point should the player need to be aiming *exactly* on the target to get a nametag to appear?
#define IFFOUTLINE true //Outlines the icons and text
#define IFFNEEDGLASSES false //Requires player to have tactical glasses in order to see IFF
#define IFFGOGGLESNEEDED ["G_Tactical_Black","G_Tactical_Clear"] //class names of glasses required
#define IFFBLACKLIST [] //List of units that need to be blacklisted from any IFF features

//////////////////
/// Mission AO ///
//////////////////

#define AOMARKERNAME "AO" //Hides area outside of marker area.


////////////////////////
/// RESPAWN SETTINGS ///
///////////////////////

#define RESPAWNTYPE 3 //set to 3 for MP respawn. set to 0 for no respawn.
#define RESPAWNTIME 2 //Respawn delay for players in seconds
#define VEHICLERESPAWNDELAY 30 // respawn delay for vehicles in seconds
#define RESPAWNBUTTON 1 //Allows players to respawn themselves in the menu
#define RESPAWNPROMPT 0 //show scoreboard dialog and respawn timer on death. RespawnType must be set to 3
#define RESPAWNONSTART 0 // -1 = don't respawn on start. Don't run respawn script || 0 = don't respawn on start. Run respawn script || 1 = respawn on start. Run respawn script.
#define RESPAWNTEMPLATES {"SpectatorFilter", "checkpointSystem"};

//////////////////
/// SAFE START ///
//////////////////

#define SAFESTARTINIT true //Controls if safestart fires at mission start
#define SAFESTARTTIMER 180 //Controls how long the safe start init timer is
#define PAUSEATSTART false //Starts the game paused. Can be unpaused by admin in FOS ADMIN MENU
#define RESTRICTATSTART false //Drags players back if they walk too far from starting point at safe start
#define RESTRICTDISTANCE 50 //How far the player can go before it drags them back


/////////////////
/// SPECTATOR ///
/////////////////

#define SHOWALLUNITS false //Allows player to spectate enemy players
#define SHOWAI true //Allow players to spectate AI
#define FREECAM false //Allow players to FREECAM
#define THIRDPERSONCAM true //Allow player to spectate in third person pov
#define SHOWFOCUSINFO true //Show or hide focus widget
#define SHOWCAMERABUTTONS true //Show camera widget
#define SHOWCONTROLSHELPER true //Show controls widget
#define SHOWHEADER true //Show header
#define SHOWENTITYLIST true //show entitiy/location widget
#define HIDEUNKNOWNENEMY false //hide enemy not yet seen by players.

#define UNCONSCIOUSSPECTATOR false //Players that go unconscious will get the spectator camera.

////////////////////////
/// Mission Teleport ///
///////////////////////
#define TELEOBJECT FOS_SafeFlag //Name of object that players use to teleport with
#define TELEBLACKLIST [[getPos player,100]] //Black list for mission teleport. Check BIS_fnc_getArea for syntax information
#define TELEMOVESQUAD true //Allows the Squad lead to move the entire squad at once. Restricts access to SL only.
#define TELESAFESTARTONLY false //Can only be accessed during safestart
#define TELEAFTERSAFESTART true //Allows SLs to mark where they want to be teleported. But only teleport once safe start is over.

//////////////////////
/// VANILLA REVIVE ///
//////////////////////

#define	REVIVEENABLED 1 // Vanilla revive (Always off if Ace_Medical detected)

/////////////////////
/// Misc settings ///
/////////////////////

#define LOADOUTARRAY [] //Add the variable names of units that you wish to overwrite units of the same class with with their current loadout (CBA REQUIRED)

#define FIXARSENALBUG true // Fixes a bug that causes AI gear to be non-interactable.
#define MESSAGEADMIN true //Controls if players can use the chat command #help to reach out to the admin. (CBA REQUIRED)
#define PMPERMISSIONS "adminlogged" //Controls who can use #PM command. Possible options are "all", "admin" or "adminLogged" (CBA REQUIRED)

#define FRIENDLYFIRETRACKER true //Notify the admin when a friendly HITS a friendly
#define FRIENDLYKILLTRACKER true //Notify the admin when a friendly KILLS a friendly

#define AUTOGEARPLAYERS false //Will essentially do a rearm on units at start. Helps ensure that their loadouts have sufficient mags.
#define AUTOGEARARRAY [["FirstAidKit",2]] //An array you can use to pass items (not magazines) to the auto gear function at start.

#define ALLOWPROFILEGLASSES 1 //0 will stop glasses set in player profile from being added to player's gear

//////////////////////////
/// OVERRIDE FUNCTIONS ///
//////////////////////////

/*
Change any of these to false to completely turn off the functionality
Safer method than deleting files
Also useful if you are an advanced mission maker and something you want to do conflicts with the framework
*/

#define	MISSIONAO true
#define MISSIONTELEPORT true
#define BRIEFING true
#define ORBAT true
#define CHECKPOINTSYSTEM true
#define CAMPAIGNSYSTEM true
#define DEBUGMESSAGESYSTEM true
#define JIPMENU true
#define DIFFICULTY true
#define FTMARKERS true
#define NAMETAG true
#define IFF true
#define GROUPTRACKER true
#define SAFESTART true
#define SPECTATOR true
#define CUSTOMLOADOUT true
#define CUSTOMCHATCOMMANDS true

#endif
