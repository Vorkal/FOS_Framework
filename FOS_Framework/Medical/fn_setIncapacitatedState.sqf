params [["_unit",player,[objnull]],["_state",true,[true,false]]];
private ["_animation"];

if !(_unit isEqualTo player) exitWith {};

if (_state) then {
    //Play PP effects for player
    ["INCAPACITATED",true] call FOS_fnc_medicalPPEffects;
    //Set variable
    _unit setVariable ["FOS_MedicalState","INCAPACITATED"];
    //Disable action menu
    _hudState = shownHud;
    _hudstate set [0,false];
    showHud _hudState;


    //Start ragdoll
    _unit setCaptive true;
    _unit setUnconscious true;

    //Wait until player rolls over
    waitUntil {animationState _unit isEqualTo "unconsciousrevivedefault"};


    //Find the most damaged part of body and play injured animation for it
    _list = ["hitface","hitneck","hithead","hitpelvis","hitabdomen","hitdiaphragm","hitchest","hitbody","hitarms","hithands","hitlegs","incapacitated"];
    _hitpointDamage = getAllHitPointsDamage _unit # 2;

    //Don't check 'incapacitated'. Almost always at 1 when killed
    _list = _list - ["incapacitated"];
    _hitpointDamage deleteAt 11;

    _highestDamageIndex = _hitpointDamage find (selectMax _hitpointDamage);

    //No damage detected. Select first index.
    if (_highestDamageIndex == -1) then {_highestDamageIndex = 0;};
    switch (toLower (_list # _highestDamageIndex)) do {

        //Head hit the most
        case "hitneck";
        case "hithead";
        case "hitface": {
            _animation = "UnconsciousReviveHead";
        };
        //Body hit the most
        case "hitabdomen";
        case "hitdiaphragm";
        case "hitchest";
        case "hitbody";
        case "hitpelvis": {
            _animation = "UnconsciousReviveBody";
        };
        //Hands hit the most
        case "hithands";
        case "hitarms": {
            _animation = "UnconsciousReviveArms";
        };
        //Legs hit the most
        case "hitlegs": {
            _animation = "UnconsciousReviveLegs";
        };
        //Just pick whatever
        default {
            _animation = selectRandom ["UnconsciousReviveHead","UnconsciousReviveBody","UnconsciousReviveArms","UnconsciousReviveLegs"];
        };
    };


    _unit switchMove _animation + "_Base";

    while {_unit getVariable ["FOS_MedicalState","HEALTHY"] isEqualTo "INCAPACITATED"} do {
        _timeStart = time;

        //Loop injury state
        _unit playMove (_animation + "_" + selectRandom ["A","B"]);
        _unit playMove (_animation + "_Base");

        waitUntil {time > _timeStart + 5 || _unit getVariable ["FOS_MedicalState","HEALTHY"] isNotEqualTo "INCAPACITATED"};
    };

    _unit switchMove "unconsciousrevivedefault";
    _unit playMove "unconsciousOutProne";
    _unit setUnconscious false;
    _unit setCaptive false;

    //Remove PP effect
    ["INCAPACITATED",false] call FOS_fnc_medicalPPEffects;
    //heal all damage
    _unit setDamage 0;
    //enable action menu
    _hudState = shownHud;
    _hudstate set [0,true];
    showHud _hudState;

} else {
    //Declare unit healthy
    _unit setVariable ["FOS_MedicalState","HEALTHY"];
};
