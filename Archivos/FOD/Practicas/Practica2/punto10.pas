program punto8;
type

	archivEmp=record
		departamento:string;
		division:integer;
		nroEmp:integer;
		categoria:1..15;
		cantHoras:integer;
	
	end;
	maestro=file of archivEmp;
	
	vector=array [ 1..15] of integer;
	
	procedure Leer(var arch:maestro;var dato:archivEmp);
	begin
	if(not eof(arch))then 
	begin
		read(arch,dato);
	end
	else
		dato.departamento:='zzzzz';
end;
	
procedure cargarV(var v:vector);
var
archText:text;
cat:integer;
hora:integer;
begin
assign(archText,'horasExtras.txt');
reset(archText);
	while(not eof(archtext)) do begin
		readln(archText,cat,hora);
		v[cat]:=hora;
	
	end;

close(archText);
end;
var
archivo:maestro;
c:archivEmp;
Montototalpordivision,Montototaldepartamento,totHoras,Totalhorasdepartamento,Totaldehorasdivision,division,nro,importeAcobrar:integer;
V:vector;
dep:string;

begin
	
	cargarV(V);
	
	assign(archivo,'votos');
	leer(archivo,c);
	
	
	
	while(c.departamento<>'zzzzz')do begin
	
		writeln('Departamento: ',c.departamento);
		
		dep:=c.departamento;
		
		Totalhorasdepartamento:=0;
		Montototaldepartamento:=0;
		
		
		while(c.departamento=dep)do begin
		
			division:=c.division;
			
			Totaldehorasdivision:=0;
			Montototalpordivision:=0;
			
			while((c.departamento=dep)and(c.division=division))do begin
					nro:=c.nroEmp;
					
					totHoras:=0;
					importeAcobrar:=0;
					
					while((c.departamento=dep)and(c.division=division)and(nro=c.nroEmp))do begin
					
						totHoras:=totHoras+c.cantHoras;
						importeAcobrar:=totHoras*V[c.categoria];
						read(archivo,c);
					
					end;
					
					Totaldehorasdivision:=Totaldehorasdivision+totHoras;
					Montototalpordivision:=Montototalpordivision+importeAcobrar;
					
					writeln('Nro empleado:', c.nroEmp,'Tot horas:',totHoras,'Importe a cobrar:',importeAcobrar);
				
				end;
				Totalhorasdepartamento:=Totalhorasdepartamento+Totaldehorasdivision;
				Montototaldepartamento:=Montototaldepartamento+Montototalpordivision;
				
				writeln('Total horas division', Totaldehorasdivision);
				writeln('Monto Total por division', Montototalpordivision);
				
			
			
			end;
			writeln('Total horas departamento', Totalhorasdepartamento);
			writeln('Monto total departamento', Montototaldepartamento);
			
			
			
		end;
		close(archivo);
	
	
end.


