params [["_unit",player,[objNull]]];

_time = 0;
{_time = _time + _x * 2} forEach (getAllHitPointsDamage player # 2);

if (_time == 0) then { //Default
    _time = 8;
};

_time
