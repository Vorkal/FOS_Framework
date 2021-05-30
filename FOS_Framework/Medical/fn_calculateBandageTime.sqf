params [["_unit",player,[objNull]],["_coef",2,[123]],["_MedicSpeedCoef",3,[417]]];





_time = 0;
//take damage done and times it by coef to get bandage time
{_time = _time + _x * _coef} forEach getAllHitPointsDamage _unit # 2;

//Reduce time if medic
if (_unit getUnitTrait 'medic') then {_time = _time / _medicSpeedCoef};

if (_time <= 0) then { //Default
    _time = 8;
};

//Cap bandage time to 15 seconds max
_time = _time min 15;

_time
