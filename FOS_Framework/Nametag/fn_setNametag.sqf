//Do not draw if briefing variable has been swapped to false
//if (!FOS_nametag) exitWith {};

#include "..\..\settings.hpp"
if !(NAMETAG) exitWith {};

params ["_unit"];
private ["_color"];

//Make sure the unit is alive
if (alive _unit) then {
    _dist = (player distance _unit) / NAMETAGMAXDISPLAYDISTANCE;
    if (_dist > 1) then {_dist = 1};

    //Determine what color should be used based on assigned team
    _color = [_unit] call FOS_fnc_getTeamColor;

    //If the player is directly looking at nametag unit, change to opacity to 1
    _color set [3, 1 - _dist];
    if (_unit distance player < NAMETAGMAXDISTANCE) then {
        if (cursorTarget isEqualTo _unit && _unit distance player < NAMETAGPRECISETHRESHOLD) then {
            _color set [3, 1];
        };
        if (cursorObject isEqualTo _unit && _unit distance player > NAMETAGPRECISETHRESHOLD) then {
            _color set [3, 1];
        };
    };

    //resize the nametag based on distance
    _size = linearConversion [0,1,_dist,0.025,0.03,false];

    //Draw the actual icon
    drawIcon3D [
        '',
        _color,
        [
            visiblePosition _unit select 0,
            visiblePosition _unit select 1,
            (visiblePosition _unit select 2) +
            ((_unit modelToWorld (
                _unit selectionPosition 'head'
            )) select 2) + 0.4 + _dist / 1.5
        ],
        0,
        0,
        0,
        name _unit,
        0,
        _size,
        'PuristaLight'
    ];
};
