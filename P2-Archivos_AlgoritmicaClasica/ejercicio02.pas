{2. Se dispone de un archivo con información de los alumnos de la Facultad de 
Informática. Por cada alumno se dispone de su código de alumno, apellido, nombre,
cantidad de materias (cursadas) aprobadas sin final y cantidad de materias con 
final aprobado. Además, se tiene un archivo detalle con el código de alumno e 
información correspondiente a una materia (esta información indica si aprobó la 
cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle 
puede haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide 
realizar un programa con opciones para:
a. Actualizar el archivo maestro de la siguiente manera:
	i.Si aprobó el final se incrementa en uno la cantidad de materias con 
	final aprobado.
	ii.Si aprobó la cursada se incrementa en uno la cantidad de materias 
	aprobadas sin final.
b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias 
	con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo
una vez.}

PROGRAM ejercicio2;
CONST 
	VALTO = 9999;
TYPE
	str20 = string[20];
	reg_alumno = record
		codAlumno: integer;
		apellido: str20;
		nombre: str20;
		cantCursadas: integer;
		cantAprobadas: integer;
	end;
	
	reg_materia = record
		codAlum: integer;
		aprobada: boolean;
	end;
	
	arch_maestro = file of reg_alumnos;
	arch_detalle = file of reg_materia;
	
//____________________________________________Listar en Txt____________________________________________
Procedure ListarEnTxt(var archivo: maestro);
Var
	txt = Text;
	alumno: reg_alumno;
	
Begin
	reset(archivo);
	rewrite(txt);
	while (not eof(archivo)) do begin
		read(archivo, alumno);
		if (alumno.cantCursadas > 4) then
			with alumno do begin
				writeln(txt, codAlumno, cantCursadas, nombre);
				writeln(txt, cantAprobadas, apellido);
			end;
	end;
	close(archivo);
	close(txt);
End;

//____________________________________________GenerarArchivoMaestro____________________________________________

//____________________________________________Leer Archivo Detalle____________________________________________ 
Procedure Leer(var arch: detalle; var dato: reg_alumno);
Begin
	if (not eof(arch)) then
		read(arch, dato);
	else
		dato.codAlum:= VALTO;
End;
//____________________________________________P.P____________________________________________
VAR
	maestro: arch_maestro;
	detalle: arch_detalle;
	
	regM: reg_alumno;
	regD, aux: reg_materia;
	
	finales, cursadas: integer;
BEGIN
	assign (maestro, 'maestro');
	reset (maestro);
	
	assign (detalle, 'detalle');
	reset (detalle);
	
	read(mestro, regM);
	leer(detalle, regD)
	
	while (regD.codAlum <> VALTO) do begin			//proceso todos los registros de los arch detalle
		aux:= regD.codAlum;
		finales:= 0;
		cursadas:= 0;
		
		while (aux = regD.conAlum) do begin 		//totalizo cant materias aprobadas o cursadas
			if (regD.aprobada) then					//en archivo detalle
				finales:= finales + 1;
			else
				cursadas:= cursadas + 1;
		end;
		
		while (regM.codAlumno <> aux.codAlum)		//busco en el maestro el que coincida con detalle
			read(mestro, regM);
			
		regM.cantAprobadas:= regM.cantAprobadas + finales;
		regM.cantCursadas:= regM.cantCursadas + cursadas;			//actualizo registros
		
		seek(mestro, filepos(maestro - 1));		//me posiciono al mestro anterior
		
		write(maestro, regM);			//actualizo maestro
			
		if (not eof(maestro))
			read(maestro, regM);
	end;
	
	close(maestro);
	close(detalle);
END;














