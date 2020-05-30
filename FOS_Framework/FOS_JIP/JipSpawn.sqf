/*
 * Name:	JipSpawn
 * Date:	7/24/2017
 * Version: 1.1
 * Author:  417
 *
 * Description:
 * Creates JIP menu for players to teleport when they come into game as a JIP.
 *
 */
private ["_index"];

//Uncomment if player does not spawn with itemRadio
// Give unit a radio if he did not have one already
//player linkItem "itemRadio";

//Create menu and then fill the menu list with data of every playable unit including AI controlled ones
createDialog "FOS_JipMenu";
{
_index = lbAdd [1500, (format ["%1",name _x])];
lbSetData [1500, _index,(format ["%1", _x])];
} foreach playableUnits;

player removeAction 0;