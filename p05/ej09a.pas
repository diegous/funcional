program P05EJ09;

var
  numbers:array[1..10] of integer = (1,2,3,4,5,6,7,8,9,10);
  result:array[1..10] of integer;
  i:integer;
  j:integer;
begin
  j := 0;

  for i := 1 to 10 do
  begin
    if odd(numbers[i]) then
    begin
      j := j + 1;
      result[j] := numbers[i];
    end
  end;

  writeln('Odd numbers:');
  for i := 1 to j do
  begin
    writeln(result[i]);
  end;
end.
