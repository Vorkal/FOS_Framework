params [["_unit",objNull,[objNull]]];

_unit addEventHandler ["Dammaged", {
	params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];

	if (alive _unit && damage _unit >= 0.95 && _hitPoint == "incapacitated") then {

		systemChat str ([_unit] call FOS_fnc_medicalCalculateState);
	};
}];
