{1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.}
PROGRAM CrearArchivoEnteros;
CONST
	FIN = 3000;
TYPE
	str20 = string[20];
	Archivo_Enteros = file of integer;
VAR
	archLogico: Archivo_Enteros;
	nro: integer;
	archFisico: str20;
BEGIN
	write('Ingrese Nombre del Archivo: ');
	readln(archFisico);
	assign(archLogico, archFisico);
	
	rewrite(archLogico);
	
	write('Ingresar numero: ');
	readln(nro);
	
	while (nro <> FIN) do begin
		write(archLogico, nro);
		write('Ingresar numero: ');
		readln(nro);
	end;
	
	close(archLogico);
END.



