_veh = _this select 0;
_vehOld = _veh;

if(damage _veh > 0.3)then{
    
    _vars = _veh getVariable "zp_heliVars";
    
    _start = _vars select 0;
    _end = _vars select 1;
    _class = _vars select 2;
    _id = _vars select 3;
    
    if(zp_heliDev)then{
        
        _varsmarker = _vehOld getVariable "zp_heliDevMarker"; 
        _m = _varsmarker select 0;
       	_m setMarkerColor "ColorRed";
        _m setMarkerType "hd_destroy";
        
        systemchat format ["Heli ID %1 deleted",_id];
    };
    
    
	{ deleteVehicle _x } forEach (crew _veh); deleteVehicle _veh;
    
    
    _veh = _class createVehicle position _start;
    createVehicleCrew _veh;
    
    _veh setVariable ["zp_heliVars",[_start,_end,_class,_id],true];
    
    _veh addEventHandler ["Hit", {_null = [_this select 0] execVM "ambientHeliEH.sqf";}]; 
    sleep 5;
    if(zp_heliDev)then{
        
        _r = str floor(((position _veh) select 0));
		_v = createMarker [_r, position _veh];
        _v setMarkerColor "ColorGreen";
        _v setMarkerText format["Heli - %1 start",_id];
    	[_v,_veh] call zp_addMarkerToHeli;
    	_veh setVariable ["zp_heliDevMarker",[_r],true];

        
    };
    
	
    
    [_veh,_start,_end,_id] call zp_startHeliTour;
        

    
};




