
_list = [];
{_list pushBack [_x,getPos _x]} forEach (call BIS_fnc_listPlayers);


while {sleep 1;FOS_Safemode} do {
    _index = _list findIf {_x # 0 distance _x # 1 > RESTRICTDISTANCE};
    if (_index != -1) then {
        _player = _list # _index # 0;
        _position = _list # _index # 1;
        _player setPosATL _position;
    };
};
