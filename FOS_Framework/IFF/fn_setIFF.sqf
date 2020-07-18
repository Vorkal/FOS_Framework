params ["_unit"];

_color = getArray (configFile/'CfgInGameUI'/'SideColors'/'colorFriendly');


_dist = (player distance _unit) / 100;
if (_dist > 1) then {_dist = 1};


_pos = _unit selectionPosition "Spine3";
_pos = _unit modelToWorldVisual _pos;

if (cursorTarget == _x) then {
    drawIcon3D [
        "",
        _color,
        _pos,
        1,
        -1.8,
        0,
        name _unit,
        0,
        0.025
    ];

    //TODO: MAKE ICONS TURN
    _scale = ((player distance _unit) * 0.25);
    _line1_start = _pos;
    _line1_end = _line1_start vectorAdd [0,0,0.60 * _scale];
    _line2_end = _unit getPos [1 * _scale, (_unit getDir player) - 90];
    _line2_end set [2, 1.22154 + 0.60 * _scale];

    //_line2_end = _line1_end vectorAdd [0,-1 * _scale,0];

    _grpIco =  _unit getPos [0.90 *  _scale, (_unit getDir player) - 90];

    _rank = [_unit, "texture"] call BIS_fnc_rankParams;
    drawLine3D [_line1_start, _line1_end, _color];
    drawLine3D [_line1_end, _line2_end, _color];
    drawIcon3D [_rank, _color, _line2_end vectorAdd [0,0.90 *  _scale,0.125 * _scale], 0.75, 0.75, 0, groupID group _unit];
    drawIcon3D ["a3\ui_f\data\map\mapcontrol\hospital_ca.paa", _color, _line2_end vectorAdd [0,0.5 * _scale,0.10 * _scale],0.75, 0.75, 0];
    drawIcon3D ["a3\missions_f_exp\data\img\classes\assault_ca.paa", _color, _line2_end vectorAdd [0,0.25 * _scale,0.10 * _scale], 0.75, 0.75, 0];
    drawIcon3D ["a3\ui_f\data\igui\cfg\simpletasks\types\run_ca.paa", _color, _line2_end vectorAdd [0,0 * _scale,0.10 * _scale], 0.75, 0.75, 0];
};
_color set [3,0.5 - _dist];
drawIcon3D [
    "a3\ui_f\data\igui\cfg\cursors\select_ca.paa",
    _color,
    _pos,
    1,
    1,
    0
];
