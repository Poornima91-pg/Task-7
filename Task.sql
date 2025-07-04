-- Creating New Database.
CREATE DATABASE IMDB;

-- Using created Database
USE IMDB;

-- Movie Table - Displays movie name,year and language

CREATE TABLE Movie (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(255),
    release_year INT,
    movie_language VARCHAR(30)
    );

INSERT INTO Movie (movie_name,release_year,movie_language) VALUES ('Amaran',2024,'Tamil'),('Mufasa:The lion king',2024,'English'),
('Tourist Family',2025,'Tamil'),('Moana 2',2024,'English');

-- Displaying table contents
select * from Movie;

-- Media Table - Displays media type and URl

CREATE TABLE Media (
    media_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    media_type ENUM('Video', 'Image'),
    url VARCHAR(500),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);

INSERT INTO Media (movie_id,media_type,url) VALUES (1,'Video','https://www.youtube.com/watch?v=hylIXfZeB4c'),
(1,'Image','https://en.wikipedia.org/wiki/Amaran_(2024_film)#/media/File:Amaran_2024_poster.jpg'),
(2,'Video','https://www.youtube.com/watch?v=o17MF9vnabg'),
(2,'Image','https://en.wikipedia.org/wiki/Mufasa:_The_Lion_King#/media/File:Mufasa_The_Lion_King_Movie_2024.jpeg'),
(3,'Video','https://www.hotstar.com/in/movies/tourist-family/1271421093'),
(3,'Image','http://en.wikipedia.org/wiki/Tourist_Family#/media/File:Tourist_Family.jpg'),
(4,'Video','https://www.hotstar.com/in/movies/moana-2/1271337439'),
(4,'Image','https://en.wikipedia.org/wiki/Moana_2#/media/File:Moana_2_poster.jpg');

-- Displaying table contents

select * from Media;


-- 1st - Movie should have multiple media (By joining Movie & Media Table)

SELECT M.movie_name, ME.media_type, ME.url
FROM Movie M
JOIN Media ME ON M.movie_id = ME.movie_id;

-- Genre Table - Contains different Genre

CREATE TABLE Genre (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(100) UNIQUE
);

INSERT INTO Genre (genre_name) VALUES ('Action'),('Biographical'),('War'),('Amination'),('Comedy'),('Drama'),('Adventure'),('Kids');

-- Displaying table contents

select * from Genre;

-- Movie Genre Table to link Movie name with multiple Genre

CREATE TABLE Movie_Genre (
    movie_id INT,
    genre_id INT,
    -- PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
    );

INSERT INTO Movie_Genre VALUES (1,1),(1,2),(1,3),(2,1),(2,8),(3,5),(3,6),(4,4),(4,7),(4,8);

-- Displaying table contents

select * from Movie_Genre;

-- 2nd -movie name with multiple genre (By Joining Movie table,Movie_genre Table and genre table to display movie name with multiple genre)

SELECT M.movie_name,G.genre_name
FROM Movie M
JOIN Movie_Genre MG ON M.movie_id = MG.movie_id
JOIN Genre G ON MG.genre_id = G.genre_id;

SELECT 
    M.movie_name,
    GROUP_CONCAT(G.genre_name) AS genres
FROM Movie M
JOIN Movie_Genre MG ON M.movie_id = MG.movie_id
JOIN Genre G ON MG.genre_id = G.genre_id
GROUP BY M.movie_name
ORDER BY M.movie_name;



-- User Table - table with username who reviews movie

CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE
);

INSERT INTO User (username) VALUES ('JJ'),('Cece'),('Kanmani'),('Chuhcu'),('Chika'),('Chacha'),('Chiku');

-- Displaying table contents

select * from User;

-- Review table for movie review

CREATE TABLE Review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    user_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 10),
    review TEXT,
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

INSERT INTO Review (movie_id,user_id,rating,review) VALUES (1,1,9,'Excellent!!!'),(1,2,10,'Salute'),(1,5,10,'Sad Story'),
(2,1,9,'Simba-Mufasa'),(2,5,9,'Good-movie'),(3,4,9,'comedy movie'),(3,6,8,'Good story'),(3,1,8,'Good'),(4,7,8,'adventurous'),
(4,6,9,'Best movie');

-- Displaying table contents

select * from Review;

-- 3rd movie with multiple reiews and reviews belong to user

SELECT M.movie_name, G.genre_name, U.username, R.rating, R.review
FROM Movie M
JOIN Movie_Genre MG ON M.movie_id = MG.movie_id
JOIN Genre G ON MG.genre_id = G.genre_id
JOIN Review R ON M.movie_id = R.movie_id
JOIN User U ON R.user_id = U.user_id;

SELECT 
    M.movie_name,
    GROUP_CONCAT(DISTINCT G.genre_name) AS genres,
    GROUP_CONCAT(DISTINCT U.username) AS reviewers,
    GROUP_CONCAT(DISTINCT R.rating) AS ratings,
    GROUP_CONCAT(DISTINCT R.review) AS reviews
FROM Movie M
JOIN Movie_Genre MG ON M.movie_id = MG.movie_id
JOIN Genre G ON MG.genre_id = G.genre_id
JOIN Review R ON M.movie_id = R.movie_id
JOIN User U ON R.user_id = U.user_id
GROUP BY M.movie_name
ORDER BY M.movie_name;

 -- Artist table has artist names
 
