CREATE TABLE movie
(
	movieID VARCHAR(100),
	primaryTitle VARCHAR(50),
	originalTitle VARCHAR(50),
	category varchar(100),
	ReleaseDate date,
	runtime INT,
	averageRating float,
	Where_to_Watch varchar(100),
	Revenue INT,
	Region varchar(30),
	movie_language varchar(100),
	PRIMARY KEY(movieID)
);

CREATE TABLE series
(
	seriesID VARCHAR(100),
	primaryTitle VARCHAR(50),
	originalTitle VARCHAR(50),
	category varchar(100),
	startDate date,
	averageRating FLOAT,
	no_of_seasons INT,
	series_language varchar(100),
	Where_to_Watch varchar(200),
	PRIMARY KEY(seriesID)
);

CREATE TABLE episode
(
	episodeID VARCHAR(100),
	seriesID VARCHAR(100),
	seasonNumber INT,
	episodeNumber INT,
	primaryTitle VARCHAR(50),
	originalTitle VARCHAR(50),
	ReleaseDate date,
	averageRating float,
	PRIMARY KEY(episodeID, seriesID),
	FOREIGN KEY (seriesID) REFERENCES series(seriesID)
);

CREATE TABLE actor
(
	actorID VARCHAR(100),
	primaryName VARCHAR(50),
	birthYear INT,
	deathYear INT,
	gender VARCHAR(100),
	PRIMARY KEY(actorID)
);

CREATE TABLE director
(
	directorID VARCHAR(100),
	primaryName VARCHAR(50),
	birthYear INT,
	deathYear INT,
	PRIMARY KEY(directorID)
);

CREATE TABLE writer
(
	writerID VARCHAR(100),
	primaryName VARCHAR(50),
	birthYear INT,
	deathYear INT,
	PRIMARY KEY(writerID)
);

CREATE TABLE actor_known_for_titles
(
	actorID VARCHAR(100),
	knownForTitles VARCHAR(50),
	PRIMARY KEY (actorID, knownForTitles),
	FOREIGN KEY (actorID) REFERENCES actor(actorID)
);

CREATE TABLE director_known_for_titles
(
	directorID VARCHAR(100),
	knownForTitles VARCHAR(50),
	PRIMARY KEY (directorID, knownForTitles),
	FOREIGN KEY (directorID) REFERENCES director(directorID)
);

CREATE TABLE writer_known_for_titles
(
	writerID VARCHAR(100),
	knownForTitles VARCHAR(50),
	PRIMARY KEY (writerID, knownForTitles),
	FOREIGN KEY (writerID) REFERENCES writer(writerID)
);

CREATE TABLE movie_actor_relation
(
	movieID VARCHAR(100),
	actorID VARCHAR(100),
	characterPlayed VARCHAR(100),
	PRIMARY KEY (movieID, actorID),
	FOREIGN KEY (movieID) REFERENCES movie(movieID),
	FOREIGN KEY (actorID) REFERENCES actor(actorID)
);

CREATE TABLE movie_director_relation
(
	movieID VARCHAR(100),
	directorID VARCHAR(100),
	PRIMARY KEY (movieID, directorID),
	FOREIGN KEY (movieID) REFERENCES movie(movieID),
	FOREIGN KEY (directorID) REFERENCES director(directorID)
);

CREATE TABLE movie_writer_relation
(
	movieID VARCHAR(100),
	writerID VARCHAR(100),
	PRIMARY KEY (movieID, writerID),
	FOREIGN KEY (movieID) REFERENCES movie(movieID),
	FOREIGN KEY (writerID) REFERENCES writer(writerID)
);

CREATE TABLE series_director_relation
(
	seriesID VARCHAR(100),
	directorID VARCHAR(100),
	PRIMARY KEY (seriesID, directorID),
	FOREIGN KEY (seriesID) REFERENCES series(seriesID),
	FOREIGN KEY (directorID) REFERENCES director(directorID)
);

CREATE TABLE series_writer_relation
(
	seriesID VARCHAR(100),
	writerID VARCHAR(100),
	PRIMARY KEY (seriesID, writerID),
	FOREIGN KEY (seriesID) REFERENCES series(seriesID),
	FOREIGN KEY (writerID) REFERENCES writer(writerID)
);

CREATE TABLE series_actor_relation
(
	seriesID VARCHAR(100),
	actorID VARCHAR(100),
	characterPlayed VARCHAR(100),
	PRIMARY KEY (seriesID, actorID),
	FOREIGN KEY (seriesID) REFERENCES series(seriesID),
	FOREIGN KEY (actorID ) REFERENCES actor(actorID)
);

CREATE TABLE award
(
	awardID VARCHAR(100),
	awardName VARCHAR(100),
	awardCategory VARCHAR(100),
	WiningYear INT,
	PRIMARY KEY (awardID)
);

CREATE TABLE movie_award_relation
(
	awardID VARCHAR(100),
	movieID varchar(100),
	PRIMARY KEY (movieID, awardID),
	FOREIGN KEY (awardID) REFERENCES award(awardID),
	FOREIGN KEY (movieID) REFERENCES movie(movieID)
);

CREATE TABLE actor_award_relation
(
	awardID VARCHAR(100),
	actorID varchar(100),
	PRIMARY KEY (actorID,awardID),
	FOREIGN KEY (awardID) REFERENCES award(awardID),
	FOREIGN KEY (actorID) REFERENCES actor(actorID)
);

CREATE TABLE writer_award_relation
(
	awardID VARCHAR(100),
	writerID varchar(100),
	PRIMARY KEY (writerID,awardID),
	FOREIGN KEY (awardID) REFERENCES award(awardID),
	FOREIGN KEY (writerID) REFERENCES writer(writerID)
);

CREATE TABLE director_award_relation
(
	awardID VARCHAR(100),
	directorID varchar(100),
	PRIMARY KEY (directorID,awardID),
	FOREIGN KEY (awardID) REFERENCES award(awardID),
	FOREIGN KEY (directorID) REFERENCES director(directorID)
);

CREATE TABLE series_award_relation
(
	awardID VARCHAR(100),
	seriesID varchar(100),
	PRIMARY KEY (seriesID,awardID),
	FOREIGN KEY (awardID) REFERENCES award(awardID),
	FOREIGN KEY (seriesID) REFERENCES series(seriesID)
);

CREATE TABLE movie_genre
(
	movieID VARCHAR(100),
	Genre text,
	PRIMARY KEY (movieID,Genre),
	FOREIGN KEY (movieID) REFERENCES movie(movieID)
);

CREATE TABLE series_genre
(
	seriesID VARCHAR(100),
	Genre text,
	PRIMARY KEY (seriesID,Genre),
	FOREIGN KEY (seriesID) REFERENCES series(seriesID)
);
