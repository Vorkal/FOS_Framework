/*
Patrols area until any enemy units or players are noticed within the given range.
Once an enemy is detected nearby they will be sent on a seek and destroy to that location.
On completion of their seek and destroy task they will resume their original patrol.
They will not pursue detected enemy units. Only secure the area they are spoted
*/

params ["_group","_patrolRange","_seekRange","_playeronly"];
