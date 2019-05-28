unit MyGraph;

INTERFACE

uses Graph, TypeAns, crt, Tools;

const COUNT_HATCH = 10;
procedure drawGraph(name : string; a : answers);

IMPLEMENTATION

const k = 20;
var h, w, x0, y0 : integer;
    gd, gm : integer;
    dx, dy, y1, x1: real;
    speed2, max, ms, min, dry , ds: real;
    s : string;

function getY(ry : real):integer;
begin
     getY := y0 - round( ry * ms );
end;

procedure drawGraph(name : string; a : answers);
var i : integer;
begin

  h := getMaxY;
  w := getMaxX;
  x0 := 3 * k;
  y0 := h - k;
  setColor(Yellow);
  line(x0, y0, w - k, y0);
  line(x0, y0, x0, k);

  dry := (1.0 - 0.0) / COUNT_HATCH;
  dx := (w - 4 * k) div getCountAnswers;
  dy := (h - 2 * k) / COUNT_HATCH;
  ms :=(h - 2 * k) / (1.0 - 0.0);

  y1 := y0;
  speed2 := 0.0;

  outTextXY(w - 5 * k, h - 5 * k , name);
  {horizontal lines}
  for i := 0 to COUNT_HATCH do begin
     y1 := y0 - dy * i;
     line(x0 - 2, round(y1), x0 + 2, round(y1));
     str(speed2:0:2, s);
     outTextXY(x0 - 2 * k, round(y1), s);
     speed2 := speed2 + dry;
  end;

  x1 := x0;

  speed2 := 0.0;
  ds := getCountAnswers / 5;

  {vertical lines }
  for i := 1 to getCountAnswers do begin
     line(round(x1), y0 + 2, round(x1), y0 - 2);
     str(speed2:0:1, s);
     outTextXY(round(x1 - 10), y0 + 10, s);
     x1 := x1 + dx * ds;
     speed2 := speed2 + ds;
  end;

  x1 := x0 + dx;
  setColor(Green);

  for i := 2 to getCountAnswers do begin
      line(round(x1 - dx),
           getY(a[i-1]),
           round(x1),
           getY(a[i]));

      delay(15);
      x1 := x1 + dx;
  end;

end;
END.