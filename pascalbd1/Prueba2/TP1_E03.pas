program TP1_E03;

uses sysutils, strutils;

Const
  L_Cc=1;
  L_Nombre=20;
  L_Longitud=2;


type
 Metadata= record
  nombre:string[L_Nombre];
  longitud:integer;
 end;

var
	DataFile : TextFile;
	Content  : String;
  archivoUser : String;
  stringAux : String;
  Metadatos : array of Metadata;

procedure definirMetadatos;
var
CantCampos:integer;
NombreCampo:String;
LongCampo:integer;
i:integer;

begin

Writeln ('ingrese cantidad de campos.');
readln (CantCampos);

Content:= padright(inttostr(CantCampos),L_Cc);

for i:=1 to CantCampos do
begin
  writeln ('Ingrese nombre del campo.');
  readln (NombreCampo);
  Writeln ('Ingrese cantidad letras para los campos.');
  readln (LongCampo);
  Content:= Content + padRight(NombreCampo,L_Nombre) + padRight(inttostr(LongCampo),L_Longitud);
end;



end;
//Final.

procedure leerMetadatos;
var
 StringAux: string;
 i,j,k: integer;
 CantCampos:integer;
begin
  StringAux:='';

 for k:=1 to L_Cc do
  StringAux:= StringAux + Content[k];

 StringAux:= trimright(StringAux);
 CantCampos:= strtoint(StringAux);
 setlength(Metadatos,CantCampos);

 for i:=1 to CantCampos do
  begin
   StringAux:= '';
   for j:=1 to L_Nombre do
    begin
     k:= k + 1;
     StringAux:= StringAux + Content[k];
    end;
  Metadatos[i].nombre:= StringAux;
  StringAux:= '';
  for j:=1 to L_Longitud do
   begin
    k:= k +1;
    StringAux:= StringAux + Content[k];
   end;
  StringAux:= trimright(StringAux);
  Metadatos[i].longitud:= strtoint(StringAux);
  end;
end;
//Final.

procedure altaRegistros;
var
  i: integer;
  stringAux: String;
begin
  leerMetadatos;

  content:= content + '1';

  for i:=1 to length(metadatos) do
  begin
    Writeln ('Ingrese el valor para ' + metadatos[i].nombre + ' que no supere los ' + inttostr(metadatos[i].longitud) + ' caracteres.');
    readln(stringAux);
    stringAux:= padRight(stringAux,metadatos[i].longitud);
    stringAux:= copy(stringAux,1,metadatos[i].longitud);
    content:= content + stringAux;
  end;
end;
//Final.

procedure modificacionRegistros(estado : char);
var
  OpcionUser: integer;
  PosicionRegistro: integer;
  longitudMetadatos : integer;
  longitudRegistros: integer;
  inicioRegistro : integer;
  i: integer;
  contentAux : string;
  stringAux : string;
  content2: string;
begin
  Writeln('Ingrese un numero valido para referirse al registro que quiere referirse.');
  Readln(OpcionUser);

  leerMetadatos;

  longitudMetadatos := 0;
  longitudRegistros := 1;

  LongitudMetadatos := (length(metadatos) * (L_Nombre+L_Longitud))+L_Cc;

  for i:=0 to length(metadatos) do
    longitudRegistros:= LongitudRegistros + metadatos[i].longitud;

  contentAux:= Estado;

  if Estado = '1' then
  begin
    for i:=1 to length(metadatos) do
    begin
      Writeln ('Ingrese el valor para ' + metadatos[i].nombre);
      readln(stringAux);
      stringAux:= padRight(stringAux,metadatos[i].longitud);
      stringAux:= copy(stringAux,1,metadatos[i].longitud);
      contentAux:= contentAux + stringAux;
    end;
  end
  else
  begin
    for i:=1 to length(metadatos) do
    begin
      stringAux:= padRight('',metadatos[i].longitud);
      contentAux:= contentAux + stringAux;
    end;
  end;

  inicioRegistro := longitudMetadatos + (LongitudRegistros * (OpcionUser-1));
  content2 := copy(content , 1 , inicioRegistro);
  content2 := content2 + contentAux;
  content2 := content2 + copy(content , inicioRegistro+longitudRegistros+1 , length(content)-1);
  content := content2;

  Writeln('Listo.');
  Readkey;
end;
//Final.

procedure borrarRegistros;
begin
  modificacionRegistros('0');
  Readkey;
end;
//Final.

procedure listarRegistros;
var
  longitudMetadatos : integer;
  longitudRegistros : integer;
  numeroRegistro: integer;
  i:integer;
  j: integer;
  opcion : boolean;

begin
  leerMetadatos;

  longitudMetadatos := 0;
  longitudRegistros := 1;

  LongitudMetadatos := (length(metadatos) * (L_Nombre+L_Longitud))+L_Cc;

  for i:=0 to length(metadatos) do
    longitudRegistros:= LongitudRegistros + metadatos[i].longitud;

  writeln('En el archivo hay ' , (length(content)-longitudMetadatos)div longitudRegistros , ' registros.');
  readkey;

  i:= longitudMetadatos+1;

  numeroRegistro := 1;
  while (i<length(content)) do
  begin
    opcion:= content[i] = '1';
      i:= i+1;
      Writeln('Registro : #'+ inttostr(numeroRegistro));
      numeroRegistro := numeroRegistro+1;

      for j:=1 to length(metadatos) do
      begin
        if opcion then
        begin

          writeln(metadatos[j].nombre, ':' , copy(content , i , metadatos[j].longitud));

        end;
        i:=i + metadatos[j].longitud;
      end;
  end;
  readkey;
end;
//Final.

procedure mostrarMenu;
var
  option : char;
begin
  repeat
    clrscr;

    writeln('1. Definir metadatos.');
    writeln('2. Alta de registros.');
    writeln('3. Modificacion de registros.');
    writeln('4. Borrado de registros.');
    writeln('5. Listar registros.');
    writeln('6. Salir.');

    readln(option);

      case option of
        '1' : definirMetadatos();
        '2' : altaRegistros();
        '3' : modificacionRegistros('1');
        '4' : borrarRegistros();
        '5' : listarRegistros();
      end;

  until (option='6');
end;
//Final.

begin
	writeln('Ingrese el nombre del archivo.');
  readln(archivoUser);

  Assign(DataFile, archivoUser);

  if not FileExists(archivoUser) then begin
    Rewrite(DataFile);
    Close(DataFile);
  end;

  reset(dataFile);
  while not (eof (dataFile)) do
  begin
    read(dataFile,StringAux);
    content := content + stringAux;
  end;
  close(dataFile);

  mostrarMenu;

  rewrite(dataFile);
  write(dataFile,content);
  close(dataFile);
end.
