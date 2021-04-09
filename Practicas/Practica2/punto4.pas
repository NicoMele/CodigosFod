program punto4;
Uses sysutils;
	const n=5;
type
	detalles=record
		codUsuario:integer;
		fecha:string;
		tiempoSesion:real;
		end;
		
	maes=record
	codUsuario:integer;
	fecha:string;
	totalTiempo:real;
	end;
	

	maestro=file of maes;
	
	detalle=file of detalles;
	
	arrayDetalles= array [ 1..n ] of detalle;
	
	arrayRegDetalles=array [ 1..n ] of detalles;
	
	
	procedure Leer (var archivo:detalle; var dato:detalles);
    begin
      if (not eof( archivo ))
        then read (archivo, dato)
        else dato.codUsuario:= 9999;
    end;


	procedure minimo(var V:arrayDetalles;var V2:arrayRegDetalles; var min:detalles);
	var 
	i,pos:integer;
	begin
		
		min.codUsuario:=9999;
		min.fecha:='zzzz';
		
		for i:= 1 to n do
		begin
		
			if((V2[i].codUsuario<min.codUsuario)or((V2[i].codUsuario=min.codUsuario)and(V2[i].fecha<min.fecha)))then
				
					min:=V2[i];
					pos:=i;
				
		
			end;
	if(min.codUsuario<>9999)then begin
			
		Leer(V[pos],V2[pos]);	
		end;
	end;


procedure crearM(var d:arrayRegDetalles; var V:arrayDetalles);
var
archivo:maestro;
min:detalles;
m:maes;
i:integer;
begin
	assign(archivo,'/var/log');
	rewrite(archivo);
	
	minimo(V,d,min);
	
	
	while(min.codUsuario<>9999)do begin
	
		m.codUsuario:=min.codUsuario;
		
		
		while(min.codUsuario=m.codUsuario)do begin
		
			m.totalTiempo:=0;
			m.fecha:=min.fecha;
			
			while((min.codUsuario=m.codUsuario)and(min.fecha=m.fecha))do begin
			
				m.totalTiempo:=m.totalTiempo+min.tiempoSesion;
			
				
				minimo(V,d,min);
			
			
			end;
			write(archivo,m);
		
		end;
		
		
		
	
	end;
close(archivo);


for i:= 1 to n do begin
		close(V[i]);	
end;


end;


var

i:integer;
D:arrayDetalles;
V2:arrayRegDetalles;
aux:string;
begin

for i:= 1 to n do begin

		aux:=IntToStr(i);
		
		assign(D[i],'detalle'+aux);
		reset(D[i]);
		Leer(D[i],V2[i]);		
end;

crearM(V2,D);




end.
