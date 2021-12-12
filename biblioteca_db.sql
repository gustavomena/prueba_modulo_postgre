-- Crear Base de datos 
DROP DATABASE biblioteca;
CREATE DATABASE biblioteca;
\c biblioteca;

--tabla de comunas, ya que en los datos de muestra parece un campo compuesto
CREATE TABLE comuna
(
    idcomuna SERIAL PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL
);

--tabla de socio
CREATE TABLE socio
(
    rut VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL ,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    comuna_idcomuna INT NOT NULL,
    telefono INT NOT NULL,

    FOREIGN KEY(comuna_idcomuna) REFERENCES comuna(idcomuna)
);

--tabla libros
CREATE TABLE libro
(
    isbn VARCHAR(16) PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    paginas SMALLINT NOT NULL
);

--apellido y fechas deben ser nulos para soportar:
--el escritor anonimo,
--los que usan pseudonimos para escribir
--los que no se conocen sus datos
CREATE TABLE autor
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

    FOREIGN KEY(libro_isbn) REFERENCES libro(isbn),
    FOREIGN KEY(autor_idautor) REFERENCES autor(idautor),
    FOREIGN KEY(idtipo_autor) REFERENCES tipo_autor(idtipo_autor)
);

--tabla de prestamos
CREATE TABLE prestamo
(
    idprestamo SERIAL PRIMARY KEY,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE NOT NULL,
    socio_rut VARCHAR(15) NOT NULL,
    libro_isbn VARCHAR(15) NOT NULL,

    FOREIGN KEY(libro_isbn) REFERENCES libro(isbn),
    FOREIGN KEY(socio_rut) REFERENCES socio(rut)
);

\echo 'INSERTANDO LIBROS';
INSERT INTO libro(isbn,titulo,paginas) VALUES('111-1111111-111','CUENTOS DE TERROR',344);
INSERT INTO libro(isbn,titulo,paginas) VALUES('222-2222222-222','POESÍAS CONTEMPORÁNEAS',167);
INSERT INTO libro(isbn,titulo,paginas) VALUES('333-3333333-333','HISTORIA DE ASIA',511);
INSERT INTO libro(isbn,titulo,paginas) VALUES('444-4444444-444','MANUAL DE MECÁNICA',298);

\echo 'INSERTANDO TIPO DE AUTOR';
INSERT INTO tipo_autor(tipo_autor) VALUES('PRINCIPAL');
INSERT INTO tipo_autor(tipo_autor) VALUES('COAUTOR');

\echo 'INSERTANDO AUTORES';
INSERT INTO autor(idautor,nombre,apellido,anno_nacimiento,anno_muerte)VALUES(3,'JOSE','SALGADO',1968,2020);
INSERT INTO autor(idautor,nombre,apellido,anno_nacimiento,anno_muerte)VALUES(4,'ANA','SALGADO',1972,NULL);
INSERT INTO autor(idautor,nombre,apellido,anno_nacimiento,anno_muerte)VALUES(1,'ANDRÉS','ULLOA',1982,NULL);
INSERT INTO autor(idautor,nombre,apellido,anno_nacimiento,anno_muerte)VALUES(2,'SERGIO','MARDONES',1950,2012);
INSERT INTO autor(idautor,nombre,apellido,anno_nacimiento,anno_muerte)VALUES(5,'MARTIN','PORTA',1976,NULL);

\echo 'INSERTANDO INSERTANDO LOS AUTORES EN LOS LIBROS';
INSERT INTO libro_autor(libro_isbn,autor_idautor, idtipo_autor) VALUES('111-1111111-111',3,1);
INSERT INTO libro_autor(libro_isbn,autor_idautor, idtipo_autor) VALUES('111-1111111-111',4,2);
INSERT INTO libro_autor(libro_isbn,autor_idautor, idtipo_autor) VALUES('222-2222222-222',1,1);
INSERT INTO libro_autor(libro_isbn,autor_idautor, idtipo_autor) VALUES('333-3333333-333',2,1);
INSERT INTO libro_autor(libro_isbn,autor_idautor, idtipo_autor) VALUES('444-4444444-444',5,1);

\echo 'INSERTANDO COMUNA';
INSERT INTO comuna(nombre)VALUES('SANTIAGO');

\echo 'INSERTANDO SOCIOS';
INSERT INTO socio    (rut,nombre,apellido,direccion,comuna_idcomuna,telefono)VALUES('1111111-1', 'JUAN', 'SOTO', 'AVENIDA 1', 1, 911111111);
INSERT INTO socio    (rut,nombre,apellido,direccion,comuna_idcomuna,telefono)VALUES('2222222-2', 'ANA', 'PÉREZ' , 'PASAJE 2', 1, 922222222);
INSERT INTO socio    (rut,nombre,apellido,direccion,comuna_idcomuna,telefono)VALUES('3333333-3' , 'SANDRA' , 'AGUILAR', 'AVENIDA 2', 1, 933333333);
INSERT INTO socio    (rut,nombre,apellido,direccion,comuna_idcomuna,telefono)VALUES('4444444-4' , 'ESTEBAN' , 'JEREZ', 'AVENIDA 3', 1, 944444444);
INSERT INTO socio    (rut,nombre,apellido,direccion,comuna_idcomuna,telefono)VALUES('5555555-5' , 'SILVANA', 'MUÑOZ', 'PASAJE 3', 1, 955555555);

\echo 'INSERTANDO PRESTAMOS';
INSERT INTO prestamo(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion)VALUES('111-1111111-111','1111111-1','2020-01-20','2020-01-27');
INSERT INTO prestamo(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion)VALUES('222-2222222-222','5555555-5','2020-01-20','2020-01-30');
INSERT INTO prestamo(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion)VALUES('333-3333333-333','3333333-3','2020-01-22','2020-01-30');
INSERT INTO prestamo(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion)VALUES('444-4444444-444','4444444-4','2020-01-23','2020-01-30');
INSERT INTO prestamo(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion)VALUES('111-1111111-111','2222222-2','2020-01-27','2020-02-04');
INSERT INTO prestamo(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion)VALUES('444-4444444-444','1111111-1','2020-01-31','2020-02-12');
INSERT INTO prestamo(libro_isbn,socio_rut,fecha_prestamo,fecha_devolucion)VALUES('111-1111111-111','3333333-3','2020-01-31','2020-02-12');


\echo 'Mostrar todos los libros que posean menos de 300 páginas';
SELECT *
FROM LIBRO
WHERE PAGINAS<300;

\echo 'Mostrar todos los autores que hayan nacido después del 01-01-1970.';
SELECT *
FROM AUTOR
WHERE ANNO_NACIMIENTO>=1970;

\echo '¿Cuál es el libro más solicitado?';

SELECT X.CANTIDAD_PRESTAMOS, LIBRO.*
FROM LIBRO INNER JOIN (SELECT COUNT(LIBRO_ISBN) CANTIDAD_PRESTAMOS, LIBRO_ISBN
    FROM PRESTAMO
    GROUP BY LIBRO_ISBN) AS X ON X.LIBRO_ISBN=LIBRO.ISBN
ORDER BY X.CANTIDAD_PRESTAMOS DESC LIMIT 1;

\echo 'Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.';
SELECT COUNT(RUT) AS CANTIDAD_PRESTAMOS, SOCIO.RUT, SOCIO.NOMBRE,SOCIO.APELLIDO, COUNT(RUT)*700 AS PAGO_X_ATRASO
FROM PRESTAMO INNER JOIN SOCIO ON PRESTAMO.SOCIO_RUT=SOCIO.RUT
GROUP BY RUT; 
