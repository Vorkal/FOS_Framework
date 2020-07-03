if (isDedicated) exitWith {};
params [["_mode",true]];



switch (_mode) do
{
	case true:
	{
		player setVariable ["FOS_SafetyMode",true];
		player allowDamage false;

		_safetyFired = player addEventHandler ["FiredMan", {
			params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
			if (_unit getVariable ["FOS_SafetyMode",true]) then {
				deletevehicle _projectile;
			} else {
				_unit removeEventHandler ["FiredMan",_thisEventHandler];
				player allowDamage true;
			};
		}];
	};
	case false;
	default
	{
		player setVariable ["FOS_SafetyMode",false];
		player allowDamage true;
	};
};
