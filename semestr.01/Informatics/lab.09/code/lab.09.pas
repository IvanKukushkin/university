Program lab10;

Const l='';

Uses Crt;

Type Aeroflot=record
		Pyn:string[15];
		Num:string[8];
		Tip:string[8];
	end;
	
Var
	X:char;
	F:file of Aeroflot;
	El1,el2:Aeroflot;
	P,n,t,pl,nl,tl,k,sr:word;
	Way:string[30];
	
Procedure dobav;
Begin
	Clrscr;
	Seek(f,FileSize(f));
	While true do Begin
		Writeln('������� ������:');
		Writeln('(��� ������ �������� ������ ���� �������)');
		Write('����� ����������: ');
		Readln(el1.pyn);
		If el1.pyn='' then 
			break;
		Write('����� �����: ');
		Readln(el1.num);
		Write('��� ��������: ');
		Readln(el.tip);
		Write(f,el1);
	End;
End;

Procedure sort;
Var I,j:integer;
Begin
	Seek(f,0);
	For i:=FileSize(f)-1 downto 1 do
		For j:=0 to i-1 do Begin
			Seek(f,j);
			Read(f,el1,el2);
			If el1.pyn>el2.pyn then Begin
				Seek(f,j);
				Write(f, el2,el1);
			End;
		End;
End;
Function kol (el:string; sr:word):word;
Begin
K:=length(el);
If odd(k) then kol:=sr+(k div 2)
Else kol:=sr+(k div 2)-1;
End;
Function kol1 (el:string; sr:word):word;
Begin
K:=length(el);
Ifodd(k) then kol1:=sr-(k div 2)-1
Else kol1:=sr-(k div 2);
End;
Procedure Vivod;
Begin
Clrscr;
Seek(f,0);
Writeln('______________________________________________');
Writeln('| ����� ��������� | ����� ����� | ��� �������� |');
Writeln('-----------------------------------------------------------------------');
While not eof(f) do
Begin
Read(f,el1);
Sr:=11;
P:=kol(el1.pyn,sr);
Pl:=kol1(el1.pyn,sr);
Sr:=9;
N:=kol(el1.num,sr);
Nl:kol1(el1.num,sr);
Sr:=10;
T:=kol(el1.tip,sr);
Tl:=kol1(el1.tip,sr);
Writeln('|',el1.pyn:p,l:pl,'|',el1.num:n,l:nl,'|',el1.tip:t,l:tl,'|');
End;
Writeln('----------------------------------------------------------------------');
Readln;
End;
Procedure Search;
Var
S:string[8];
Found:Boolean;
Begin
Clrscr;
Write('������� ��� ��������: ');
Found:=false;
Seek(f,0);
Writeln('______________________________________________');
Writeln('| ����� ��������� | ����� ����� | ��� �������� |');
Writeln('-----------------------------------------------------------------------');
While not eof(f) do
Begin
Read(f,el1);
If s=el1.tip then
Begin
Read(f,el1);
Sr:=11;
P:=kol(el1.pyn,sr);
Pl:=kol1(el1.pyn,sr);
Sr:=9;
N:=kol(el1.num,sr);
Nl:kol1(el1.num,sr);
Sr:=10;
T:=kol(el1.tip,sr);
Tl:=kol1(el1.tip,sr);
Writeln('|',el1.pyn:p,l:pl,'|',el1.num:n,l:nl,'|',el1.tip:t,l:tl,'|');
Found:=true;
End;
End;
Writeln('---------------------------------------------------------------');
If not Found then writeln('������ ��� �������� �� ���������������.');
Readln'
End;
Begin
Clrscr;
Writeln('������������! ������� ���� � �����(�� ����� 30 ��������):');
Readln(way);
If way='' then exit;
Assign(f,way);
Writeln('������� ������ ������ ��������:');
Writeln('1. ������� ���� ��� ������ ��� ������.');
Writeln('2. ������� ���������� ����� � �������.');
X:=readkey;
If (x<>'1') and (x<>'2') then
Begin
Writeln('�������� �����. ���������� �����.');
Exit;
End;
Case x of
'1':reset(f);
'2':write(f);
End;
While true do
Begin
Clrscr;
Writeln('�������� ������ ��������:');
Writeln('1. �������� ������ � ����.');
Writeln('2. ����� ������� ������.');
Writeln('3. ����� � ������� �� ���� ��������.');
Writeln('4. �����.');
X:=readkey;
Case x of
'1':begin dobav; sort; end;
'2':vivod;
'3':search;
'4':begin close(f); exit; end;
End;
End;
End.