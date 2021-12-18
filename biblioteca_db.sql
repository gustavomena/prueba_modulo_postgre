-- Crear Base de datos 
DROP DATABASE biblioteca;
CREATE DATABASE biblioteca;
\c biblioteca;

--tabla de comunas, ya que en los datos de muestra parece un campo compuesto
CREATE TABLE comunas
(
    idcomuna SERIAL PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL
);

--tabla de socio
CREATE TABLE socios
(
    rut VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL ,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    comuna_idcomuna INT NOT NULL,
    telefono INT NOT NULL,

    FOREIGN KEY(comuna_idcomuna) REFERENCES comunas(idcomuna)
);

--tabla libros
CREATE TABLE libros
(
    isbn VARCHAR(16) PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    paginas SMALLINT NOT NULL
);

--apellido y fechas deben ser nulos para soportar:
--el escritor anonimo,
--los que usan pseudonimos para escribir
--los que no se conocen sus datos
CREATE TABLE autores
(
    idautor SMALLINT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NULL,
    anno_nacimiento SMALLINT NULL,
    anno_muerte SMALLINT NULL
);

--tabla tipo autor, para poder asignar los tipos autor y co-autor
CREATE TABLE tipo_autor
(
    idtipo_autor SERIAL PRIMARY KEY,
    tipo_autor VARCHAR(45) NOT NULL
);

--tabla libro autor, asigna a los libros sus  autores
CREATE TABLE libro_autor
(
    idlibro_autor SERIAL PRIMARY KEY,
    libro_isbn VARCHAR(15) NOT NULL,
    autor_idautor SMALLINT NOT NULL,
    idtipo_autor SMALLINT NOT NULL,

    FOREIGN KEY(libro_isbn) REFERENCES libros(isbn),
    FOREIGN KEY(autor_idautor) REFERENCES autores(idautor),
    FOREIGN KEY(idtipo_autor) REFERENCES tipo_autor(idtipo_autor)
);

--tabla de prestamos
CREATE TABLE prestamos
(
    idprestamo SERIAL PRIMARY KEY,
    fecha_prestamo DATE NOT NULL,
    fecha_esperada_devolucion DATE NOT NULL,
    fecha_devolucion DATE NOT NULL,
    socio_rut VARCHAR(15) NOT NULL,
    libro_isbn VARCHAR(15) NOT NULL,

    FOREIGN KEY(libro_isbn) REFERENCES libros(isbn),
    FOREIGN KEY(socio_rut) REFERENCES socios(rut)
);

\echo 'INSERTANDO LIBROS';
INSERT INTO libros(isbn,titulo,paginas) VALUES('111-1111111-111','CUENTOS DE TERROR',344);
INSERT INTO libros(isbn,titulo,paginas) VALUES('222-2222222-222','POESÍAS CONTEMPORÁNEAS',167);
INSERT INTO libros(isbn,titulo,paginas) VALUES('333-3333333-333','HISTORIA DE ASIA',511);
INSERT INTO libros(isbn,titulo,paginas) VALUES('444-4444444-444','MANUAL DE MECÁNICA',298);

\echo 'INSERTANDO TIPO DE AUTOR';
INSERT INTO tipo_autor(tipo_autor) VALUES('PRINCIPAL');
INSERT INTO tipo_autor(tipo_autor) VALUES('COAUTOR');

\echo 'INSERTANDO AUTORES';
INSERT INTO autores(idautor,nombre,apellido,anno_nacimiento,anno_muerte)VALUES(3,'JOSE','SALGADO',1968,2020);
INSERT INTO autores(idautor,nombre,apellido,anno_nacimiento,anno_muerte)VALUES(4,'ANA','SALGADO',1972,NULL);
INSERT INTO autores(idautor,nombre,apellido,anno_nacimiento,anno_muerte)VALUES(1,'ANDRÉS','ULLOA',1982,NULL);
INSERT INTO autores(idautor,nombre,apellido,anno_nacimiento,anno_muerte)VALUES(2,'SERGIO','MARDONES',1950,2012);
INSERT INTO autores(idautor,nombre,apellido,anno_nacimiento,anno_muerte)VALUES(5,'MARTIN','PORTA',1976,NULL);

