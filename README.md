# Ambient Helicopters

![heli.png](https://bitbucket.org/repo/88BadX/images/254885951-heli.png)

### How it works: ###

It search for all defined helipads and create pairs, startpad and endpad. Then it create a random helicopter and give the order to move to the paired helipad and rest for a random time, about 8min then it will return to the first helipad and rest again. If the helicopter is damaged(30%) it will be deleted and a new one will start from the first helipad.
 
### Video: ###
https://www.youtube.com/watch?v=fsWI-RYcd_s


### Install info: ###

Download the master and create a "ambient-helicopters.Altis" folder and put all the files in it.

```
#!python
Only run the [] call zp_heliInit; on the server
```
The mission **need** a gamelogic named **server**.

To disable the dev marker modify the zp_heliDev variable.
```
#!python

zp_heliDev = false;
```

Add new vehicles, open the **ambientHeli.sqf** and edit the **_heliArray** array.
```
#!python

_heliArray = ["C_Heli_Light_01_civil_F"];
```

To change the heli spawn helipads edit the **_heliPadClasses** array, you can add ArmA I & ArmA II helipads.
```
#!python

_heliPads= nearestObjects[position server,["Land_HelipadSquare_F","Land_HelipadRescue_F","Land_HelipadCivil_F"],5000000];
```