while {true} do {
    //Wait until admin object is not objNull
    waitUntil {sleep 0.1;call FOS_fnc_getAdmin != objnull};
    //Store admin object found
    _admin = call FOS_fnc_getAdmin;
    //Execute admin briefing
    [] remoteExec ["FOS_fnc_briefing",_admin];
    //wait until admin object changes
    waitUntil {sleep 0.1;_admin != call FOS_fnc_getAdmin};
    //Execute briefing to new admin
    [] remoteExec ["FOS_fnc_briefing",call FOS_fnc_getAdmin];
    //Execute briefing to old admin. So that admin menu is removed.
    [] remoteExec ["FOS_fnc_briefing",_admin];
};
