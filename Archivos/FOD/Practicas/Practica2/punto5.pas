program punto5;
Uses sysutils;
	const n=50;
type
	
	
	nacimientos=record
		nroPartida:integer;
		nombre:string;
		apellido:string;
		direccion:string;
		matriculaMedico:integer;
		dniMadre:string;
		nombreYapeMadre:string;
		nombreYapePadre:string;
		dniPadre:string;
		end;
		
	fallecimientos=record
		nroPartida:integer;
		DNI:string;
		nombre:string;
		apellido:string;
		fecha:string;
		hora:string;
		lugar:string;
		matriculaMedicoFirmo:integer;
		end;
		
	maes=record
		nroPartida:integer;
		nombre:string;
		apellido:string;
		direccion:string;
		matriculaMedico:integer;
		matriculaMedicoFirmo:integer;
		dniMadre:string;
		nombreYapeMadre:string;
		nombreYapePadre:string;
		dniPadre:string;
		fecha:string;
		hora:string;
		lugar:string;
		
	end;
	

	maestro=file of maes;
	
	detalle1=file of nacimientos;
	detalle2=file of fallecimientos;
	
	arrayNacimientosDetalles= array [ 1..n ] of detalle1;
	
	arrayRegNacimientos=array [ 1..n ] of nacimientos;
	
	arrayFallecimientosDetalles= array [ 1..n ] of detalle2;
	
	arrayRegFallecimientos=array [ 1..n ] of Fallecimientos;
	
	
	procedure Leer (var archivo:detalle1; var dato:nacimientos);
    begin
      if (not eof( archivo ))
        then read (archivo, dato)
        else dato.nroPartida:= 9999;
    end;
		
	procedure Leer2 (var archivo:detalle2; var dato:fallecimientos);
    begin
      if (not eof( archivo ))
        then read (archivo, dato)
        else dato.nroPartida:= 9999;
    end;


	
procedure minimo1(d2:arrayRegFallecimientos;var V2:arrayFallecimientosDetalles;var min1:fallecimientos);
 var 
	i,pos:integer;
	begin
		min1.nroPartida:=9999;
		pos:=0;
		
		for i:= 1 to n do
		begin
		
			if(d2[i].nroPartida<min1.nroPartida)then
				
					min1:=d2[i];
					pos:=i;
				
		
			end;
			
		if(min1.nroPartida<>9999)then begin
			Leer2(V2[pos],d2[pos]);
			end;


end;

procedure minimo2(var d1:arrayRegNacimientos; var V1:arrayNacimientosDetalles;var min2:nacimientos);
 var 
	i,pos:integer;
	begin
		min2.nroPartida:=9999;
		
		pos:=0;
		for i:= 1 to n do
		begin
		
			if(d1[i].nroPartida<min2.nroPartida)then
				
					min2:=d1[i];
					pos:=i;
				
		
			end;
			
	if(min2.nroPartida<>9999)then begin
			
		Leer(V1[pos],d1[pos]);
		
		end;


end;
procedure crearMaestro(var d1:arrayRegNacimientos; var V1:arrayNacimientosDetalles;var d2:arrayRegFallecimientos;var V2:arrayFallecimientosDetalles);
var
archivo:maestro;
m:maes;
i:integer;
min1:fallecimientos;
min2:nacimientos;
begin

assign(archivo,'maestro');
rewrite(archivo);
	
	minimo1(d2,V2,min1);
	minimo2(d1,V1,min2);
	
	
	while((min1.nroPartida<>9999)and(min2.nroPartida<>9999)) do begin
	
		if(min1.nroPartida=min2.nroPartida)then begin
		
				m.nroPartida:=min2.nroPartida;	
				m.nombre:=min2.nombre;
				m.apellido:=min2.apellido;	
				m.direccion:=min2.direccion;	
				m.matriculaMedico:=min2.matriculaMedico;	
				m.dniMadre:=min2.dniMadre;	
				m.nombreYapeMadre:=min2.nombreYapeMadre;	
				m.nombreYapePadre:=min2.nombreYapePadre;	
				m.dniPadre:=min2.dniPadre;	
				m.fecha:=min1.fecha;	
				m.hora:=min1.hora;	
				m.lugar:=min1.lugar;	
				m.matriculaMedicoFirmo:=min1.matriculaMedicoFirmo;
				minimo1(d2,V2,min1);
				minimo2(d1,V1,min2);
		
		end 
		else begin
		
			if(min1.nroPartida<min2.nroPartida)then begin
				m.nroPartida:=min1.nroPartida;	
				m.nombre:=min1.nombre;
				m.apellido:=min1.apellido;	
				m.fecha:=min1.fecha;	
				m.hora:=min1.hora;	
				m.lugar:=min1.lugar;	
				m.matriculaMedicoFirmo:=min1.matriculaMedicoFirmo;
				minimo1(d2,V2,min1);
			
			end
			else begin
				
				m.nroPartida:=min2.nroPartida;	
				m.nombre:=min2.nombre;
				m.apellido:=min2.apellido;	
				m.direccion:=min2.direccion;	
				m.matriculaMedico:=min2.matriculaMedico;	
				m.dniMadre:=min2.dniMadre;	
				m.nombreYapeMadre:=min2.nombreYapeMadre;	
				m.nombreYapePadre:=min2.nombreYapePadre;	
				m.dniPadre:=min2.dniPadre;	
				minimo2(d1,V1,min2);
		
			end;
			write(archivo,m);
		
			
	end;
			
				
				
		
for i:= 1 to n do begin
		close(V1[i]);
		close(V2[i]);		
end;
	
	
	
close(archivo);
end;

end;

procedure exportar(var archivo:maestro);
var
d:maes;
archText:text;
begin	
	assign(archText,'reporte.txt');
	rewrite(archText);
	reset(archivo);
	while(not eof(archivo))do
	begin
		read(archivo,d);
		
			write(archText,d.nroPartida,d.nombre,d.apellido,d.direccion,d.matriculaMedico,d.dniMadre,d.nombreYapeMadre,d.nombreYapePadre,d.dniPadre,d.lugar,d.fecha,d.hora,d.matriculaMedicoFirmo);
		
		
	end;
	close(archText);
	close(archivo);
	

end;


var


i:integer;
D1:arrayRegNacimientos;
D2:arrayRegFallecimientos;
V1:arrayNacimientosDetalles;
V2:arrayFallecimientosDetalles;
aux:string;
begin




for i:= 1 to n do begin
		aux:=IntToStr(i);
		assign(V1[i],'detalle'+aux);//??
		reset(V1[i]);
		Leer(V1[i],D1[i]);	
		
		assign(V2[i],'deta'+aux);//??
		reset(V2[i]);
		Leer2(V2[i],D2[i]);	
		
end;

crearMaestro(D1,V1,D2,V2);




end.
