params [["_unit",player,[objNull]],["_coef",2,[123]],["_MedicSpeedCoef",3,[417]]];

if (_unit getUnitTrait 'medic') then {_coef / _medicSpeedCoef};

_time = 0;
{_time = _time + _x * 2} forEach (getAllHitPointsDamage player # _coef);

if (_time == 0) then { //Default
    _time = 8;
};

_time
