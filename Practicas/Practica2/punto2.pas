program punto2;
Uses sysutils;// libreria para sacar espacios en blanco
type
	alumnos=record
		codAlum:integer;
		nombre:string;
		apellido:string;
		cursadasAprob:integer;
		finalesAprob:integer;
	
	end;
	detalles=record
		codAlum:integer;
		infMateria:string;// F=aprobo final, C=aprobo cursada.
	
	end;
	maestro=file of alumnos;
	detalle=file of detalles;
	
	
procedure creoMaestro(var archivoM:maestro);
var
a:alumnos;
nombreMaestro:string;
archText:text;
begin
	writeln('Ingrese el nombre del archivo maestro');
	readln(nombreMaestro);
	assign(archivoM,nombreMaestro);
	rewrite(archivoM);
	
	assign(archText,'alumnos.txt');
	reset(archText);
	
	while(not eof(archText)) do begin
	
		readln(archText,a.codAlum,a.cursadasAprob,a.nombre);
		readln(archText,a.finalesAprob,a.apellido);
		
		a.nombre:=Trim(a.nombre);//saco espacios
		a.apellido:=Trim(a.apellido);//saco espacios
		
		write(archivoM,a);
	
	
	end;
	close(archivoM);
	close(archText);
	

end;	
procedure creoDetalle(var archivo:detalle);
var
d:detalles;
nombreDetalle:string;
archText:text;
begin
	writeln('Ingrese el nombre del archivo detalle');
	readln(nombreDetalle);
	assign(archivo,nombreDetalle);
	rewrite(archivo);
	
	assign(archText,'detalle.txt');
	reset(archText);
	
	while(not eof(archText)) do begin
	
		readln(archText,d.codAlum,d.infMateria);
		
		d.infMateria:=Trim(d.infMateria);
		
		write(archivo,d);
	
	
	end;
	close(archivo);
	close(archText);
	

end;

procedure Leer(var arch:detalle;var dato:detalles);
begin
	if(not eof(arch))then 
	begin
		read(arch,dato);
	end
	else
		dato.codAlum:=9999;
end;

procedure exportarAReporteAlumno(var archivo:maestro);
var
a:alumnos;
archText:text;
begin	
	assign(archText,'reporteAlumnos.txt');
	rewrite(archText);
	reset(archivo);
	while(not eof(archivo))do
	begin
		read(archivo,a);
		writeln(archText,'Codigo de Alumno: ',a.codAlum,' Cursadas Aprobadas: ',a.cursadasAprob,' Nombre del Alumno: ',a.nombre);
		writeln(archText,'Finales Aprobados: ',a.finalesAprob,' Apellido: ',a.apellido);
	end;
	
	close(archText);
	close(archivo);

end;

procedure exportarAReporteDetalle(var archivo:detalle);
var
d:detalles;
archText:text;
begin	
	assign(archText,'reporteDetalle.txt');
	rewrite(archText);
	reset(archivo);
	while(not eof(archivo))do
	begin
		read(archivo,d);
		writeln(archText,d.codAlum,' ',d.infMateria);
		
	end;
	close(archText);
	close(archivo);
	

end;

procedure actualizoMaestro(var archivoMaes:maestro; var archivoDet:detalle);
var
d:detalles;
a:alumnos;
begin
	reset(archivoMaes);
	reset(archivoDet);
	Leer(archivoDet,d);
	while(d.codAlum<>9999)and(not eof(archivoMaes))do begin
		
		read(archivoMaes,a);
		
		while(a.codAlum<>d.codAlum)do begin
		
		if(not eof (archivoMaes))then
			read(archivoMaes,a);
		end;
		
		while(a.codAlum=d.codAlum)do begin
		
			if(d.infMateria='F')then begin
				a.finalesAprob:=a.finalesAprob+1;
			end
			
			else 
				a.cursadasAprob:=a.cursadasAprob+1;
			Leer(archivoDet,d);
		end;
		Seek(archivoMaes,filepos(archivoMaes)-1);
		write(archivoMaes,a);
		
	
	end;
	close(archivoDet);
	close(archivoMaes);
	
end;

procedure exportarCursadas(var archivo:maestro);
var
a:alumnos;
archText:text;
begin	
	assign(archText,'cursadas.txt');
	rewrite(archText);
	reset(archivo);
	while(not eof(archivo))do
	begin
		read(archivo,a);
		if((a.cursadasAprob>4)and(a.finalesAprob=0))then begin
			writeln(archText,a.codAlum,' ',a.cursadasAprob,' ',a.nombre);
			writeln(archText,a.finalesAprob,' ',a.apellido);
		
		end;
		
		
	end;
	close(archText);
	close(archivo);
	

end;
procedure menu();
begin
	writeln('################################################MENU###############################################################');
	writeln('a-Crear el archivo maestro a partir de un archivo de texto llamado alumnos.txt');
	writeln('b-Crear el archivo detalle a partir de en un archivo de texto llamado detalle.txt');
	writeln('c-Listar el contenido del archivo maestro en un archivo de texto llamado reporteAlumnos.txt');
	writeln('d-Listar el contenido del archivo detalle en un archivo de texto llamado reporteDetalle.txt.');
	writeln('e-Actualizar el archivo maestro');
	writeln('o-Si ya existe el archivo y queres operar con el');
	writeln('Pulse i para cerrar ');
	writeln('################################################MENU################################################################');
	
	
	end;
var
op:string;
archMaes:maestro;
archDet:detalle;
begin
menu();
writeln('Ingrese opcion');
	readln(op);
	while(op<>'i')do begin
	
		Case op of
		
		'a':creoMaestro(archMaes);
		'b':creoDetalle(archDet);
		'c':exportarAReporteAlumno(archMaes);
		'd':exportarAReporteDetalle(archDet);
		'e':actualizoMaestro(archMaes,archDet);
		end;
		writeln('Ingrese opcion');
		readln(op);
	
	end;

end.
