-- In this assignment, you'll be building the domain model, database 
-- structure, and data for "KMDB" (the Kellogg Movie Database).
-- The end product will be a report that prints the movies and the 
-- top-billed cast for each movie in the database.

-- Requirements/assumptions
--
-- - There will only be three movies in the database – the three films
--   that make up Christopher Nolan's Batman trilogy.
-- - Movie data includes the movie title, year released, MPAA rating,
--   and studio.
-- - There are many studios, and each studio produces many movies, but
--   a movie belongs to a single studio.
-- - An actor can be in multiple movies.
-- - Everything you need to do in this assignment is marked with TODO!

-- User stories
--
-- - As a guest, I want to see a list of movies with the title, year released,
--   MPAA rating, and studio information.
-- - As a guest, I want to see the movies which a single studio has produced.
-- - As a guest, I want to see each movie's cast including each actor's
--   name and the name of the character they portray.
-- - As a guest, I want to see the movies which a single actor has acted in.
-- * Note: The "guest" user role represents the experience prior to logging-in
--   to an app and typically does not have a corresponding database table.


-- Deliverables
-- 
-- There are three deliverables for this assignment, all delivered via
-- this file and submitted via GitHub and Canvas:
-- - A domain model, implemented via CREATE TABLE statements for each
--   model/table. Also, include DROP TABLE IF EXISTS statements for each
--   table, so that each run of this script starts with a blank database.
-- - Insertion of "Batman" sample data into tables.
-- - Selection of data, so that something similar to the sample "report"
--   below can be achieved.

-- Rubric
--
-- 1. Domain model - 6 points
-- - Think about how the domain model needs to reflect the
--   "real world" entities and the relationships with each other. 
--   Hint: It's not just a single table that contains everything in the 
--   expected output. There are multiple real world entities and
--   relationships including at least one many-to-many relationship.
-- 2. Execution of the domain model (CREATE TABLE) - 4 points
-- - Follow best practices for table and column names
-- - Use correct data column types (i.e. TEXT/INTEGER)
-- - Use of the `model_id` naming convention for foreign key columns
-- 3. Insertion of data (INSERT statements) - 4 points
-- - Insert data into all the tables you've created
-- - It actually works, i.e. proper INSERT syntax
-- 4. "The report" (SELECT statements) - 6 points
-- - Write 2 `SELECT` statements to produce something similar to the
--   sample output below - 1 for movies and 1 for cast. You will need
--   to read data from multiple tables in each `SELECT` statement.
--   Formatting does not matter.

-- Submission
-- 
-- - "Use this template" to create a brand-new "hw1" repository in your
--   personal GitHub account, e.g. https://github.com/<USERNAME>/hw1
-- - Do the assignment, committing and syncing often
-- - When done, commit and sync a final time, before submitting the GitHub
--   URL for the finished "hw1" repository as the "Website URL" for the 
--   Homework 1 assignment in Canvas

-- Successful sample output is as shown:

-- Movies
-- ======

-- Batman Begins          2005           PG-13  Warner Bros.
-- The Dark Knight        2008           PG-13  Warner Bros.
-- The Dark Knight Rises  2012           PG-13  Warner Bros.

-- Top Cast
-- ========

-- Batman Begins          Christian Bale        Bruce Wayne
-- Batman Begins          Michael Caine         Alfred
-- Batman Begins          Liam Neeson           Ra's Al Ghul
-- Batman Begins          Katie Holmes          Rachel Dawes
-- Batman Begins          Gary Oldman           Commissioner Gordon
-- The Dark Knight        Christian Bale        Bruce Wayne
-- The Dark Knight        Heath Ledger          Joker
-- The Dark Knight        Aaron Eckhart         Harvey Dent
-- The Dark Knight        Michael Caine         Alfred
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
-- The Dark Knight Rises  Christian Bale        Bruce Wayne
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon
-- The Dark Knight Rises  Tom Hardy             Bane
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle

-- Turns column mode on but headers off
.mode column
.headers off

-- Drop existing tables, so you'll start fresh each time this script is run.
-- TODO!

DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS studios;
DROP TABLE IF EXISTS appearances;

-- Create new tables, according to your domain model
-- TODO!

CREATE TABLE movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    year_released INTEGER,
    mpaa_rating TEXT,
    FK_studios_id INTEGER
);

CREATE TABLE actors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    actors_name TEXT
);

CREATE TABLE studios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    studio_name TEXT
);

CREATE TABLE appearances (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    char_name TEXT,
    FK_actors_id INTEGER,
    FK_movies_id INTEGER
);
-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary
-- TODO!

INSERT INTO movies (title, year_released, mpaa_rating, FK_studios_id) 
VALUES ("Batman Begins","2005", "PG-13", "1"), ("The Dark Knight","2008", "PG-13", "1"), ("The Dark Knight Rises","2013", "PG-13", "1");

INSERT INTO actors (actors_name)
VALUES ("Christian Bale"), ("Michael Caine"), ("Liam Neeson"), ("Katie Holmes"), ("Gary Oldman"), ("Heath Ledger"), ("Aaron Eckhart"), ("Maggie Gyllenhaal"), ("Joseph Gordon-Levitt"), ("Anne Hathaway"), ("Tom Hardy");

INSERT INTO studios (studio_name)
VALUES ("Warner Bros.");

INSERT INTO appearances (FK_actors_id, char_name, FK_movies_id)
VALUES ("1", "Bruce Wayne", "1"), ("2", "Alfred", "1"), ("3", "Ra's Al Ghul", "1"), ("4", "Rachel Dawes", "1"), ("5", "Commissioner Gordon", "1"), ("1", "Bruce Wayne", "2"), ("6", "Joker", "2"), ("7", "Harvey Dent", "2"), ("2", "Alfred", "2")
, ("8", "Rachel Dawes", "2"), ("1", "Bruce Wayne", "3"), ("2", "Alfred", "3"), ("5", "Commissioner Gordon", "3"), ("11", "Baine", "3"), ("9", "John Blake", "3"), ("10", "Selina Kyle", "3");

-- Prints a header for the movies output
.print "Movies"
.print "======"
.print ""

-- The SQL statement for the movies output
-- TODO!

SELECT movies.title, movies.year_released, movies.mpaa_rating, studios.studio_name FROM movies
LEFT JOIN studios
ON movies.FK_studios_id = studios.id;

-- SELECT id, actors_name FROM actors;
--SELECT id, studio_name FROM studios;

--SELECT studios.studio_name, movies.title FROM movies
--LEFT JOIN studios ON movies.FK_studios_id = studios.id;

--SELECT actors.actors_name, movies.title FROM appearances
--LEFT JOIN actors ON appearances.FK_actors_id = actors.id
--LEFT JOIN movies ON appearances.FK_movies_id = movies.id
--WHERE actors_name = "Christian Bale";

-- Prints a header for the cast output
.print ""
.print "Top Cast"
.print "========"
.print ""


-- The SQL statement for the cast output
-- TODO!


SELECT movies.title, actors.actors_name, appearances.char_name FROM appearances
LEFT JOIN actors ON FK_actors_id = actors.id
LEFT JOIN movies ON FK_movies_id = movies.id;