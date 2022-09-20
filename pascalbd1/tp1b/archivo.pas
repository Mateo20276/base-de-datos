unit archivo;

interface

Uses sysutils;

type

    TRegistro = Record
        cliente: Integer;
        apellido: String[16];
        nombre: String[16];
        siguiente: Integer;     // -1 -> null
    end;

    TArchivo = Object
        private
            datos: file of TRegistro;
            Function hash(k: Integer): Integer;
        public
            Procedure crearArchivo();
            Procedure leer();
            Procedure buscar();
            Procedure agregar(registro: TRegistro);
            Procedure eliminar();
            // Function modificar(): String;
    end;

const SIZE = 1009;


implementation


Function TArchivo.hash(k: Integer): Integer;
begin
    hash := k mod SIZE;
end;


Procedure TArchivo.crearArchivo();
var rAux: TRegistro;
    i: Integer;
begin
    assign(datos, 'Prueba.dat');
    rewrite(datos);
    rAux.cliente := 0;
    rAux.nombre := '.';
    rAux.apellido := '.';

    for i := 0 to SIZE do begin
        seek(datos, i);
        write(datos, rAux);
    end;

    close(datos);
end;


Procedure TArchivo.leer();
var registro: TRegistro;
begin
    assign(datos,'Prueba.dat');
    reset(datos);

    // Leer tabla hash
    while not eof(datos) do begin
        read(datos, registro);
        if registro.cliente <> 0 then begin
            WriteLn('Cliente: ' + IntToStr(registro.Cliente));
            WriteLn('Nombre: ' + registro.Nombre);
            WriteLn('Apellido: ' + registro.Apellido);
            WriteLn('Siguiente: ' + IntToStr(registro.Siguiente));
            WriteLn();
        end;
    end;

    close(datos);
end;


Procedure TArchivo.buscar();
begin
end;


Procedure TArchivo.eliminar();
begin
end;


Procedure TArchivo.agregar(registro: TRegistro);
var pos: Integer;
    rAux: TRegistro;
begin
    pos := hash(registro.cliente);
    Writeln('posicion: ' + IntToStr(pos));
    assign(datos, 'Prueba.dat');
    reset(datos);

    // Se mueve a la posicion y verifica si ya existe una clave
    seek(datos, pos);
    read(datos, rAux);
    Writeln('posicion despues de read(): ' + IntToStr(pos));
    Writeln('raux.cliente: ' + IntToStr(rAux.cliente));

    // Cliente ya existente
    if (registro.cliente = rAux.cliente) then begin
      WriteLn('El cliente ya existe');
      Exit;
    end
    // Colision
    else if (registro.cliente <> rAux.cliente) and (rAux.cliente <> 0) then begin
        while (rAux.siguiente <> -1) and (registro.cliente <> rAux.cliente) do begin
            seek(datos, rAux.siguiente);
            read(datos, rAux);
        end;

        if (registro.cliente = rAux.cliente) then begin
            WriteLn('El cliente ya existe');
            Exit; 
        end;

        pos := fileSize(datos);

        // Modifico la referencia al siguiente registro
        rAux.siguiente := pos;
        seek(datos, filePos(datos)-1);
        write(datos, rAux);

        // Agrego el registro al final
        seek(datos, pos);
        write(datos, registro);
    end 
    // Posicion vacia
    else begin
        seek(datos, pos);
        write(datos, registro);
    end;
    
    close(datos);
    WriteLn('El cliente se ha agregado correctamente');
end;

  
end.