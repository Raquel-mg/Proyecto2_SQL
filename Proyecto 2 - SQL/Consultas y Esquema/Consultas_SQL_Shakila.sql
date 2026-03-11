-- DataProject: LógicaConsultasSQL

-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’
SELECT "title", "rating"
FROM "film"
WHERE rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40
SELECT 
    concat(a."first_name", ' ', a."last_name") AS nombre_actores,
    a."actor_id"
FROM "actor" AS a
WHERE a."actor_id" BETWEEN 30 AND 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original
SELECT f."title", l."name" AS language_name
FROM "film" as f
INNER JOIN "language" as l 
	ON f."language_id" = l."language_id"
WHERE f."language_id" = f."original_language_id";

-- 5. Ordena las películas por duración de forma ascendente
SELECT "title", "length"
FROM "film"
ORDER BY "length" ASC;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido
SELECT CONCAT(first_name, ' ', last_name) AS "Nombre_completo_actor"
FROM "actor" AS a
WHERE last_name ILIKE '%Allen%';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento
SELECT 
	"rating",
	COUNT("rating")
FROM "film"
GROUP BY "rating";

-- 8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film
SELECT "title", "rating", "length"
FROM "film"
WHERE "rating" = 'PG-13' OR "length" > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas
SELECT VARIANCE("replacement_cost") AS "Variabilidad_reemplazo"
FROM "film";

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD
SELECT 
	MIN("length") AS "Menor_duracion",
	MAX("length") AS "Mayor_duracion"
FROM "film";

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día
SELECT 
	p."amount", 
	r."rental_date"
FROM "payment" AS p
INNER JOIN "rental" AS r 
  ON p."rental_id" = r."rental_id"
WHERE "amount" <> 0
ORDER BY r."rental_date" DESC
LIMIT 1 OFFSET 2;

-- 12.  Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.
SELECT "title", "rating"
FROM "film"
WHERE "rating" NOT IN ('NC-17','G');

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración
SELECT 
	AVG("length") AS Promedio_duracion,
	"rating" AS Clasificacion
FROM "film"
GROUP BY "rating";

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos
SELECT "title", "length"
FROM "film"
WHERE "length" > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
SELECT SUM("amount")
FROM "payment";

-- 16. Muestra los 10 clientes con mayor valor de id
SELECT 
	CONCAT("first_name", ' ', "last_name") AS nombre_cliente, 
	"customer_id"
FROM "customer"
ORDER BY "customer_id" DESC
LIMIT 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
SELECT first_name, last_name 
FROM actor 
WHERE actor_id IN (
	SELECT actor_id 
	FROM film_actor 
	WHERE film_id = ( 
		SELECT film_id 
		FROM film 
		WHERE title ILIKE '%Egg Igby%'
	) 
);

-- 18. Selecciona todos los nombres de las películas únicos
SELECT DISTINCT title 
FROM film;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ
SELECT f."title", f."length"
FROM "film" AS f
INNER JOIN "film_category" AS fc
ON f."film_id" = fc."film_id"
WHERE fc."category_id" = 5 AND f."length" > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración
SELECT 
	c.name AS nombre_categoria, 
	ROUND(AVG(f.length),2) AS duracion_promedio
FROM category AS c 
INNER JOIN film_category AS fc 
	ON c.category_id = fc.category_id 
INNER JOIN film AS f 
	ON fc.film_id = f.film_id 
GROUP BY c.name 
HAVING AVG(f.length) > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG("rental_duration")
FROM "film";

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT 
	CONCAT("first_name", ' ', "last_name") nombre_completo
FROM "actor";

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
SELECT 
    DATE(rental_date) AS dia,
    COUNT(*) AS total_alquileres
FROM rental
GROUP BY DATE(rental_date)
ORDER BY total_alquileres DESC;

-- 24. Encuentra las películas con una duración superior al promedio.
SELECT "title", "length"
FROM "film"
WHERE "length" > (
	SELECT AVG("length")
	FROM "film");

-- 25. Averigua el número de alquileres registrados por mes
SELECT
  to_char(date_trunc('month', rental_date), 'YYYY-MM') AS mes_label,
  COUNT(*) AS total
FROM rental
GROUP BY 1
ORDER BY 1;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
SELECT
	ROUND(AVG("amount"),2) AS promedio_total_pagado,
	ROUND(VARIANCE("amount"),2) AS varianza_total_pagado,
	ROUND(STDDEV("amount"),2) AS desv_total_pagado
FROM "payment";

