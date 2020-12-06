/*
* Welcome to the FOS Framework!
* This file will include all the configurable settings of this framework
* (Init,Description.ext, and function specific params)
* Almost all lines in this file will look like this: #define name value
* To change a setting, change the value part (The 3rd portion of the line)
* CHANGING #DEFINE OR THE MIDDLE TEXT WILL CAUSE A PARSING ERROR
* Also do not delete an entire #define line for any reason.
*
* NOTE: Obviously, this menu is not complete. If you don't see something that can be changed here, you will have to edit it from the file directly.
*/


//Just a catcher to make sure it is not overwriting settings
#ifndef FOSSETTINGS

///////////////////////
/// MISSION DETAILS ///
//////////////////////

//NOTE: These settings will not restrict player count or alter functionality. They are purely server browser info.
#define GAMETYPE "TEST" // the gametype of your mission
#define MINPLAYERS 1    // min players
#define MAXPLAYERS 32   // max players

#define AUTHOR "Mission Maker" //Name of the mission maker

#define BRIEFINGNAME "BriefingName"//Name of mission when seen from mission selection screen
#define MISSIONTITLE "onLoadName" //Title of the mission seen on load screen
#define LOADSCREENDESCRIPTON "LOADSCREENDESCRIPTON" //Description of the mission seen on load screen
#define LOADSCREENIMAGE "" //Image seen on load screen

#define OVERVIEWDESCRIPTION "OVERVIEWDESCRIPTION" //Description of the mission listed below the overview picture on mission select screen
#define OVERVIEWPICTURE "" //Image seen on mission select screen

#define BRIEFING 1 //Set to 0 to skip the map and load instantly into the mission
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
        #define MISSIONSWITCH "" //Only used with persistance system. Add the name of the next mission

        /////////////
        /// END 2 ///
        /////////////
        #define END2NAME END2//Name of the win type as shown to the admin (NO SPACES!)
        #define END2TITLE "Mission accomplished!" //Title that appears to the players as this mission end type is triggered
        #define END2SUBTITLE "" //Subtitle that appears below the title as the mission end type is triggered. Leave blank to disable
        #define END2DESCRIPTION "" //Text that appears in the debriefing screen
        #define END2WIN 1  // 1 is a win state. 0 is a fail state
        #define MISSIONSWITCH "" //Only used with persistance system. Add the next mission name

        /////////////
        /// END 3 ///
        /////////////
        #define END3NAME END3//Name of the win type as shown to the admin (NO SPACES!)
        #define END3TITLE "Mission accomplished!" //Title that appears to the players as this mission end type is triggered
        #define END3SUBTITLE "" //Subtitle that appears below the title as the mission end type is triggered. Leave blank to disable
        #define END3DESCRIPTION "" //Text that appears in the debriefing screen
        #define END3WIN 1  // 1 is a win state. 0 is a fail state
        #define MISSIONSWITCH "" //Only used with persistance system. Add the next mission name


        //////////////
        /// END 4 ///
        /////////////
        #define END4NAME END4//Name of the win type as shown to the admin (NO SPACES!)
        #define END4TITLE "Mission failed!" //Title that appears to the players as this mission end type is triggered
        #define END4SUBTITLE "" //Subtitle that appears below the title as the mission end type is triggered. Leave blank to disable
        #define END4DESCRIPTION "" //Text that appears in the debriefing screen
        #define END4WIN 0  // 1 is a win state. 0 is a fail state
        #define MISSIONSWITCH "" //Only used with persistance system. Add the next mission name

        /////////////
        /// END 5 ///
        /////////////
        #define END5NAME END5//Name of the win type as shown to the admin (NO SPACES!)
        #define END5TITLE "Mission failed!" //Title that appears to the players as this mission end type is triggered
        #define END5SUBTITLE "" //Subtitle that appears below the title as the mission end type is triggered. Leave blank to disable
        #define END5DESCRIPTION "" //Text that appears in the debriefing screen
        #define END5WIN 0  // 1 is a win state. 0 is a fail state
        #define MISSIONSWITCH "" //Only used with persistance system. Add the next mission name

    /////////////
    /// ORBAT ///
    /////////////
    #define CANREFRESH true //Players can press the refresh button to get an update on the current ORBAT
    #define SHOWALL true //Lists all players friendly to you in ORBAT. Even if they are a different side.
    #define CLICKTOFIND false //Players can click on the group name to find the group on the map
    #define PERFECTINFO false //If true, clicking refresh removes dead players from group. Even if they have not been "found" or "reported" yet
    #define FINDFREQ true //Lets you click on any unit in ORBAT in order to see their currently used frequencies (TFAR ONLY SETTING)
    #define HIDEGROUPS [] //List of groups you can tell the ORBAT to hide no matter what

