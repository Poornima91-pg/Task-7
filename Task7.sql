-- 1)	Movie Should have multiple Media ( Image or Video) -  (By joining Movie & Media Table)

SELECT M.movie_name, ME.media_type, ME.url
FROM Movie M
JOIN Media ME ON M.movie_id = ME.movie_id;

-- 2)	Movie can belongs to multiple genre. (By Joining Movie table,Movie_genre Table and genre table to display movie name with multiple genre)

SELECT M.movie_name,G.genre_name
FROM Movie M
JOIN Movie_Genre MG ON M.movie_id = MG.movie_id
JOIN Genre G ON MG.genre_id = G.genre_id;

-- After Grouping By Movie name

SELECT 
    M.movie_name,
    GROUP_CONCAT(G.genre_name) AS genres
FROM Movie M
JOIN Movie_Genre MG ON M.movie_id = MG.movie_id
JOIN Genre G ON MG.genre_id = G.genre_id
GROUP BY M.movie_name
ORDER BY M.movie_name;

-- 3)  movie with multiple reiews and reviews belong to user ( By joining Movie,Genre,Movie_genre,Review and User Table)

SELECT M.movie_name, G.genre_name, U.username, R.rating, R.review
FROM Movie M
JOIN Movie_Genre MG ON M.movie_id = MG.movie_id
JOIN Genre G ON MG.genre_id = G.genre_id
JOIN Review R ON M.movie_id = R.movie_id
JOIN User U ON R.user_id = U.user_id;

-- After Grouping by Movie name

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

-- 4) Artist with multiple skills ( By Joining Artist,Artist_skill & Skill Tables)

SELECT A.artist_name, S.skill_name
FROM Artist A
JOIN Artist_Skill ASK ON A.artist_id = ASK.artist_id
JOIN Skill S ON ASK.skill_id = S.skill_id; 

-- After Grouping by Movie name

SELECT 
    A.artist_name,
    GROUP_CONCAT(S.skill_name) AS skills
FROM Artist A
JOIN Artist_Skill ASK ON A.artist_id = ASK.artist_id
JOIN Skill S ON ASK.skill_id = S.skill_id
GROUP BY A.artist_name
ORDER BY A.artist_name;

-- 5) Artist with multiple role in a movie (By Joining Movie,movie_artist_role,Artist Table)

SELECT M.movie_name, A.artist_name,MAR.Artist_role
FROM Movie M
JOIN Movie_Artist_Role MAR ON M.movie_id = MAR.movie_id
JOIN Artist A ON MAR.artist_id =A.Artist_id;

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









