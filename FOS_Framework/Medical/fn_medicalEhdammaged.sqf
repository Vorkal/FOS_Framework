params [["_unit",objNull,[objNull]]];

_unit addEventHandler ["Dammaged", {
	params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];
    systemChat str damage _unit;
}];
