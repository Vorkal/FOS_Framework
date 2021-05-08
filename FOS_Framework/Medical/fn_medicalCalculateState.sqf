params ["_unit"];


_armDamage = (_unit getHitPointDamage "hithands") + (_unit getHitPointDamage "hitarms");
_legDamage = _unit getHitPointDamage "hitlegs";
_bodyDamage = _unit getHitPointDamage "hitBody";
_headDamage = _unit getHitPointDamage "hitHead";


if (_headDamage > 0.50) exitWith {"UNCONSCIOUS"};
if (_bodyDamage > 0.50) exitWith {"INCAPACITATED"};
if (_armDamage > 0.25) exitWith {"INCAPACITATED"};
if (_legDamage > 0) exitWith {"DOWN"};

//Default return
"DOWN";
