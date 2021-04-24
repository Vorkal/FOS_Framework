/* //Executes only in 3den (preview scenario)



//FIVE BUCKS SAYS THIS DOESN'T WORK


_firstUnit = player;
_secondUnit = test;

//Parachute
chute1 = createVehicle ['NonSteerable_Parachute_F', position _firstUnit,[],0,'Fly'];
chute1 setPos position _firstUnit;
_firstUnit moveInDriver chute1;
chute1 allowDamage false;

//Backpack attached to chest.
//TODO: Make this check the player backpack
backpackproxy = createSimpleObject ["B_Carryall_oli_Mine", getPos chute1];
backpackproxy attachTo [chute1,[0,-0.055,-0.02],"proxy:\a3\data_f\proxies\para\pilot.001"];
backpackproxy setdir 180;

//Fake parachute required for the rope because it is trying to sling load. Need a non-physics object.
chute1Proxy = createVehicle ['NonSteerable_Parachute_F', position _firstUnit,[],0,'Fly'];
chute1Proxy attachTo [chute1,[0,0,0]];
hideObject chute1Proxy;

//Parachute
chute2 = createVehicle ['NonSteerable_Parachute_F', position _secondUnit,[],0,'Fly'];
chute2 setPos position _secondUnit;
_secondUnit moveInDriver chute2;
chute2 allowDamage false;

//Backpack attached to chest.
backpackproxy2 = createSimpleObject ["B_Carryall_oli_Mine", getPos chute2];
backpackproxy2 attachTo [chute1,[0,-0.055,-0.02],"proxy:\a3\data_f\proxies\para\pilot.001"];
backpackproxy2 setdir 180;

//Fake parachute required for the rope because it is trying to sling load. Need a non-physics object.
chute2Proxy = createVehicle ['NonSteerable_Parachute_F', position _firstUnit,[],0,'Fly'];
chute2Proxy attachTo [chute2,[0,0,0]];
hideObject chute2Proxy;

//Link the parachutes
ropeCreate [
chute2Proxy,
[0,0,0],
chute1Proxy,
[0,0,0],
10
];

// It worked? */
