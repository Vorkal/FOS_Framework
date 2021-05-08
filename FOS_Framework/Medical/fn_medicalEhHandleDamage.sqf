params [["_unit",objNull,[objNull]]];

_unit addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

    //ignore damage under the threshold
    if (_damage < 0.1) exitWith {0};
	
    if (alive _unit) then { //Unit shot is still alive
        _damage = _damage min 0.95
    };
    _damage
}];
