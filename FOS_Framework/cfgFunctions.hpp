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
		file = "FOS_Framework\AI";
		class spawnPatrol {};
		class spawnGarrison {};
		class spawnCamp {};
		class spawnDefend {};
	};
	class AO
	{
		file = "FOS_Framework\AO";
		class missionAOInit {};
	};
	class briefing {
		file = "FOS_Framework\Briefing";
		class briefing {};
		class orbatnotes {};
		class adminChecker {};
	};
	class Campaign {
		file = "FOS_Framework\Campaign";
		class saveCampaign {};
		class loadCampaign {};
		class assignCampaignObject {};
	};
	class Checkpoints
	{
		file = "FOS_Framework\Checkpoints";
		class checkpointSystem {};
		class checkpointPointsSystem {};
		class checkpointSystemOnKilled {};
		class checkpointSystemOnRespawn {};
	};
	class Debug
	{
		file = "FOS_Framework\Debug";
		class debugSystemAdd {};
		class debugSystemInit {};
		class debugSystemCopy {};
	};
	class Difficulty
	{
		file = "FOS_Framework\Difficulty";
		class setSkill {};
		class setDynamicSkill {};
		class difficultyInit {};
		class limitLootDrop {};
	};
	class FTMarkers
	{
		file = "FOS_Framework\FTMarkers";
		class FTMarkerInit {};
		class setFTMarker {};
	};
	class groupTracker
	{
		file = "FOS_Framework\groupTracker";
		class grpTrackerInit {};
		class setGrpTracker {};
	};
	class IFF
	{
		file = "FOS_Framework\IFF";
		class iffInit {};
		class setIFF {};
	};
	class Spectator
	{
		file = "FOS_Framework\Spectator";
		class spectatorOnRespawn {};
		class spectatorOnKilled {};
	};
	class medical
	{
		file = "FOS_Framework\Medical";
		class medicalInit {};
		class beginHeal {};
		class setDownState {};
		class setIncapacitatedState {};
		class beginHealOther {};
		class medicalEhHandleDamage {};
		class medicalEHdammaged {};
		class addHealAction {};
		class medicalCalculateState {};
		class medicalPPEffects {};
		class setUnconsciousState {};
		class calculateBandageTime {};
		class addStabilizeAction {};
		class addReviveAction {};
		class forceRevive {};
		class dragPlayer {};
		class draggedPLayer {};
		class addDragAction {};
		class addDropAction {};
	};
	class Misc
	{
		file = "FOS_Framework\Misc";
		class autogear {};
		class Bombardment {};
		class getAdmin {};
		class messageAdmin {};
		class sideDetectsPlayers {};
		class ambientRadio {};
		class protectedUnit {};
		class endMission {};
		class fillAmmoContainer {};
		class getRoleIcon {};
		class getTeamColor {};
		class customLoadout {};
		class canSee {};
		class tfarFindFrequency {};
		class pauseMissionServer {};
		class pauseMissionClient {};
		class addTeleportAction {};
		class dynamicEarplugs {};
	};
	class nametag {
		file = "FOS_Framework\Nametag"
		class nametagInit {};
		class setNametag {};
	};
	class SafeStart
	{
		file = "FOS_Framework\SafeStart";
		class safeStartClientInit {};
		class safeStartServerInit {};
		class safeStartToggleClient {};
		class safeStartToggleServer {};
		class safeStartRestrictZone {};
	};
	class Zeus
	{
		file = "FOS_Framework\Zeus";
		class zeusInit {};
		class zeusTracer {};
	};
};
