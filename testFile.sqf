//Executes only in 3den (preview scenario)
[] spawn {
_emptyDisplay = findDisplay 46 createDisplay "RscDisplayEmpty";

_ctrl = _emptyDisplay ctrlCreate ["RscListBox", 339];


_ctrl lbAdd "test";
_ctrl ctrlSetPosition [0.25,0.25,0.5,0.5];
_ctrl ctrlCommit 0;
};