\echo 'INSERTANDO INSERTANDO LOS AUTORES EN LOS LIBROS';
INSERT INTO libro_autor(libro_isbn,autor_idautor, idtipo_autor) VALUES('111-1111111-111',3,1);
INSERT INTO libro_autor(libro_isbn,autor_idautor, idtipo_autor) VALUES('111-1111111-111',4,2);
INSERT INTO libro_autor(libro_isbn,autor_idautor, idtipo_autor) VALUES('222-2222222-222',1,1);
INSERT INTO libro_autor(libro_isbn,autor_idautor, idtipo_autor) VALUES('333-3333333-333',2,1);
INSERT INTO libro_autor(libro_isbn,autor_idautor, idtipo_autor) VALUES('444-4444444-444',5,1);

\echo 'INSERTANDO COMUNA';
INSERT INTO comunas(nombre)VALUES('SANTIAGO');

\echo 'INSERTANDO SOCIOS';
INSERT INTO socios    (rut,nombre,apellido,direccion,comuna_idcomuna,telefono)VALUES('1111111-1', 'JUAN', 'SOTO', 'AVENIDA 1', 1, 911111111);
INSERT INTO socios    (rut,nombre,apellido,direccion,comuna_idcomuna,telefono)VALUES('2222222-2', 'ANA', 'PÉREZ' , 'PASAJE 2', 1, 922222222);
INSERT INTO socios    (rut,nombre,apellido,direccion,comuna_idcomuna,telefono)VALUES('3333333-3' , 'SANDRA' , 'AGUILAR', 'AVENIDA 2', 1, 933333333);
INSERT INTO socios    (rut,nombre,apellido,direccion,comuna_idcomuna,telefono)VALUES('4444444-4' , 'ESTEBAN' , 'JEREZ', 'AVENIDA 3', 1, 944444444);
INSERT INTO socios    (rut,nombre,apellido,direccion,comuna_idcomuna,telefono)VALUES('5555555-5' , 'SILVANA', 'MUÑOZ', 'PASAJE 3', 1, 955555555);

\echo 'INSERTANDO PRESTAMOS';
INSERT INTO prestamos(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion,fecha_esperada_devolucion)VALUES('111-1111111-111','1111111-1','2020-01-20','2020-01-27','2020-01-27');
INSERT INTO prestamos(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion,fecha_esperada_devolucion)VALUES('222-2222222-222','5555555-5','2020-01-20','2020-01-30','2020-01-27');
INSERT INTO prestamos(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion,fecha_esperada_devolucion)VALUES('333-3333333-333','3333333-3','2020-01-22','2020-01-30','2020-01-29');
INSERT INTO prestamos(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion,fecha_esperada_devolucion)VALUES('444-4444444-444','4444444-4','2020-01-23','2020-01-30','2020-01-30');
INSERT INTO prestamos(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion,fecha_esperada_devolucion)VALUES('111-1111111-111','2222222-2','2020-01-27','2020-02-04','2020-02-04');
INSERT INTO prestamos(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion,fecha_esperada_devolucion)VALUES('444-4444444-444','1111111-1','2020-01-31','2020-02-12','2020-02-07');
INSERT INTO prestamos(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion,fecha_esperada_devolucion)VALUES('111-1111111-111','3333333-3','2020-01-31','2020-02-12','2020-02-07');


\echo 'Mostrar todos los libros que posean menos de 300 páginas';
SELECT *
FROM LIBROS
WHERE PAGINAS<300;

\echo 'Mostrar todos los autores que hayan nacido después del 01-01-1970.';
SELECT *
FROM AUTORES
WHERE ANNO_NACIMIENTO>=1970;

\echo '¿Cuál es el libro más solicitado?';

SELECT X.CANTIDAD_PRESTAMOS, LIBROS.*
FROM LIBROS INNER JOIN (SELECT COUNT(LIBRO_ISBN) CANTIDAD_PRESTAMOS, LIBRO_ISBN
    FROM PRESTAMOS
    GROUP BY LIBRO_ISBN) AS X ON X.LIBRO_ISBN=LIBROS.ISBN
ORDER BY X.CANTIDAD_PRESTAMOS DESC LIMIT 1;

\echo 'Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.';

SELECT SUM(fecha_devolucion-fecha_esperada_devolucion)*100 as total_deuda, SOCIOS.NOMBRE, SOCIOS.APELLIDO
FROM PRESTAMOS INNER JOIN SOCIOS ON SOCIOS.RUT=PRESTAMOS.SOCIO_RUT
GROUP BY SOCIOS.RUT ;

