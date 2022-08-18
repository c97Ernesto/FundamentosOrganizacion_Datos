{2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y
el promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.}
PROGRAM CrearArchivoEnteros;
CONST
	FIN = 3000;
TYPE
	str20 = string[20];
	Archivo_Enteros = file of integer;
	
{_________________________________________________RecorrerArchivo_________________________________________________}
Procedure Recorrer(var archivo: Archivo_Enteros);
Var
	nro: integer;
	suma: integer;
	cantMayores: integer;
	cantN: integer;
	
Begin
	cantMayores:= 0;
	cantN:= 0;
	suma:= 0;
	
	reset(archivo);		// abrimos el archivo para poder leer y escribir sobre el mismo
	
	while (not eof(archivo)) do begin	//mientras no estemos en la ultima posicion del archivo
		cantN:= cantN + 1;
		
		read(archivo, nro);		//leemos desde el archivo
		
		suma:= suma + nro;
		if (nro > 1500) then
			cantMayores:= cantMayores + 1;
		
		writeln('Contenido: ', nro);
	end;
	
	close(archivo);
	
	writeln('Cantidad de Numeros mayores a 1500: ', cantMayores);
	writeln('Promedio: ', (cantN/suma));

End;

{_________________________________________________P.P_________________________________________________}	
VAR
	archLogico: Archivo_Enteros;		//nombre lógico del archivo
	nro: integer;		
	archFisico: str20;					//nombre físico del archivo
	
BEGIN
	write('Ingrese Nombre del Archivo: ');	
	readln(archFisico);					//leemos el nombre fisico que desea poner el usuario
	assign(archLogico, archFisico);			//enlazamos el nombre fisico con el nombre con el que trabajaremos en el algoritmo
	
	rewrite(archLogico);				//apertura del archivo para creacion y posterior escritura
	
	write('Ingresar numero: ');
	readln(nro);
	
	while (nro <> FIN) do begin
		write(archLogico, nro);			//escritura del numero en el archivo
		write('Ingresar numero: ');
		readln(nro);
	end;
	
	close(archLogico);			//cerramos archivo
	
	Recorrer(archLogico);
END.