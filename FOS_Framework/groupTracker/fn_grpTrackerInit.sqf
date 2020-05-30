while {true} do {
	sleep 5;
	_playerGroup = allGroups select {isPlayer leader _x};
  [_playerGroup,"b_inf",0] spawn FOS_fnc_setGrpTracker;

};
