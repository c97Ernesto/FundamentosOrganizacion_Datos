{5. Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
	a. Crear un archivo de registros no ordenados de celulares y cargarlo con 
	datos ingresados desde un archivo de texto denominado “celulares.txt”. 
	Los registros correspondientes a los celulares, deben contener: código 
	de celular, el nombre, descripcion, marca, precio, stock mínimo y el 
	stock disponible.
	b. Listar en pantalla los datos de aquellos celulares que tengan un stock 
	menor al stock mínimo.
	c. Listar en pantalla los celulares del archivo cuya descripción contenga 
	una	cadena de caracteres proporcionada por el usuario.
	d. Exportar el archivo creado en el inciso a) a un archivo de texto 
	denominado “celulares.txt” con todos los celulares del mismo.
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por 
el usuario una única vez.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se 
especifique en tres líneas consecutivas: en la primera se especifica: código 
de celular, el precio y marca, en la segunda el stock disponible, stock mínimo 
y la descripción y en la tercera nombre en ese orden. Cada celular se carga 
leyendo tres líneas del archivo “celulares.txt”.}
PROGRAM Ejercicio5;
Type
	opciones = 'a'..'f';
	
	reg_Celular = record
		codCelular: integer;
		nombre: string;
		descripcion:string;
		marca: string;
		precio: real;
		stockMinimo: integer;
		stockDisponible: integer;
	end;
	
	arch_Celulares = file of reg_Celular;
{_____________________________________Crear Archivo_____________________________________}
Procedure CrearArchivo(var archivo: arch_Celulares);
Var
	nomArch: string;
	archTxt: Text;
	celular: reg_Celular;
Begin
	write('Ingresar Nombre del Archivo a crear: ');
	readln(nomArch);
	assign(archivo, nomArch);
	rewrite(archivo);
	
	assign(archTxt, 'celulares.txt');
	reset(archTxt);
	
	while (not eof(archTxt)) do begin
	
		with celular do begin
			readln(archTxt, codCelular, precio,nombre);				//readln para cuando pasamos en el txt al sig renglon
			readln(archTxt, stockMinimo,stockDisponible,marca);		//los strings siempre al final
			readln(archTxt, descripcion);
		end;
		
		write(archivo, celular);
	end;
	
	close(archivo);
	writeln('Fin de Carga de Datos.');
	writeln('');
	
End;
{_____________________________________Mostrar Celu_____________________________________}
Procedure MostrarCelu(c: reg_Celular);
Begin
	with c do begin
		writeln('CodCelu: ', codCelular,' / Nombre: ', nombre,' / Descripcion: ', descripcion);
		writeln('Marca: ', marca,' / Precio: ', precio:2:2,' / Stock Minimo: ', stockMinimo,' / Stock Disponible: ', stockDisponible);
	end;
End;
{_____________________________________Mostrar Archivo_____________________________________}
Procedure MostrarArchivo(var archivo: arch_Celulares);
	
Var
	nombre: string;
	celu: reg_Celular;
Begin
	write('Nombre Archivo: ');
	readln(nombre);
	reset(archivo);
	
	while (not eof(archivo)) do begin
		read(archivo, celu);
		MostrarCelu(celu);
	end;
	
	close(archivo);
End;

{_____________________________________Listar Stock Minimo_____________________________________}
Procedure ListarStock(var archivo: arch_Celulares);
Var
	nomArch: string;
	celu: reg_Celular;
Begin
	write('Ingresar nombre del Archivo: ');
	readln(nomArch);
	assign(archivo, nomArch);
	reset(archivo);
	
	while (not eof(archivo)) do begin
		read(archivo, celu);
		
		if (celu.stockMinimo > celu.stockDisponible) then
			MostrarCelu(celu);
				
	end;
	
	close(archivo)
End;
{_____________________________________Listar Determinado_____________________________________}
Procedure ListarDeterminado(var archivo: arch_Celulares);
Var
	nomArch: string;
	celu: reg_celular;
	cadena: string;
	ok: boolean;
	
Begin
	ok:= false;
	
	write('Ingresar Nombre del Archivo: ');
	readln(nomArch);
	assign(archivo, nomArch);
	reset(archivo);
	
	write('Ingrese Descripcion del Celular: ');
	readln(cadena);
	
	while (not eof(archivo)) do begin
		read(archivo, celu);
		
		if (cadena = celu.descripcion) then begin
			MostrarCelu(celu);
			ok:= true;
		end;
		
	end;
	
	if (not ok) then
		writeln('No se ecnontro Celular');
		
	close(archivo);
End;

{_____________________________________Exportar a Txt_____________________________________}
Procedure ExportarAtxt(var archivo: arch_Celulares);
Var
	archTxt: Text;
	nomArch: string;
	celu:reg_Celular;
Begin
	Write('Ingrese Nombre del Archivo: ');
	readln(nomArch);
	assign(archivo, nomArch);
	reset(archivo);
	
	assign(archTxt, 'celularesExportados.txt');
	rewrite(archTxt);
	
	while (not eof(archivo)) do begin
		read(archivo, celu);
		
		with celu do begin
			writeln(archTxt, 'CodCelu: ', codCelular,' / Nombre: ', nombre,' / Descripcion: ', descripcion);
			writeln(archTxt, 'Marca: ', marca,' / Precio: ', precio:2:2,' / Stock Minimo: ', stockMinimo,' / Stock Disponible: ', stockDisponible);
			writeln(archTxt,'');
			writeln(archTxt, 'Siguiente modelo: ');
		end;
	end;
	
	writeln('Exportacion Finalizada');
	
	
	close(archivo);
		
End;
{_____________________________________P.P_____________________________________}

VAR
	archCelulares: arch_Celulares;
	opc: opciones;
BEGIN
	opc:='a';
	
	while (opc <> 'e') do begin
		writeln('=================MENU=================');
		writeln('a. Crear Archivo de Registros.');
		writeln('b. Listar Stock Minimo.');
		writeln('c. Listar Descripcion Determinada.');
		writeln('d. Exportar Archivo a "celulares.txt".');
		writeln('e. Salir.');
		writeln('======================================');
		writeln('');
		
		write('Ingresar Opcion: ');
		readln(opc);
		
		case opc of
			'a': CrearArchivo(archCelulares);
			'b': ListarStock(archCelulares);
			'c': ListarDeterminado(archCelulares);
			'd': ExportarAtxt(archCelulares);
			'f': MostrarArchivo(archCelulares);
		end;
		
	end;
	
END.
