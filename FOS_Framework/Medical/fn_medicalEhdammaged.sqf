params [["_unit",objNull,[objNull]]];

_unit addEventHandler ["Dammaged", {
	params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];

	if (alive _unit && damage _unit >= 0.95 && _hitPoint == "incapacitated") then {

		_state = [_unit] call FOS_fnc_medicalCalculateState;
		switch (toUpper _state) do {
		    case ("DOWN"): {
				if (_unit getVariable ["FOS_MedicalState","HEALTHY"] isEqualTo "HEALTHY") then {
					[_unit] remoteExec ["FOS_fnc_setDownState",_unit];
				};
		    };
			case ("INCAPACITATED"): {
			   if (_unit getVariable ["FOS_MedicalState","HEALTHY"] isEqualTo "HEALTHY") then {
				   [_unit] remoteExec ["FOS_fnc_setIncapacitatedState",_unit];
			   };
		   };
		   case ("UNCONSCIOUS"): {
			  if (_unit getVariable ["FOS_MedicalState","HEALTHY"] isEqualTo "HEALTHY") then {
				  [_unit] remoteExec ["FOS_fnc_setUnconsciousState",_unit];
			  };
		  };
			default {
				if (_unit getVariable ["FOS_MedicalState","HEALTHY"] isEqualTo "HEALTHY") then {
					[_unit] remoteExec ["FOS_fnc_setDownState",_unit];
				};
			};
		};
	} else {
		_actionID = _unit getVariable ["FOS_fnc_healActionID",-1];
		if (_actionID != -1) then {
			[_unit,_actionID] call BIS_fnc_holdActionRemove;
		};
	    [_unit] remoteExecCall ["FOS_fnc_addHealAction",0];
	};
}];
