{3. Se cuenta con un archivo de productos de una cadena de venta de alimentos 
congelados. De cada producto se almacena: código del producto, nombre, descripción,
stock disponible, stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la 
cadena. Se debe realizar el procedimiento que recibe los 30 detalles y actualiza 
el stock del archivo maestro. La información que se recibe en los detalles es: 
código de producto y cantidad vendida. Además, se deberá informar en un archivo 
de texto: nombre de producto, descripción, stock disponible y precio de aquellos 
productos que tengan stock disponible por debajo del stock mínimo.
Nota: todos los archivos se encuentran ordenados por código de productos. En cada 
detalle puede venir 0 o N registros de un determinado producto.}
PROGRAM ejercicio3;
CONST 
	VALOR_ALTO = 9999
	MAXsucursales = 30;
TYPE
	str20 = string[20];
	
	reg_Producto = record
		codProd: integer;
		nombre: str20;
		descrpcion: str20;
		stockDisp: integer;
		stockMin: integer;
		precio: real;
	end;
	
	reg_Detalle = record
		codProd: integer;
		cantVendida: integer;
	end;
	
	arch_maestro = file of reg_Producto;
	arch_detalle = file of reg_Detalle;
	
	vec_archDetalles = array [1..30] of arch_detalle:
	vec_regDetalles = array[1..30] of reg_Detalle


procedure leer(var archD: arch_detalle; r: reg_Detalle);
begin
	if (not eof(archD)) then
		read(archD, r);
	else
		r.codProd:= VALOR_ALTO;
end;

Procedure Minimo(var vReg: vec_regDetalles; min: reg_Detalle; vD: vec_Detalles);
Var
	i: integer;
	minCod: integer;
	minPos: integer;
Begin
	minPos:= 1;
	minCod:= VALOR_ALTO;
	
	for i:= 1 to 30 do begin
		if (vReg[i].cod < minCod) then begin
			min:= vReg[i];
			minCod:= vReg[i].codProd;
			minPos:= i;
		end;	
	end;
	leer(vD[minPos], vReg[minPos]);		//volvemos a leer para saber si fue el ultimo archivo
end;	
	
	
Procedure Actualizar(var maestro: arch_maestro; var vecDetalles: vec_Detalles);
Var
	nomDetalle: str20;
	regMin: reg_Detalle;
	regMaestro: reg_Producto;
	vecRegD: vec_regDetalles;
	totalVendido: integer;
	codAct: integer;
Begin
	for i:= 1 to MAXsucursales do begin
		readln(nomDetalle);
		assign(vDetalles[i], nomDetalle);
		reset(vDetalles[i]);
		leer(vDetalles[i], vecReg[i]);		//cargo el vector de registros con los primeros
	end;									//ya que vienen todos ordenados

	reset (maestro);
	Minimo(vecRegD, regMin, vecDetalles);
	
	while (regMin.codProd <> VALOR_ALTO) do begin
		totalVendido:= 0;
		codAct:= regMin.codProd;
		while (codAct = regMin.codProd) do begin
			totalVendido:= totalVendido + regMin.cantVendida;
			Minimo(vecRegD, regMin, vecDetalles);
		end;
		
		read(maestro, regMaestro);
		while (regMaestro.codProd <> codAct) do 
			read(maestro, regMaestro)
			
		regMaestro.stockDisp:= regMaestro.stockDisp - totalVendido;
		
		seek(maestro, filepos(maestro - 1));
		write(maestro, regMaestro);
	end;
	
	for i:= 1 to MAXsucursales do
		close(vDetalles[i]);
	
End;
	
	
VAR
	nomArch: str20;
	maestro: arch_maestro;
	vecDetalles: vec_Sucursales;
	
BEGIN
	write('Ingresar NOmbre del Archivo Maestro: ');
	readln(nomArch);
	Actualizar(maestro, vecDetalles);
	
	
	
END.