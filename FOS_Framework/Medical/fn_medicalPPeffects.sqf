params [["_type","Down",["String"]],["_mode",true,[false]]];
private ["_redPP","_blurPP"];

switch (toLower _type) do {
    case (toLower "Down"): {
        if (_mode) then {
            if (isNil {missionNameSpace getVariable ["FOS_Medical_whitePP",nil]}) then { //Make sure this is not already active
                _whitePP = ppEffectCreate ["colorCorrections", 1502];
                _whitePP ppEffectEnable true;
                _whitePP ppEffectAdjust [1.0, 1.0, 0.0, [1, 1, 1, 0.65], [0.0, 1.0, 1.0, 1.0], [0.199, 0.587, 0.114, 0.0],[0.50,0.25,1,0,0,0.5,0.745]];
                _whitePP ppEffectCommit 0.25;
                //Store handler
                missionNameSpace setVariable ["FOS_Medical_whitePP",_whitePP];
            };
            if (isNil {missionNameSpace getVariable ["FOS_Medical_blurPP",nil]}) then { //Make sure this is not already active
                _blurPP = ppEffectCreate ["RadialBlur", 255];
                _blurPP ppEffectEnable true;
                _blurPP ppEffectAdjust [0.0125, 0.0125, 0.5, 0.1];
                _blurPP ppEffectCommit 0.25;
                //Store handler
                missionNameSpace setVariable ["FOS_Medical_blurPP",_blurPP];
            };
        } else {
            //Destroy previous PP effect
            _redPP = missionNameSpace getVariable ["FOS_Medical_whitePP",nil];
            _blurPP = missionNameSpace getVariable ["FOS_Medical_blurPP",nil];
            if !(isNil "_redPP") then {ppEffectDestroy _redPP};
            if !(isNil "_blurPP") then {ppEffectDestroy _blurPP};
            //Wipe handler from variable
            missionNameSpace setVariable ["FOS_Medical_whitePP",nil];
            missionNameSpace setVariable ["FOS_Medical_blurPP",nil];
        };
    };
    case (toLower "incapacitated"): {
        if (_mode) then {
            if (isNil {missionNameSpace getVariable ["FOS_Medical_RedPP",nil]}) then { //Make sure this is not already active
                _redPP = ppEffectCreate ["colorCorrections", 1502];
                _redPP ppEffectEnable true;
                _redPP ppEffectAdjust [1.0, 1.0, 0.0, [0.745, 0, 0, 0.5], [0.0, 1.0, 1.0, 1.0], [0.199, 0.587, 0.114, 0.0],[0.50,0.25,1,0,0,0.5,0.745]];
                _redPP ppEffectCommit 0.25;
                //Store handler
                missionNameSpace setVariable ["FOS_Medical_RedPP",_redPP];
            };
            if (isNil {missionNameSpace getVariable ["FOS_Medical_blurPP",nil]}) then { //Make sure this is not already active
                _blurPP = ppEffectCreate ["RadialBlur", 255];
                _blurPP ppEffectEnable true;
                _blurPP ppEffectAdjust [0.0125, 0.0125, 0.5, 0.1];
                _blurPP ppEffectCommit 0.25;
                //Store handler
                missionNameSpace setVariable ["FOS_Medical_blurPP",_blurPP];
            };
        } else {
            //Destroy previous PP effect
            _redPP = missionNameSpace getVariable ["FOS_Medical_RedPP",nil];
            _blurPP = missionNameSpace getVariable ["FOS_Medical_blurPP",nil];
            if !(isNil "_redPP") then {ppEffectDestroy _redPP};
            if !(isNil "_blurPP") then {ppEffectDestroy _blurPP};
            //Wipe handler from variable
            missionNameSpace setVariable ["FOS_Medical_RedPP",nil];
            missionNameSpace setVariable ["FOS_Medical_blurPP",nil];
        };
    };
    case (toLower "unconscious"): {
        if (_mode) then {
            if (isNil {missionNameSpace getVariable ["FOS_Medical_BlackPP",nil]}) then { //Make sure this is not already active
                _blackPP = ppEffectCreate ["colorCorrections", 1502];
                _blackPP ppEffectEnable true;
                _blackPP ppEffectAdjust [1.0, 1.0, 0.0, [0, 0, 0, 1], [0.0, 1.0, 1.0, 1.0], [0.199, 0.587, 0.114, 0.0],[0.50,0.25,1,0,0,0.5,0.745]];
                _blackPP ppEffectCommit 0.25;
                //Store handler
                missionNameSpace setVariable ["FOS_Medical_BlackPP",_blackPP];
            };
            if (isNil {missionNameSpace getVariable ["FOS_Medical_blurPP",nil]}) then { //Make sure this is not already active
                _blurPP = ppEffectCreate ["DynamicBlur", 255];
                _blurPP ppEffectEnable true;
                _blurPP ppEffectAdjust [1];
                _blurPP ppEffectCommit 0.25;
                //Store handler
                missionNameSpace setVariable ["FOS_Medical_blurPP",_blurPP];
            };
        } else {
            //Destroy previous PP effect
            _blackPP = missionNameSpace getVariable ["FOS_Medical_BlackPP",nil];
            _blurPP = missionNameSpace getVariable ["FOS_Medical_blurPP",nil];
            if !(isNil "_blackPP") then {ppEffectDestroy _blackPP};
            if !(isNil "_blurPP") then {ppEffectDestroy _blurPP};
            //Wipe handler from variable
            missionNameSpace setVariable ["FOS_Medical_BlackPP",nil];
            missionNameSpace setVariable ["FOS_Medical_blurPP",nil];
        };
    };
};
