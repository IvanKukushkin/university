program lab6;
uses crt;
var
	si,x_begin,x_end,dx,y,x,E:real;
	i:integer;
begin
clrscr;
writeln('������� �������� x ���������');
readln(x_begin); 
writeln;
writeln('������� �������� x ��������');
readln(x_end);
writeln;
writeln('������� �������� ���� dx');
readln(dx);
writeln;
writeln('������� �������� E');
readln(E);
writeln;
x:=x_begin;
if (x>x_end) then begin {��� ������, ���� �������� ������ ���������}
	writeln('�������� �-���������� ������ �-���������');
	writeln('������� ���');
end else begin
    while (x<=x_end) do begin {���� �� X-��}
		si:=-x;
		y:=1+si;
		i:=0;
		while (abs(si)>E) do begin {�������� ��������}
			inc(i); {C����� ���������������� ��������� ����}
			si:=si*(-x/(i+1));  
			y:=y+si;                             
		end;
		writeln('x=',x,' y=',y,' ���������� ���������������� ������ ���� ',i);
		x:=x+dx; {���}
	end;
end;
readln;
end.