/////////////////////////
/// CHECKPOINT SYSTEM ///
////////////////////////


#define HIDEBODIES true //Controls when players respawn if their old body is removed from the game
#define CLEARBODIES true //Controls when players respawn, if their old bodies have all items (not assigned items) removed.

#define CHECKPOINTPOINTSYSTEM true //Enables checkpoint point system where players can call a checkpoint
#define INITIALPOINTAMOUNT 0 //Amount of checkpoint calls the players have at the start.
#define POINTSPAWN true //True: Use default method of checkpoint Array: array of objects that respawned players will spawn at.  Example: [sphere1,sphere2]
#define POINTGEAR "SAVED" //String to control point spawn gear. "":Do not override ArmA method "INIT": use starting gear "SAVED": Use gear on death
#define POINTPROTECTION 5 //Number: amount of spawn protection time

#define CALLCHECKPOINTPERMISSIONS 0 // 0: Everyone can call checkpoints 1: Squad leaders can call checkpoints 2: Only admin can

#define CHECKPOINTDEADONLY true //Allow only the dead to call checkpoints
#define SPECTATORCHECKPOINTSLEFT true // Allows dead players to see checkpoints left
#define SPECTATORCALLCHECKPOINTS true // Allows dead players to call a checkpoint

#define ANNOUNCEUSER true //Alert the entire server who pressed the call checkpoint button. Only tells current admin if set to false

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

//Note: When sleeping units are damaged, they will not react to the damage until they are "woken up" by distance.
#define DYNAMICSIMDISTANCEINFANTRY 750 //Approximate distance from enemy units before dynamic simulationn will put infantry to sleep
#define DYNAMICSIMDISTANCEVEHICLE 350 //Approximate distance from enemy units before dynamic simulationn will put active vehicle to sleep
#define DYNAMICSIMDISTANCEEMPTYVEHICLE 250 //Approximate distance from enemy units before dynamic simulationn will put empty vehicle to sleep
#define DYNAMICSIMDISTANCEPROP 50 //Approximate distance from all units before dynamic simulationn will put props to sleep

#define DYNAMICSIMMOVEMENTCOEF 2 //Doubles the activation distances listed above if the unit is currently moving

//NOTE: These two settings may override what you set in 3DEN if changed!
#define DYNAMICSIMAUTOADDUNITS false //Automatically adds all AI into dynamic simulation manager so you don't have to through 3DEN
#define DYNAMICSIMCANAIWAKE true //Controls if AI can wake up enemy units in their presence

////////////////////////
/// FIRETEAM MARKERS ///
////////////////////////

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

#define GRPTRACKERIGNOREACE false // By default, group trackers will not be created if ACE_MAP is detected. You can alter this behaviour by setting this to true

///////////
/// IFF ///
///////////
#define IFFDEFAULTTARGET 2 //Controls the targets for IFF. 0: none/off || 1: side only || 2: Anyone who is considered friendly
#define IFFMAXDISTANCE 1e10 //Max distance before IFF does not appear under any circumstances.
#define IFFMAXDISPLAYDISTANCE 100 //Max distance before nametag is no longer always displayed.
#define IFFPRECISETHRESHOLD 42 //At what distance past that point should the player need to be aiming *exactly* on the target to get a nametag to appear?
#define IFFNEEDGLASSES false //Requires player to have tactical glasses in order to see IFF

