params ["_unit"];

//Current color for friendlies in game
_color = getArray (configFile/'CfgInGameUI'/'SideColors'/'colorFriendly');

//Find the distance and then scale the number down for use in controlling the alpha of icons
_dist = (player distance _unit) / 100;
if (_dist > 1) then {_dist = 1};


//Find the position that group indicators usually reside at.
_pos = _unit selectionPosition "Spine3";
_pos = _unit modelToWorldVisual _pos;

if (cursorTarget == _x) then {
    //Add a name above the IFF group hex if player is targeting them
    drawIcon3D [
        "",
        _color,
        _pos,
        1,
        -1.8,
        0,
        name _unit,
        2,
        0.025
    ];
    _headPos = _unit selectionPosition "Head";
    _headPos = _unit modelToWorldVisual _headPos;

    //Really complicated scaling and turning of the status indicator line. Pretend this looks cleaner.
    _scale = ((player distance _unit) * 0.25);
    if (player distance _unit <= 5) then {_scale = 5 * 0.25};
    _line1_start = _headPos;
    _line1_end = _line1_start vectorAdd [0,0, 0.30 * _scale];
    _line2_end = _headPos getPos [0.65 * _scale, (_unit getDir player) - 90];
    _line2_end set [2, (_unit selectionPosition "Head") # 2];
    _line2_end = _line2_end vectorAdd [0,0, 0.30 * _scale];
    //set variables for group icon
    _grpIco_Pos =  _headPos getPos [0.0495 *  _scale, (_unit getDir player) - 90];
    _grpIco_Pos set [2, (_unit selectionPosition "Head") # 2];
    _grpIco_Pos = _grpIco_Pos vectorAdd [0,0, 0.42 * _scale];

    //set variables for health icon
    _healthIco_Pos = _headPos getPos [0.25 * _scale, (_unit getDir player) - 90];
    _healthIco_Pos set [2, (_unit selectionPosition "Head") # 2];
    _healthIco_Pos = _healthIco_Pos vectorAdd [0,0, 0.42 * _scale];
    _healthIco_Info = linearConversion [0,1,damage _unit,100,0,true];
    //set variables for ammo icon
    _AmmoIco_Pos = _headPos getPos [0.40 * _scale, (_unit getDir player) - 90];
    _AmmoIco_Pos set [2, (_unit selectionPosition "Head") # 2];
    _AmmoIco_Pos = _AmmoIco_Pos vectorAdd [0,0, 0.42 * _scale];

    _oldAmmoAmount = 0;
    {
        _oldAmmoAmount = _oldAmmoAmount + ((configfile >> "CfgMagazines" >> _x >> "count") call BIS_fnc_getCfgData)
    } forEach ((configfile >> "CfgVehicles" >> typeOf _unit >> "magazines") call BIS_fnc_getCfgData);
    _ammoAmount = 0;
    if (count primaryWeaponMagazine _unit > 1) then {_ammoAmount = 1};
    {
        _ammoAmount = _ammoAmount + _x # 1
    } forEach (magazinesAmmo _unit + [["",_unit ammo primaryWeapon _unit]] + [["",_unit ammo secondaryWeapon _unit]] + [["",_unit ammo handgunWeapon _unit]]);

    _AmmoIco_Info = linearConversion [0,_oldAmmoAmount,_ammoAmount,0,100,false];
    //set variables for stamina icon
    _StaminaIco_Pos = _headPos getPos [0.55 * _scale, (_unit getDir player) - 90];
    _StaminaIco_Pos set [2, (_unit selectionPosition "Head") # 2];
    _StaminaIco_Pos = _StaminaIco_Pos vectorAdd [0,0, 0.42 * _scale];
    _staminaIco_Info = linearConversion [0,1,getFatigue _unit,100,0,true];
    //Find the current rank of unit in their group
    _rank = [_unit, "texture"] call BIS_fnc_rankParams;

    //Draw the lines and icons to show status
    drawLine3D [_line1_start, _line1_end, _color];
    drawLine3D [_line1_end, _line2_end, _color];
    drawIcon3D [_rank, _color, _grpIco_Pos, 0.75, 0.75, 0, groupID group _unit,0,0.03];
    drawIcon3D ["a3\ui_f\data\map\mapcontrol\hospital_ca.paa", _color, _healthIco_Pos,0.75, 0.75, 0,str round _healthIco_Info + "%"];
    drawIcon3D ["a3\missions_f_exp\data\img\classes\assault_ca.paa", _color, _AmmoIco_Pos, 0.75, 0.75, 0,str round _AmmoIco_Info + "%"];
    drawIcon3D ["a3\ui_f\data\igui\cfg\simpletasks\types\run_ca.paa", _color,_StaminaIco_Pos, 0.75, 0.75, 0, str round _staminaIco_Info + "%"];
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
