zp_addMarkerToHeli = {
   
	_v = _this select 0;
	_veh = _this select 1;
    
    [_v,_veh] spawn {

	    _v = _this select 0;
	    _veh = _this select 1;
	    
        while{alive _veh} do {
			_v setMarkerPos getpos _veh;
      		 sleep 10;
        };
	    
	};
         
};

zp_startHeliTour = {
    
    _vehicle = _this select 0;
    _startPad = _this select 1;
    _endPad = _this select 2;
    _id = _this select 3;
          
    _vehicle domove getPos _endPad;
    _vehicle flyinheight 120;
	 _vehicle disableAi "TARGET"; 
	_vehicle disableAi "AUTOTARGET"; 
	_vehicle enableAttack false; 
	_vehicle setCombatMode "BLUE"; 
	_vehicle setBehaviour "CARELESS"; 
	_vehicle allowFleeing 0;  
  
    
    
     [_endPad,_vehicle,_id,_startPad] spawn {

	    _endPad = _this select 0;
	    _vehicle = _this select 1;
		_id = _this select 2;
		_c = true;
		_startPad = _this select 3;
		_d = driver _vehicle; 
          
        while{alive _vehicle AND _c} do {
            
			sleep 5;
            
			_meters = _vehicle distance _endpad;
            
			if(zp_heliDev)then{
                
               //systemchat format ["%1: Helicopter with ID %2: %3m",name _d,_id,_meters];
               
            };           
            
            if(_meters < 200)then{

				_c = false;
				dostop _vehicle;
                
                if(zp_heliDev)then{
                 
                  //systemchat format ["Helicopter with ID %1 landing",_id];
                  
                };
                
				_vehicle land "LAND";
	                
	            [_vehicle,_startPad,_endPad,_id] call zp_launchTime;
                
            };
            
        };
	    
	};
      
};

zp_heliInit = {
  
    _heliArray = ["C_Heli_Light_01_civil_F"];

	_y = 0;
    
	_heliPads= nearestObjects[position server,["Land_HelipadSquare_F","Land_HelipadRescue_F","Land_HelipadCivil_F"],5000000];
	
    {    
    
		_m = createMarker [str position _x, position _x];
        _m setMarkerType "mil_flag";
        _m setMarkerText format["Helipad - %1",_y];
        _y = _y + 1;
        
	} foreach _heliPads;
	
    
	_c = count  _helipads;
	_numbers = floor( _c / 2  );
	
	_linkedHelipads = [];
	
	for [{_i=0}, {_i< _numbers}, {_i=_i+1}] do
	{
	    
	    _index = _i;
	    _helipadStart = _helipads select _index;
	    _indexEnd = _index + _numbers;
	    
	   _helipadEnd = _helipads select _indexEnd;
	    
	    _linkedHelipads pushBack [_helipadStart,_helipadEnd];
	    
	   
	    
	};
	
	_y = 0;
    
    {    
    	_start = _x select 0;
        _end = _x select 1;
        _class = [_heliArray] call zp_selectHeliCiv; 
               
        _veh = _class createVehicle position _start;
        
        _veh setVariable ["zp_heliVars",[_start,_end,_class,_y],true];
        
        _veh addEventHandler  ["Hit", {_null = [_this select 0] execVM "ambientHeliEH.sqf";}]; 
        
        createVehicleCrew _veh;
        
        if(zp_heliDev)then{

    		_m = createMarker [str position _start, position _start];
	        _m setMarkerType "mil_flag";
	        _m setMarkerText format["Helipad - %1 start",_y];
        
        	_r = str floor(((position _veh) select 0));
			_v = createMarker [_r, position _veh];
            
            _veh setVariable ["zp_heliDevMarker",[_r],true];
            
	        _v setMarkerType "n_air";
	        _v setMarkerColor "ColorGreen";
	        _v setMarkerText format["Heli - %1 start",_y];
        	
			[_v,_veh] call zp_addMarkerToHeli;
            
            
            
            _m = createMarker [str position _end, position _end];
	        _m setMarkerType "mil_flag";
	        _m setMarkerText format["Helipad - %1 end",_y];
            
        };
       
        _y = _y + 1;
                
        [_veh,_start,_end,_y] call zp_startHeliTour;
        
	} foreach _linkedHelipads;  
    
};



zp_launchTime = {
    
    _vehicle = _this select 0;
    _startpad = _this select 1;
    _endPad = _this select 2;
    _id = _this select 3;
    
    _timeoutBase =  240;
    
    _timeOutAdditional = floor (random 300);
    
    _timeout = _timeoutBase + _timeOutAdditional;
    
    _vehicle setfuel 1;
    
    //systemChat format ["ID: %1 macht %2s pause.",_id,_timeout];
    
    sleep _timeout;
    
    if(_vehicle distance _endPad < 50 )then{
            
			//systemChat format ["ID: %1 starting.",_id];
             
			[_vehicle,_endPad,_startpad,_id] call zp_startHeliTour;
            
    }else{
        
			//systemChat format ["ID: %1 starting.",_id];
             
			[_vehicle,_startPad,_endPad,_id] call zp_startHeliTour;
    };
    
    

};

zp_selectHeliCiv = {
    
    _heliArray = _this select 0;
    
    _c = count _heliArray;
    
    _i = floor( random _c );
    
    _class = _heliArray select _i;
    
    _class
    
};