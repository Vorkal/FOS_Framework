params [["_difficulty",1]];


//// SERVER CODE
if (isServer && missionNamespace getVariable ["BIS_exp_camp_dynamicEnemySkill_init", false]) then {
	switch ( _difficulty) do
	{
		case 0:
		{
			[true,[[west,0.20,0.05,0.50,0.17],[east,0.20,0.05,0.50,0.17],[independent,0.20,0.05,0.50,0.17]]] call FOS_fnc_setDynamicSkill;
		};
		case 1:
		{
			[true,[[west,0.50,0.09,0.70,0.25],[east,0.50,0.09,0.70,0.25],[independent,0.50,0.09,0.70,0.25]]] call FOS_fnc_setDynamicSkill;
		};
		case 2:
		{
			[true,[[west,0.50,0.17,0.85,0.35],[east,0.50,0.17,0.85,0.35],[independent,0.50,0.17,0.85,0.35]]] call FOS_fnc_setDynamicSkill;
		};
		default
		{
			[true,[[west,0.50,0.09,0.70,0.25],[east,0.50,0.09,0.70,0.25],[independent,0.50,0.09,0.70,0.25]]] call FOS_fnc_setDynamicSkill;
		};
	};
};


//// CLIENT CODE
if (isPlayer player) then {
	switch (_difficulty) do
	{
		case 0:
		{
			//Damage reduction
			player addEventHandler ["HandleDamage", {
				params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
				_currentHealth = damage _unit;
				_newDamage = _currentHealth + (_damage * 0.25);
				_newDamage
			}];
		};
		case 1:
		{
			//Damage reduction
			player addEventHandler ["HandleDamage", {
				params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
				_currentHealth = damage _unit;
				_newDamage = _currentHealth + (_damage * 0.50);
				_newDamage
			}];
		};
		case 2:
		{

		};
		default
		{
			/* STATEMENT */
		};
	};
};
