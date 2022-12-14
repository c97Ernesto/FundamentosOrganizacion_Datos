1. Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.

Procedure Compactar(var archivo: arch_Empleados);
Var
	empleado: reg_Empleado;
Begin
	reset(archivo);
	
	while (not eof(archivo)) do begin
		read(archivo, empleado);
		codAct:= empleado.codEmpleado;
		
		while (empleado.codEmpleado = codAct) do begin
			
End;