CREATE TABLE Artist (
    artist_id INT PRIMARY KEY AUTO_INCREMENT,
    artist_name VARCHAR(100)
);

INSERT INTO Artist (artist_name) VALUES ('Siva'),('Sasi'),('Simba'),('Timon'),('Moana'),('Puma'),('Mufasa'),('Sai Pallavi');

-- Displaying table contents

select * from Artist;

-- Skill Table has different skill names

CREATE TABLE Skill (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    skill_name VARCHAR(100) UNIQUE
);

INSERT INTO Skill (Skill_name) VALUES ('Dancing'),('singing'),('Fighting'),('acting'),('Comedy'),('Emotional');

-- Displaying table contents

select * from Skill;

-- Artist skill table to assign artist with different skills

CREATE TABLE Artist_Skill (
    artist_id INT,
    skill_id INT,
    -- PRIMARY KEY (artist_id, skill_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id),
    FOREIGN KEY (skill_id) REFERENCES Skill(skill_id)
);

INSERT INTO Artist_Skill VALUES (1,1),(1,3),(1,4),(2,2),(2,4),(2,5),(2,6),(3,4),(3,5);

-- Displaying table contents

select * from Artist_skill;
-- Table that assigns artist to multiple roles in a movie

CREATE TABLE Movie_Artist_Role (
    movie_id INT,
    artist_id INT,
    artist_role VARCHAR(100),
    -- PRIMARY KEY (movie_id, artist_id, role),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
);

INSERT INTO Movie_Artist_role (movie_id,artist_id,artist_role) VALUES (1,1,'Lead Actor'),(1,1,'Major'),(1,1,'Friendly'),
(2,3,'Lead actor'),(2,3,'Comedy'),(3,2,'Lead actor'),(3,2,'Emotional'),(3,2,'Comedian'),(4,5,'Lead role');

-- Displaying table contents

select * from Movie_Artist_Role;

-- 4th - Artist with multiple skills

SELECT A.artist_name, S.skill_name
FROM Artist A
JOIN Artist_Skill ASK ON A.artist_id = ASK.artist_id
JOIN Skill S ON ASK.skill_id = S.skill_id;

SELECT 
    A.artist_name,
    GROUP_CONCAT(S.skill_name) AS skills
FROM Artist A
JOIN Artist_Skill ASK ON A.artist_id = ASK.artist_id
JOIN Skill S ON ASK.skill_id = S.skill_id
GROUP BY A.artist_name
ORDER BY A.artist_name;

-- 5th - Artist with multiple role in a movie

SELECT M.movie_name, A.artist_name,MAR.Artist_role
FROM Movie M
JOIN Movie_Artist_Role MAR ON M.movie_id = MAR.movie_id
JOIN Artist A ON MAR.artist_id = A.artist_id;

-- After Grouping by movie name
	SELECT 
		M.movie_name,
		A.artist_name,
		GROUP_CONCAT(MAR.artist_role) AS roles
	FROM Movie M
	JOIN Movie_Artist_Role MAR ON M.movie_id = MAR.movie_id
	JOIN Artist A ON MAR.artist_id = A.artist_id
	GROUP BY M.movie_name, A.artist_name
	ORDER BY M.movie_name, A.artist_name;
--
SELECT 
    M.movie_name,
    G.genre_name,
    A.artist_name,
    MAR.artist_role,
    S.skill_name,
    U.username,
    R.rating,
    R.review
FROM Movie M
JOIN Movie_Genre MG ON M.movie_id = MG.movie_id
JOIN Genre G ON MG.genre_id = G.genre_id
JOIN Movie_Artist_Role MAR ON M.movie_id = MAR.movie_id
JOIN Artist A ON MAR.artist_id = A.artist_id
LEFT JOIN Artist_Skill ASK ON A.artist_id = ASK.artist_id
LEFT JOIN Skill S ON ASK.skill_id = S.skill_id
LEFT JOIN Review R ON M.movie_id = R.movie_id
LEFT JOIN User U ON R.user_id = U.user_id
ORDER BY M.movie_name, A.artist_name, S.skill_name group by M.Movie_name;

SELECT 
    M.movie_name,
    GROUP_CONCAT(DISTINCT G.genre_name) AS genres,
    GROUP_CONCAT(DISTINCT A.artist_name) AS artists,
    GROUP_CONCAT(DISTINCT MAR.artist_role) AS roles,
    GROUP_CONCAT(DISTINCT S.skill_name) AS skills,
    GROUP_CONCAT(DISTINCT U.username) AS reviewers,
    AVG(R.rating) AS avg_rating
FROM Movie M
JOIN Movie_Genre MG ON M.movie_id = MG.movie_id
JOIN Genre G ON MG.genre_id = G.genre_id
JOIN Movie_Artist_Role MAR ON M.movie_id = MAR.movie_id
JOIN Artist A ON MAR.artist_id = A.artist_id
LEFT JOIN Artist_Skill ASK ON A.artist_id = ASK.artist_id
LEFT JOIN Skill S ON ASK.skill_id = S.skill_id
LEFT JOIN Review R ON M.movie_id = R.movie_id
LEFT JOIN User U ON R.user_id = U.user_id
GROUP BY M.movie_name
ORDER BY M.movie_name;
