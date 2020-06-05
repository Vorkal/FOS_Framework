/*
Author: 417

Description: Makes a unit impervious to all damage EXCEPT player caused damage.
NOTE: This will only work if this function is called where the unit is LOCAL
So... just run it on everywhere. That way it will trigger no matter what

Parameters:
_object (OBJECT): The object you wish to be the radio

Example:
[this] call FOS_fnc_protectedUnit;
*/


this addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
  if (isPlayer _instigator) then {
    _damage
  } else {
    _damage = 0;
  };

  _damage
}];
