/*
Author: 417

Description: Get unit role icon

Parameters:
    _object (OBJECT): Unit being checked

Returns:
    STRING - image path
*/

params [
	["_object",objnull,[objnull]]
];

_picture = "a3\ui_f\data\map\vehicleicons\iconman_ca.paa";

//Check if squad leader
if (_object == leader _object) exitWith {"a3\ui_f\data\map\vehicleicons\iconmanleader_ca.paa"};
//Check if medic
if (_object getUnitTrait "Medic") exitWith {"a3\ui_f\data\map\vehicleicons\iconmanmedic_ca.paa"};
//check if engineer
if (_object getUnitTrait "Engineer") exitWith {"a3\ui_f\data\map\vehicleicons\iconmanengineer_ca.paa"};
//Check if demo specialist
if (_object getUnitTrait "explosiveSpecialist") exitWith {"a3\ui_f\data\map\vehicleicons\iconmanengineer_ca.paa"};
//Check if unit is unarmed
if (primaryWeapon _object == "" && secondaryWeapon _object == "" && handgunWeapon _object == "" && alive _object) exitWith {"a3\ui_f\data\map\vehicleicons\iconmanvirtual_ca.paa"};
//check if AT
if (getText (configfile >> "CfgVehicles" >> typeOf _object>> "icon") == "iconManAT") exitWith {"a3\ui_f\data\map\vehicleicons\iconmanmg_ca.paa"};
//check if MG
if (getText (configfile >> "CfgVehicles" >> typeOf _object>> "icon") == "iconManMG") exitWith {"a3\ui_f\data\map\vehicleicons\iconmanat_ca.paa"};
//Default return
"a3\ui_f\data\map\vehicleicons\iconman_ca.paa"
