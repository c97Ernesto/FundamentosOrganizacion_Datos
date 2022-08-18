PROGRAM Ejercicio3
TYPE
	opciones = ['a', 'b', 'c', 'd', 'e'];
	reg_Empleado = record
		numEmpleado: integer;
		apellido: str20;
		nombre: str20;
		edad: integer;
		dni: integer;
	end;
	
	Archivo_Empleados = file of reg_Empleado;

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
	empleado_ reg_Empleado;
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
	
	close;
	readln();
	
End;


VAR
	archEmpleados: Archivo_Empleados;
	opc: opciones
BEGIN
	writeln('MENU');
	writeln('a. Crear Archivo de Empleados.');
	writeln('b. Listar nombre o apellido de empleado determinado.');
	writeln('c. Listar todos los empleados.');
	writeln('d. Listar empleados pronto a jubilarse.');
	writeln('e. Salir.');
	
	write('Ingrese una opcion: ');
	readln(opc);
	
	case (opc) of
		'a': CrearArchivo(archEmpleados);
		'b': ListarNombreDeterminado(archEmpleados);
		'c': ListarDatos(archEmpleados);
		'd': ListarProxJubilarse(archEmpleados);
		'e': halt;
		
		else begin
			writeln('Opcion Incorrecta');
		end;
	end;
END.