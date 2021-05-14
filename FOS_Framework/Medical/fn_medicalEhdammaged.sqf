params [["_unit",objNull,[objNull]]];

_unit addEventHandler ["Dammaged", {
	params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];

	if (alive _unit && damage _unit >= 0.95 && _hitPoint == "incapacitated") then {

		_state = [_unit] call FOS_fnc_medicalCalculateState;
		switch (toUpper _state) do {
		    case ("DOWN"): {
				if (_unit getVariable ["FOS_MedicalState","HEALTHY"] isEqualTo "HEALTHY") then {
					[_unit] spawn FOS_fnc_setDownState;
				};
		    };
			default {
				if (_unit getVariable ["FOS_MedicalState","HEALTHY"] isEqualTo "HEALTHY") then {
					[_unit] spawn FOS_fnc_setDownState;
				};
			};
		};
	};
}];
