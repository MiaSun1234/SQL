USE Movie;
SELECT Movie.movie_id,Movie.movie_title,Director.director_fn,Director.director_ln
FROM Movie INNER JOIN Director ON Movie.director_id= Director.director_id;

SELECT Movie.movie_id,Movie.movie_title,genre.genre_desc
FROM Movie INNER JOIN genre ON Movie.genre_id= genre.genre_id;

SELECT Movie.movie_id,Movie.movie_title,studio.studio_name
FROM Movie INNER JOIN studio ON Movie.studio_id= studio.studio_ID;

SELECT Movies.movie_id,Movies.movie_title,actor.actor_fn,actor.actor_ln 
FROM Movies INNER JOIN actor ON Movies.lead_male_id= actor.actor_id;

SELECT Movie.movie_id,Movie.movie_title,actor.actor_fn,actor.actor_ln 
FROM Movie INNER JOIN actor ON Movie.lead_fmale_id= actor.actor_id;

SELECT Movie.movie_id,Movie.movie_title,matRating.mat_code 
FROM Movie INNER JOIN matRating ON Movie.mat_code= matRating.mat_code;


SELECT 
Movies.movie_id,
Movies.movie_title,
Director.director_id,
CONCAT(Director.director_fn, ' ', Director.director_ln) AS director_name,
genre.genre_desc,
studio.studio_name,
actor.actor_fn,
actor.actor_ln,
matRating.mat_code
FROM Movies
LEFT JOIN Director ON Movies.director_id= Director.director_id
LEFT JOIN genre ON Movies.genre_id= genre.genre_id
LEFT JOIN studio ON Movies.studio_id= studio.studio_id
LEFT JOIN actor ON Movies.lead_male_id= actor.actor_id
LEFT JOIN actor ON Movies.lead_fmale_id= actor.actor_id
LEFT JOIN matRating ON Movies.mat_code= matRating.mat_code;
GROUP BY 
Movies.movie_id, Director.director_id, genre.genre_id,studio.studio_id, actor.actor_id,matRating.mat_code;
ORDER BY 
Movies.movie_title;

SELECT 
Movies.movie_id,
Movies.movie_title,
CONCAT(Director.director_fn, ' ', Director.director_ln) AS director_name,
CONCAT(mactor.actor_fn, ' ', mactor.actor_Ln) AS mactor_name,
CONCAT(factor.actor_fn, ' ', factor.actor_Ln) AS factor_name,
genre.genre_desc,
studio.studio_name,
matRating.mat_code
FROM Movies
LEFT JOIN Director ON Movies.director_id= Director.director_id
LEFT JOIN actor AS mactor ON Movies.lead_male_id= mactor.actor_id 
LEFT JOIN actor AS factor ON Movies.lead_fmale_id= factor.actor_id
LEFT JOIN genre ON Movies.genre_id= genre.genre_id
LEFT JOIN studio ON Movies.studio_id= studio.studio_id
LEFT JOIN matRating ON Movies.mat_code= matRating.mat_code;



SELECT 
    studio.studio_name,
    COUNT(Movies.movie_id) AS movie_count
FROM Movies 
RIGHT JOIN studio 
ON studio.studio_ID= Movies.studio_id
GROUP BY 
   studio.studio_ID, studio.studio_name
ORDER BY 
    movie_count DESC;


SELECT *
FROM  Director
JOIN (
    SELECT director_id, COUNT(*) as movie_count
    FROM Movies 
    GROUP BY director_id
    HAVING COUNT(*) >= 2
) Movies ON Movies.director_id = Director.director_id;

SELECT director_id, COUNT(*) as movie_count
    FROM Movies 
    GROUP BY director_id
    HAVING COUNT(*) >= 2

SELECT 
    genre.genre_desc AS type,
    NULL AS title,
    COUNT(Movies.movie_id) AS movie_count
FROM genre
LEFT JOIN Movies ON genre.genre_id = Movies.genre_id
GROUP BY 
    genre.genre_id, genre.genre_desc
UNION ALL
SELECT 
    genre.genre_desc AS type,
    Movies.movie_title AS title,
    NULL AS movie_count
FROM 
    genre
JOIN 
    Movies ON genre.genre_id = Movies.genre_id
ORDER BY type, 
    CASE WHEN title IS NULL THEN 0 ELSE 1 END;
    
SELECT 
    movie_id, 
    movie_title, 
    length, 
    rating
FROM 
    Movies;
SELECT 
    movie_id, 
    movie_title, 
    length, 
    rating,
    studio_id
FROM 
    Movies
WHERE 
    Movies.studio_id in (SELECT studio_id FROM studio WHERE not studio_name='Sony Pictures');
    
SELECT 
Movies.movie_id,
Movies.movie_title,
genre.genre_desc
FROM Movies 
LEFT JOIN genre ON Movies.genre_id= genre.genre_id;

SELECT 
*
FROM Movies 
RIGHT JOIN studio ON Movies.studio_id= studio.studio_id;

SELECT 
Movies.movie_id,
Movies.movie_title,
studio.studio_id,
studio.studio_name
FROM Movies 
INNER JOIN studio ON Movies.studio_id= studio.studio_id;

SELECT 
Movies.movie_id,
Movies.movie_title,
studio.studio_id,
studio.studio_name
FROM Movies 
RIGHT JOIN studio ON Movies.studio_id= studio.studio_id
UNION
SELECT 
Movies.movie_id,
Movies.movie_title,
studio.studio_id,
studio.studio_name
FROM Movies 
INNER JOIN studio ON Movies.studio_id= studio.studio_id;

SELECT 
Movies.movie_id,
Movies.movie_title,
Movies.director_id,
Movies.length
FROM Movies 
WHERE length>100
UNION
SELECT 
Movies.movie_id,
Movies.movie_title,
Movies.director_id,
Movies.length
FROM Movies 
WHERE director_id>=3;
