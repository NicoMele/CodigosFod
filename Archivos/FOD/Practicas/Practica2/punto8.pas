program punto6;
type
	cliente=record
		cod:integer;
		nombre:string;
		apellido:string;
		anio:integer;
		mes:1..12;
		dia:string;
		monto:integer;
	
	end;
	
	clientes=file of cliente;
	
	vector=array [ 1..12] of integer;
	
	procedure Leer(var arch:clientes;var dato:cliente);
	begin
	if(not eof(arch))then 
	begin
		read(arch,dato);
	end
	else
		dato.cod:=9999;
end;
	
	procedure pongoEn0Vector(var v:vector);
	var
	i:integer;
	begin
		for i:= 1 to 12 do begin
			v[i]:=0;
		
		end;
	
	end;
	
	
	procedure imprimirArreglo(v:vector);
	var
	i:integer;
	begin
		for i:= 1 to 12 do begin
		
				writeln('Mes: ',i,' Monto',v[i]);
		
		end;
	
	end;
var
archivo:clientes;
c:cliente;
ClienteVariable,totEmpresa,totAnio,anio:integer;
mes:integer;
v:vector;
begin
	assign(archivo,'ventas');
	leer(archivo,c);
	totEmpresa:=0;
	
	while(c.cod<>9999)do begin
	
		writeln('Cliente: ',c.nombre,' Apellido: ',c.apellido,' codigo:',c.cod);
		
		ClienteVariable:=c.cod;
		
		while(c.cod=ClienteVariable)do begin
		
			anio:=c.anio;
			totAnio:=0;
			pongoEn0Vector(v);
			
			while((c.cod=ClienteVariable)and(anio=c.anio))do begin
			
				mes:=c.mes;
				
				while((c.cod=ClienteVariable)and (anio=c.anio) and(c.mes=mes))do begin
					v[mes]:=v[mes]+c.monto;
					leer(archivo,c);
				
				end;
				totAnio:=totAnio+v[mes];
			end;
			
			imprimirArreglo(v);
			writeln('Anio:',anio,'Monto:',totAnio);
			
			totEmpresa:=totEmpresa+totAnio;
			
			
		end;
		
	
	end;
	writeln('Total del empresa',totEmpresa);
	
end.
