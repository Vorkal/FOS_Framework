params ["_unit"];
_unit = player;
while {sleep 0.5;alive player} do {
    if ("ppn" in animationState _unit isEqualTo false) then { //Force player back to prone position if no prone animation detected
        player playAction "playerprone";
        //Get position of head
        //TODO: Change this to the actual selection of the head
        _headPos = getPosASL _unit vectorAdd [0,0,1.33];
        //Play sound of agony
        _hurtSound = format ["A3\sounds_f\characters\human-sfx\P0%1\Hit_Max_%2.wss", selectRandom [4,5,6,7,8,9], selectRandom [1,2,3,4,5]];
        playSound3D [_hurtSound, _unit, false,_headPos, 1.5, 1, 15];
        //Move lips 
        _unit setRandomLip true;
    } else {
        _unit setRandomLip false;
    };
};