-- 27. ¿Qué películas se alquilan por encima del precio medio?
SELECT DISTINCT f.title
FROM film f
INNER JOIN inventory i 
	ON f.film_id = i.film_id
INNER JOIN rental r 
	ON i.inventory_id = r.inventory_id
INNER JOIN payment p 
	ON r.rental_id = p.rental_id
WHERE p.amount > (
    SELECT AVG(amount) 
    FROM "payment");

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT 
	"actor_id",
	COUNT("film_id") AS total_peliculas
FROM "film_actor"
GROUP BY "actor_id"
HAVING COUNT("film_id") > 40
ORDER BY total_peliculas DESC;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible
SELECT 
    f.film_id,
    f.title,
    COUNT(i.inventory_id) AS cantidad_disponible
FROM film f
INNER JOIN inventory i 
    ON f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY f.title;

-- 30. Obtener los actores y el número de películas en las que ha actuado
SELECT
	a."actor_id",
	CONCAT(a."first_name", ' ', a."last_name") AS nombre_actor,
	COUNT(fa."film_id") AS numero_peliculas
FROM "actor" AS a
INNER JOIN "film_actor" AS fa
	ON a."actor_id" = fa."actor_id"
GROUP BY a."actor_id"
ORDER BY numero_peliculas DESC;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados
SELECT 
    f."film_id",
    f."title",
    (SELECT STRING_AGG(a."first_name" || ' ' || a."last_name", ', ')
        FROM "film_actor" fa
        JOIN "actor" a 
            ON fa."actor_id" = a."actor_id"
        WHERE fa."film_id" = f."film_id") AS "actores"
FROM "film" f
ORDER BY f."title";

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película
SELECT 
    a."actor_id",
    CONCAT(a."first_name", ' ' ,a."last_name") nombre_actores,
    (SELECT STRING_AGG(f."title", ', ')
        FROM "film" f
        JOIN "film_actor" fa 
            ON f."film_id" = fa."film_id"
        WHERE a."actor_id" = fa."actor_id") AS peliculas
FROM "actor" AS a
ORDER BY a."actor_id";

-- 33.Obtener todas las películas que tenemos y todos los registros de alquiler
SELECT 
	f."film_id", 
	f."title", 
	(SELECT COUNT(*) 
	FROM "inventory" AS i 
	JOIN "rental" AS r 
		ON r."inventory_id" = i."inventory_id" 
	WHERE i."film_id" = f."film_id") AS total_alquileres 
FROM "film" AS f 
ORDER BY total_alquileres DESC;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros
SELECT 
	c."customer_id",
	CONCAT(c."first_name", ' ',c."last_name") AS nombre_cliente,
	SUM(p."amount") AS total_gastado
FROM "customer" AS c
INNER JOIN "payment" AS p
	ON c."customer_id" = p."customer_id"
GROUP BY c."customer_id"
ORDER BY total_gastado DESC
LIMIT 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'
SELECT "actor_id", "first_name", "last_name"
FROM "actor"
WHERE "first_name" ILIKE '%Johnny%';

-- 36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido
SELECT 
    "first_name" AS Nombre,
    "last_name" AS Apellido
FROM "actor";

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT 
	MIN("actor_id"),
	MAX("actor_id")
FROM "actor";

-- 38. Cuenta cuántos actores hay en la tabla “actorˮ
SELECT COUNT("actor_id")
FROM "actor";

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente
SELECT "first_name", "last_name"
FROM "actor"
ORDER BY "last_name" ASC;

-- 40. Selecciona las primeras 5 películas de la tabla “filmˮ.
SELECT "title"
FROM "film"
LIMIT 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
	-- El nombre más repetido es Kenneth:
SELECT 
	"first_name",
	COUNT("first_name") repeticiones_nombre
FROM "actor"
GROUP BY "first_name"
ORDER BY repeticiones_nombre DESC;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron
SELECT 
    r."rental_id",
    r."rental_date",
    CONCAT(c."first_name", ' ',c."last_name") AS nombre_cliente
FROM "rental" AS r
INNER JOIN "customer" AS c
    ON r."customer_id" = c."customer_id"
ORDER BY r."rental_date";

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres
SELECT 
    c."customer_id",
    CONCAT(c."first_name", ' ',c."last_name") AS nombre_cliente,
    COUNT(r.rental_id) AS total_alquileres
FROM "customer" AS c
LEFT JOIN "rental" AS r
    ON c."customer_id" = r."customer_id"
