program Ej01;

uses sysutils, strutils;

type
	registro=record
		apellido:string[20];
		nombre:string[40];
		codigo: integer;
		estado:boolean;
	end;
	archivo=file of registro;
var 
	r_cliente: registro;
	clientes:archivo;
	wwait:char;
	menuoption:integer;

procedure listado(var clientes:archivo; var r_cliente:registro);
var
	i:integer;
begin
	i:=-1;
	reset(clientes);
	seek(clientes,0);
	while not eof(clientes) do
		begin
			inc(i);
			read(clientes,r_cliente);
			if r_cliente.estado then
			begin
				with r_cliente do
				writeln(i,' ',apellido,' ', nombre, ' ', codigo, ' ', estado);
			end;
		end;
	close(clientes);
	readkey;
end;

procedure consulta(var clientes:archivo; var r_cliente:registro);
var
	posicion:integer;
begin
	reset(clientes);
	write('ingrese la posicion: ');
	readln(posicion);
	if ((posicion >= 0) and (posicion < filesize(clientes))) then
	begin
		seek(clientes,posicion);
		read(clientes,r_cliente);
		if r_cliente.estado then
			begin
				seek(clientes,posicion);
				read(clientes,r_cliente);
				with r_cliente do
				writeln(apellido,' ', nombre, ' ', codigo, ' ', estado);
			end
		else
			writeln('El cliente no existe');	
	end
	else
		writeln('El cliente no existe');
	close(clientes);
	readkey;
end;


procedure altas(var clientes:archivo; var r_cliente:registro);
var
	posicion:integer;
	apellido1:string[20];
	nombre1:string[40];
	codigo1:integer;
begin
	reset(clientes);
	writeln('Ingrese posicion:');
	readln(posicion);
		if posicion >= 0 then
			begin
				writeln('Ingrese apellido: ');
				readln(apellido1);
				writeln('Ingrese nombre: ');
				readln(nombre1);
				writeln('Ingrese codigo: ');
				readln(codigo1);
				seek(clientes,posicion);
				r_cliente.apellido:=apellido1;
				r_cliente.nombre:=nombre1;
				r_cliente.codigo:=codigo1;
				r_cliente.estado:=true;
				seek(clientes,posicion);
				write(clientes,r_cliente);		
			end
		else
			writeln('Posicion invalida');
readkey;		
close(clientes);
end;



procedure bajas (var clientes:archivo; var r_cliente:registro);
var
	posicion:integer;
begin
reset(clientes);
writeln('Ingrese la posicion del cliente');
readln(posicion);
if ((posicion >= 0) and (posicion < filesize(clientes))) then
	begin
	seek(clientes,posicion);
	if r_cliente.estado then
		begin
		seek(clientes,posicion);
		read(clientes,r_cliente);
		r_cliente.estado:=false;
		seek(clientes,posicion);
		write(clientes,r_cliente);
		writeln('Cliente dado de baja');
		end
	else
	writeln('El cliente no existe, ingrese otra posicion');
	end
else
	writeln('Posicion invalida');

readkey;
close(clientes);
end;




procedure modificaciones (var clientes:archivo; var r_cliente:registro);
var
	posicion:integer;
	apellido1:string[20];
	nombre1:string[40];
	codigo1:integer;
begin
reset(clientes);
writeln('Ingrese posicion del cliente');
readln(posicion);
if ((posicion >= 0) and (posicion < filesize(clientes))) then
	begin
		seek(clientes,posicion);
		read(clientes,r_cliente);
		if r_cliente.estado then
			begin
				seek(clientes,posicion);
				writeln('Ingrese apellido: ');
				readln(apellido1);
				writeln('Ingrese nombre: ');
				readln(nombre1);
				writeln('Ingrese codigo: ');
				readln(codigo1);
				seek(clientes,posicion);
				r_cliente.apellido:=apellido1;
				r_cliente.nombre:=nombre1;
				r_cliente.codigo:=codigo1;
				seek(clientes,posicion);
				write(clientes,r_cliente);
			end
		else
			writeln('El cliente se encuentra dado de baja');
	end	
else
	writeln('Posicion invalida');
	
close(clientes);
end;



BEGIN
assign(clientes, 'C:\Users\enzob\Desktop\Ej01\clientes.dat');
reset(clientes);
menuoption:=0;
	
while menuoption<>6 do
	begin
		clrscr;
		textcolor(white);
		gotoxy(5,3); 
		writeln('Menu');
		gotoxy(7,5);
		writeln('1_ Mostrar listado completo.');
		gotoxy(7,7);
		writeln('2_ Alta.');
		gotoxy(7,9);
		writeln('3_ Baja.');
		gotoxy(7,11);
		writeln('4_ Modificacion.');
		gotoxy(7,13);
		writeln('5_ Consulta.');
		gotoxy(7,15);
		writeln('6_ Salir');
		
		gotoxy(32,20);
		write('Elija una opcion: ');	
		read(menuoption);
		case menuoption of
			1: listado(clientes,r_cliente);
			2: altas(clientes,r_cliente);
			3: bajas(clientes,r_cliente);
			4: modificaciones(clientes,r_cliente);
			5: consulta(clientes,r_cliente);
			6: begin
				clrscr; 
				gotoxy(3,3);
				writeln('Hasta luego.');
				end;
		else
			gotoxy(2,25);
			writeln('Opcion incorrecta');
			read(wwait);
		end;
	end;		
END.