//////////////////
/// Mission AO ///
//////////////////

#define AOMARKERNAME "AO" //Hides area outside of marker area.

///////////////
/// NAMETAG ///
///////////////

#define NAMETAGDEFAULTTARGET 1 //Controls the initial targets for nametag. 0: none/off || 1: squad members || 2: all friendly players (Turn off IFF for #2)
#define NAMETAGMAXDISTANCE 1e10 //Max distance before nametag does not appear under any circumstances.
#define NAMETAGMAXDISPLAYDISTANCE 75 //Max distance before nametag is no longer always displayed.
#define NAMETAGPRECISETHRESHOLD 35 //At what distance past that point should the player need to be aiming *exactly* on the target to get a nametag to appear?
#define NAMETAGNEEDGLASSES false //Requires player to have tactical glasses in order to see nametags

/////////////////////////
/// CAMPAIGN SETTINGS ///
/////////////////////////

//NOTE: The mission must END in order to save. #missions does not count.

#define MISSIONPERSISTANCE false // Set to true to activate all parameters listed in this category

#define MISSIONKEY "" //The "key" that all missions within the same campaign must have. Case sensitive. Leave empty if you are not building a campaign
#define MISSIONINDEX -1 //Index of this mission within your campaign.

#define LOCKMISSION false //Will not allow the mission to open unless a mission with a previous index has been COMPLETED.
#define MUSTWIN false //Will only allow allow this mission to unlock if a mission in the previous index was a WIN. LOCKMISSION must also be true

#define SERVERCOMMANDPASSWORD "password" //This string must match the server command password of the server you want to use this campaign on

#define PERSISTENTPLAYERGEAR false //Player gear carries over to next mission. Setting must also be true in next mission
#define REFILLPARTIALMAGS true
#define SAVEARRAY [] //List variable names of objects you would like to be saved.

////////////////////////
/// RESPAWN SETTINGS ///
///////////////////////

//NOTE: Leave these settings like this if you plan to use the checkpoint system
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

//NOTE: This works, but isn't perfect. It relies on knowsAbout which can take time to update. There may be a delay before it actually reveals a unit
#define HIDEUNKNOWNENEMY false //hide enemy not yet seen by player side. objects already hidden at the time of death will not be checked

////////////////////////
/// Mission Teleport ///
///////////////////////
#define TELEOBJECT FOS_SafeFlag //Name of object that players use to teleport with
#define TELEBLACKLIST [[getPos player,100]] //Black list for mission teleport. Check BIS_fnc_getArea for syntax information
#define TELEMOVESQUAD true //Allows the Squad lead to move the entire squad at once. Restricts access to SL only.
#define TELESAFESTARTONLY false //Can only be accessed during safestart
#define TELEAFTERSAFESTART true //Allows SLs to mark where they want to be teleported once safe start is over. If safe start is off it just sends them there

//////////////////////
/// VANILLA REVIVE ///
//////////////////////

#define	REVIVEENABLED 1 // Vanilla revive (Always off if Ace_Medical detected)

/////////////////////
/// Misc settings ///
/////////////////////

#define LOADOUTARRAY [gar] //Add the variable names of units that you wish to overwrite units of the same class with with their current loadout (CBA REQUIRED)

#define FIXARSENALBUG true // Runs a fix that will resolve being unable to access AI inventory sometimes.
#define MESSAGEADMIN true //Controls if players can use the chat command #help to reach out to the admin. (CBA REQUIRED)
#define PMPERMISSIONS "adminlogged" //Controls who can use #PM command. Possible options are "all", "admin" or "adminLogged" (CBA REQUIRED)

#define FRIENDLYFIRETRACKER true //Tells the admin when a friendly hits a friendly
#define FRIENDLYKILLTRACKER true //Tells the admin when a friendly kills a friendly

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
#define CHECKPOINTSYSTEM false
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
