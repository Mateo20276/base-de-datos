program Robin;

Uses sysutils;
Type
    proceso = record
        PID: String;
        TS: Integer;
        TE: Integer;
    end;
    proces= Array [1..100] of proceso;

    function elementomenor(procesos: proces): integer;
    var i, sum,elem: integer;
    begin
        sum:= 99999;
        for i:= 1 to lenght(procesos)  do 
        begin
            if (procesos[i] < sum and sum <> 0)then
            begin
                sum:= procesos[i];
                elem:= i;
            end; 

            procesos[elem]:= 0;
        end;
    end;

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



var
procesos: proces;
aux,i,reloj:Integer;
nom: string;
begin

writeln('Escriba cuantos procesos desea agregar');
readln(nom);
aux:= StrToInt(nom);

reloj:= 0;



while sumar(procesos, aux) > 0 do 
begin
    for i:= 1 to aux do begin
            Writeln('Escriba el nombre del procesos a agregar');
            readln(nom);
            Writeln('Escriba el tiempo requerido del proceso');
            readln(tiemp);
            procesos[i].PID:= nom;
            procesos[i].TS:= tiemp;
            procesos[i].TE:= reloj;
        end;


    reloj:= reloj + elementomenor(procesos);

end;

end;