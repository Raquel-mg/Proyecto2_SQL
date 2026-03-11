🎬 Análisis de Base de Datos de Alquiler de Películas con SQL

📌 1. Descripción del proyecto

El objetivo de este proyecto es analizar una base de datos de alquiler de películas utilizando SQL con PostgreSQL mediante la herramienta DBeaver.

A través de diferentes consultas SQL se exploran los datos para obtener información relevante sobre:

Películas

Actores

Categorías

Clientes

Alquileres

Los resultados obtenidos a partir de las consultas se han recopilado posteriormente en un informe de análisis, donde se interpretan los principales patrones y conclusiones extraídas de la base de datos.


🗂 2. Estructura del proyecto

Organización de los archivos del proyecto:

Proyecto 2 - SQL/

├── Consultas y Esquema/
		- Consultas_SQL_Shakila.sql
		- Esquema_Proyecto_Shakila.png

├── Informe de Resultados/
		- Informe de Resultados - Análisis de la Base de Datos de Alquiler de Películas.docx
		- Informe de Resultados - Análisis de la Base de Datos de Alquiler de Películas.pdf

├── README.md


🛠 3. Herramientas utilizadas

Durante el desarrollo del proyecto se utilizaron las siguientes herramientas:

PostgreSQL: Sistema de gestión de bases de datos
DBeaver: Cliente de base de datos y editor SQL
SQL: Lenguaje de consulta para el análisis de datos
Editor de documentos (Word): Elaboración del informe final


📥 4. Pasos 

Paso 1 – Descarga de la base de datos

El primer paso consistió en descargar la base de datos que se utilizaría para el análisis:

Descargar el archivo de la base de datos en formato SQL (shakila.sql).

Guardar el archivo en una carpeta del ordenador.

Estructura de carpetas:

Escritorio\
	raq\
	   ThePower\
	      Proyecto 2 - SQL - Enunciados y BBDD\
		  BBDD_Proyecto_shakila_sinuser.sql 

Este archivo contiene:

La estructura de las tablas

Las relaciones entre ellas

Los datos insertados en cada tabla


Paso 2 – Conexión a PostgreSQL en DBeaver

Una vez descargada la base de datos, se creó una conexión en DBeaver para poder trabajar con PostgreSQL.

Pasos:

Abrir DBeaver.

Ir al menú:

Base de Datos → Nueva Conexión

Seleccionar PostgreSQL como tipo de base de datos.

Introducir los datos de conexión.

Configuración:

Host: localhost
Port: 5432
Database: postgres
Username: postgres
Password: 

Pulsar Test Connection para comprobar que la conexión funciona correctamente.

Hacer clic en Finish para crear la conexión.


Paso 3 – Cargar la base de datos en DBeaver

Después de crear la conexión, se cargó el archivo SQL para crear todas las tablas y datos.

Pasos realizados:

Hacer clic derecho sobre la 'Bases de Datos' en DBeaver.

Hacer clic en 'Crear Nueva Base de Datos': 

Database name: Proyecto_Shakila
Owner: postgres
Template database: 
Encoding: UTF8
Tablespace: pg_default

Hacer clic derecho en la nueva base de datos 'Proyecto_Shakila'

Hacer clic en 'Editor SQL' y 'Nuevo Script SQL'

Abrir el archivo descargado 'sakila.sql' y copiar y pegar el script en DBeaver

Ejecutar el script completo utilizando 'Ejecutar SQL Script'

Este proceso crea automáticamente:

Todas las tablas

Las relaciones entre tablas

Los registros de datos


Paso 4 – Creación del diagrama de la base de datos

Para comprender mejor la estructura de la base de datos se generó un diagrama entidad-relación (ER Diagram).

Pasos en DBeaver:

Abrir el panel Database Navigator.

Expandir el esquema de la base de datos.

Hacer clic botn derecho en 'Proyecto_shakila', hacer clic en 'Crear', elegir 'Esquema' y nombrarlo.

