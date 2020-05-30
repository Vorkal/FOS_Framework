class FOS
{
	tag = "FOS";
	class functions
	{
		file = "FOS_Framework";
		class preInit {preInit = 1};
		class postInit {postInit = 1};
	};
	class AI
	{
		file = "FOS_Framework\FOS_AI";
		class spawnPatrol {};
		class spawnGarrison {};
		class spawnCamp {};
	}
	class AO
	{
		file = "FOS_Framework\FOS_AO";
		class missionAOInit {};
	};
	class briefing {
		file = "FOS_Framework\FOS_Briefing";
		class briefing {};
	}
	class Checkpoints
	{
		file = "FOS_Framework\FOS_Checkpoints";
		class checkpointSystemInit {};
		class checkpointSystem {};
		class checkpointPointsSystem {};
	};
	class Difficulty
	{
		file = "FOS_Framework\FOS_Difficulty";
		class setSkill {};
		class setDynamicSkill {};
		class difficultyInit {};
	};
	class FTMarkers
	{
		file = "FOS_Framework\FOS_FTMarkers";
		class FTMarkerInit {};
		class setFTMarker {};
	};
	class groupTracker
	{
		file = "FOS_Framework\FOS_groupTracker";
		class grpTrackerInit {};
		class setGrpTracker {};
	}
	class Spectator
	{
		file = "FOS_Framework\FOS_Spectator";
		class spectatorInit {};
	};
	class Misc
	{
		file = "FOS_Framework\FOS_Misc";
		class Bombardment {};
		class getAdmin {};
		class messageAdmin {};
		class sideDetectsPlayers {};
		class ambientRadio {};
	};
	class SafeStart
	{
		file = "FOS_Framework\FOS_SafeStart";
		class safeStartClientInit {};
		class safeStartServerInit {};
		class safeStartToggleClient {};
		class safeStartToggleServer {};
	};
	class Zeus
	{
		file = "FOS_Framework\FOS_Zeus";
		class zeusInit {};
	};
};
