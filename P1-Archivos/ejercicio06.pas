{6. Agregar al menú del programa del ejercicio 5, opciones para:
	a. Añadir uno o más celulares al final del archivo con sus 
	datos ingresados por teclado.
	b. Modificar el stock de un celular dado.
	c. Exportar el contenido del archivo binario a un archivo 
	de texto denominado: ”SinStock.txt”, con aquellos celulares 
	que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular.}

PROGRAM Ejercicio6;
Type
	opciones = 'a'..'i';
	
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
	
	close(archTxt);
	close(archivo);
		
End;
{_____________________________________Añadir Celulares_____________________________________}
Procedure AddCelular(var archivo: arch_Celulares);

	procedure leerReg(r: reg_Celular);
	begin
		writeln('Ingrese Info del Celualr (-1 para terminar)');
		with r do begin
			write('Codigo de Celular: ');
			readln(codCelular);
			if (codCelular <> -1) then begin
				write('Nombre: ');
				readln(nombre);
				write('Descripcion: ');
				readln(descripcion);
				write('Marca: ');
				readln(marca);
				write('Precio: ');
				readln(precio);
				write('Stock Minimo: ');
				readln(stockMinimo);
				write('Stock Disponible: ');
				readln(stockDisponible);
			end;
		end;
	end;
	
Var
	celu: reg_Celular;
	nomArch: string;
	
Begin
	write('Ingrese nombre del Archivo a modificar: ');
	readln(nomArch);
	assign(archivo, nomArch);
	reset(archivo);		//abrimos archivo como lectura/escritura
	
	seek(archivo, fileSize(archivo));			//posicionamiento al final del archivo
	leerReg(celu);
	
	while (celu.codCelular <> -1) do begin
		write(archivo, celu);
		leerReg(celu);
	end;
	
	writeln('Fin Agregar');
	close(archivo);
End;
{_____________________________________Modificar Stock de Celular_____________________________________}
Procedure ModifStock(var archivo: arch_Celulares);
Var
	nomArch, nomCel: string;
	celu: reg_Celular;
Begin
	write('Ingresar nombre del Archivo: ');
	readln(nomArch);
	assign(archivo, nomArch);
	reset(archivo);
	
	write('Ingrese nombre del Celular ("" para finalizar):');
	readln(nomCel);
	
	while (not eof(archivo)) and (nomCel <> '') do begin	
		read(archivo, celu);
		
		if (nomCel = celu.nombre) then begin
			writeln('Celular: ', celu.nombre);
			
			write('Ingrese nuevo Stock: ');
			readln(celu.stockDisponible);
			
			seek(archivo, filepos(archivo)-1);
			write(archivo, celu);
			
			writeln('Stock Actualizado');
			writeln('');
		end
		else
			writeln('No existe nombre');
			
		
		write('Ingrese nombre del Celular ("" para finalizar):');
		readln(nomCel);
	end;
	close(archivo);
	
End;
{_____________________________________Exportar a SinStock.txt_____________________________________}
Procedure ExportSinStockTxt(var archivo: arch_Celulares);
Var
	nomArch: string;
	archTxt: Text;
	celu: reg_Celular;
Begin
	write('Ingrese nombre del archivo: ');
	readln(nomArch);
	assign(archivo, nomArch);
	reset(archivo);
	
	assign(archTxt, 'SinStock.txt');
	rewrite(archTxt);
	
	while (not eof(archivo)) do begin
		read(archivo, celu);
		
		if (celu.stockDisponible = 0) then
		
			with celu do begin
				writeln(archTxt, 'CodCelu: ', codCelular,' / Nombre: ', nombre,' / Descripcion: ', descripcion);
				writeln(archTxt, 'Marca: ', marca,' / Precio: ', precio:2:2,' / Stock Minimo: ', stockMinimo,' / Stock Disponible: ', stockDisponible);
				writeln(archTxt,'');
			end;
		
		writeln('Celular Exportado');
		
	end;
	writeln('Archivo Exportado');
	
	close(archivo);
	close(archTxt);
End;
{_____________________________________P.P_____________________________________}

VAR
	archCelulares: arch_Celulares;
	opc: opciones;
BEGIN
	opc:='a';
	
	while (opc <> 'i') do begin
		writeln('=================MENU=================');
		writeln('a. Crear Archivo de Registros.');
		writeln('b. Listar Stock Minimo.');
		writeln('c. Listar Descripcion Determinada.');
		writeln('d. Exportar Archivo a "celulares.txt".');
		writeln('e. Mostrar Archivo Binario .');
		writeln('f. Añadir Celulares.');
		writeln('g. Modificar el Stock de Celular.');
		writeln('h. Exportar celulares sin stock a "SinStock.txt".');
		writeln('i. Salir.');
		writeln('======================================');
		writeln('');
		
		write('Ingresar Opcion: ');
		readln(opc);
		
		case opc of
			'a': CrearArchivo(archCelulares);
			'b': ListarStock(archCelulares);
			'c': ListarDeterminado(archCelulares);
			'd': ExportarAtxt(archCelulares);
			'e': MostrarArchivo(archCelulares);
			'f': AddCelular(archCelulares);
			'g': ModifStock(archCelulares);
			'h': ExportSinStockTxt(archCelulares);
		end;
		
	end;
	
END.
