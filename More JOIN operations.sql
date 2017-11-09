/*1.
List the films where the yr is 1962 [Show id, title]
*/

SELECT id, title
 FROM movie
 WHERE yr=1962;

/*2.
Give year of 'Citizen Kane'.
*/

SELECT yr
FROM movie
WHERE title='Citizen Kane';

/*3.
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
*/

SELECT id,title,yr
FROM movie
WHERE title LIKE 'Star Trek%';

/*4.
What id number does the actor 'Glenn Close' have?
*/

SELECT id
FROM actor
WHERE name = 'Glenn Close';

/*5.
What is the id of the film 'Casablanca'
*/

SELECT id
FROM movie
WHERE title = 'Casablanca';

/*6.
Obtain the cast list for 'Casablanca'.

what is a cast list?
Use movieid=11768, (or whatever value you got from the previous question)
*/

SELECT name
FROM actor JOIN casting ON (id = actorid)
WHERE movieid = 11768;

/*7.
Obtain the cast list for the film 'Alien'
*/

SELECT name
FROM actor JOIN casting ON (actorid = id) JOIN movie ON (movieid = movie.id)
WHERE title = 'Alien';

/*8.
List the films in which 'Harrison Ford' has appeared
*/

SELECT title AS Films 
FROM movie JOIN casting ON (casting.movieid = movie.id) JOIN actor ON (actor.id = casting.actorid)
WHERE name = 'Harrison Ford'; 

/*9.
List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/

SELECT title AS Films 
FROM movie JOIN casting ON (casting.movieid = movie.id) JOIN actor ON (actor.id = casting.actorid)
WHERE name = 'Harrison Ford' AND ord <> 1;

/*10.
List the films together with the leading star for all 1962 films.
*/

SELECT title AS Films , name
FROM movie JOIN casting ON (casting.movieid = movie.id) JOIN actor ON (actor.id = casting.actorid)
WHERE ord = 1 AND yr = 1962;

/*11.
Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 where name='John Travolta'
 GROUP BY yr) AS t);

/*12.
List the film title and the leading actor for all of the films 'Julie Andrews' played in.

Did you get "Little Miss Marker twice"?
*/
SELECT title,name
FROM movie JOIN casting ON (movieid = movie.id
                                      AND ord = 1)
           JOIN actor ON (actorid = actor.id)
WHERE movie.id IN (SELECT movieid FROM casting
                    WHERE actorid IN (
                        SELECT id FROM actor
                             WHERE name='Julie Andrews'));

/*13.
Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
*/

SELECT actor.name
FROM actor
JOIN casting
ON casting.actorid = actor.id
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(*) >= 30;

