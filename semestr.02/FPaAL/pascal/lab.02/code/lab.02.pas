program lab02;

uses crt;

type 
	TNodePointer=^TNode;
	TData=record
		id:integer;
		origin,destination:string[16];
		time_departure,time_arrival:string[5];
		price:integer;
	end;
	TNode=record
		data:TData;
		left,right:TNodePointer;
	end;
	TDataFile=file of TData;

var root:TNodePointer;

procedure free(node:TNodePointer);
begin
	if(node <> nil) then begin
		free(node^.left);
		free(node^.right);
		dispose(node);
	end;
end;

procedure put(cur,node:TNodePointer);
begin
	if(cur^.data.id > node^.data.id) then begin
		if(cur^.left = nil) then
			cur^.left:= node
		else
			put(cur^.left,node);
	end else begin
		if(cur^.right = nil) then
			cur^.right:= node
		else
			put(cur^.right,node);
	end;
end;

procedure read_file;
var f:file of TData;
    tmpp:TNodePointer;
begin
	assign(f,'data.bin');
	reset(f);
	if(root <> nil) then
		free(root);
	root:= nil;
	while(not(EOF(f))) do begin
		new(tmpp);
		read(f,tmpp^.data);
		tmpp^.left:= nil;
		tmpp^.right:= nil;
		if(root = nil) then
			root:= tmpp
		else
			put(root,tmpp);
	end;
	close(f);
end;

procedure writef(var f:TDataFile;tmpp:TNodePointer);
begin
	if(tmpp <> nil) then begin
		writef(f,tmpp^.left);
		writef(f,tmpp^.right);
		write(f,tmpp^.data);
	end;
end;

procedure write_file;
var f:file of TData;
begin
	assign(f,'data.bin');
	rewrite(f);
	writef(f,root);
	close(f);
end;

function input:TNodePointer;
var tmpp:TNodePointer;
begin
	new(tmpp);
	write('������� ����� ������: ');
	readln(tmpp^.data.id);
	write('������� ����� �����������: ');
	readln(tmpp^.data.origin);
	write('������� ����� ����������: ');
	readln(tmpp^.data.destination);
	write('������� ����� �����������: ');
	readln(tmpp^.data.time_departure);
	write('������� ����� ��������: ');
	readln(tmpp^.data.time_arrival);
	write('������� ��������� ������: ');
	readln(tmpp^.data.price);
	tmpp^.left:= nil;
	tmpp^.right:= nil;
	input:= tmpp;
end;

procedure organize;
var c:char;
begin
	if(root <> nil) then
		free(root);
	writeln('����������� �����������');
	root:= input;
	writeln('�������� ������� ��������');
	writeln('����������? (y/n)');
	readln(c);
	while(c = 'y') do begin
		clrscr;
		put(root,input);
		writeln('����������? (y/n)');
		readln(c);
	end;
end;

procedure print_left;
var tmpp:TNodePointer;
begin
	tmpp:= root;
	while(tmpp^.left <> nil) do	
		tmpp:= tmpp^.left;
	writeln('+-------+-------------+-------------+-------------+-------------+----------+');
	writeln('| ����� | ����������� |  ���������� | ����������� |   ��������  |   ����   |');
	writeln('+-------+-------------+-------------+-------------+-------------+----------+');
	with tmpp^.data do
		writeln('|',id:7,'|',origin:13,'|',destination:13,'|',time_departure:13,'|',time_arrival:13,'|',price:10,'|');
	writeln('+-------+-------------+-------------+-------------+-------------+----------+');
	writeln('��� ����������� ������� ������� Enter');
	readln;
end;



procedure print(node:TNodePointer);
begin
	if(node = root) then begin
    writeln('+-------+-------------+-------------+-------------+-------------+----------+');
    writeln('| ����� | ����������� |  ���������� | ����������� |   ��������  |   ����   |');
    writeln('+-------+-------------+-------------+-------------+-------------+----------+');
	end;
	if(node <> nil) then begin
		print(node^.left);
		with node^.data do
			writeln('|',id:7,'|',origin:13,'|',destination:13,'|',time_departure:13,'|',time_arrival:13,'|',price:10,'|');
    writeln('+-------+-------------+-------------+-------------+-------------+----------+');
		print(node^.right);
	end;
	if(node = root) then begin
		writeln('��� ����������� ������� ������� Enter');
		readln;
	end;
end;

procedure print_map(node:TNodePointer;tab:integer);
begin
	if(node<>nil) then begin
		tab:= tab+3;
		print_map(node^.right,tab);
		writeln('':tab,node^.data.id);
		print_map(node^.left,tab);
		if(tab = 3) then begin
			writeln('��� ����������� ������� ������� Enter');
			readln;
		end;
	end;
end;

var c:char;
begin
	root:= nil;
	if(fileexists('data.bin')) then
		read_file;
	repeat
		clrscr;
		writeln('�������� ��������:');
		writeln('1 - �����������');
		writeln('2 - ����������');
		writeln('3 - ������ �����������');
		writeln('4 - ������ ������ ������ �����');
		writeln('5 - ������ ���������');
		writeln('6 - �����');
		readln(c);
		clrscr;
		case c of
			'1':organize;
			'2':put(root,input);
			'3':print(root);
			'4':print_left;
			'5':print_map(root,0);
		end;
		write_file;
	until c = '6';
	free(root);
end.
