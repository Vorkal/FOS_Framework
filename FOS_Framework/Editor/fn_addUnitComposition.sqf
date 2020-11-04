//if !(is3DEN) exitWith {};

params ["_amountOfSquads","_squadType","_vehicles"];
private ["_side","_sidePrefix"];

//Use the location the camera is looking at as a reference
_pos = screenToWorld [0.5,0.5];

//Create composition to add playable units into
_id = -1 add3DENLayer "Player Composition";

_squadDictionary = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","India","Juliet","Kilo","Lima","Mike","November","Oscar","Papa","Quebec",
"Romeo","Sierra","Tango","Uniform","Victor","Whiskey","xray","Yankee","Zulu"];
_squadPrefixes = _squadDictionary apply {[_x,0,0] call BIS_fnc_trimString};
_side = west;
_sidePrefix = "B";

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
        group _entity set3DENAttribute ["Name", _sidePrefix + "_" + "CMD"];
    } else {
        _entity = group _entity create3DENEntity ["Object",_x # 0,_cmdPos vectorAdd [2.5,-5,0]];
    };
    _entity set3DENAttribute ["Name", _sidePrefix + _x # 1];
    _entity set3DENAttribute ["Init", _x # 2];
    _entity set3DENAttribute ["description","Command " + _x # 3];
    _entity set3DENAttribute ["ControlMP",true];

} forEach _cmdUnits # 0;

for "_i" from 0 to (_amountOfSquads - 1) do {
    _squadName = _squadDictionary # _i;
    _squadPrefix = _squadPrefixes # _i;
    switch (_squadType) do {
        //8 Man Squad | 1 FT
        case (0): {
            //Define the comp
            _FTComp = [
                [
                    [_sidePrefix + "_Soldier_SL_F","_SL","0 = this spawn {_this assignTeam 'MAIN'}", "Squad Lead"],
                    [_sidePrefix + "_medic_F","_M","0 = this spawn {_this assignTeam 'YELLOW'}", "Medic"],
                    [_sidePrefix + "_HeavyGunner_F","_MMG","0 = this spawn {_this assignTeam 'BLUE'}", "MMG"],
                    [_sidePrefix + "_Soldier_A_F","_AG","0 = this spawn {_this assignTeam 'BLUE'}", "Ammo bearer"],
                    [_sidePrefix + "_Soldier_TL_F","_TL","0 = this spawn {_this assignTeam 'RED'}", "Team lead"],
                    [_sidePrefix + "_soldier_AR_F","_AR","0 = this spawn {_this assignTeam 'RED'}", "Automatic Rifleman"],
                    [_sidePrefix + "_soldier_LAT_F","_AT","0 = this spawn {_this assignTeam 'RED'}", "Anti Tank"],
                    [_sidePrefix + "_Soldier_F","_R","0 = this spawn {_this assignTeam 'RED'}", "Rifleman"]
                ],
                ["B_MRAP_01_F","B_MRAP_01_F"]
            ];

            //Create FT units
            _entity = objNull;
            _ftPos = _pos;
            {
                if (_forEachIndex == 0) then {
                    //Create group leader
                    _entity = create3DENEntity ["Object",_x # 0,_ftPos];
                    //Assign group variable name
                    group _entity set3DENAttribute ["Name", _sidePrefix + "_" +  _squadName];
                } else {
                    //Find new position to place subordinate
                    _ftPos = _ftPos vectorAdd [0,-2.5,0];
                    //create subordinate
                    _entity = group _entity create3DENEntity ["Object",_x # 0,_ftPos];
                };
                //Assign variable name
                _entity set3DENAttribute ["Name", _sidePrefix + "_" +  _squadPrefix +  _x # 1];
                //Assign init code
                _entity set3DENAttribute ["Init", _x # 2];
                //Assign slot screen name
                _entity set3DENAttribute ["description",_squadName + " " + _x # 3];
                //Declare as playable
                _entity set3DENAttribute ["ControlMP",true];
            } forEach _FTComp # 0;

            //Create assigned vehicles
            _vehiclePos = _ftPos;
            _entity = objNull;
            {
                _entity = create3DENEntity ["Object",_x,_vehiclePos vectorAdd [3.5,-(-2.5 * count (_FTComp # 0)),0],true];
                _vehiclePos = _vehiclePos vectorAdd [0,-10,0];
                _entity set3DENAttribute ["Name", (_sidePrefix + "_" +  _squadPrefix + "_vehicle_" + str _forEachIndex)];
                _entity set3DENAttribute ["Init", "[this, units "+ _sidePrefix + "_" + _squadName + ",false] call FOS_fnc_fillAmmoContainer"];
                _entity set3DENAttribute ["ammoBox", ""];
            } forEach _FTComp # 1;

            _pos = _pos vectorAdd [7.5,0,0];
        };
        //14 Man Squad | 2 FT
        case (1): {
            //code
        };
        //14 Man Squad | 3 FT
        case (2): {
            //code
        };
    };

};

//Run for each _amountOfSquads requested
/* for "_i" from 1 to _amountOfSquads do {
    //_grp = createGroup west;
    switch (_squadSize) do {
        case (14): {
            switch (_unitsPerFT) do {
                case (4): {
                    {
                        if (isNil "_grp") then {
                            _entity = create3DENEntity ["Object",_x,_pos];
                            _grp = group _entity;
                            _entity set3DENAttribute ["ControlMP",true];
                            _pos = _pos vectorAdd [0,2.5,0];
                        } else {
                            _entity = _grp create3DENEntity ["Object",_x,_pos];
                            _entity set3DENAttribute ["ControlMP",true];
                            _pos = _pos vectorAdd [2.5,0,0];
                        };
                        _entity set3DENLayer _id;
                    } forEach ["B_Soldier_TL_F","B_soldier_AR_F","B_soldier_LAT_F","B_Soldier_F"];
                    _pos = _pos vectorAdd [-7.5,5,0];
                    _vehiclePos = _pos  vectorAdd [-5,-5,0];
                    create3DENEntity ["Object","B_MRAP_01_F",_vehiclePos,true];
                    _grp = nil;
                };
                case (6): {
                    //Check if this loop of the code is an even or odd number. used for alternating between AT teams or MG team
                    if (_i % 2 != 0) then {
                        {
                            if (isNil "_grp") then {
                                _entity = create3DENEntity ["Object",_x,_pos];
                                _grp = group _entity;
                                _entity set3DENAttribute ["ControlMP",true];
                                _pos = _pos vectorAdd [0,2.5,0];
                            } else {
                                _entity = _grp create3DENEntity ["Object",_x,_pos];
                                _entity set3DENAttribute ["ControlMP",true];
                                _pos = _pos vectorAdd [2.5,0,0];
                            };
                            _entity set3DENLayer _id;
                        } forEach ["B_Soldier_TL_F","B_soldier_AR_F","B_soldier_AAR_F","B_soldier_LAT_F","B_soldier_LAT_F","B_Soldier_F"];
                    } else {
                        {
                            if (isNil "_grp") then {
                                _entity = create3DENEntity ["Object",_x,_pos];
                                _grp = group _entity;
                                _entity set3DENAttribute ["ControlMP",true];
                                _pos = _pos vectorAdd [0,2.5,0];
                            } else {
                                _entity = _grp create3DENEntity ["Object",_x,_pos];
                                _entity set3DENAttribute ["ControlMP",true];
                                _pos = _pos vectorAdd [2.5,0,0];
                            };
                            _entity set3DENLayer _id;
                        } forEach ["B_Soldier_TL_F","B_soldier_AR_F","B_soldier_AAR_F","B_soldier_AR_F","B_soldier_AAR_F","B_Soldier_F"];
                    };
                    _pos = _pos vectorAdd [-12.5,5,0];
                    _grp = nil;
                    _vehiclePos = _pos vectorAdd [-5,-5,0];
                    create3DENEntity ["Object","B_LSV_01_unarmed_F",_vehiclePos,true];
                };
            };
        };
        case (8): {
            {
                if (isNil "_grp") then {
                    _entity = create3DENEntity ["Object",_x,_pos];
                    _grp = group _entity;
                    _entity set3DENAttribute ["ControlMP",true];
                    _pos = _pos vectorAdd [0,2.5,0];
                } else {
                    _entity = _grp create3DENEntity ["Object",_x,_pos];
                    _entity set3DENAttribute ["ControlMP",true];
                    _pos = _pos vectorAdd [2.5,0,0];
                };
                _entity set3DENLayer _id;
            } forEach ["B_Soldier_SL_F","B_medic_F","B_HeavyGunner_F","B_Soldier_A_F","B_Soldier_TL_F","B_soldier_AR_F","B_soldier_LAT_F","B_Soldier_F"];

            _pos = _pos vectorAdd [-17.5,5,0];

            _vehiclePos = _pos vectorAdd [-5,-5,0];
            for "_i" from 1 to 2 do {
                create3DENEntity ["Object","B_MRAP_01_F",_vehiclePos,true];
                _vehiclePos = _vehiclePos vectorAdd [-5,0,0];
            };
            _grp = nil;
        };
    };
}; */
