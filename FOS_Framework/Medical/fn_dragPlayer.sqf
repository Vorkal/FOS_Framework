params ["_unit","_target"];

_unit setVariable ["FOS_dragging",_target,true];





//play animations
/* [_target, "grabCarried"] remoteExec ["playActionNow", _target]; */

_unit playActionNow "grabDrag";
