# Spotify Advanced SQL Project
Project Category: Advanced
[Click Here to get Dataset](https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset)

![Spotify Logo](https://github.com/najirh/najirh-Spotify-Data-Analysis-using-SQL/blob/main/spotify_logo.jpg)


This project performs exploratory data analysis (EDA) and insights generation on a Spotify dataset. The SQL queries explore various aspects such as artist popularity, track features, album types, and streaming behavior. Key analysis includes identifying trends, correlations, and outliers in music data, offering valuable insights for music industry professionals, data analysts, and enthusiasts.

```sql
-- create table
DROP TABLE IF EXISTS spotify;
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
```
## Project Steps

1.Data Loading and Cleaning
	Imported the Spotify dataset and performed initial cleaning by removing rows with zero duration.

2.Exploratory Data Analysis (EDA)
	Analyzed basic statistics like total rows, unique artists, albums, and missing values.
	Identified outliers in song features such as tempo and danceability. 
 
3.Descriptive Analysis
	Calculated key statistics for numerical columns (e.g., energy, danceability, tempo).
	Analyzed album type distribution and top/least streamed artists.
 
4.Advanced Queries
	Extracted insights on album types, song popularity, and licensed vs. non-licensed tracks.
	Investigated correlation between song features (energy, views) and performance.
 
5.Feature-Based Analysis
	Performed in-depth analysis of album types, calculating average metrics for views, streams, and track features.
	Analyzed track performance across different platforms (Spotify vs. YouTube).
 
6.Results and Insights
	Generated queries to identify trends, popular artists, and the impact of official videos on song performance.
	Provided actionable insights, including top artists, songs with high energy, and tracks with exceptional danceability.
  
---

## Questions

### Easy Level
1. Retrieve the names of all tracks that have more than 1 billion streams.
2. List all albums along with their respective artists.
3. Get the total number of comments for tracks where `licensed = TRUE`.
4. Find all tracks that belong to the album type `single`.
5. Count the total number of tracks by each artist.

### Medium Level
1. Calculate the average danceability of tracks in each album.
2. Find the top 5 tracks with the highest energy values.
3. List all tracks along with their views and likes where `official_video = TRUE`.
4. For each album, calculate the total views of all associated tracks.
5. Retrieve the track names that have been streamed on Spotify more than YouTube.

### Advanced Level
1. Find the top 3 most-viewed tracks for each artist using window functions.
2. Write a query to find tracks where the liveness score is above the average.
3. **Use a `WITH` clause to calculate the difference between the highest and lowest energy values for tracks in each album.**
14. Is there a correlation between a track’s energy and its popularity (views/streams)?
15. Has the average track length (duration) varied between different album types?
16. Which artist dominates each album type based on the number of streams?
17. Identify tracks that have unusually low or high values for a combination of features.
18. Which tracks perform better on Spotify vs YouTube in terms of views and streams?
19. What percentage of the total streams does each artist contribute to the platform?
20. What is the relationship between the album type (e.g., single, album) and the average number of views and streams?
   






