program punto4;
	type
	
		empleados=record
			numeroDeEmp:integer;
			apellido:string;
			nombre:string;
			edad:integer;
			DNI:string;
			end;
	archivoLogico=file of empleados;


procedure LeeEmpleado(var E:empleados);
begin
	writeln('Ingrese el apellido del empleado ');
	readln(E.apellido);
	if(E.apellido<> 'fin')then begin
		writeln('Ingrese el nombre del empleado ');
		readln(E.nombre);
		writeln('Ingrese el numero de Empleado del empleado ');
		readln(E.numeroDeEmp);
		writeln('Ingrese el edad del empleado ');
		readln(E.edad);
		writeln('Ingrese el DNI del empleado ');
		readln(E.DNI);
	end;

end;

procedure ListarNombreYApellido(var archivo:archivoLogico);
var
e:empleados;
nombre:string;
begin
		
		writeln('Ingrese Apellido o Nombre  a buscar ');
		readln(nombre);
		
		reset(archivo);
	
	while(not eof(archivo))do begin
		writeln();
		read(archivo,e);
		if((e.nombre=nombre) or (e.apellido=nombre))then		
		begin
			writeln('Nombre:',' ',e.nombre);
			writeln('Apelido:',' ',e.apellido);
			writeln('Numero de Empleado:',' ',e.numeroDeEmp);
			writeln('Edad:',' ',e.edad);
			writeln('DNI:',' ',e.DNI);
			
		writeln('-------------------------------');	
			
		end;
		
		
	
	end;
	close(archivo);

end;


procedure ListarTodosLosEmpleados(var archivo:archivoLogico);
var
e:empleados;

begin
	
	reset(archivo);
	writeln('Listado de todos los empleados');
	while(not eof(archivo))do begin
		read(archivo,e);
		
			write(' Nombre: ',e.nombre,',');
			write(' Apelido: ',e.apellido,',');
			write(' Numero de Empleado: ',e.numeroDeEmp,',');
			write(' Edad: ',e.edad,',');
			writeln(' DNI: ',e.DNI,',');
			
		
		
	
	end;
	writeln('Fin del listado');
	close(archivo);

end;
procedure ListarMayoresA70(var archivo:archivoLogico);
var
e:empleados;

begin
		
		reset(archivo);
		writeln('Listado de todos los empleados mayores a 70');
	while(not eof(archivo))do begin
		read(archivo,e);
			if(e.edad>70)then begin
			write(' Nombre: ',e.nombre,',');
			write(' Apelido: ',e.apellido,',');
			write(' Numero de Empleado: ',e.numeroDeEmp,',');
			write(' Edad: ',e.edad,',');
			writeln(' DNI: ',e.DNI,',');
			end;
		
		
	
	end;
	close(archivo);

end;

procedure creacion(var archEmpleados:archivoLogico);
var
archFisico:string;
E:empleados;
begin
	
	writeln('Ingrese el nombre del Archivo a crear ');
	readln(archFisico);
	assign(archEmpleados,archFisico);
	rewrite(archEmpleados);
	LeeEmpleado(E);
	while(E.apellido<> 'fin')do begin
	
		write(archEmpleados,E);
		LeeEmpleado(E);
	
	end;
	close(archEmpleados);
	
end;

procedure agregar(var archivo:archivoLogico);
var
E:empleados;
begin
	reset(archivo);
	LeeEmpleado(E);
	Seek(archivo,filesize(archivo));
	writeln('Agrege los empleados, para dejar de agregar coloque fin en el campo apellido');
	while(E.apellido<>'fin')do begin
		write(archivo,E);
		LeeEmpleado(E);
	
	end;
	close(archivo);
end;

procedure modificar(var archivo:archivoLogico);
var
cod:integer;
e:empleados;
edad:integer;

begin
	
	reset(archivo);
	writeln('Agrege el numero de empleado a modificar, para dejar de modificar coloque 0');
	readln(cod);
	read(archivo,e);
	while(cod<>0)do
		begin
			while((not eof(archivo))and(e.numeroDeEmp<>cod))do
				begin
					read(archivo,e);
				end;		
			if(e.numeroDeEmp=cod)then
				begin
					writeln('escriba la edad para actualizarsela al empleado');
					readln(edad);
			
					seek(archivo,filepos(archivo)-1);
					e.edad:=edad;
					write(archivo,e);
				end
					else	
					writeln('Numero de empleado no existente'); 
		
									
										
	writeln('Agrege el numero de empleado a modificar, para dejar de modificar coloque 0');
	readln(cod);
	seek(archivo,0);//me posiciono devuelta en el primer elemento.
	end;
				close(archivo);
	
	
	
end;

procedure faltaDNI(var archivo:archivoLogico);
var
archText:text;
e:empleados;

begin
	
	assign(archText,'faltaDNIEmpleado.txt');
	rewrite(archText);
	reset(archivo);
	while(not eof(archivo))do
	 begin
		read(archivo,e);
		if(e.DNI='00')then begin
			writeln(archText,' ',e.nombre,' ',e.apellido,' ',e.numeroDeEmp,' ',e.edad,' ',e.DNI);
		end;
		end;
	writeln('se exporto con exito al archivo faltaDNIEmpleado.txt');
	close(archivo);
	close(archText);
end;
procedure exportar(var archivo:archivoLogico);
var
archText:text;
e:empleados;

begin
	
	assign(archText,'todos_empleados.txt');
	rewrite(archText);
	reset(archivo);
	while(not eof(archivo))do
	 begin
		read(archivo,e);
		writeln(archText,'Nombre: ',e.nombre,' Apellido: ',e.apellido,' Numero de empleado: ',e.numeroDeEmp,' Edad: ',e.edad,' DNI: ',e.DNI);
		end;
	writeln('se exporto con exito');
	close(archivo);
	close(archText);
end;


procedure menu();

begin
	writeln('################################################MENU###############################################################');
	writeln('a-Para opcion crear un archivo de empleados');
	writeln('b-Para para abrir el archivo y Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
	writeln('c-Para abrir el archivo y  Listar en pantalla los empleados de a uno por linea');
	writeln('d-Para abrir el archivo y Listar en pantalla empleados mayores de 70 , proximos a jubilarse');
	writeln('e-Para agregar empleados');
	writeln('f-Para modificar la edad de los empleados');
	writeln('g-Para exportar todos los empleados a txt');
	writeln('h-Para exportar todos los empleados que no tengan DNI  a txt');
	writeln('o-Si ya existe el archivo y queres operar con el');
	writeln('Pulse zzz para cerrar ');
	writeln('################################################MENU################################################################');
	end;
var 


archivo:archivoLogico;

op,nombre:string;

begin  
	menu();
	
	readln(op);
	
while(op<>'zzz') do begin
	Case op of 
	'o':
	 begin
		writeln('Escriba el nombre del archivo a abrir');
		readln(nombre);
		assign(archivo,nombre);
	end;
	'a': begin
		creacion(archivo);
	end;
	'b':begin
	
		ListarNombreYApellido(archivo);
	end;
	'c':begin
	
		ListarTodosLosEmpleados(archivo);
	end;
	'd':begin
		ListarMayoresA70(archivo);
	
	end;
	'e':begin
		writeln('Agrege los empleados, para dejar de agregar coloque fin en el campo apellido');
		agregar(archivo);
	
	end;
	'f':begin
		modificar(archivo);
	
	end;
	
	'g':begin
		exportar(archivo);
	
	end;
	'h':begin
		faltaDNI(archivo);
	
	end;
	
	end;
	writeln('Ingrese opciones para operar con el archivo o zzz para finalizar');
	readln(op);
	
end;


end.
