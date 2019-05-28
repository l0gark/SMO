unit Screen;

INTERFACE

uses Graph, Menu, MyGraph, TypeAns, Tools, MyTable;

const

  names: array [1..COUNT_TABS] of string = ('Help', 'Settings', 'Prob1',
  										  'Prob2', 'Prob3', 'CoefBusy1', 'AvgTime2', 'Table');

procedure createMenu2(i: integer);
procedure createMenu(i: integer; ans: answers);

procedure toLeft;
procedure toRight;
procedure toUp;
procedure toDown;

procedure select;
procedure initScreen;

IMPLEMENTATION

var
  gd, gm, indexTab: integer;

  a: arrTabs;


procedure drawHelp;
begin
  setColor(Yellow);
  outTextXY(50, 50, 'Use arrows on your keyboard to navigate in app');
  outTextXY(50, 70, 'Click "R" or "r" to restart simulation');
  outTextXY(50, 90, 'Click "Q" or "q" to quit app');
end;

procedure drawMenu;
var
  i: integer;
begin
  for i := 1 to COUNT_TABS do
    a[i].draw(i, round(GetMaxX / COUNT_TABS), indexTab);
end;

procedure redraw;
var table : CellArray;
    i, indexResult : integer;
    speed2 : real;
begin
  clearDevice;
  drawMenu;
  if (a[indexTab].isGraph) then drawGraph(a[indexTab].tabs[0], a[indexTab].ans);
  if(indexTab = 1) then drawHelp;
  if(indexTab = 2) then drawSettings(getMaxX - 300);
  if(indexTab = 8) then begin
     indexResult := 1;
     {set data}

     table[1].name := 'Speed2';
     speed2 := getLeft;

     for i := 1 to getCountAnswers do begin
         table[1].a[i] := speed2;
         speed2 := speed2 + getStep;
     end;
     indexResult := 2;

     for i := 1 to COUNT_TABS do begin
      if(a[i].isGraph) then begin
        table[indexResult].name := a[i].tabs[0];
        table[indexResult].a := a[i].ans;
        inc(indexResult);
      end;
     end;
     drawTable(table);
  end;
end;

procedure createMenu(i: integer; ans: answers);
begin
  if i in [1..COUNT_TABS] then
    a[i].init2(names[i], ans);
end;

procedure createMenu2(i: integer);
begin
  if i in [1..COUNT_TABS] then
    a[i].init1(names[i]);
  if(i = 2) then begin
    a[i].setNext('KMin');
    a[i].setNext('Answers');
    a[i].setNext('Step');
    a[i].setNext('Speed1');
    a[i].setNext('Speed3');
    a[i].setNext('SpeedIsp');
    a[i].setNext('Min');
  end;
end;

procedure initScreen;
begin
  gd := Detect;
  InitGraph(gd, gm, '');
  indexTab := 3;
  redraw;
end;

procedure toLeft;
begin
  if(a[indexTab].index <> 0) and (indexTab = 2) then begin
    decrease(a[indexTab].index);
    redraw;
    exit;
  end;

  if(indexTab > 1) then begin
    a[indexTab].close;
    indexTab := indexTab - 1;
    drawMenu;
  end;
end;

procedure toRight;
begin
  if(a[indexTab].index <> 0) and (indexTab = 2) then begin
    increase(a[indexTab].index);
    redraw;
    exit;
  end;

  if(indexTab < COUNT_TABS ) then begin
    a[indexTab].close;
    indexTab := indexTab + 1;
    drawMenu;
  end;
end;

procedure toUp;
begin
  if(a[indexTab].isOpen) and (a[indexTab].index < a[indexTab].n - 1) then begin
    inc(a[indexTab].index);
    drawMenu;
  end;
end;

procedure toDown;
begin
  if(a[indexTab].isOpen) and (a[indexTab].index > 0) then begin
    dec(a[indexTab].index);
    drawMenu;
  end;
end;

procedure select;
begin
  if not (a[indexTab].isOpen) then begin
    a[indexTab].open;
  end else begin
    if(a[indexTab].index = 0) then a[indexTab].close;
    if(indexTab = 2) then
      case a[indexTab].index of
        1:
      end;
  end;

  redraw;
end;



END.