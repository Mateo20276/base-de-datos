program Robin;

Uses sysutils;
Type
    proceso = record
        PID: String;
        TS: Integer;
    end;
    proces= Array [1..100] of proceso;

    function elementomenor(var procesos: proces;auxi: Integer): integer; // encunetro el proceso mas corto
    var i, sum,elem: integer;
    begin
        sum:= 999;
        for i:= 1 to auxi  do 
        begin
            if ((procesos[i].TS < sum) and (procesos[i].TS <> 0))then
            begin
                sum:= procesos[i].TS;
                elem:= i;
            end; 
        end;
        elementomenor:= sum;
        writeln('Procesos ejecutado: ' + procesos[elem].PID);
        procesos[elem].TS:= 0;

    end;

    function sumar(arreg: proces; auxi: Integer): Integer; // sumo los procesos
    var sum: Integer;
         i: Integer;
    begin
        sum:= 0;
        for i:= 1 to auxi do begin
            sum:= sum + arreg[I].TS;  
        end;
        sumar:= sum;
    end;

var
procesos: proces;
aux,i,reloj:Integer;
nom,tiemp: string;
tiemporetorno: real;
te: integer;

begin

writeln('Escriba cuantos procesos desea agregar');
readln(nom);
aux:= StrToInt(nom);
te:= 0;
reloj:= 0;
tiemporetorno:= 0;

for i:= 1 to aux do begin                                  //cargo los procesos
    Writeln('Escriba el nombre del procesos a agregar');
    readln(nom);
    Writeln('Escriba el tiempo requerido del proceso');
    readln(tiemp);
    procesos[i].PID:= nom;
    procesos[i].TS:= StrToInt(tiemp);
    te:= te + StrToInt(tiemp);
end;


while (sumar(procesos, aux) > 0) do // ejecuto el sjf
begin   
    reloj:= reloj + elementomenor(procesos, aux);

    writeln('Desea agregar mas procesos? (S/N)');     //cargo nuevamente los procesos si lo desea
    readln(nom);
    if ((nom = 'S') OR (nom = 's')) then
    begin
        writeln('Escriba cuantos procesos desea agregar');
        readln(nom);
        aux:=  aux + StrToInt(nom);
    
    for i := (aux - StrToInt(nom) + 1) to aux do begin
            Writeln('Escriba el nombre del procesos a agregar');
            readln(nom);
            Writeln('Escriba el tiempo requerido del proceso');
            readln(tiemp);
            procesos[i].PID:= nom;
            procesos[i].TS:= StrToInt(tiemp);
            te:= te + StrToInt(tiemp);
        end;
    end;
    tiemporetorno:= tiemporetorno + reloj;
    readln(nom);

end;
writeln('tiempo de retorno: ', ((tiemporetorno/aux)):0:2);
writeln('tiempo de espera: ', ((tiemporetorno - te)/aux):0:2);
readln(nom);

end.