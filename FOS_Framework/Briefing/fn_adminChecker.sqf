while {true} do {
    //Could return null if no admin is found
    waitUntil {sleep 5;!(isNull (call FOS_fnc_getAdmin))};
    //Store admin object found
    _admin = call FOS_fnc_getAdmin;
    //Wait until admin object changes
    waitUntil {sleep 10;call FOS_fnc_getAdmin != _admin};
    //Execute briefing to new admin
    [] remoteExec ["FOS_fnc_briefing",call FOS_fnc_getAdmin];
};
