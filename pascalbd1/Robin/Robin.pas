program Robin;

Uses sysutils;
Type
    proceso = record
        PID: String;
        TS: Integer;
    end;
    proces= Array [1..100] of proceso;
    list= Array [1..100] of Double;

    function sumar(arreg: proces; auxi: Integer): Integer;
    var sum: Integer;
         i: Integer;
    begin
        sum:= 0;
        for i:= 1 to auxi do begin
            sum:= sum + arreg[I].TS;  
        end;
        sumar:= sum
    end;

    function sumar1(arreg: list; auxi: Integer): Double;
    var sum: Double;
         i: Integer;
    begin
        sum:= 0;
        for i:= 1 to auxi do begin
            sum:= sum + arreg[I];  
        end;
        sumar1:= sum
    end;

const Q= 4;
      Ti= 1;
var nom: String;
    tiemp: Integer;
    aux: Integer;
    aux1: Double;
    i: Integer;
    Pant: proceso;
    Reloj: Double;
    procesos: proces;
    lista: list;
    TRetorno: Double;
    TEsperaaux: Double;

begin
    Writeln('Escriba cuantos procesos desea agregar');
    Readln(nom);
    aux:= StrToInt(nom);
    Pant.PID:= 'null';
    Pant.TS:= 0;
    Reloj:= 0;

    for i:= 1 to aux do begin
        Writeln('Escriba el nombre del procesos a agregar');
        readln(nom);
        Writeln('Escriba el tiempo requerido del proceso');
        readln(tiemp);
        procesos[i].PID:= nom;
        procesos[i].TS:= tiemp;
    end;
    TEsperaaux:= sumar(procesos,aux);
    TRetorno:= 0;
    readln(nom);

    while sumar(procesos,aux) > 0 do
      begin      
        for i := 1 to aux do 
        begin                  
            if procesos[i].TS > Q then
            begin
(*                if procesos[i].PID <> Pant.pid then 
                begin
                    Reloj:= Reloj + Ti/2; 
                    writeln('lo sbe1')                    
                end;*)
                procesos[i].TS:= procesos[i].TS - Q;
                Reloj:= Reloj + Q;
            end
           else if procesos[i].TS > 0 then begin
(*               if procesos[i].PID <> Pant.pid then begin
                    Reloj:= Reloj + Ti/2;   
                    writeln('lo sbe2')                        
                end; *)
                Reloj:= Reloj + procesos[i].TS;
                procesos[i].TS:= 0;
                lista[i]:= Reloj;
            end;                                                     
        end;   
    end;
    TRetorno:= sumar1(lista,aux);
    aux1:= aux;
    write('El Tiempo de retorno fue de:');
    writeln((TRetorno / aux1):0:2);
    write('El Tiempo de espera fue de:');
    writeln(((TRetorno - TEsperaaux) / aux1):0:2);
    readln(nom);

end.