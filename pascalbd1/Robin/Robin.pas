program Robin;

Uses sysutils;
Type
    proceso = record
        PID: String;
        TS: Integer;
    end;
    proces= Array [1..100] of proceso;

    function sumar(arreg: proces; auxi: Integer): Integer; // sumo los procesos
    var sum: Integer;
         i: Integer;
    begin
        sum:= 0;
        for i:= 1 to auxi do begin
            sum:= sum + arreg[I].TS;  
        end;
        sumar:= sum
    end;

const Q= 4;
      Ti= 1;
var nom: String;
    tiemp,aux,sumapros: Integer;
    aux1,Reloj,TRetorno: Double;
    i: Integer;
    procesos: proces;

begin
    Writeln('Escriba cuantos procesos desea agregar');
    Readln(nom);
    aux:= StrToInt(nom);
    Reloj:= 0;
    sumapros:= 0;
    TRetorno:= 0;

    for i:= 1 to aux do begin                   //cargo los procesos
        Writeln('Escriba el nombre del procesos a agregar');
        readln(nom);
        Writeln('Escriba el tiempo requerido del proceso');
        readln(tiemp);
        procesos[i].PID:= nom;
        procesos[i].TS:= tiemp;
        sumapros:= sumapros + tiemp;
    end;


    while sumar(procesos,aux) > 0 do    //ejecuto el robin
      begin      
        for i := 1 to aux do 
        begin                  
            if procesos[i].TS > Q then
            begin
                procesos[i].TS:= procesos[i].TS - Q;
                Reloj:= Reloj + Q;
            end
            else if procesos[i].TS > 0 then begin
                Reloj:= Reloj + procesos[i].TS;
                procesos[i].TS:= 0;
                TRetorno:= TRetorno + Reloj;
            end;                                                     
        end;   
    end;
    aux1:= aux;
    write('El Tiempo de retorno fue de:');
    writeln((TRetorno / aux1):0:2);
    write('El Tiempo de espera fue de:');
    writeln(((TRetorno - sumapros) / aux1):0:2);
    readln(nom);

end.