
#primero creo la tabla cliente 

CREATE TABLE cliente
(
    id_cliente INT NOT NULL,

    nombre VARCHAR(30),

    PRIMARY KEY (id_cliente)

)ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1


# segundo creo la tabla venta con la llave foranea a su vez añado el indice al campo foraneo

/* regla 1 : en la tabla padre y en la tabla hijo donde se aplicara la llave foranea no solamente los campos de cada tabla deberan tener el mismo 
			 tipo de dato y ser not null sino que en ambos campos se deberá crear indice y en el momento de crear la llave foranea todas las tablas
             deberan estar vacias.
*/

CREATE TABLE venta
(
    id_factura INT NOT NULL,

    id_cliente INT NOT NULL,    

    cantidad   INT,

    PRIMARY KEY(id_factura),

    INDEX (id_cliente),   #debo crear el index del campo al que añadire llave foranea 

    CONSTRAINT fk_ventas FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
    
    ON UPDATE CASCADE 
  
    ON DELETE CASCADE

)ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1

# borrar tabla 

DROP TABLE venta 

# si quiero crear el indice por aparte   https://www.youtube.com/watch?v=OLGOAkegLj8

CREATE INDEX id_cliente_index ON nombrebasededatos.nombretabla (id_cliente);

#ejemplo 

CREATE INDEX id_cliente ON prueba.venta(id_cliente);

# ver indice creado 

SHOW INDEX FROM nombrebasededatos.nombretabla

# ejemplo 

show index from prueba.venta

#borrar indice creado

ALTER TABLE nombrebasededatos.nombretabla DROP nombre_index;

#ejemplo 

ALTER TABLE prueba.venta DROP id_cliente


# ver descripcion de la tabla creada

SHOW CREATE TABLE venta

# borrar clave foranea 

/* Para eliminar la clave foránea se tiene que especificar el ID que ha sido generado y asignado 
   internamente por MySQL a la clave foránea.
   En este caso, se puede usar la sentencia SHOW CREATE TABLE para determinar dicho ID.
*/

 ALTER TABLE venta DROP FOREIGN KEY fk_ventas; 
 
 # añadir llave foranea cuando tabla ya existe pero siempre cuando ya exista el indice en el campo donde se añadira la llave foranea 
 
 ALTER TABLE venta ADD CONSTRAINT fk_ventas FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente) ON UPDATE CASCADE ON DELETE CASCADE ;

/*
Caso UPDATE y DELETE


    ON DELETE RESTRICT
    ON DELETE NO ACTION
    ON DELETE SET DEFAULT
    ON DELETE CASCADE
    ON DELETE SET NULL


La acción que InnoDB realiza para cualquier operación UPDATE o DELETE 
depende de lo que se haya definido en la subcláusulas ON UPDATE y ON DELETE creada en la cláusula FOREIGN KEY.
Cuando el usuario intenta borrar o actualizar un registro en una tabla padre se realizará lo siguiente:

ON DELETE RESTRICT   es la acción predeterminada, y no permite una eliminación si existe un registro asociado,
                     RESTRICT: Rechaza la operación de eliminación o actualización en la tabla padre. 

ON DELETE NO ACTION   hace lo mismo.

NO ACTION: No se permite borrar o actualizar ningún valor de clave primaria si en la tabla hija hay un valor de clave foránea relacionada.

NO ACTION y RESTRICT son similares en tanto omiten la cláusula ON DELETE u ON UPDATE.              
                     
ON DELETE SET DEFAULT  actualmente no funciona en MySQL - se supone que pone el valor de la clave foránea al valor 
                       por omisión (DEFAULT) que se definió al momento de crear la tabla.

ON DELETE CASCADE,  Si se especifica y una fila en la tabla padre es eliminada, 
                    entonces se eliminarán las filas de la tabla hijo 
                    cuya clave foránea sea igual al valor de la clave referenciada en la tabla padre. 
                    Esta acción siempre ha estado disponible en MySQL.
                    CASCADE: Borra o actualiza el registro en la tabla padre 
                    y automáticamente borra o actualiza los registros coincidentes en la tabla hija.

ON DELETE SET NULL,  Si se especifica las filas en la tabla hijo son actualizadas automáticamente 
                     poniendo en las columnas de la clave foránea el valor NULL. 
                     Si se especifica una acción SET NULL, 
                     debemos asegurarnos de no declarar las columnas en la tabla como NOT NULL. 

*/


# manual :    https://ingsystemas.webnode.es/bases-de-datos/llaves-primarias-y-foraneas/

# crear o añadir indices en tablas   https://www.anerbarrena.com/mysql-create-index-5281/