El diagrama muestra visualmente:

Las tablas de la base de datos

Las claves primarias

Las claves foráneas

Las relaciones entre tablas

Las tablas principales incluyen:

film
actor
film_actor
category
film_category
customer
rental
inventory
payment
store
staff
address
city
country
language


Paso 5 – Exploración de la base de datos

Antes de comenzar el análisis se exploraron las tablas para entender la estructura y los datos disponibles.

Algunas consultas utilizadas fueron:

SELECT * FROM film;
SELECT * FROM actor;
SELECT * FROM customer;

Esta exploración permitió identificar:

Los campos disponibles

Los tipos de datos

Las relaciones entre las tablas


Paso 6 – Creación de consultas SQL

Posteriormente se desarrollaron diferentes consultas SQL para responder a preguntas relacionadas con la base de datos.

Se utilizaron distintos conceptos del lenguaje SQL.

Consultas básicas

Se emplearon cláusulas como:

SELECT

WHERE

ORDER BY

Ejemplo:

SELECT title, length
FROM film
ORDER BY length DESC;

Funciones de agregación

Para realizar cálculos sobre los datos se utilizaron funciones como:

COUNT()

AVG()

SUM()

MIN()

MAX()

Para relacionar la información entre diferentes tablas se utilizaron:

INNER JOIN

LEFT JOIN

CROSS JOIN

También se utilizaron subconsultas para resolver consultas más complejas.

CTE (Common Table Expressions)

En algunos casos se utilizaron CTE para organizar mejor consultas complejas.


📊 5. Análisis de los resultados

Las consultas SQL permitieron obtener información relevante sobre la base de datos, como por ejemplo:

Número total de películas y actores

Duración media de las películas

Categorías más populares

Películas más alquiladas

Clientes más activos

Tendencias temporales de alquiler

Estos resultados fueron interpretados para identificar patrones y comportamientos dentro de los datos.


📝 6. Elaboración del informe final

Finalmente se elaboró un informe de análisis en el que se recopilan y explican los resultados obtenidos mediante las consultas SQL.

El informe incluye:

Análisis de las películas

Análisis de los actores

Análisis de las categorías

Análisis de los alquileres

Análisis de los clientes

Conclusiones finales


-- RESUMEN DEL ANÁLISIS FINAL:

El análisis de la base de datos del videoclub se realizó mediante consultas SQL con el objetivo de explorar la información relacionada con películas, actores, categorías, clientes y alquileres.

La base de datos contiene 1000 películas y 200 actores. La duración de las películas varía entre 46 y 185 minutos, con una duración media aproximada de 115 minutos. La clasificación por edades más común es PG-13, seguida de NC-17 y R.

En cuanto a los actores, todos los registrados han participado al menos en una película. Gina Degeneres es la actriz con mayor número de participaciones (42 películas), seguida de Walter Torn y Mary Keitel.

El análisis por categorías muestra que deportes, extranjeras y familiares son las categorías con mayor número de películas, mientras que deportes, animación y acción se encuentran entre las más alquiladas.

La base de datos registra 16.044 alquileres, con una duración media de 5 días por alquiler. El precio medio de alquiler es de 4,20 dólares. Además, se observa un patrón temporal claro: los meses de verano (julio y agosto de 2005) presentan la mayor actividad de alquiler, mientras que febrero de 2006 registra la menor demanda.

Entre las películas más alquiladas destacan Bucket Brotherhood, Rocketeer Mother y Scalawag Duck. Asimismo, 792 películas han sido alquiladas al menos 10 veces.

En cuanto a los clientes, la base de datos incluye 599 usuarios. Los más activos son Eleanor Hunt y Karl Seal, con 46 y 45 alquileres respectivamente.

En general, el análisis demuestra cómo el uso de consultas SQL permite extraer información valiosa sobre patrones de consumo, popularidad de contenido y comportamiento de los clientes dentro de una base de datos relacional.

