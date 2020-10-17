params [["_pos",[0,0,0]],["_units",allPlayers],["_distanceThreshold",50]];
private ["_canSee"];

//If object then convert to position
if (typeName _pos == "OBJECT") then {_pos = getpos _pos};

//Check if _pos parameter is a position or something else
if (typeName _pos == "ARRAY" && count _pos == 3) then {
    //Raise the _pos a little because grass can obscure the calculation
    private _posASL = (AGLToASL _pos) vectorAdd [0,0,1.5];
    //Find how many _units can see _pos or are close enough
    _canSee = _units select {_x distance _pos < _distanceThreshold || ([_x,"VIEW"] checkVisibility [eyePos _x, _posASL] > 0.5)};
} else {
    //Check 99 times for a position in the area that can be seen
    for "_i" from 0 to 99 do {
        //Convert area into a random position
        _randomPos = [_pos] call BIS_fnc_randomPosTrigger;

        private _posASL = (AGLToASL _randomPos) vectorAdd [0,0,1.5];

        _canSee = _units select {_x distance _randomPos < _distanceThreshold || ([_x,"VIEW"] checkVisibility [eyePos _x, _posASL] > 0.5)};

        if (count _canSee > 0) exitWith {true};
    };
};

if (count _canSee > 0) then {true} else {false};