GROUP BY c.customer_id
ORDER BY total_alquileres DESC;

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
SELECT 
    f."film_id",
    f."title",
    c."category_id",
    c."name" AS category_name
FROM "film" as f
CROSS JOIN "category" AS c;

	-- No aporta mucho valor en este caso. Un CROSS JOIN genera el producto cartesiano entre ambas tablas y por lo tanto combina cada película con cada categoría. 
	-- Si hay 1.000 películas y 16 categorías, el resultado de la consulta tendrá 16.000 filas. 
	-- Esto no refleja relaciones reales entre películas y categorías, porque en este esquema la relación correcta se encuentra en la tabla film_category. Por tanto:
	-- Produce muchas combinaciones artificiales, genera resultados poco útiles y una consulta más pesada.

-- 45.  Encuentra los actores que han participado en películas de la categoría 'Action'.
SELECT CONCAT(a."first_name", ' ', a."last_name") AS nombre_actores, fc."category_id"
FROM "actor" AS a
INNER JOIN "film_actor" AS  fa 
	ON a."actor_id" = fa."actor_id"
INNER JOIN "film" AS f 
	ON fa."film_id" = f."film_id"
INNER JOIN "film_category" AS fc
	ON f."film_id" = fc."film_id"
WHERE fc."category_id" = 1; -- Pongo category_id igual a 1 porque el id 1 equivale a la categoría 'Action'.

-- 46.  Encuentra todos los actores que no han participado en películas
select "first_name", "last_name"
from "actor"
where not exists (
	select 1
	from "film_actor"
	where "actor"."actor_id" = "film_actor"."actor_id");

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
SELECT 
    CONCAT(a."first_name", ' ', a."last_name") AS nombre_actores,
    COUNT(fa."film_id") AS total_peliculas
FROM "actor" AS a
INNER JOIN "film_actor" AS fa
    ON a."actor_id" = fa."actor_id"
GROUP BY a."actor_id", a."first_name", a."last_name"
ORDER BY total_peliculas DESC;

-- 48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.
CREATE VIEW actor_num_peliculas AS
SELECT 
    CONCAT(a."first_name", ' ', a."last_name") AS nombre_actores,
    COUNT(fa."film_id") AS total_peliculas
FROM "actor" AS a
INNER JOIN "film_actor" AS fa
    ON a."actor_id" = fa."actor_id"
GROUP BY a."actor_id", a."first_name", a."last_name"
ORDER BY total_peliculas DESC;

SELECT*
FROM actor_num_peliculas anp;

-- 49. Calcula el número total de alquileres realizados por cada cliente.
SELECT 
	CONCAT(c."first_name", ' ', c."last_name") AS nombre_clientes,
    COUNT(r."rental_id") AS total_alquileres
FROM "rental" AS r
INNER JOIN "customer" AS c
	ON r."customer_id" = c."customer_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
ORDER BY total_alquileres DESC;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
SELECT 
	SUM(f."length")
FROM "film" AS f
INNER JOIN "film_category" AS fc
	ON f."film_id" = fc."film_id"
WHERE fc."category_id" = 1;

SELECT 
	f."title",
	f."length"
FROM "film" AS f
INNER JOIN "film_category" AS fc
	ON f."film_id" = fc."film_id"
WHERE fc."category_id" = 1
ORDER BY "length" DESC;

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.
WITH cliente_rentas_temporal AS (
    SELECT 
    	r."customer_id", 
    	CONCAT(c."first_name", ' ', c."last_name") AS nombre_cliente, 
    	COUNT(r."rental_id") AS alquiler_cliente
    FROM "rental" AS r
    INNER JOIN "customer" AS c
    	ON r."customer_id" = c."customer_id"
    GROUP BY r."customer_id", c."first_name", c."last_name")
SELECT "customer_id", nombre_cliente, alquiler_cliente
FROM cliente_rentas_temporal;

-- 52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
WITH peliculas_alquiladas AS (
	SELECT 
        i."film_id",
        f."title",
        COUNT(r."rental_id") AS total_alquileres
    FROM "rental" AS r
    INNER JOIN "inventory" AS i 
        ON r."inventory_id" = i."inventory_id"
    INNER JOIN "film" AS f
    	ON i."film_id" = f."film_id"
    GROUP BY i."film_id",f."title")
SELECT "film_id", "title", total_alquileres
FROM peliculas_alquiladas
WHERE total_alquileres >= 10;

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
SELECT f."title"
FROM "film" AS f
INNER JOIN "inventory" AS i
	ON f."film_id" = i."film_id"
