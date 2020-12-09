
if (uiNamespace getVariable ["FOS_FirstLaunch", true]) then {
    systemChat "Welcome to the FOS Framework!";
    systemChat "Check out the Settings.hpp and briefing.sqf file for most configurable options";
};

uiNamespace setVariable ["FOS_FirstLaunch", false];

_FOSMissions = profileNameSpace getVariable ["FOS_MissionList",[]];

_index = _FOSMissions findIf {(missionName + "." + worldName) == _x};
//Only keep up with the last 25 missions
if (count _FOSMissions > 25) then {
    _FOSMissions deleteat 0;
};
_FOSMissions pushBackUnique (missionName + "." + worldName);
profilenamespace setVariable ["FOS_MissionList",_FOSMissions];

if (true) then {
    _emptyDisplay = findDisplay 313 createDisplay "RscDisplayEmpty";

    _backGround  = _emptyDisplay ctrlCreate ["RscBackground", -1];
    _backGround ctrlSetPosition [0.25,0.15,0.35,0.65];
    _backGround ctrlSetBackgroundColor [0,0,0,0.7];
    _backGround ctrlCommit 0;

    _headerText  = _emptyDisplay ctrlCreate ["RscText", -1];
    _headerText ctrlSetPosition [0.275,0.075,0.75,0.2];
    _headerText ctrlSetBackgroundColor [1,1,1,0];
    _headerText ctrlSetTextColor [1,1,1,1];
    _headerText ctrlSetText "FOS_Framework First time Setup!";
    _headerText ctrlCommit 0;

    _numberText  = _emptyDisplay ctrlCreate ["RscText", -1];
    _numberText ctrlSetPosition [0.31,0.125,0.75,0.2];
    _numberText ctrlSetBackgroundColor [1,1,1,0];
    _numberText ctrlSetTextColor [1,1,1,1];
    _numberText ctrlSetText "Enter amount of squads";
    _numberText ctrlCommit 0;

    _editBox = _emptyDisplay ctrlCreate ["RscEdit", 4171];
    _editBox ctrlSetPosition [0.32,0.25,0.20,0.05];
    _editBox ctrlSetBackgroundColor [0,0,0,0.7];
    _editBox ctrlSetTextColor [1,1,1,1];
    _editBox ctrlCommit 0;

    _listText  = _emptyDisplay ctrlCreate ["RscText", -1];
    _listText ctrlSetPosition [0.365,0.225,0.75,0.2];
    _listText ctrlSetBackgroundColor [1,1,1,0];
    _listText ctrlSetTextColor [1,1,1,1];
    _listText ctrlSetText "Squad Type";
    _listText ctrlCommit 0;

    _listBox = _emptyDisplay ctrlCreate ["RscListBox", 4172];
    //Do not question why the hell adding a space makes this menu align perfectly in game.
    _listBox lbAdd "8 Man Squad    | 1 FT";
    _listBox lbAdd "14 Man Squad  | 2 FT";
    _listBox lbAdd "14 Man Squad  | 3 FT";
    _listBox ctrlSetPosition [0.32,0.35,0.20,0.125];
    _listBox ctrlCommit 0;

    _listSideText  = _emptyDisplay ctrlCreate ["RscText", -1];
    _listSideText ctrlSetPosition [0.365,0.40,0.75,0.2];
    _listSideText ctrlSetBackgroundColor [1,1,1,0];
    _listSideText ctrlSetTextColor [1,1,1,1];
    _listSideText ctrlSetText "Squad Side";
    _listSideText ctrlCommit 0;

    _listSideBox = _emptyDisplay ctrlCreate ["RscListBox", 4173];
    _listSideBox lbAdd "West";
    _listSideBox lbAdd "East";
    _listSideBox lbAdd "Independent";
    _listSideBox ctrlSetPosition [0.32,0.52,0.20,0.125];
    _listSideBox ctrlCommit 0;

    _okButton = _emptyDisplay ctrlCreate ["RscButton", -1];
    _okButton ctrlSetText "Create";
    _okButton ctrlSetPosition [0.32,0.655,0.20,0.125];
    _okButton ctrlCommit 0;

    uiNamespace setVariable ["FOS_FTS_Edit", _editBox];
    uiNamespace setVariable ["FOS_FTS_List", _listBox];
    uiNamespace setVariable ["FOS_FTS_ListSide", _listSideBox];

    //functions don't appear to compile on first run in 3den So the my whole function has to be shoved into this event handler
    _okButton ctrladdEventHandler ["ButtonClick",{
        params ["_ctrl"];
        private ["_side","_sidePrefix","_amountOfSquads","_squadType"];
        if !(is3DEN) exitWith {};
        _display = ctrlParent _ctrl;
        _amountOfSquads = parseNumber ctrlText (uiNamespace getVariable ["FOS_FTS_Edit",2]);
        _squadType = lbCurSel (uiNamespace getVariable ["FOS_FTS_List",1]);
        _squadSide = lbCurSel (uiNamespace getVariable ["FOS_FTS_ListSide",0]);

        if (_amountOfSquads == 0) exitWith {};

        //Use the location the camera is looking at as a reference
        _pos = screenToWorld [0.5,0.5];

        //Create composition to add playable units into
        _id = -1 add3DENLayer "Player Composition";

        _squadDictionary = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","India","Juliet","Kilo","Lima","Mike","November","Oscar","Papa","Quebec",
        "Romeo","Sierra","Tango","Uniform","Victor","Whiskey","xray","Yankee","Zulu"];
        _squadPrefixes = _squadDictionary apply {[_x,0,0] call BIS_fnc_trimString};
        //Switch the unit type that appears based on mission maker choice
        switch (_squadSide) do {
            case (0): {
                _side = west;
                _sidePrefix = "B";
            };
            case (1): {
                _side = east;
                _sidePrefix = "O";
            };
            case (2): {
                _side = independent;
                _sidePrefix = "I";
            };
            default {
                _side = west;
                _sidePrefix = "B";
            };
        };
        //Create FT units
        _createFT = {
            _entity = objNull;
            _ftPos = _pos;
            {
                //Exception handler
                _unitClass = _x # 0;
                if (_unitClass isEqualTo "I_HeavyGunner_F") then { //Vanilla Independent don't have an MMG
                    _unitClass = "I_soldier_AR_F";
                };

                if (_forEachIndex == 0) then {
                    //Create group leader
                    _entity = create3DENEntity ["Object",_unitClass,_ftPos];
                    _entity set3DENLayer _id;
                    //Assign group variable name
                    group _entity set3DENAttribute ["Name", _sidePrefix + "_" +  _squadPrefix + _x # 4];
                    group _entity set3DENAttribute ["groupID", _squadName + _x # 5];
                } else {
                    //Find new position to place subordinate
                    _ftPos = _ftPos vectorAdd [0,-2.5,0];
                    //create subordinate
                    _entity = group _entity create3DENEntity ["Object",_unitClass,_ftPos];
                };
                //Assign variable name
                _entity set3DENAttribute ["Name", _sidePrefix + "_" +  _squadPrefix + _x # 4 +  _x # 1];
                //Assign init code
                _entity set3DENAttribute ["Init", _x # 2];
                //Assign slot screen name
                _entity set3DENAttribute ["description",_squadName + _x # 4 + " " + _x # 3];
                //Declare as playable
                _entity set3DENAttribute ["ControlMP",true];
            } forEach _this # 0;

            //Create assigned vehicles
            _vehiclePos = _ftPos;
            _entity = objNull;
            {
                //Create vehicle
                _entity = create3DENEntity ["Object",_x,_vehiclePos vectorAdd [3.5,-(-2.5 * count (_this # 0)),0],true];
                _entity set3DENLayer _id;
                //Move the position down for the next vehicle spawn
                _vehiclePos = _vehiclePos vectorAdd [0,-10,0];
                //Variable name for vehicle
                _entity set3DENAttribute ["Name", (_sidePrefix + "_" +  _squadPrefix + _this # 0 # 0 # 4 + "_vehicle_" + str _forEachIndex)];
                //Make this vehicle a refill point for the assigned group
                _entity set3DENAttribute ["Init", "[this, units "+ _sidePrefix + "_" + _squadPrefix + _this # 0 # 0 # 4 + ",false] call FOS_fnc_fillAmmoContainer"];
                //Remove gear already in the cargo
                _entity set3DENAttribute ["ammoBox", ""];
            } forEach _this # 1;

            //_pos = _pos vectorAdd [7.5,0,0];
        };

        _cmdUnits = [
            [
                [_sidePrefix + "_officer_F","_CMD_CO","0 = this spawn {_this assignTeam 'MAIN'}","CO"],
                [_sidePrefix + "_medic_F","_CMD_Medic","0 = this spawn {_this assignTeam 'YELLOW'}","Medic"]
            ],
            ["B_Quadbike_01_F"]
        ];

        //Create CMD units
        _cmdPos = _pos vectorAdd [0,35,0];
        _entity = objNull;
        {
            if (_forEachIndex == 0) then {
                _entity = create3DENEntity ["Object",_x # 0,_cmdPos];
                _entity set3DENLayer _id;
                group _entity set3DENAttribute ["Name", _sidePrefix + "_" + "CMD"];
                group _entity set3DENAttribute ["groupID", "Command"];
            } else {
                _entity = group _entity create3DENEntity ["Object",_x # 0,_cmdPos vectorAdd [2.5,-5,0]];
            };
            _entity set3DENAttribute ["Name", _sidePrefix + _x # 1];
            _entity set3DENAttribute ["Init", _x # 2];
            _entity set3DENAttribute ["description","Command " + _x # 3];
            _entity set3DENAttribute ["ControlMP",true];
        } forEach _cmdUnits # 0;

        for "_i" from 0 to (_amountOfSquads - 1) do {
            if (_i > 26) exitWith {};
            _squadName = _squadDictionary # _i;
            _squadPrefix = _squadPrefixes # _i;
            switch (_squadType) do {
                //8 Man Squad | 1 FT
                case (0): {
                    //Define the comp
                    _FTComp = [
                        [
                            //[objecttype,unitNameSuffix,initCode,Role Description,groupindex,groupID]
                            [_sidePrefix + "_Soldier_SL_F","_SL","0 = this spawn {_this assignTeam 'MAIN'}", "Squad Lead","",""],
                            [_sidePrefix + "_medic_F","_M","0 = this spawn {_this assignTeam 'YELLOW'}", "Medic","",""],
                            [_sidePrefix + "_HeavyGunner_F","_MMG","0 = this spawn {_this assignTeam 'BLUE'}", "MMG","",""],
                            [_sidePrefix + "_Soldier_A_F","_AG","0 = this spawn {_this assignTeam 'BLUE'}", "Ammo bearer","",""],
                            [_sidePrefix + "_Soldier_TL_F","_TL","0 = this spawn {_this assignTeam 'RED'}", "Team lead","",""],
                            [_sidePrefix + "_soldier_AR_F","_AR","0 = this spawn {_this assignTeam 'RED'}", "Automatic Rifleman","",""],
                            [_sidePrefix + "_soldier_LAT_F","_AT","0 = this spawn {_this assignTeam 'RED'}", "Anti Tank","",""],
                            [_sidePrefix + "_Soldier_F","_R","0 = this spawn {_this assignTeam 'RED'}", "Rifleman","",""]
                        ],
                        ["B_MRAP_01_F","B_MRAP_01_F"]
                    ];
                    _FTComp call _createFT;
                    _pos = _pos vectorAdd [7.5,0,0];
                };
                //14 Man Squad | 2 FT
                case (1): {
                    //Define the comp
                    _SLComp = [
                        [
                            [_sidePrefix + "_Soldier_SL_F","_SL","0 = this spawn {_this assignTeam 'MAIN'}", "Squad Lead","","_SL"],
                            [_sidePrefix + "_medic_F","_M","0 = this spawn {_this assignTeam 'YELLOW'}", "Medic","",""]
                        ],
                        ["B_MRAP_01_F"]
                    ];
                    _FT1Comp = [
                        [
                            [_sidePrefix + "_Soldier_TL_F","_TL","0 = this spawn {_this assignTeam 'MAIN'}", "Team Lead","1","_FT1"],
                            [_sidePrefix + "_soldier_AR_F","_AR","0 = this spawn {_this assignTeam 'RED'}", "Automatic Rifleman","1",""],
                            [_sidePrefix + "_soldier_AAR_F","_AAR","0 = this spawn {_this assignTeam 'RED'}", "Asst. Automatic Rifleman","1",""],
                            [_sidePrefix + "_soldier_LAT_F","_AT1","0 = this spawn {_this assignTeam 'GREEN'}", "Rifleman AT","1",""],
                            [_sidePrefix + "_soldier_LAT_F","_AT2","0 = this spawn {_this assignTeam 'GREEN'}", "Rifleman AT","1",""],
                            [_sidePrefix + "_Soldier_F","_R","0 = this spawn {_this assignTeam 'GREEN'}", "Rifleman","1",""]
                        ],
                        ["B_LSV_01_unarmed_F"]
                    ];
                    _FT2Comp = [
                        [
                            [_sidePrefix + "_Soldier_TL_F","_TL","0 = this spawn {_this assignTeam 'MAIN'}", "Team Lead","2","_FT2"],
                            [_sidePrefix + "_soldier_AR_F","_AR1","0 = this spawn {_this assignTeam 'BLUE'}", "Automatic Rifleman","2",""],
                            [_sidePrefix + "_soldier_AAR_F","_AAR1","0 = this spawn {_this assignTeam 'BLUE'}", "Asst. Automatic Rifleman","2",""],
                            [_sidePrefix + "_soldier_AR_F","_AR2","0 = this spawn {_this assignTeam 'YELLOW'}", "Automatic Rifleman","2",""],
                            [_sidePrefix + "_soldier_AAR_F","_AAR2","0 = this spawn {_this assignTeam 'YELLOW'}", "Asst. Automatic Rifleman","2",""],
                            [_sidePrefix + "_Soldier_F","_R","0 = this spawn {_this assignTeam 'YELLOW'}", "Rifleman","2",""]
                        ],
                        ["B_LSV_01_unarmed_F"]
                    ];
                    //Spawn the comp and adjust the spawn placement each time.
                    _SLComp call _createFT;
                    _pos = _pos vectorAdd [-7.5,-7.5,0];
                    _FT1Comp call _createFT;
                    _pos = _pos vectorAdd [11.5,0,0];
                    _FT2Comp call _createFT;
                    _pos = _pos vectorAdd [-7.5,-20,0];
                };
                //14 Man Squad | 3 FT
                case (2): {
                    //Define the comp
                    _SLComp = [
                        [
                            [_sidePrefix + "_Soldier_SL_F","_SL","0 = this spawn {_this assignTeam 'MAIN'}", "Squad Lead","","_SL"],
                            [_sidePrefix + "_medic_F","_M","0 = this spawn {_this assignTeam 'YELLOW'}", "Medic","",""]
                        ],
                        ["B_MRAP_01_F"]
                    ];
                    _FT1Comp = [
                        [
                            [_sidePrefix + "_Soldier_TL_F","_TL","0 = this spawn {_this assignTeam 'MAIN'}", "Team Lead","1","_FT1"],
                            [_sidePrefix + "_soldier_AR_F","_AR","0 = this spawn {_this assignTeam 'BLUE'}", "Automatic Rifleman","1",""],
                            [_sidePrefix + "_soldier_LAT_F","_AT","0 = this spawn {_this assignTeam 'RED'}", "Rifleman AT","1",""],
                            [_sidePrefix + "_soldier_GL_F","_G","0 = this spawn {_this assignTeam 'GREEN'}", "Grenadier","1",""]
                        ],
                        ["B_MRAP_01_F"]
                    ];
                    _FT2Comp = [
                        [
                            [_sidePrefix + "_Soldier_TL_F","_TL","0 = this spawn {_this assignTeam 'MAIN'}", "Team Lead","2","_FT2"],
                            [_sidePrefix + "_soldier_AR_F","_AR","0 = this spawn {_this assignTeam 'BLUE'}", "Automatic Rifleman","2",""],
                            [_sidePrefix + "_soldier_LAT_F","_AT","0 = this spawn {_this assignTeam 'RED'}", "Rifleman AT","2",""],
                            [_sidePrefix + "_soldier_GL_F","_G","0 = this spawn {_this assignTeam 'GREEN'}", "Grenadier","2",""]
                        ],
                        ["B_MRAP_01_F"]
                    ];
                    _FT3Comp = [
                        [
                            [_sidePrefix + "_Soldier_TL_F","_TL","0 = this spawn {_this assignTeam 'MAIN'}", "Team Lead","3","_FT3"],
                            [_sidePrefix + "_soldier_AR_F","_AR","0 = this spawn {_this assignTeam 'BLUE'}", "Automatic Rifleman","3",""],
                            [_sidePrefix + "_soldier_LAT_F","_AT","0 = this spawn {_this assignTeam 'RED'}", "Rifleman AT","3",""],
                            [_sidePrefix + "_soldier_GL_F","_G","0 = this spawn {_this assignTeam 'GREEN'}", "Grenadier","3",""]
                        ],
                        ["B_MRAP_01_F"]
                    ];
                    //Spawn the comp and adjust the spawn placement each time.
                    _SLComp call _createFT;
                    _pos = _pos vectorAdd [-7.5,-7.5,0];
                    _FT1Comp call _createFT;
                    _pos = _pos vectorAdd [11.5,0,0];
                    _FT2Comp call _createFT;
                    _pos = _pos vectorAdd [11.5,0,0];
                    _FT3Comp call _createFT;
                    _pos = _pos vectorAdd [-15.5,-20,0];
                };
            };
        };
        _display closeDisplay 1;
    }];
};
