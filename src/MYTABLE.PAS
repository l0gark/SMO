unit MyTable;

INTERFACE

uses TypeAns, Tools, Graph, crt;

const COUNT_COLUMN = 6;
      SPACE = 30;
      CELL_HEIGHT = 20;

type Column = object
  name : string;
  a : answers;
end;

type CellArray = array [1..COUNT_COLUMN] of column;

procedure drawTable(columns : CellArray);

IMPLEMENTATION

procedure drawCell(xCentre, yTop : integer; text : string);
var width, height : integer;
begin
  width := textWidth(text);
  height := textHeight(text);
  outTextXY(xCentre - width div 2,
            yTop + CELL_HEIGHT div 2 - height div 2,
            text);
end;

procedure drawColumn(col : Column; x1, x2 : integer);
var XCentre, y, i: integer;
    text : string;
begin
    xCentre := x1 + (x2 - x1) div 2;
    y := SPACE;
    drawCell(xCentre, y, col.name);

    {vertical lines}
    line(x1, y, x1, y + (getCountAnswers + 1) * CELL_HEIGHT);
    line(x2, y, x2, y + (getCountAnswers + 1) * CELL_HEIGHT);

    for i := 1 to getCountAnswers do begin
        y := y + CELL_HEIGHT;
        str(col.a[i]:0:3, text);
        drawCell(xCentre, y, text);
    end;

end;

procedure drawTable(columns : CellArray);
var widthColumn, x , width, i: integer;
begin
  width := getMaxX;
  widthColumn := (width - 2 * SPACE) div COUNT_COLUMN;
  x := SPACE;

  {horizontal lines}
   line(SPACE, SPACE, x + widthColumn * COUNT_COLUMN, SPACE);
   line(SPACE, SPACE + CELL_HEIGHT, x + widthColumn * COUNT_COLUMN, SPACE + CELL_HEIGHT);
   line(SPACE,
        SPACE + CELL_HEIGHT * (getCountAnswers + 1),
        x + widthColumn * COUNT_COLUMN,
        SPACE + CELL_HEIGHT * (getCountAnswers + 1));

   for i := 1 to COUNT_COLUMN do begin
      delay(50);
      drawColumn(columns[i], x, x + widthColumn);
      x := x + widthColumn;
  end;
end;
END.
