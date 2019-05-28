unit OnGraph;

INTERFACE

uses Graph, crt, TypeAns;

const COUNT_HATCH = 10;

procedure drawNextPoint(ry : real; nk : integer);
procedure initMyGraph(num : integer);

IMPLEMENTATION

const k = 25;
      COUNT_POINT = 400;
var h, w, x0, y0 : integer;
    gd, gm : integer;
    dx, dy, y1, x1: real;
    speed2, max, ms, min, dry, ds : real;
    s : string;

function getY(ry : real):integer;
begin
     getY := y0 - round(ry  * ms);
end;

procedure drawNextPoint(ry: real; nk : integer);
begin
  if (nk mod 5 = 0) then delay(1);
  if(nk > COUNT_POINT) then exit;
  setColor(Green);
  circle(round(x1), getY(ry), 1);
  x1 := x1 + dx;
end;

procedure initMyGraph(num : integer);
var i : integer;
begin

  gd := Detect;

  initGraph(gd, gm, '');
  clearDevice;

  h := getMaxY;
  w := getMaxX;
  x0 := 3 * k;
  y0 := h - k;
  setColor(Yellow);
  line(x0, y0, w - k, y0);
  line(x0, y0, x0, k);

  dry := (1.0 - 0.0) / COUNT_HATCH;
  dx := (w - 4 * k) / COUNT_POINT;
  dy := (h - 3 * k) / COUNT_HATCH;
  ms :=(h - 3 * k) / (1.0 - 0.0);

  y1 := y0 - k;
  speed2 := 0;

  str(num, s);
  outTextXY(5 * k, 2 * k , s);
  {horizontal lines}
  for i := 1 to COUNT_HATCH + 1 do begin
     line(x0 - 2, round(y1), x0 + 2, round(y1));
     str(speed2:0:2, s);
     outTextXY(x0 - 2 * k, round(y1), s);
     speed2 := speed2 + dry;
     y1 := y1 - dy;
  end;

  x1 := x0;

  speed2 := 0.0;
  ds := COUNT_POINT / 5;

  {vertical lines }
  for i := 1 to COUNT_ANSWERS do begin
     line(round(x1), y0 + 2, round(x1), y0 - 2);
     str(round(speed2), s);
     outTextXY(round(x1 - 10), y0 + 10, s);
     x1 := x1 + dx * ds;
     speed2 := speed2 + ds;
  end;

  x1 := x0 + dx;
  setColor(Green);
end;


end.