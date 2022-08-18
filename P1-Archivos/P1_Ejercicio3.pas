{3. Realizar un programa que presente un menú con opciones para:
a. Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
b. Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario una
única vez.}

PROGRAM Ejercicio3;
TYPE
	str20 = string [20];
	str8 = String[8];
	opciones = 'a'..'e';
	
	reg_Empleado = record
		numEmpleado: integer;
		apellido: str20;
		nombre: str20;
		edad: integer;
		dni: str8;
	end;
	
	Archivo_Empleados = file of reg_Empleado;

{_____________________________________CrearArchivo_____________________________________}

Procedure CrearArchivo(var archivo: Archivo_Empleados);
	
	procedure leerEmpleado(var r: reg_Empleado);
	begin
		with r do begin
			write('Ingresar Apellido: ');
			readln(apellido);
			if (apellido <> 'fin') then begin
				write('Nombre: ');
				readln(nombre);
				write('Dni: ');
				readln(dni);
				write('Edad: ');
				readln(edad);
				write('Numero de Empleado: ');
				readln(numEmpleado);
			end;
		end;
	end;
	
Var
	nomArchivo: str20;
	empleado: reg_Empleado;
Begin
	write('Ingresar Nombre del Archivo: ');
	readln(nomArchivo);
	
	assign(archivo, nomArchivo);
	rewrite(archivo);
	
	leerEmpleado(empleado);
	while (empleado.apellido <> 'fin') do begin
		write(archivo, empleado);
		leerEmpleado(empleado);
	end;
	
	close(archivo);
	readln();
End;
{_____________________________________MostrarEmpelado_____________________________________}
Procedure MostrarEmpleado(r: reg_Empleado);
Begin
	with r do 
		writeln('Nombre: ', nombre, '. Apellido: ', apellido, '. Edad: ', edad, '. Dni: ', dni, '. Num Empleado: ', numEmpleado);	
	
End;

{_____________________________________ListarNomApeDeter_____________________________________}
Procedure ListarNomApeDeter(var archivo: Archivo_Empleados);
Var
	empleado: reg_Empleado;
	nomArchivo: str20;
	nombre: str20;
Begin
	write('Ingresar nombre del archivo que desea abrir: ');
    readln(nomArchivo);
    Assign(archivo, nomArchivo);
	
	write('Ingresar nombre o apellido a buscar: ');
	readln(nombre);
	
	reset(archivo);
	
	while (not eof(archivo)) do begin
		read(archivo, empleado);
		if (empleado.nombre = nombre) or (empleado.apellido = nombre) then
			MostrarEmpleado(empleado);
	end;
	
	close(archivo);
	writeln('');
	
End;

{_____________________________________ListarDatos_____________________________________}
Procedure ListarDatos(var archivo: Archivo_Empleados);
Var
	empleado: reg_Empleado;
	nomArch: str20;
Begin
	write('Ingrese nombre del Archivo a Listar: ');
	readln(nomArch);
	assign(archivo, nomArch);
	reset(archivo);
	
	while (not eof(archivo)) do begin
		read(archivo, empleado);
		MostrarEmpleado(empleado);
	end;
	
	close(archivo);
	writeln('')
End;

{_____________________________________ListarProxJubilarse_____________________________________}
Procedure ListarProxJubilarse(var archivo: Archivo_Empleados);
Var
	empleado: reg_Empleado;
	nomArch: str20;
Begin
	write('Ingresar nombre del Archivo: ');
	readln(nomArch);
	assign(archivo, nomArch);
	reset(archivo);
	
	while (not eof(archivo)) do begin
		read(archivo, empleado);
		if (empleado.edad > 70) then 
			MostrarEmpleado(empleado);
	end;

End;

{_____________________________________P.P_____________________________________}
VAR
	archEmpleados: Archivo_Empleados;
	opc: opciones;
BEGIN
	writeln('MENU');
	writeln('a. Crear Archivo de Empleados.');
	writeln('b. Listar nombre o apellido de empleado determinado.');
	writeln('c. Listar todos los empleados.');
	writeln('d. Listar empleados pronto a jubilarse.');
	writeln('e. Salir.');
	writeln('');
	
	
	
	write('Ingrese una opcion: ');
	readln(opc);
	
	while (opc <> 'e') do begin
		case (opc) of
			'a': CrearArchivo(archEmpleados);
			'b': ListarNomApeDeter(archEmpleados);
			'c': ListarDatos(archEmpleados);
			'd': ListarProxJubilarse(archEmpleados);	
		end;
		
		write('Ingrese una opcion: ');
		readln(opc);
		writeln('');
		
	end;
	
END.
