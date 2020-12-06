#define PERSISTENTPLAYERGEAR false
#define REFILLPARTIALMAGS true

#include "..\..\settings.hpp"
if !(CAMPAIGNSYSTEM) exitWith {};

_campaignList = profileNameSpace getVariable ["FOS_CAMPAIGNDATA",[]];

if (MISSIONINDEX == 0) exitWith {};

//Find the data of the correct mission
_previousCampaignIndex = _campaignList findIf {_x # 0 # 0 == MISSIONKEY && _x # 0 # 1 == (MISSIONINDEX - 1)};

_campaignData = _campaignList # _previousCampaignIndex;


/*
    PLAYER LOADOUTS
*/

//load player loadouts
_loadouts = _campaignData # 1;
{
	//Find unique ID and index in the array
	_playerID = getPlayerUID _x;
    _playerIndex = _loadouts findIf {_x # 0 == _playerID};

    //Assign gear
    if (_playerIndex != -1) then {
        _x setUnitLoadout [_loadouts # _playerIndex # 1,REFILLPARTIALMAGS]
    };
} forEach (call BIS_fnc_listPlayers);

/*
    OBJECT DATA
*/

//load object data
_objectData = _campaignData # 2;
//Get all objects in current mission
_allObjects = entities "";
{
    //String of current object
    _currentObjectName = _x # 0;
    //Find if string matches string name of any other object
    _index = _allObjects findIf {_currentObjectName == str _x};

    if (_index != -1) then {
        _object = _allObjects # _index;

        //

        //Load hit points
        _hitPointData = _x # 1;
        //Mortars don't have hitpoint data
        if !(_hitPointData isEqualTo []) then {
            _object setDamage [_x # 7,false];
            _hitPointNames = _hitPointData # 0;
            _hitPointDamage = _hitPointData # 2;
            {_object setHitPointDamage [_x, _hitPointData # 2 # _forEachIndex, false]} forEach _hitPointNames;
        } else {
            _object setDamage [_x # 7,false];
        };
        //Load fuel
        _object setFuel _x # 2;
        //Load fuel cargo
        _object setFuelCargo _x # 3;
        //Load magazines
        _object setVehicleAmmo 0;
        {_object addMagazineTurret [_x # 0,_x # 1,_x # 2]}foreach _x # 4;
        //Load ammo cargo
        _object setAmmoCargo _x # 5;
        //clear current cargo
        clearWeaponCargoGlobal _object;
        clearMagazineCargoGlobal _object;
        clearBackpackCargoGlobal _object;
        clearItemCargoGlobal _object;
        //Weapon cargo
        _weaponData = _x # 6 # 0;
        if !(_weaponData isEqualTo [[],[]]) then {
            {_object addWeaponCargoGlobal [_x, _weaponData # 1 # _forEachIndex]} forEach _weaponData # 0;
        };
        //magazine cargo
        _magazineData = _x # 6 # 1;
        if !(_magazineData isEqualTo [[],[]]) then {
            {_object addmagazineCargoGlobal [_x, _magazineData # 1 # _forEachIndex]} forEach _magazineData # 0;
        };
        //Backpack cargo
        _backpackData = _x # 6 # 2;
        if !(_backpackData isEqualTo [[],[]]) then {
            {_object addBackpackCargoGlobal [_x, _backpackData # 1 # _forEachIndex]} forEach _backpackData # 0;
        };
        //Item cargo
        _itemData = _x # 6 # 2;
        if !(_itemData isEqualTo [[],[]]) then {
            {_object additemCargoGlobal [_x, _itemData # 1 # _forEachIndex]} forEach _itemData # 0;
        };
    };
} forEach _objectData;
