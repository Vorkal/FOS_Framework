/*
Name: Zeus init
Description: initializes Zeus on a unit

*/

if (!isServer) exitWith {};

params [["_unit",objnull,[objnull]]];

//No unit given, exiting.
if (isNull _unit) exitWith {};
//Unit is not player, exiting
if (!isPlayer _unit) exitWith {};

//Create zeus unit
_curator = (createGroup sideLogic) createUnit ["ModuleCurator_F",[0,0,0] , [], 0, ""];

//assign the passed unit as curator
_unit assignCurator _curator;

//Add all objects
_curator addCuratorEditableObjects [(entities ""),true];

// Reduce costs for all actions
_curator setCuratorWaypointCost 0;
{_curator setCuratorCoef [_x,0];} forEach ["place","edit","delete","destroy","group","synchronize"];

//Return zeus object
_curator