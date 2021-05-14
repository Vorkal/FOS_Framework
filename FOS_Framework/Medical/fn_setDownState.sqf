params [["_unit",player,[objnull]],["_state",true,[true,false]]];

if !(_unit isEqualTo player) exitWith {};

if (_state) then {
    if (_unit getVariable ["FOS_MedicalState","HEALTHY"] isEqualTo "DOWN") exitWith {};
    //Set variable
    _unit setVariable ["FOS_MedicalState","DOWN"];
    //Play PP effects for player
    ["DOWN",true] call FOS_fnc_medicalPPEffects;
    //Disable action menu
    _hudState = shownHud;
    _hudstate set [0,false];
    showHud _hudState;

    //Break the legs fully if they are not already broken
    player setHitPointDamage ["hitlegs",1];


    //Start ragdoll
    _unit setCaptive true;
    _unit setUnconscious true;

    //Wait until player rolls over
    waitUntil {animationState _unit isEqualTo "unconsciousrevivedefault"};
    //Wait until player is no longer injured or until player is healthy.
    waitUntil {_unit getVariable ["FOS_MedicalState","HEALTHY"] isNotEqualTo "DOWN" || inputAction "moveForward" isEqualTo 1};

    //Remove unconscious flag
    _unit setUnconscious false;

    //Wait until player starts rolling out of unconcious mode
    waitUntil {animationState _unit isEqualTo "unconsciousoutprone" || _unit getVariable ["FOS_MedicalState","HEALTHY"] isNotEqualTo "DOWN"};

    //Remove flag to keep player safe
    _unit setCaptive false;
    //Unconscious state exited
    waitUntil {animationState _unit isNotEqualTo "unconsciousoutprone" || _unit getVariable ["FOS_MedicalState","HEALTHY"] isNotEqualTo "DOWN"};

    while {alive _unit && _unit getVariable ["FOS_MedicalState","HEALTHY"] isEqualTo "DOWN"} do { //Player down or dead
        if ("ppn" in animationState _unit isEqualTo false && {inputAction _x isEqualTo 1} count ["moveForward","moveBackward","MoveLeft","moveRight"] > 0) then { //Force player back to prone position if no prone animation detected
            _unit playAction "playerprone";
            //Get position of head
            /* TODO: Change this to the actual selection of the head */
            _headPos = getPosASL _unit vectorAdd [0,0,1.33];
            //Play sound of agony
            _hurtSound = format ["A3\sounds_f\characters\human-sfx\P0%1\Hit_Max_%2.wss", selectRandom [4,5,6,7,8,9], selectRandom [1,2,3,4,5]];
            playSound3D [_hurtSound, _unit, false,_headPos, 1.5, 1, 15];
            systemChat "agony";
            //Move lips
            _unit setRandomLip true;
            sleep 0.5;
        } else {
            _unit setRandomLip false;
        };
    };

    ["DOWN",false] call FOS_fnc_medicalPPEffects;
} else {
    //Declare unit healthy
    _unit setVariable ["FOS_MedicalState","HEALTHY"];
    //Remove PP effect
    ["DOWN",false] call FOS_fnc_medicalPPEffects;
    //heal all damage
    _unit setDamage 0;
    //enable action menu
    _hudState = shownHud;
    _hudstate set [0,true];
    showHud _hudState;
};
