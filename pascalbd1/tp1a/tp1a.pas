program tp1a;
Uses sysutils;
type
    
    treg= record
        Apellido: string;
        Nombre: string;
        Cliente: string;
    end;
    f= file of treg;

    procedure Agregar();
    var arch: f;
        reg: treg;

    begin
        assign (arch,'Prueba.dat');
        Reset (arch);

        seek(arch,filesize(arch));
        WriteLn('Escriba su numero de cliente');
        readln(reg.Cliente);
                

        while (reg.Cliente <> '0') do begin
            seek(arch,filesize(arch));
            WriteLn('Escriba su apellido');
            readln(reg.Apellido);
            WriteLn('Escriba su nombre');
            readln(reg.Nombre);
            write(arch,reg);
            WriteLn('Escriba 0 en numero de cliente para salir');
            WriteLn('Escriba su numero de cliente');;
            readln(reg.Cliente);
        end;

        close(arch)
    end;


    procedure Leer();
    var arch: f;
        linea: treg;
        cont: Integer;
    begin
        assign (arch,'Prueba.dat');
        reset (arch);
        cont:= 1;

        while not eof(arch) do begin
            read(arch,linea);
            writeln('');
            Writeln('Posicion:' + IntToStr(cont));
            WriteLn('Apellido:' + linea.Apellido);
            WriteLn('Nombre:' + linea.Nombre);
            WriteLn('Cliente:' + linea.Cliente);
            writeln('');
            inc(cont);
        end;

    close(arch);
    end;
    


    procedure borrarmodificar(pos: string; dato: char);
    var arch: f;
        linea: treg;
        posint: integer;
    begin
        assign (arch,'Prueba.dat');
        reset (arch);
        posint:= StrToInt(pos);

        if posint > FileSize(arch) then begin
            writeln('Posicion inexistente');
            close(arch);
            exit
        end;
        

        if dato = '3' then
        begin
            seek(arch,posint);
            while not eof(arch) do begin
                read(arch,linea);
                seek(arch,posint - 1);
                write(arch, linea);
                posint:= posint + 1;
                seek(arch,posint);
            end;

            seek(arch, posint - 1);
            Truncate(arch);


        end;  

        if dato = '2' then
        begin
            seek(arch,posint - 1);
            write('Ingrese el nuevo apellido: ');
            readln(linea.Apellido);
            writeln('');
            
            write('Ingrese el nuevo nombre: ');
            readln(linea.Nombre);
            writeln('');
            
            write('Ingrese el nuevo numero de cliente: ');
            readln(linea.Cliente);

            write(arch,linea);
        end;      

        close(arch);
    end;   
           
var
dato: char;
pos: string;

begin
dato:= '1';
while (dato = '1') or (dato = '2') or (dato = '3') or (dato = '4') do
  begin
    WriteLn('Escriba 1 si quiere agregar');
    WriteLn('Escriba 2 si quiere modificar');
    WriteLn('Escriba 3 si quiere borrar');
    WriteLn('Escriba 4 si leer los datos');
    WriteLn('Escriba otra cosa si quiere salir');
    readln(dato);
    
    if (dato = '1') then
    begin
    agregar;
    end;


    if (dato = '2') then
    begin
    writeln('');
    WriteLn('Ingrese posicion a modificar');
    
    readln(pos);
    borrarmodificar(pos,dato);

    end;

    if (dato = '3') then
    begin
    writeln('');
    WriteLn('Ingrese posicion a borrar');
    readln(pos);
    borrarmodificar(pos, dato);
    end;


    if (dato = '4') then
    begin
    leer;
    end;
    

end;

end.

   