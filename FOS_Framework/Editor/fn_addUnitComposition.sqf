//if !(is3DEN) exitWith {};

params ["_amountOfSquads","_squadSize","_unitsPerFT"];
private ["_grp","_entity"];

//Use the location the camera is looking at as a reference
_pos = screenToWorld [0.5,0.5];

//Create composition to add playable units into
_id = -1 add3DENLayer "Player Composition";

//Run for each _amountOfSquads requested
for "_i" from 1 to _amountOfSquads do {
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
            _grp = nil;
        };
    };
};
