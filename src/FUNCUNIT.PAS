unit FuncUnit;

interface
uses OnGraph, Tools;

type person = object
	speed, nextTime: real;
    priority: integer;
	procedure setNextTime;
end;

generator = object(person)
	countGood, countBad, count: integer;
	fullTime: real;
	constructor initGenerator(number: integer);
	procedure showResults(number: integer);
	procedure showProbablity(number : integer);

end;

isp = object(person)
	number : integer;
	oldTime : real;
	constructor initIsp;
end;

arr = array [1..3] of generator;

procedure emulate(num: integer; p : isp; var a : arr; speed2 : real; kMin : integer);
procedure writeAnswers2(a : arr; speed2 : real);
function getTime(a : arr): real;
implementation

procedure person.setNextTime;
begin
	nextTime := nextTime - Ln(Random) / speed;
end;

constructor generator.initGenerator(number: integer);
begin
	nextTime := 0;
	priority := number;
	count := 0;
	countGood := 0;
	countBad := 0;
	fullTime := 0;

	case priority of
		1: speed := getSpeed1;
		2: speed := 1;
		3: speed := getSpeed3;
	end;

	if number <> 2 then setNextTime;
end;

procedure generator.showResults(number : integer);
begin
     writeln(number, '. real =  ', countBad + countGood, '  ||  teor = ', count);
end;

constructor isp.initIsp;
begin
	priority := 10;
	speed := getSpeedIsp;
	number := 0;
	nextTime := 1000000.0;
end;

procedure generator.showProbablity(number : integer);
begin
    write(countBad / count:0:3, ' | ');
end;



function getMinIndexTime(var a: arr; var p : isp): integer;
var minIndex, i : integer;
begin
	minIndex := 1;
	for i := 2 to 3 do
		if(a[minIndex].nextTime > a[i].nextTime) then
			minIndex := i;

	if(a[minIndex].nextTime > p.nextTime) then
		minIndex := -1;

	getMinIndexTime := minIndex;
end;

function getMinCount(a: arr):integer;
var min, i : integer;
begin
	min:= a[1].count;
	for i := 2 to 3 do
		if(min > a[i].count) then
			min := a[i].count;
	getMinCount := min;
end;

function getProbability(a : arr): real;
var count, countBad, i : integer;
begin
	count := 0;
	countBad := 0;
	for i := 1 to 3 do  begin
		count := count + a[i].count;
		countBad := countBad + a[i].countBad;
	end;
	getProbability := countBad / count;
end;



function getSum(a : arr): integer;
var sum, i : integer;
begin
	sum := 0;
	for i := 1 to 3 do  begin
		sum := sum + a[i].count;
	end;
	getSum := sum;
end;



function getTime(a : arr): real;
var i : integer;
	time : real;
begin
	time := 0;
	for i := 1 to 3 do
		time := time + a[i].fullTime;
	getTime := time;
end;

function getAvgTime(a: arr; i : integer): real;
begin
    if(a[i].countGood = 0) then
      getAvgTime := 0
    else
      getAvgTime := a[i].fullTime / a[i].countGood;
end;

procedure writeAnswers2(a : arr; speed2 : real);
var i: integer;
begin
  write(speed2:0:2, ' | ');

 	for i := 1 to 3 do
        a[i].showProbablity(i);

	write(a[1].fullTime / getTime(a):0:3, ' | ');

  for i := 1 to 3 do
    write(getAvgTime(a, i):0:3, ' | ');

  writeln;
end;

procedure emulate(num : integer; p : isp; var a : arr; speed2 : real; kMin : integer);
var
	i, actualIndex: integer;
begin
    randomize;

    p.initIsp;
    for i := 1 to 3 do
      a[i].initGenerator(i);

    a[2].speed := speed2;
    a[2].setNextTime;
    initMyGraph(num);

	while (getMinCount(a) < kMin) do begin
		actualIndex := getMinIndexTime(a, p);
		{Isp end the work}
		if(actualIndex < 0) then begin
			inc(a[p.number].countGood);

			a[p.number].fullTime := a[p.number].fullTime + p.nextTime - p.oldTime;
			p.initIsp;
			continue;
		end;

		inc(a[actualIndex].count);
    if(actualIndex = 1) then
          drawNextPoint(a[1].countBad / a[1].count, a[1].count);

		{New Request change old}
		if (a[actualIndex].priority < p.priority) then begin
			p.priority := a[actualIndex].priority;
			if (p.number > 0) then inc(a[p.number].countBad);
			p.number := actualIndex;
			p.nextTime := a[actualIndex].nextTime;
			p.oldTime := p.nextTime;
			p.setNextTime;

		end else{This request was closed}
			inc(a[actualIndex].countBad);

		a[actualIndex].setNextTime;
	end;

end;

end.