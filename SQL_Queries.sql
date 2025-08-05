-- SQL Queries
-- 1. Give drama movies/series available on Netflix
SELECT mv.primaryTitle, mg.genre, mv.Where_to_Watch 
FROM movie as mv
Natural join movie_genre as mg
WHERE mg.genre = 'Drama' AND mv.Where_to_Watch = 'Netflix'
UNION
SELECT s.primaryTitle, sg.genre, s.Where_to_Watch
FROM series s 
NATURAL JOIN series_genre as sg
WHERE sg.genre = 'Drama' AND 
s.Where_to_Watch = 'Netflix';
	

-- 2. Directors who directed series of genre crime
SELECT d.primaryName, d.directorid, sg.genre FROM director as d
JOIN series_director_relation as sdr ON d.directorID = sdr.directorID
JOIN series as s ON sdr.seriesID = s.seriesID
JOIN series_genre as sg ON s.seriesID = sg.seriesID
WHERE sg.Genre = 'Crime'
GROUP BY d.primaryName, d.directorid, sg.genre;
	

-- 3. Give series with at least 5 seasons with average rating of at least 9
SELECT s.seriesid, s.primarytitle, s.averageRating, s.no_of_seasons From series as s
Where s.no_of_seasons >= 5 AND s.averagerating >= 9.0;

-- 4. Give top 10 rated movies with their director. 
SELECT mv.movieid, mv.primaryTitle, d.primaryName
FROM movie as mv
JOIN movie_director_relation as mdr ON mv.movieID = mdr.movieID
JOIN director as d ON mdr.directorID = d.directorID
ORDER BY mv.averageRating DESC
LIMIT 10;

-- 5. Give count of awards won by all movies
SELECT mv.movieid, mv.primarytitle, count(mar.awardid) as No_of_Award_Won FROM movie as mv
Left JOIN movie_award_relation as mar On mv.movieid = mar.movieid
Group by mv.movieid, mv.primarytitle
ORDER BY No_of_Award_Won DESC;

-- 6. Give top series character names
SELECT s.seriesid, s.primarytitle, sar.characterplayed
FROM series as s
JOIN series_actor_relation as sar ON s.seriesID = sar.seriesID  
JOIN actor as act ON sar.actorid = act.actorID
WHERE s.seriesID IN (
         SELECT seriesID
         FROM series
         ORDER BY averageRating DESC
         LIMIT 5)
ORDER BY s.averageRating DESC;

-- 7. Give the list the series and the episodes that are released after 2010
SELECT s.seriesid, s.primaryTitle, e.episodeid, e.primaryTitle, e.ReleaseDate
FROM series as s
JOIN episode as e ON s.seriesID = e.seriesID
WHERE e.ReleaseDate > '2010-01-01'
ORDER BY e.ReleaseDate DESC;

-- 8. Give region wise highest grossing movies
SELECT m.Region, m.primaryTitle, m.Revenue
FROM movie m
INNER JOIN (
           SELECT Region, MAX(Revenue) AS max_revenue
           FROM movie
           WHERE Revenue IS NOT NULL
           GROUP BY Region
) t ON m.Region = t.Region AND m.Revenue = t.max_revenue
ORDER BY m.Revenue DESC;

-- 9. Give the genre with highest average rating from movies/series
(SELECT 'Movie' AS type, mg.Genre, MAX(mv.averageRating) AS avg_rating
FROM movie as mv
INNER JOIN movie_genre as mg ON mv.movieID = mg.movieID
GROUP BY mg.Genre
ORDER BY avg_rating DESC
LIMIT 1)
UNION ALL
(SELECT 'Series' AS type, sg.Genre, MAX(s.averageRating) AS avg_rating
FROM series as s
INNER JOIN series_genre as sg ON s.seriesID = sg.seriesID
GROUP BY sg.Genre
ORDER BY avg_rating DESC
LIMIT 1);

-- 10. Give the list of actors who have not won any awards
SELECT a.actorID, a.primaryName
FROM actor a
EXCEPT
SELECT a.actorID, a.primaryName
FROM actor a
JOIN actor_award_relation aar ON a.actorID = aar.actorID;

-- 11. Give the genre with highest number of movies and series
SELECT Genre, COUNT(*) AS total_titles
FROM (
 SELECT Genre FROM movie_genre
 UNION ALL
 SELECT Genre FROM series_genre
) AS combined_genres
GROUP BY Genre
ORDER BY total_titles DESC
LIMIT 1;

-- 12. Give the writer who have written movies with highest revenue
SELECT w.writerID, w.primaryName, SUM(m.Revenue) AS total_revenue
FROM writer w
LEFT JOIN movie_writer_relation mwr ON w.writerID = mwr.writerID
LEFT JOIN movie m ON mwr.movieID = m.movieID
WHERE m.Revenue IS NOT NULL
GROUP BY w.writerID, w.primaryName
ORDER BY total_revenue DESC
LIMIT 1;

-- 13. Give series-wise top episode for all the series
SELECT s.primaryTitle, s.originalTitle, e.seasonNumber, e.episodeNumber, e.primaryTitle, e.averageRating
FROM series s
INNER JOIN episode e ON s.seriesID = e.seriesID
INNER JOIN (
 SELECT seriesID, MAX(averageRating) AS max_rating
 FROM episode
 GROUP BY seriesID
) t ON e.seriesID = t.seriesID AND e.averageRating = t.max_rating
ORDER BY s.primaryTitle, e.seasonNumber, e.episodeNumber;

-- 14. give highest rated series language wise
SELECT s1.series_language, s1.averageRating AS highest_rating, s1.primaryTitle AS series_title, s1.seriesid
FROM series s1
INNER JOIN (
 SELECT series_language, MAX(averageRating) AS max_rating
 FROM series
 GROUP BY series_language
) s2
ON s1.series_language = s2.series_language AND s1.averageRating = s2.max_rating
ORDER BY highest_rating DESC;

-- 15. give famous movies written by writer of highest rated movie
Select w.primaryname as Writer_Name, wk.knownfortitles as Famous_Movies From writer_known_for_titles as wk
Natural Join writer as w
Natural Join movie_writer_relation as mwr
Natural Join movie as mv
Inner Join(Select movieid, averageRating From movie
                  Group by movieid, averageRating
                   Order by averagerating DESC LIMIT 1
                  ) t on mv.movieid = t.movieid and mv.averageRating = t.averageRating;
	
-- 16. give famous movies of most award winning actors
SELECT distinct a.primaryname as Actor_Name, ak.knownfortitles as Famous_movies
From actor_known_for_titles as ak
Natural Join actor a
Natural Join actor_award_relation aar
Inner Join (SELECT actorid, Count(awardID) as No_of_Awards_Won From actor_award_relation
                   Group by actorid
                   Order by No_of_Awards_Won DESC LIMIT 1
                   )t On aar.actorid = t.actorid;
	
-- 17. ⁠give famous series of directors who directed series in spanish
SELECT distinct d.primaryname as Director_Name, dk.knownfortitles as Famous_series
From director_known_for_titles as dk
Natural Join director d
Natural Join series_director_relation sdr
Natural Join series s
Where s.series_language = 'Spanish';