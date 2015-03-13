/*
tort_DynamicWeather
Version: 1.1.5
Author: tortuosit; derived of a weather script by Meatball
Date: 20140716

Disclaimer: Feel free to use and modify this code. Please report errors and enhancements back so that anybody can profit.

*** Thread and documentation: http://forums.bistudio.com/showthread.php?178674 ***

How to use:
1 - Save this script into your mission directory as tort_DynamicWeather.sqf
2 - Call it with 0 = ["cloudy", "freeCycle", [0.1, 0], [0.1, 0.3], [0, 0.8, 0, 0.6, 0, 1], 0, 0] execVM "\@tort_DynamicWeather\script\tort_DynamicWeather.sqf";
    Arguments and presets see http://forums.bistudio.com/showthread.php?178674.

tort_dynamicweather = true; testvalue = 1; tRandomCounter = 0;
private ["_ocMin", "_ocMax", "_fogMin", "_fogMax", "_windMin", "_windMax", "_minVari", "_maxVari", "_ignoreMinMax", "_randomEvent", "_transitionSpeed", "_fogMinHeight", "_fogMaxHeight", "_daytime", "_fogEnableGroundfog", "_groundfogBetween", "_goundFogActive", "_seed", "_turbulence"];

// Random number generator
// Input: number, seed (integer)
// _myrandomnumber = [max] call tRandom;
tRandom = {
   tRandomCounter = tRandomCounter + 1;
   private["_i","_num","_out","_arr"]; _out = "";
   for "_i" from 1 to 6 do {
      _num = sin(_i^3 + tRandomCounter + seedVar) + 1;
      _arr = toArray str(_num);
      if ((count _arr) > 6) then {_out = _out + toString([_arr select ((count _arr) - 2)]);};
   };
   seedvar = (1000000 - (parseNumber (_out)) + tRandomCounter) % 1000000;
   ((_this select 0) * parseNumber ("0." + _out))
};

// You can change the following values /////////////////////////////////////////
_fogEnableGroundfog = 1; // 0 or 1
_groundfogBetween = [20, 8]; // groundfog between hours of day
_fogMinHeight = 10; _fogMaxHeight = 80;
// Do not change anything below this line //////////////////////////////////////

_count = count _this;
_initial = "cloudy"; if (_count > 0) then {_initial = _this select 0};
_trend = "freeCycle"; if (_count > 1) then {_trend = _this select 1};
_probRndChange = [0, 0]; if (_count > 2) then {_probRndChange = _this select 2};
_variation = [0, 0.2, 1800]; if (_count > 3) then {_variation = _this select 3};
_minMax = [0, 1, 0, 0.5, 0, 1]; if (_count > 4) then {_minMax = _this select 4};
_debugMode = 0; if (_count > 5) then {_debugMode = _this select 5};
   if (_debugMode == 3) then {_debugMode = 100};
_seed = 0; if (_count > 6) then {_seed = (_this select 6) % 1000000};
if (_seed == 0) then {_seed = floor(random(1000000));};
seedVar = _seed;

_minVari = _variation select 0; _maxVari = _variation select 1;
if ((count _variation) > 2) then {_transitionSpeed = (_variation select 2) * 60} else {_transitionSpeed = 1800};
_ocMin = _minMax select 0;_ocMax = _minMax select 1;
_fogMin = _minMax select 2; _fogMax = _minMax select 3;
_windMin = _minMax select 4; _windMax = _minMax select 5;

if (typeName _probRndChange == "SCALAR") then {_probRndChange = [_probRndChange, 0]};

if (typeName _initial == "ARRAY") then {
   if ((typeName (_initial select 0)) == "STRING") then {
      _initial = (_initial select 0);
   } else {
      overcastLevel = _initial select 0; fogLevel = _initial select 1; windStrength = _initial select 2; rainLevel = _initial select 3; windDirection = [360] call tRandom;
      if isNil "overcastLevel" then {overcastLevel = [1] call tRandom;}; if isNil "rainLevel" then {rainLevel = 0}; if isNil "fogLevel" then {fogLevel = [1] call tRandom;}; if isNil "windStrength" then {windStrength = [1] call tRandom;};
      if (overcastLevel < 0) then {overcastLevel = [abs(overcastLevel)] call tRandom;};
      if (fogLevel < 0) then {fogLevel = [abs(fogLevel)] call tRandom;};
      if (windStrength < 0) then {windStrength = [abs(windStrength)] call tRandom;};
   };
};

// Set initial weather presets
if (typeName _initial == "STRING") then {
   switch (_initial) do {
      case "clear": {overcastLevel = 0; rainLevel = 0; fogLevel = 0; windStrength = [0.1] call tRandom; windDirection = [360] call tRandom; rainLevel = 0};
      case "cloudy": {overcastLevel = 0.4 + ([0.15] call tRandom); fogLevel = ([0.015] call tRandom); windStrength = 0.2 + ([0.06] call tRandom); windDirection = ([360] call tRandom); rainLevel = 0};
      case "foggy":  {overcastLevel = 0.3 + ([0.15] call tRandom); fogLevel = 0.4 + ([0.2] call tRandom); windStrength = 0.3 + ([0.4] call tRandom); windDirection = [360] call tRandom; rainLevel = 0};
      case "bad": {overcastLevel = 0.8 + ([0.15] call tRandom); fogLevel = 0.1 + ([0.1] call tRandom); windStrength = 0.6 + ([0.4] call tRandom); windDirection = [360] call tRandom; rainLevel = 0};
      case "random": {overcastLevel = _ocMin + ([_ocMax-_ocMin] call tRandom); windStrength = _windMin + ([_windMax - _windMin] call tRandom); windDirection = [360] call tRandom;
                      fogLevel = _fogMin + (([1] call tRandom) * ([_fogMax - _fogMin] call tRandom));rainLevel = 0;}; // higher probability to lower fog values
      case "rndGood": {overcastLevel = ([0.5] call tRandom); windStrength = ([0.5] call tRandom); windDirection = [360] call tRandom;
                      fogLevel = (([0.5] call tRandom) * ([_fogMax - _fogMin] call tRandom)); rainLevel = 0;}; // higher probability to lower fog values
      case "rndBad": {overcastLevel = 0.5 + ([0.5] call tRandom); windStrength = 0.5 + ([0.5] call tRandom); windDirection = [360] call tRandom;
                      fogLevel = ((0.5 + ([0.5] call tRandom)) * ([_fogMax - _fogMin] call tRandom)); rainLevel = 0;}; // higher probability to lower fog values
      case "sunny": {overcastLevel = 0.3 + ([0.08] call tRandom); fogLevel = 0; windStrength = [0.5 ] call tRandom; windDirection = [360] call tRandom; rainLevel = 0;}; //sunny
      default {overcastLevel = 0.3; fogLevel = 0; windStrength = 0.1; windDirection = [360] call tRandom; rainLevel = 0;};
   };
};

_groundFogActive = false; currentTime = (date select 3) + ((date select 4)/60);
if ((currentTime > 8) && (currentTime < 20)) then {_daytime = true} else {_daytime = false};
if ((_groundfogBetween select 0) < (_groundfogBetween select 1)) then {
  if ((currentTime > (_groundfogBetween select 0)) && (currentTime < (_groundfogBetween select 1))) then {_groundFogActive = true;};
} else {
   if ((currentTime > (_groundfogBetween select 0)) || (currentTime < (_groundfogBetween select 1))) then {_groundFogActive = true;};
};
if (([1] call tRandom) < 0.05) then {_groundFogActive = !_groundFogActive};
fogDecay = (0.15 - ([0.05] call tRandom) - ([0.05] call tRandom) - ([0.05] call tRandom)) * _fogEnableGroundfog;
fogBase = (_fogMinHeight + ([_fogMaxHeight - _fogMinHeight] call tRandom)) * _fogEnableGroundfog;
if !(_groundFogActive) then {fogDecay = 0.01; fogBase = 0;};

// set constants to initial levels
constantLevels = [overcastLevel, fogLevel, windStrength];

// apply initial weather
if (_debugMode <3) then {
   skiptime -24; 86400 setOvercast overcastLevel; skiptime 24; 0 setRain rainLevel;
   sleep 0.5;simulWeatherSync;sleep 0.5;ForceWeatherChange;sleep 0.5;
   0 setFog [fogLevel, fogDecay, fogBase]; 0 setWindStr windStrength; 0 setWindDir windDirection;
};

// write 2 log lines to rpt
diag_log format ["TORT_DYNAMICWEATHER[ARGS] [%1, %2, %3, %4, %5, %6, %7]",_this select 0,_this select 1,_this select 2,_this select 3,_this select 4,_this select 5,_this select 6];
diag_log format ["TORT_DYNAMICWEATHER[SEED#%1][INITWEATHER] OC:%2 FOG:[%3,%4,%5] WSTR:%6 WDIR:%7 POS:%8",_seed,round(overcastLevel*100)/100,round(fogLevel*100)/100,round(fogDecay*100)/100,round(fogBase*100)/100,round(windStrength*100)/100,windDirection,getPos player];

if ((_debugMode > 0) && (_debugMode < 3)) then {
   hint format ["TORT_DYNAMICWEATHER [SEED#%1] Initial weather: Overcast %2 | Fog [%3, %4, %5] | Wind %6 | DebugMode %7",_seed,round(overcastLevel*100)/100,round(fogLevel*100)/100,round(fogDecay*100)/100,round(fogBase*100)/100,round(windStrength*100)/100,_debugMode]; sleep 10;
// } else {
//    hint format ["[SEED#%1] tort_DynamicWeather is running. Initial weather (%2) has been applied. The trend is: %3",_seed,_initial,_trend];
};

while {true} do {
   if (_trend == "constant") then {_turbulence = 1} else {_turbulence = 1 + floor([4*overcastLevel] call tRandom);};
   for "_i" from 1 to _turbulence do {
      if (_debugMode < 3) then {currentTime = (date select 3);};
      _randomEvent = (([1] call tRandom) < (_probRndChange select 0));
      _groundFogActive = false;
      if ((_groundfogBetween select 0) < (_groundfogBetween select 1)) then {
        if ((currentTime > (_groundfogBetween select 0)) && (currentTime < (_groundfogBetween select 1))) then {_groundFogActive = true;};
      } else {
         if ((currentTime > (_groundfogBetween select 0)) || (currentTime < (_groundfogBetween select 1))) then {_groundFogActive = true;};
      };
      if ((currentTime > 8) && (currentTime < 20)) then {_daytime = true} else {_daytime = false};
      if (([1] call tRandom) < 0.05) then {_groundFogActive = !_groundFogActive};
      if (_groundFogActive) then {
         fogDecay = (0.15 - ([0.05] call tRandom) - ([0.05] call tRandom) - ([0.05] call tRandom));
         fogBase = (_fogMaxHeight - ([(0.25 * (_fogMaxHeight - _fogMinHeight))] call tRandom) - ([(0.25 * (_fogMaxHeight - _fogMinHeight))] call tRandom) - ([(0.25 * (_fogMaxHeight - _fogMinHeight))] call tRandom) - ([(0.25 * (_fogMaxHeight - _fogMinHeight))] call tRandom));
      } else {
         fogDecay = 0.01; fogBase = 0;
      };
      // Create random numbers for next forecast.
      _randOc = (_minVari + ([_maxVari - _minVari] call tRandom)) / _turbulence;
      _randFog = (_minVari + ([_maxVari - _minVari] call tRandom)) / _turbulence;
      _randWS =(_minVari + ([_maxVari - _minVari] call tRandom)) / _turbulence;
      _randWD = (round((([180] call tRandom)-90)* _turbulence *10))/10;

// ######## RANDOM NEXT WEATHER ######## //
      if ((_trend == "random") || (_randomEvent)) then {
         _ignoreMinMax = (([1] call tRandom) < (_probRndChange select 1));
         if (_ignoreMinMax) then {
            overcastLevel = [1] call tRandom;
            fogLevel = [1] call tRandom;
            windStrength = [1] call tRandom;
         } else {
            overcastLevel = _ocMin + ([_ocMax - _ocMin] call tRandom);
            windStrength = _windMin + ([_windMax - _windMin] call tRandom);
            if (_daytime) then {
               fogLevel = _fogMin + ((([_fogMax - _fogMin] call tRandom)) * ([1] call tRandom));
               // on not _randomEvent encounters, turn off fog completely
               if (_randomEvent && (([1] call tRandom) > (overcastLevel * 0.7))) then {fogLevel = _fogMin}; //often no fog
            } else {
               // nighttime: more fog possible
               fogLevel = _fogMin + ([_fogMax - _fogMin] call tRandom);
               // on not _randomEvent encounters, likely to turn off fog completely
               if (!_randomEvent && (([1] call tRandom) < (0.15))) then {fogLevel = _fogMin}; //sometimes no fog
            };
         windStrength = _windMin + ([_windMax - _windMin] call tRandom);
         };
      };

// ######## always oscillate between extremes ######## //
      if (_trend == "oscillate") then {
         _ignoreMinMax = (([1] call tRandom) < (_probRndChange select 1));
         if (_ignoreMinMax) then {
            if (([1] call tRandom) < 0.9) then {
               if (overcastLevel < (_ocMin + (0.5 * (_ocMax-_ocMin)))) then {
                  overcastLevel = _ocMax - _minVari - ([_maxVari - _minVari] call tRandom);
               } else {
                  overcastLevel = _ocMin + _minVari + ([_maxVari - _minVari] call tRandom);
               };
            };
            if (([1] call tRandom) < 0.9) then {
               if (fogLevel < (_fogMin + (0.5 * (_fogMax-_fogMin)))) then {
                  fogLevel = _fogMax - _minVari - ([_maxVari - _minVari] call tRandom);
               } else {
                  fogLevel = _fogMin + _minVari + ([_maxVari - _minVari] call tRandom);
               };
            };
            if (([1] call tRandom) < 0.9) then {
               if (windStrength < (_windMin + (0.5 * (_windMax-_windMin)))) then {
                  windStrength = _windMax - _minVari - ([_maxVari - _minVari] call tRandom);
               } else {
                  windStrength = _windMin + _minVari + ([_maxVari - _minVari] call tRandom);
               };
            };
         } else {
            if (([1] call tRandom) < 0.9) then {
               if (overcastLevel < 0.5) then {
                  overcastLevel = 1 - _minVari - ([_maxVari - _minVari] call tRandom);
               } else {
                  overcastLevel = _minVari + ([_maxVari - _minVari] call tRandom);
               };
            };
            if (([1] call tRandom) < 0.9) then {
               if (fogLevel < 0.5) then {
                  fogLevel = 1 - _minVari - ([_maxVari - _minVari] call tRandom);
               } else {
                  fogLevel = _minVari + ([_maxVari - _minVari] call tRandom);
               };
            };
            if (([1] call tRandom) < 0.9) then {
               if (windStrength < 0.5) then {
                  windStrength = 1 - _minVari - ([_maxVari - _minVari] call tRandom);
               } else {
                  windStrength = _minVari + ([_maxVari - _minVari] call tRandom);
               };
            };
         };
      };

// ######## CONSTANT NEXT WEATHER ######## //
      if (!_randomEvent && (_trend == "constant")) then {
         if (_maxVari == 0) then {
            // if no variance, immediately return back to constant value
            overcastLevel = (constantLevels select 0) + _minVari - ([2 * _minVari] call tRandom);
            fogLevel = (constantLevels select 1) + _minVari - ([2 * _minVari] call tRandom);
            windStrength = (constantLevels select 2) + _minVari - ([2 *_minVari] call tRandom);
//          overcastLevel = (constantLevels select 0); fogLevel = (constantLevels select 1); windStrength = (constantLevels select 2);
         } else {
            // move back to constant value in user def. variation steps
            overcastLevelPrev = overcastLevel; fogLevelPrev = fogLevel; windStrengthPrev = windStrength;
            if (overcastLevel < ((constantLevels select 0) - _maxVari)) then {
               overcastLevel = overcastLevel + _randOc;
               if (overcastLevel > ((constantLevels select 0) + _maxVari)) then {overcastLevel = (constantLevels select 0) + ([_maxVari] call tRandom)};
            };
            if (overcastLevel > ((constantLevels select 0) + _maxVari)) then {
               overcastLevel = overcastLevel - _randOc;
               if (overcastLevel < ((constantLevels select 0) - _maxVari)) then {overcastLevel = (constantLevels select 0) - ([_maxVari] call tRandom)};
            };
            if (fogLevel < ((constantLevels select 1) - _maxVari)) then {
               fogLevel = fogLevel + _randFog;
               if (fogLevel > ((constantLevels select 1) + _maxVari)) then {fogLevel = (constantLevels select 1) + ([_maxVari] call tRandom)};
            };
            if (fogLevel > ((constantLevels select 1) + _maxVari)) then {
               fogLevel = (constantLevels select 1) - _randFog;
               if (fogLevel < ((constantLevels select 1) - _maxVari)) then {fogLevel = (constantLevels select 1) - ([_maxVari] call tRandom)};
            };
            if (windStrength < ((constantLevels select 2) - _maxVari)) then {
               windStrength = windStrength + _randWS;
               if (windStrength > ((constantLevels select 2) + _maxVari)) then {windStrength = (constantLevels select 2) + ([_maxVari] call tRandom)};
            };
            if (windStrength > ((constantLevels select 2) + _maxVari)) then {
               windStrength = (constantLevels select 2) - _randFog;
               if (windStrength < ((constantLevels select 2) - _maxVari)) then {windStrength = (constantLevels select 2) - ([_maxVari] call tRandom)};
            };
            if (overcastLevel == overcastLevelPrev) then {
               overcastLevel = (constantLevels select 0) + _minVari - ([2 * _minVari] call tRandom)};
               if (fogLevel == fogLevelPrev) then {fogLevel = (constantLevels select 1) + _minVari - ([2 * _minVari] call tRandom);
            };
            if (windStrength == windStrengthPrev) then {windStrength = (constantLevels select 2) + _minVari - ([2 *_minVari] call tRandom);};
            windDirection = windDirection + _randWD; if (windDirection >= 360 ) then {windDirection = windDirection - 360}; if (windDirection < 0) then {windDirection = 360 + windDirection};
         };
         if (overcastLevel < 0) then {overcastLevel = 0}; if (overcastLevel > 1) then {overcastLevel = 1};
         if (fogLevel < 0) then {fogLevel = 0}; if (fogLevel > 1) then {fogLevel = 1};
         if (windStrength < 0) then {windStrength = 0}; if (windStrength > 1) then {windStrength = 1};
      };

// ######## CYCLING WEATHER ######## //
      if (!_randomEvent && (_trend != "constant") && (_trend != "random")) then {
         switch (_trend) do {
            case "pBetter":
            {
               // 2/3 chance of weather getting better
               if (([3] call tRandom)>1) then {_randOc = -1 * _randOc;_randWS = -1 * _randWS;};
               if (([4] call tRandom)>1) then {_randFog = -1 * _randFog};
               // if wrong direction, then soft
               if (_randOc > 0) then {_randOc = _randOc * ([1] call tRandom)};
               if (_randWS > 0) then {_randWS = _randWS * ([1] call tRandom)};
               if (_randFog > 0) then {_randFog = _randFog * ([1] call tRandom)};
            };
            case "pWorse": {
               // 2/3 chance of weather getting worse (except fog)
               if (([3] call tRandom)<1) then {_randOc = -1 * _randOc;_randWS = -1 * _randWS;};
               if (([3] call tRandom)>1) then {_randFog = -1 * _randFog};
               // if wrong direction, then soft
               if (_randOc < 0) then {_randOc = _randOc * ([1] call tRandom)};
               if (_randWS < 0) then {_randWS = _randWS * ([1] call tRandom)};
               if (_randFog < 0) then {_randFog = _randFog * ([1] call tRandom)};
            };
            case "better": {
               _randOc = -1 * _randOc; _randWS = -1 * _randWS; _randFog = -1 * _randFog;
            };
            case "worse": {
               if (([5] call tRandom)>1) then {_randFog = -1 * _randFog};
            };
            case "freeCycle": {
               if (([2] call tRandom)>1) then {_randOc = -1 * _randOc;_randWS = -1 * _randWS;_randFog = -1 * _randFog};
               //if (([3] call tRandom)<1) then {_randFog = -1 * _randFog};
            };
         };
         // Create next random overcast level and keep it between borders
         // if value exceeds border, choose a new value between border and _maxVari
         overcastLevel = overcastLevel + _randOc;
         if (overcastLevel > _ocMax) then {overcastLevel = _ocMax - ([_maxVari] call tRandom)};
         if (overcastLevel < _ocMin) then {overcastLevel = _ocMin + ([_maxVari] call tRandom)};
         // Create next random fog level  //keep fog rather low
         fogLevel = fogLevel + _randFog;
         if (_groundFogActive) then {
            if (([1] call tRandom) < 0.5) then {fogLevel = _fogMin + ([_maxVari] call tRandom)};
         } else {
            if (([1] call tRandom) > (overcastLevel * 0.8)) then {fogLevel = _fogMin}; //often min fog at daytime
         };
         if (fogLevel > _fogMax) then {fogLevel = _fogMax - _minVari - ([_maxVari] call tRandom)};
         if (fogLevel < _fogMin) then {fogLevel = _fogMin};
         // Create next random Wind level
         windStrength = windStrength + _randWS;
         if (windStrength > _windMax) then {windStrength = _windMax - ([_maxVari] call tRandom)};
         if (windStrength < _windMin) then {windStrength = _windMin + ([_maxVari] call tRandom)};
      };

      // Create next random Wind Dir level and keep between [0 .. 360[
      if ((([1] call tRandom) > 0.8) || (_trend == "random") || (_randomEvent)) then {windDirection = ([360] call tRandom);} else {windDirection = windDirection + _randWD;};
      if (windDirection >= 360 ) then {windDirection = windDirection - 360};
      if (windDirection < 0) then {windDirection = 360 + windDirection};

// ######## EXECUTE & DEBUG ########
      if ((_debugMode == 1) || (_debugMode == 2)) then {
         sleep 2;
         diag_log format ["TORT_DYNAMICWEATHER@%1s[SEED#%2][DONE IN MAX:%3s/%4s] OC:%5 FOG:[%6,%7,%8] WSTR:%9 WDIR:%10 POS:%11",time,_seed,floor(_transitionSpeed / _turbulence),_transitionSpeed,round(overcastLevel*100)/100,round(fogLevel*100)/100,round(fogDecay*100)/100,round(fogBase*100)/100,round(windStrength*100)/100,windDirection,getPos player];
         hint format ["[SEED#%1] [Time %2:%3h] Next weather: Overcast %4 | Fog [%5, %6, %7] | Wind %8 | Turbulence %9",_seed,date select 3,date select 4,round(overcastLevel*1000)/1000,round(fogLevel*1000)/1000,round(fogDecay*1000)/1000,round(fogBase*1000)/1000,round(windStrength*1000)/1000,_turbulence];
      };

      if (_debugMode < 2) then {
         // apply new weather
         if (_i == 1) then {_transitionSpeed setOvercast overcastLevel; floor(5 + ([30] call tRandom)) setRain 0;};
         floor(_transitionSpeed / _turbulence * (0.9 + ([0.1] call tRandom))) setFog [fogLevel, fogDecay, fogBase];
         floor(_transitionSpeed / _turbulence * (0.9 + ([0.1] call tRandom))) setWindStr windStrength;
         floor(_transitionSpeed / _turbulence * (0.9 + ([0.1] call tRandom))) setWindDir windDirection;
         sleep floor(_transitionSpeed / _turbulence);
      };

      if (_debugMode == 2) then {
         diag_log format ["TORT_DYNAMICWEATHER@%1s[SEED#%2][DONE IN MAX:%3s/%4s] OC:%5 FOG:[%6,%7,%8] WSTR:%9 WDIR:%10 POS:%11",time,_seed,floor(_transitionSpeed / _turbulence),_transitionSpeed,round(overcastLevel*100)/100,round(fogLevel*100)/100,round(fogDecay*100)/100,round(fogBase*100)/100,round(windStrength*100)/100,windDirection,getPos player];
         // apply weather quickly
         _transitionSpeed setOvercast overcastLevel;
         3 setRain 0; 3 setFog [fogLevel, fogDecay, fogBase]; 3 setWindStr windStrength; 3 setWindDir windDirection;
         sleep 4; forceweatherchange; skiptime (1 / (2 * _turbulence));
      };

      if (_debugMode > 10) then {
         diag_log format ["TDW,%1, SEEDVAR,%2, TIME,%3, RND,%4, OC,%5, GFA,%6, FOGL,%7, FOGD,%8, FOGB,%9, WSTR,%10, WDIR,%11",testvalue,seedvar,(floor(currentTime * 100))/100,_randomEvent,round(overcastLevel*100)/100,_groundFogActive,round(fogLevel*10000)/10000,round(fogDecay*10000)/10000,round(fogBase*100)/100,round(windStrength*100)/100,floor(windDirection)];
         hint format ["Value#%1 written to .rpt",testvalue]; sleep 0.005;
         testvalue = testvalue + 1;
         thisLength = (round((_transitionSpeed / _turbulence)/36))/100;
         currentTime = (currentTime + thisLength) % 24;
      };
   };
   if ((testvalue > _debugMode) && (testvalue > 3)) then {hint format ["%1 values written to .rpt - quitting", _debugMode];};
   if ((testvalue > _debugMode) && (testvalue > 3)) exitWith {};
};