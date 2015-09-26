program lab01;

uses crt;

type TRowPointer=^TRow;
     TRow=record
          id:integer;
          origin,destination:string[16];
          time_departure,time_arrival:string[5];
          price:integer;
          next:TRowPointer;
     end;

var  head,tail:TRowPointer;

procedure free;
var  cur,next:TRowPointer;
begin
     cur:= head;
     while(cur <> nil) do begin
          next:= cur^.next;
          dispose(cur);
          cur:= next;
     end;
     head:= nil;
     tail:= nil;
end;

procedure read_file;
var  f:file of TRow;
     tmpp:TRowPointer;
     tmpe:TRow;
begin
     assign(f,'data.bin');
     reset(f);
     if(head <> nil) then
          free;
     head:= nil;
     tail:= nil;
     while(not(EOF(f))) do begin
          read(f,tmpe);
          new(tmpp);
          tmpp^:= tmpe;
          tmpp^.next:= nil;
          if(head = nil) then begin
               head:= tmpp;
          end else begin
               tail^.next:= tmpp;
          end;
          tail:= tmpp;
     end;
     close(f);
end;

procedure write_file;
var  f:file of TRow;
     tmpp:TRowPointer;
begin
     assign(f,'data.bin');
     rewrite(f);
     tmpp:= head;
     while(tmpp <> nil) do begin
          write(f,tmpp^);
          tmpp:= tmpp^.next;
     end;
     close(f);
end;

function input:TRowPointer;
var  tmpp:TRowPointer;
begin
	new(tmpp);
	write('������� ����� ������: ');
	readln(tmpp^.id);
	write('������� ����� �����������: ');
	readln(tmpp^.origin);
	write('������� ����� ����������: ');
	readln(tmpp^.destination);
	write('������� ����� �����������: ');
	readln(tmpp^.time_departure);
	write('������� ����� ��������: ');
	readln(tmpp^.time_arrival);
	write('������� ��������� ������: ');
	readln(tmpp^.price);
	tmpp^.next:= nil;
	input:= tmpp;
end;

procedure add_head;
var  tmpp:TRowPointer;
begin
     writeln('���������� �������� � ������');
     tmpp:= input;
     tmpp^.next:= head;
     head:= tmpp;
     writeln('������� ��������');
     writeln('��� ����������� ������� ������� Enter');
     readln;
end;

procedure add_tail;
var  tmpp:TRowPointer;
begin
     if(tail = nil) then begin
          writeln('����������� ������ ���� �������������');
          exit;
     end;
     writeln('���������� �������� � �����');
     tmpp:= input;
     tail^.next:= tmpp;
     tail:= tmpp;
     writeln('������� ��������');
     writeln('��� ����������� ������� ������� Enter');
     readln;
end;

procedure organize;
var  tmpp:TRowPointer;
     c:char;
begin
     if(head <> nil) then
          free;
     writeln('����������� �����������');
     tmpp:= input;
     head:= tmpp;
     tail:=tmpp;
     writeln('������ ������� ��������');
     writeln('����������? (y/n)');
     readln(c);
     while(c = 'y') do begin
          clrscr;
          add_tail;
          writeln('����������? (y/n)');
          readln(c);
     end;
end;

procedure remove;
var  prev,cur,next:TRowPointer;
     needle:integer;
begin
     if(head = nil) then begin
          writeln('����������� ������ ���� �������������');
          exit;
     end;
     write('������� ����� ������ ��� ��������: ');
     readln(needle);
     if(head^.id = needle) then begin 
          cur:= head;
          head:= head^.next;
          dispose(cur);
     end else begin
          prev:= head;
          cur:= prev^.next;
          while(cur <> nil) do begin
               next:= cur^.next;
               if(cur^.id = needle) then begin
                    prev^.next:= next;
                    dispose(cur);
                    cur:= nil;
               end else begin
                    prev:= cur;
                    cur:= next;
               end;
          end;
     end;
     writeln('������� ����� �� ����������� ��� �� ����������� � ��� �����');
     writeln('��� ����������� ������� ������� Enter');
     readln;
end;

procedure print;
var tmpp:TRowPointer;
begin 
     tmpp:= head;
     writeln('+-------+-------------+-------------+-------------+-------------+----------+');
     writeln('| ����� | ����������� |  ���������� | ����������� |   ��������  |   ����   |');
     writeln('+-------+-------------+-------------+-------------+-------------+----------+');
     while(tmpp <> nil) do begin
          writeln('|',tmpp^.id:7,'|',tmpp^.origin:13,'|',tmpp^.destination:13,'|',tmpp^.time_departure:13,'|',tmpp^.time_arrival:13,'|',tmpp^.price:10,'|');
          writeln('+-------+-------------+-------------+-------------+-------------+----------+');
          tmpp:= tmpp^.next;
     end;
     writeln('��� ����������� ������� ������� Enter');
     readln;
end;

var  c:char;
begin
     head:= nil;
     tail:= nil;
     if(fileexists('data.bin')) then
          read_file;
     repeat
          clrscr;
          writeln('�������� ��������:');
          writeln('1 - �����������');
          writeln('2 - ���������� � ������');
          writeln('3 - ���������� � �����');
          writeln('4 - �������� ��������');
          writeln('5 - ������ �����������');
          writeln('6 - �����');
          readln(c);
          clrscr;
          case c of
               '1':organize;
               '2':add_head;
               '3':add_tail;
               '4':remove;
               '5':print;
          end;
          write_file;
     until c = '6';
     free;
end.