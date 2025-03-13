--------------------------------------------------
-- Importing the dataset
--------------------------------------------------
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- Don't forget to import the dataset after creating the table and please change the escape sign from single quote (') to double quote (") while importing.

--------------------------------------------------
-- EDA
--------------------------------------------------

-- Total number of rows in the dataset to understand its size
SELECT COUNT(*) FROM spotify;

-- Count of unique artists in the dataset
SELECT COUNT(DISTINCT(artist)) FROM spotify;

-- Count of unique albums in the dataset
SELECT COUNT(DISTINCT(album)) FROM spotify;

-- List of all distinct album types
SELECT DISTINCT(album_type) FROM spotify;

-- Max and min song duration in minutes
SELECT MAX(duration_min), MIN(duration_min) FROM spotify;

-- Identifying potential wrong entries where duration is 0
SELECT * FROM spotify WHERE duration_min = 0;

-- Count of unique channels used for streaming
SELECT COUNT(DISTINCT(channel)) FROM spotify;

-- Counting missing values in key columns: artist, track, and album
SELECT 
    COUNT(*) - COUNT(artist) AS missing_artist, 
    COUNT(*) - COUNT(track) AS missing_track,
    COUNT(*) - COUNT(album) AS missing_album
FROM spotify;

-- Deleting wrong entries (duration = 0) from the dataset
DELETE FROM spotify WHERE duration_min = 0;

-- Re-checking the total count after deletion
SELECT COUNT(*) FROM spotify;

-- Calculate min, max, average, and standard deviation for numerical columns like energy, danceability, and tempo
SELECT 
    MIN(energy), MAX(energy), AVG(energy), STDDEV(energy)
FROM spotify;

SELECT 
    MIN(danceability), MAX(danceability), AVG(danceability), STDDEV(danceability)
FROM spotify;

SELECT 
    MIN(tempo), MAX(tempo), AVG(tempo), STDDEV(tempo)
FROM spotify;

-- Distribution of album types (Count of songs per album type)
SELECT album_type, COUNT(*) 
FROM spotify 
GROUP BY album_type;

-- Identifying outliers (songs with extremely high tempo)
SELECT * 
FROM spotify 
WHERE tempo > (SELECT AVG(tempo) + 3 * STDDEV(tempo) FROM spotify);

-- Average danceability for each album type
SELECT album_type, AVG(danceability) AS avg_danceability
FROM spotify 
GROUP BY album_type;

-- Top 10 most streamed artists
SELECT artist, SUM(stream) AS total_streams
FROM spotify 
GROUP BY artist 
ORDER BY total_streams DESC
LIMIT 10;

-- Top 10 least streamed artists
SELECT artist, SUM(stream) AS total_streams
FROM spotify 
GROUP BY artist 
ORDER BY total_streams ASC
LIMIT 10;

-- Comparing licensed vs non-licensed songs based on average views and streams
SELECT licensed, AVG(views) AS avg_views, AVG(stream) AS avg_streams 
FROM spotify 
GROUP BY licensed;

-- Impact of official videos on views and streams
SELECT official_video, AVG(views) AS avg_views, AVG(stream) AS avg_streams
FROM spotify 
GROUP BY official_video;

-- Top 10 songs by total streams
SELECT track, artist, stream 
FROM spotify 
ORDER BY stream DESC 
LIMIT 10;

-- Most popular album types based on total streams
SELECT album_type, SUM(stream) AS total_streams
FROM spotify
GROUP BY album_type 
ORDER BY total_streams DESC;

--------------------------------------------------
-- Questions
--------------------------------------------------

-- Q1. Retrieve the names of all tracks that have more than 1 billion streams
SELECT COUNT(*) FROM spotify WHERE stream > 1000000000;

-- Q2. List all albums along with their respective artists
SELECT DISTINCT album, artist FROM spotify;

-- Q3. Get the total number of comments for tracks where licensed = TRUE
SELECT SUM(comments) 
FROM spotify 
WHERE licensed = 'true';

-- Q4. Find all tracks that belong to the album type 'single'
SELECT *
FROM spotify 
WHERE album_type = 'single';

-- Q5. Count the total number of tracks by each artist
SELECT artist, 
       COUNT(track) AS total_no_of_songs 
FROM spotify 
GROUP BY artist 
ORDER BY total_no_of_songs DESC;

-- Q6. Calculate the average danceability of tracks in each album type
SELECT album_type, AVG(danceability) AS danceability
FROM spotify
GROUP BY album_type
ORDER BY AVG(danceability) DESC;

-- Q7. Find the top 5 tracks with the highest energy values
SELECT track, energy 
FROM spotify 
ORDER BY energy DESC 
LIMIT 5;

-- Q8. List all tracks along with their views and likes where official_video = TRUE
SELECT track, views, likes 
FROM spotify 
WHERE official_video = 'true';

-- Q9. For each album, calculate the total views of all associated tracks
SELECT album, SUM(views) AS total_views
FROM spotify 
GROUP BY album 
ORDER BY SUM(views) DESC;

-- Q10. Retrieve the track names that have been streamed more on Spotify than YouTube
SELECT track FROM spotify 
WHERE most_played_on = 'Spotify';

-- Q11. Find the top 3 most-viewed tracks for each artist using window functions
WITH cte AS (
    SELECT artist, track, views, ROW_NUMBER() 
    OVER (PARTITION BY artist ORDER BY views DESC) AS rn 
    FROM spotify 
)
SELECT artist, track, views FROM cte WHERE rn <= 3;

-- Q12. Write a query to find tracks where the liveness score is above the average
SELECT track FROM spotify 
WHERE liveness > (SELECT AVG(liveness) FROM spotify);

-- Q13. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album
WITH energy_stats AS (
    SELECT album, 
           MAX(energy) AS max_energy, 
           MIN(energy) AS min_energy,
           COUNT(track) AS track_count
    FROM spotify
    GROUP BY album
)
SELECT album, 
       max_energy, 
       track_count,
       min_energy, 
       (max_energy - min_energy) AS energy_difference
FROM energy_stats;

-- Q14. Is there a correlation between a track’s energy and its popularity (views/streams)?
SELECT CORR(energy, views) AS energy_views_corr, CORR(energy, stream) AS energy_stream_corr
FROM spotify;

-- Q15. Has the average track length (duration) varied between different album types?
SELECT album_type, AVG(duration_min) AS avg_track_length
FROM spotify
GROUP BY album_type
ORDER BY avg_track_length DESC;

-- Q16. Which artist dominates each album type based on the number of streams?
WITH cte AS ( 
    SELECT album_type, 
           artist, 
           SUM(stream) AS total_streams, 
           ROW_NUMBER() OVER (PARTITION BY album_type ORDER BY SUM(stream) DESC) AS rn
    FROM spotify
    GROUP BY album_type, artist
)
SELECT album_type, artist, total_streams 
FROM cte
WHERE rn = 1;

-- Q17. Identify tracks that have unusually low or high values for a combination of features
SELECT track, danceability, energy, tempo
FROM spotify
WHERE danceability > 0.8 AND energy < 0.3;

-- Q18. Which tracks perform better on Spotify vs YouTube in terms of views and streams?
SELECT track, views, stream, most_played_on
FROM spotify
WHERE views > stream OR stream > views;

-- Q19. What percentage of the total streams does each artist contribute to the platform?
SELECT artist, 
       SUM(stream) * 100.0 / (SELECT SUM(stream) FROM spotify) AS percentage_contribution
FROM spotify
GROUP BY artist
ORDER BY percentage_contribution DESC;

-- Q20. What is the relationship between the album type (e.g., single, album) and the average number of views and streams?
SELECT album_type, 
       AVG(views) AS avg_views, 
       AVG(stream) AS avg_streams
FROM spotify
GROUP BY album_type
ORDER BY avg_streams DESC;
