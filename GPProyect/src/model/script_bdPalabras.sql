CREATE DATABASE bdPalabras; -- DROP DATABASE bdPalabras;

USE bdPalabras; -- USE mysql;

CREATE TABLE usuario( -- SELECT * FROM usuario
    id INT AUTO_INCREMENT,
    run VARCHAR(13),
    nombre VARCHAR(100),
    password VARCHAR(100),
    PRIMARY KEY(id)
); -- DROP TABLE usuario

INSERT INTO usuario VALUES(NULL, '11-1','nom1','111');
INSERT INTO usuario VALUES(NULL, '22-2','nom2','222');
INSERT INTO usuario VALUES(NULL, '33-3','nom3','333');
INSERT INTO usuario VALUES(NULL, '44-4','Claudio Castro','castro');
INSERT INTO usuario VALUES(NULL, '55-5','Juan Pablo Queraltó','banana');



CREATE TABLE significado( -- SELECT * FROM significado
id INT AUTO_INCREMENT,
descripcionSignificado VARCHAR(400),
PRIMARY KEY (id)
); -- DROP TABLE significado

INSERT INTO significado VALUES(NULL,'Hola');


CREATE TABLE palabra( -- SELECT * FROM palabra
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    fk_significado INT,
    PRIMARY KEY(id),
    FOREIGN KEY(fk_significado) REFERENCES significado(id)
); -- DROP TABLE palabra;
INSERT INTO palabra VALUES(NULL,'Holas',1);


SELECT descripcionSignificado, nombre 
FROM significado 
INNER JOIN palabra ON significado.id = palabra.fk_significado



/*PROCEDIMIENTO ALMACENADO QUE VALIDA QUE EL RUT NO SEA EL MISMO*/

DELIMITER //

CREATE PROCEDURE existeuser ( IN _run varchar(13),  _nombre VARCHAR(100), _contra VARCHAR(100))
BEGIN
    DECLARE  _existerut bit;

    SET _existerut= (SELECT COUNT(*) FROM usuario WHERE run=_run);
    if _existerut=0
        THEN
            INSERT INTO usuario(id,run,nombre,password) VALUES(null,_run,_nombre,_contra);
            SELECT 'USER CREADO EXITOSAMENTE';
    ELSE
	select 'Ya existe el usuario';
    END if;

END

//
DELIMITER ;-- DROP PROCEDURE existeuser




--CREACION DE PALABRA
DELIMITER //
CREATE PROCEDURE registrarPalabra (IN _significado VARCHAR(300), OUT _id INT)
BEGIN

    DECLARE _descripcionIgual bit;
    DECLARE _idSignificado INT;
    SET _descripcionIgual = (SELECT COUNT(*) FROM significado WHERE descripcionSignificado = _significado);
    IF _descripcionIgual = 1
        THEN
            SET _idSignificado = (SELECT id FROM significado WHERE descripcionSignificado = _significado);
        ELSE
            SELECT 'Descripcion no encontrada o no es igual que la ingresada';
    END IF;

    SET _id = _idSignificado;
    SELECT _id;
END

//
DELIMITER ; -- DROP PROCEDURE registrarPalabra

CALL registrarPalabra(poto);

INSERT INTO palabra VALUES(NULL,'a',(SELECT MAX(id) FROM significado));