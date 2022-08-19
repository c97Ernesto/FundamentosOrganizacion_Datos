{4. Agregar al menú del programa del ejercicio 3, opciones para:
	a. Añadir una o más empleados al final del archivo con sus datos 
	ingresados por teclado.
	b. Modificar edad a una o más empleados.
	c. Exportar el contenido del archivo a un archivo de texto llamado
	“todos_empleados.txt”.
	d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, 
	los empleados que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado.}

PROGRAM Ejercicio3;
TYPE
	str20 = string [20];
	str8 = String[8];
	opciones = 'a'..'i';
	
	reg_Empleado = record
		numEmpleado: integer;
		apellido: str20;
		nombre: str20;
		edad: integer;
		dni: str8;
	end;
	
	Archivo_Empleados = file of reg_Empleado;


Procedure LeerEmpleado(var r: reg_Empleado);
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
{_____________________________________CrearArchivo_____________________________________}

Procedure CrearArchivo(var archivo: Archivo_Empleados);
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
		LeerEmpleado(empleado);
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
{_____________________________________Añadir Empleados_____________________________________}
Procedure AddEmpleados(var archivo: Archivo_Empleados);
Var
	nomArch: str20;
	empleado: reg_Empleado;
	
Begin
	write('Ingresar nombre del archivo');
	readln(nomArch);
	
	assign(archivo, nomArch);	
	reset(archivo);
	
	{buscar}		{TamañoArchivo}
	seek(archivo, FileSize(archivo));	//posicionamiento al final del archivo
	
	LeerEmpleado(empleado);
	while (empleado.apellido <> 'fin') do begin
		write(archivo, empleado);
		LeerEmpleado(empleado);
	end;	
End;
{_____________________________________Modificar Edad_____________________________________}
Procedure ModificarEdad(var archivo: Archivo_Empleados);
	
	procedure editar(var r: reg_Empleado);
	
	begin
		with r do begin
			writeln('Edad Anterior: ',edad);
			write('Ingresar Nueva Edad:');
			readln(edad);
		end;
	end;

Var
	nomArch: str20;
	encontre: boolean;
	empleado: reg_Empleado;
	n: integer;
Begin
	encontre:= false;
	
	write('Ingresar nombre de Archivo: ');
	readln(nomArch);
	
	assign(archivo, nomArch);
	reset(archivo);
	
	write('Ingresar Numero de Empleado para modificar la Edad: ');
	readln(n);
	while (n <> -1) do begin
	
		while (not(eof)) and (not encontre)do begin
			read(archivo, empleado);
			
			if (empleado.numEmpleado = n) then begin
				encontre:= true;
				editar(empleado);
				seek(archivo, FilePos(archivo)-1);
				write(archivo, empleado);
				writeln('Se modifico la edad del empleado correctamente.');
			end;
				
		end;
		writeln('Editar otro empleado?');
		write('Ingresar num de empleado (-1 para terminar): ');
	end;
End;
{_____________________________________Exportar a txt_____________________________________}
Procedure ExportarAtxt(var archivo: Archivo_Empleados);
Var
	archTxt: Text;
	nomArchEmpleados: str20;
	empleado: reg_Empleado;
	
Begin
	write('Ingrese Nombre del Archivo de Empleados: ');
	readln(nomArchEmpleados);
	assign(archivo, nomArchEmpleados);
	reset(archivo);	
	
	assign(archTxt, 'todos_empleados.txt');
	rewrite(archTxt);
	
	while(not eof(archivo))do begin
		read(archivo, empleado);
		with empleado do 
			writeln(archTxt, ' ', numEmpleado, ' ', apellido, ' ', nombre, ' ', edad, ' ', dni);
	end;
	close(archivo);
	close(archTxt);
End;
{_____________________________________Exportar sin Dni a txt_____________________________________}
Procedure ExportarSinDniAtxt(var archivo: Archivo_Empleados);
Var
	archTxt: Text;
	nomArchEmpleados: str20;
	empleado: reg_Empleado;
Begin
	write('Ingrese Nombre del Archivo de Empleados: ');
	readln(nomArchEmpleados);
	assign(archivo, nomArchEmpleados);
	reset(archivo);	
	
	assign(archTxt, 'faltaDNIEmpleado');
	rewrite(archTxt);
	
	while not eof(archivo) do begin
		read(archivo, empleado);
		if (empleado.dni = '00') then 
			writeln(archTxt, empleado.numEmpleado, ' ', empleado.apellido, ' ', empleado.nombre, ' ', empleado.edad, ' ', empleado.dni);
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
	writeln('e. Añadir Empleados al Archivo.');
	writeln('f. Modificar Edad de Empleados.');
	writeln('g. Exportar a "todos_empleados.txt".');
	writeln('h. Exportar a "faltaDNIEmpleado.txt" empleados sin DNI.');
	writeln('i. Salir.');
	writeln('');
	
	write('Ingrese una opcion: ');
	readln(opc);
	
	while (opc <> 'i') do begin
		case (opc) of
			'a': CrearArchivo(archEmpleados);
			'b': ListarNomApeDeter(archEmpleados);
			'c': ListarDatos(archEmpleados);
			'd': ListarProxJubilarse(archEmpleados);
			'e': AddEmpleados(archEmpleados);
			'f': ModificarEdad(archEmpleados);
			'g': ExportarAtxt (archEmpleados);
			'h': ExportarSinDniAtxt(archEmpleados);
		end;
		
		write('Ingrese una opcion: ');
		readln(opc);
		writeln('');
		
	end;
	
END.
