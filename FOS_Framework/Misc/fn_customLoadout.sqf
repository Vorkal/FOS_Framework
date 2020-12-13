#include "..\..\settings.hpp";
if !(CUSTOMLOADOUT) exitWith {};

params ["_unit"];

_index = LOADOUTARRAY findif {(typeOf _unit) == typeOf _x};

if (_index != -1) then {
    _hostUnit = LOADOUTARRAY # _index;
    _unit setUnitLoadout (getUnitLoadout _hostUnit);
};