INNER JOIN "rental" AS r
	ON i."inventory_id" = r."inventory_id"
INNER JOIN "customer" AS c
	ON r."customer_id" = c."customer_id"
WHERE c.first_name ILIKE '%Tammy%'AND c.last_name ILIKE '%Sanders%' AND r.return_date IS NULL
ORDER BY f."title" ASC;

-- 54.  Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.
SELECT DISTINCT
    a."first_name",
    a."last_name"
FROM "actor" AS a
JOIN "film_actor" AS fa
    ON a."actor_id" = fa."actor_id"
JOIN "film_category" AS fc
    ON fa."film_id" = fc."film_id"
JOIN "category" AS c
    ON fc."category_id" = c."category_id"
WHERE c."name" = 'Sci-Fi'
ORDER BY a."last_name" ASC;

-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
SELECT DISTINCT
    a.first_name,
    a.last_name
FROM "actor" AS a
JOIN "film_actor" AS fa
    ON a."actor_id" = fa."actor_id"
JOIN "film" AS f
    ON fa."film_id" = f."film_id"
JOIN "inventory" AS i
    ON f."film_id" = i."film_id"
JOIN "rental" AS r
    ON i."inventory_id" = r."inventory_id"
WHERE r."rental_date" > (
    SELECT MIN(r2.rental_date)
    FROM "rental" AS r2
    JOIN "inventory" AS i2
        ON r2."inventory_id" = i2."inventory_id"
    JOIN "film" AS f2
        ON i2."film_id" = f2."film_id"
    WHERE f2."title" ILIKE '%Spartacus Cheaper%'
)
ORDER BY a.last_name;

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
SELECT 
    a."first_name",
    a."last_name"
FROM "actor" a
WHERE NOT EXISTS (
    SELECT 1
    FROM "film_actor" fa
    INNER JOIN "film_category" fc
        ON fa."film_id" = fc."film_id"
    INNER JOIN "category" c
        ON fc."category_id" = c."category_id"
    WHERE fa."actor_id" = a."actor_id"
      AND c."name" = 'Music');

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
SELECT DISTINCT
    f."title"
FROM "film" AS f
JOIN "inventory" AS i
    ON f."film_id" = i."film_id"
JOIN "rental" AS r
    ON i."inventory_id" = r."inventory_id"
WHERE (r."return_date" - r."rental_date") > INTERVAL '8 days' AND r.return_date IS NOT NULL;

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.
SELECT f."title"
FROM "film" AS f
INNER JOIN "film_category" AS  fc 
	ON f."film_id" = fc."film_id"
WHERE fc."category_id" = 2;

-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.
SELECT "title"
FROM "film"
WHERE "length" = (
    SELECT "length"
    FROM "film"
    WHERE "title" ILIKE '%Dancing Fever%')
ORDER BY "title";

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
SELECT 
    CONCAT(c."first_name", ' ' , c."last_name") AS nombre_clientes
FROM "customer" AS c
JOIN "rental" AS r
    ON c."customer_id" = r."customer_id"
JOIN "inventory" AS i
    ON r."inventory_id" = i."inventory_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
HAVING COUNT(DISTINCT i."film_id") >= 20
ORDER BY c."last_name";

-- 61.  Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT 
    c."name" AS "categoria",
    COUNT(*) AS total_alquileres
FROM "rental" r
JOIN "inventory" i 
    ON r."inventory_id" = i."inventory_id"
JOIN "film_category" fc 
    ON i."film_id" = fc."film_id"
JOIN "category" c 
    ON fc."category_id" = c."category_id"
GROUP BY c."name"
ORDER BY "total_alquileres" DESC;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
SELECT 
    c."name" AS "categoria",
    COUNT(f."film_id") AS "total_peliculas"
FROM "category" AS c
JOIN "film_category" AS fc
    ON c."category_id" = fc."category_id"
JOIN "film" AS f
    ON fc."film_id" = f."film_id"
WHERE f."release_year" = 2006
GROUP BY c."name"
ORDER BY "total_peliculas" DESC;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
SELECT 
    s."first_name",
    s."last_name",
    st."store_id"
FROM "staff" as s
CROSS JOIN "store" AS st;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT 
    c."customer_id",
    c."first_name",
    c."last_name",
    COUNT(r."rental_id") AS "total_peliculas_alquiladas"
FROM "customer" AS c
JOIN "rental" AS r
    ON c."customer_id" = r."customer_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
ORDER BY total_peliculas_alquiladas DESC;
