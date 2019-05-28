unit Menu;

interface
uses Graph, TypeAns;

const COUNT_TABS = 8;
type
  tab = object
  	n, index : integer;
  	isOpen, isGraph : boolean;
    ans : answers;

  	tabs : array [0..10] of string;
  	constructor init2(name : string; ans0 : answers);
    constructor init1(name: string);
  	procedure setNext(name : string);
  	procedure draw(i, width, indexTab : integer);
  	procedure open;
  	procedure close;
  end;

  arrTabs = array [1..COUNT_TABS] of tab;

IMPLEMENTATION
	const
		  height = 10;

  constructor tab.init1(name : string);
  begin
    tabs[0] := name;
    n := 1;
    isGraph := false;
  end;

	constructor tab.init2(name : string; ans0 : answers);
	begin
    tabs[0] := name;
    isGraph := true;
    ans := ans0;
		n := 1;
	end;

	procedure tab.setNext(name : string);
	begin
		tabs[n] := name;
		n := n + 1;
	end;

	procedure tab.open;
	begin
		isOpen := true;
	end;

	procedure tab.close;
	begin
		isOpen := false;
		index := 0;
	end;

	procedure tab.draw(i, width, indexTab : integer);
	var j : integer;
	begin
		for j := 0 to n - 1 do begin
			if (indexTab = i) and (index = j) then begin
			 	setFillStyle(SolidFill, Green);
		    Bar((i - 1) * width, j * height, i * width, (j + 1) * height);
      end else begin
        setFillStyle(SolidFill, Blue);
        Bar((i - 1) * width, j * height, i * width, (j + 1) * height);
      end;
			setColor(Yellow);
			outTextXY((i - 1) * width, j * height + 1, tabs[j]);

      if not(isOpen) then break;
		end;
	end;
END.