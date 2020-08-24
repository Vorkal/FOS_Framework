/*
Author: 417

Description: Fill an ammo container with all ammo and weapons that players currently have. Or their starting gear
    NOTE: Run this everywhere. It will only execute where the container is local.
Parameters:
_container (OBJECT): The cargo space that the ammo will be added to.
_players (ARRAY): list of players that will have their equipment added to the container
_initialgear (BOOLEAN): true adds the player's classname based gear to the box. Default is false
    NOTE:   If the checkpoint system is active, then the initial gear will be the player's actual starting gear.
    Not just class based.
Example:
[ammoBox,allPlayers,false] call FOS_fnc_fillAmmoContainer;
*/

//TODO: Return value when process succeeds

params [["_container",objNull,[objnull]],["_players",allPlayers,[[objNull,objnull]]],["_initialgear",false,[true,false]]];

//Run this only on the machine that owns the container
if !(local _container) exitWith {};

{
    _unit = _x;
    if (_initialgear) then {
        _loadout = _unit getVariable "FOS_InitPlayerloadout";
        if (isNil "_loadout") then {
            _initWeapons = (configfile >> "CfgVehicles" >> typeOf _unit >> "respawnWeapons") call BIS_fnc_getCfgData;
            //Remove throw and put from the list of wepaons added. They cause an error
            _initWeapons = _initWeapons - ["Throw","Put"];
            {_container addWeaponCargoGlobal [_x, 1]} foreach _initWeapons;

            //Grab the magazine amount from unit's config file
            _initMagazines = ((configfile >> "CfgVehicles" >> typeOf _unit >> "magazines") call BIS_fnc_getCfgData);
            //Find all unique ammo
            _items = [];
            {_items pushBackUnique _x} forEach _initMagazines;
            //add it 10 times into the container
            {_container addMagazineCargoGlobal [_x, 10]} forEach _items;
        } else {

            for "_i" from 0 to 2 do {
                if (count (_loadout # _i) == 0) exitWith {};
                _container addWeaponWithAttachmentsCargoGlobal [(_loadout # _i),1];
            };
            //Find all unique ammo
            _items = [];
            {_items pushBackUnique (_x # 0)} forEach (_loadout) # 4 # 1;
            //add it 10 times into the container
            {_container addMagazineCargoGlobal [_x, 10]} forEach _items;
        };
    } else {

        for "_i" from 0 to 2 do {
            if (count (_loadout # _i) == 0) exitWith {};
            _container addWeaponWithAttachmentsCargoGlobal [(getUnitLoadout _unit # _i),1];
        };
        //Find all unique ammo
        _items = [];
        {_items pushBackUnique _x} forEach (magazines _unit);
        //add it 10 times into the container
        {_container addMagazineCargoGlobal [_x, 10]} forEach _items;
    };
} forEach _players;
