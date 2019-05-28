unit TypeAns;

interface
const COUNT_ANSWERS = 20;

type answers = array [1..50] of real;

function getMax(a : answers):real;
function getMin(a : answers) : real;

implementation

function getMax(a : answers) : real;
var i, maxIndex : integer;
begin
   maxIndex := 1;
   for i := 2 to COUNT_ANSWERS do begin
       if (a[maxIndex] < a[i] )  then
           maxIndex := i;
   end;
   getMax := a[maxIndex];
end;

function getMin(a : answers) : real;
var i, minIndex : integer;
begin
   minIndex := 1;
   for i := 2 to COUNT_ANSWERS do begin
       if (a[minIndex] > a[i] )  then
           minIndex := i;
   end;
   getMin := a[minIndex];
end;

end.