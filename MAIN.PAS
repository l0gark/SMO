program main;
uses FuncUnit, TypeAns, Screen, Tools, crt;

var
   mIsp : isp; a : arr;
   speed2 : real;
   i, j, index : integer;
   ch: char;

   needRestart: boolean;
   probs: array[1..3] of answers;
   coefs1 : answers;
   avgTimes2 : answers;

procedure init(var mIsp: isp; var a : arr);
var i : integer;
begin
  assign(output, 'outsmo.txt');
  rewrite(output);
  setDefaultSettigns;
end;

procedure quit;
begin
   close(output);
end;

procedure work;
var i, j : integer;
begin
  speed2 := getLeft;

  writeln('-----------------------------------------');
  for i := 1 to getCountAnswers do begin
		emulate(i, mIsp, a, speed2, getKMin);

    writeAnswers2(a, speed2);
    for j := 1 to 3 do begin
      probs[j][i] := a[j].countBad / a[j].count;
    end;

   	coefs1[i] := a[1].fullTime / getTime(a);
	  avgTimes2[i] := a[2].fullTime / a[2].countGood;
		speed2 := speed2 + getStep;
	end;

end;

procedure life;
begin

  createMenu2(1);
  createMenu2(2);
  createMenu(3, probs[1]);
  createMenu(4, probs[2]);
  createMenu(5, probs[3]);
  createMenu(6, coefs1);
  createMenu(7, avgTimes2);
  createMenu2(8);

  initScreen;
  needRestart := false;
  while true do begin
    ch := readKey;
    if(ch = #77) then toRight;
    if(ch = #75) then toLeft;

    if(ch = #72) then toDown;
    if(ch = #80) then toUp;


    if(ch = #13) then select;

    if (ch = 'r') or (ch = 'R') or (ch = 'Š') or (ch = 'ª')  then begin
        needRestart := true;
        break;
    end;

    if (ch = 'q') or (ch = 'Q') or (ch = '©') or (ch = '‰') then break;
  end;

end;

begin
	init(mIsp, a);

  needRestart := true;
  while needRestart do begin
    work;
    life;
  end;

	quit;
end.