unit Tools;


interface
 uses Graph;

 procedure drawSettings(x : integer);

 procedure setLeft(left0 : real);
 procedure setKMin(kMin0 : integer);
 procedure setCountAnswers(countAnswers0 : integer);
 procedure setStep(step0 : real);
 procedure setSpeed1(speed : real);
 procedure setSpeed3(speed : real);
 procedure setSpeedIsp(speed : real);

 function getKMin : integer;
 function getCountAnswers : integer;
 function getStep : real;
 function getSpeed1 : real;
 function getSpeed3 : real;
 function getSpeedIsp: real;
 function getLeft : real;


 procedure setDefaultSettigns;


 procedure increase(index: integer);
 procedure decrease(index: integer);


IMPLEMENTATION

var KMin, countAnswers : integer;
    step, speed1, speed3, speedIsp, left : real;

procedure setDefaultSettigns;
begin
  setKMin(1000);
  setCountAnswers(11);
  setStep(0.8);
  setSpeed1(2.0);
  setSpeed3(1.0);
  setSpeedIsp(5.0);
  setLeft(1.0);
end;

procedure drawSettings(x : integer);
var s: string;
begin
  str(KMin, s);
  outTextXY(x, 50, 'KMin = ' + s);

  str(countAnswers, s);
  outTextXY(x, 70, 'Amount answers = ' + s);

  str(step:0:2, s);
  outTextXY(x, 90, 'Step = ' + s);

  str(speed1:0:2, s);
  outTextXY(x, 110, 'Speed1 = ' + s);

  str(speed3:0:2, s);
  outTextXY(x, 130, 'Speed3 = ' + s);

  str(speedIsp:0:2, s);
  outTextXY(x, 150, 'SpeedIsp = ' + s);

  str(left:0:2, s);
  outTextXY(x, 170, 'Min = ' + s);
end;

procedure setKMin(kMin0 : integer);
begin
  if (kMin0 >= 500) and (kMin0 <= 15000) then
     kMin := kMin0;
end;

procedure setCountAnswers(countAnswers0 : integer);
begin
  if(countAnswers0 in[10..50]) then
    countAnswers := countAnswers0;
end;

procedure setStep(step0 : real);
begin
    if(step0 >= 0.1) and (step0 <= 5.1) then begin
        step := step0;
    end;
end;

procedure setSpeed1(speed : real);
begin
   if(speed > 0.05) and (speed <= 5.0) then begin
       speed1 := speed;
   end;
end;

procedure setSpeed3(speed : real);
begin
   if(speed > 0.05) and (speed <= 5.0) then begin
       speed3 := speed;
   end;
end;

procedure setSpeedIsp(speed : real);
begin
   if(speed > 0.05) and (speed <= 10.0) then begin
       speedIsp := speed;
   end;
end;

procedure setLeft(left0 : real);
begin
    if(left0 > 0.05) then
      left := left0;
end;

function getStep : real;
begin
    getStep := step;
end;

function getKMin : integer;
begin
  getKMin := kMin;
end;

function getCountAnswers : integer;
begin
    getCountAnswers := countAnswers;
end;

function getSpeed1 : real;
begin
    getSpeed1 := speed1;
end;

function getSpeed3 : real;
begin
    getSpeed3 := speed3;
end;

function getSpeedIsp : real;
begin
    getSpeedIsp := speedIsp;
end;

function getLeft : real;
begin
    getLeft := left;
end;

procedure increase(index: integer);
begin
   case index of
     1: setKMin(kMin + 100);
     2: setCountAnswers(countAnswers + 1);
     3: setStep(step + 0.1);
     4: setSpeed1(speed1 + 0.1);
     5: setSpeed3(speed3 + 0.1);
     6: setSpeedIsp(speedIsp + 0.1);
     7: setLeft(left + 0.1);
   end;
end;


procedure decrease(index: integer);
begin
   case index of
     1: setKMin(kMin - 100);
     2: setCountAnswers(countAnswers - 1);
     3: setStep(step - 0.1);
     4: setSpeed1(speed1 - 0.1);
     5: setSpeed3(speed3 - 0.1);
     6: setSpeedIsp(speedIsp - 0.1);
     7: setLeft(left - 0.1);
   end;
end;

END.