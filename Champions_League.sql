-- Hello Jamaladdin Muellim, I hope you are reading this. Basically, I commited all of my code to
-- wrong repository, I created my own repository and worked on my code there. This is the repository
-- https://github.com/NaikPashayev/Database_Systems_Assignment_2-SQL
-- I hope this will not cause a problem. Thank you very much :)

-- Dropping tables
DROP TABLE IF EXISTS goals CASCADE;
DROP TABLE IF EXISTS players CASCADE;
DROP TABLE IF EXISTS matches CASCADE;
DROP TABLE IF EXISTS teams CASCADE;
DROP TABLE IF EXISTS players_backup CASCADE;
DROP TABLE IF EXISTS new_players CASCADE;
DROP MATERIALIZED VIEW IF EXISTS match_summary CASCADE;
DROP VIEW IF EXISTS top_scorers CASCADE;


-- Step 1: Demonstrate the usage of PK and FK: Create two tables with the PK/FK relation.
CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(100) UNIQUE NOT NULL,
    country TEXT NOT NULL
	);

CREATE TABLE players (
    player_id SERIAL PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    position VARCHAR(50) CHECK (position IN ('Goalkeeper', 'Defender', 'Midfielder', 'Forward')),
    team_id INT REFERENCES teams(team_id) ON DELETE CASCADE
);

-- Step 2: Demonstrating ALTER commands
ALTER TABLE teams ADD COLUMN stadium_name VARCHAR(100);
ALTER TABLE teams ALTER COLUMN country TYPE TEXT;

-- Step 3: Constraints (Check, Unique, not null)
CREATE TABLE matches (
    match_id SERIAL PRIMARY KEY,
    home_team INT REFERENCES teams(team_id),
    away_team INT REFERENCES teams(team_id),
    match_date DATE NOT NULL,
    home_score INT CHECK (home_score >= 0),
    away_score INT CHECK (away_score >= 0),
    UNIQUE (home_team, away_team, match_date)
);

-- Step 4: Demonstrating Joins
CREATE TABLE goals (
    goal_id SERIAL PRIMARY KEY,
    player_id INT REFERENCES players(player_id),
    match_id INT REFERENCES matches(match_id),
    minute_scored INT CHECK (minute_scored BETWEEN 1 AND 120)
);

-- Sample data
INSERT INTO teams (team_name, country, stadium_name) VALUES
('Real Madrid', 'Spain', 'Santiago Bernabéu'),
('Manchester City', 'England', 'Etihad Stadium'),
('Liverpool', 'England', 'Anfield'),
('Barcelona', 'Spain', 'Camp Nou'),
('Bayern Munich', 'Germany', 'Allianz Arena'),
('Paris Saint-Germain', 'France', 'Parc des Princes'),
('Inter Milan', 'Italy', 'San Siro'),
('Chelsea', 'England', 'Stamford Bridge');

INSERT INTO players (player_name, position, team_id) VALUES
('Kylian Mbappe', 'Forward', 1),
('Kevin De Bruyne', 'Midfielder', 2),
('Virgil Van Dijk', 'Defender', 3),
('Lamine Yamal', 'Forward', 4),
('Harry Kane', 'Forward', 5),
('Ousmane Dembele', 'Forward', 6),
('Lautaro Martinez', 'Forward', 7),
('Enzo Fernandez', 'Midfielder', 8),
('Jude Bellingham', 'Midfielder', 1),
('Erling Haaland', 'Forward', 2),
('Mohamed Salah', 'Forward', 3),
('Pedri', 'Midfielder', 4);

INSERT INTO matches (home_team, away_team, match_date, home_score, away_score) VALUES
(1, 2, '2025-03-10', 2, 1),
(3, 4, '2025-03-11', 3, 2),
(5, 6, '2025-03-12', 2, 2),
(7, 8, '2025-03-13', 1, 0),
(1, 3, '2025-03-14', 3, 1),
(2, 4, '2025-03-15', 2, 2);

INSERT INTO goals (player_id, match_id, minute_scored) VALUES
(1, 1, 45),
(2, 1, 60),
(3, 2, 30),
(4, 2, 75),
(5, 3, 25),
(6, 3, 50),
(7, 4, 10),
(8, 4, 80),
(9, 5, 35),
(10, 5, 55),
(11, 6, 20),
(12, 6, 70);

-- Natural Join
SELECT player_name, team_name FROM players NATURAL JOIN teams;

-- Inner Join
SELECT players.player_name, teams.team_name
FROM players
INNER JOIN teams ON players.team_id = teams.team_id;

-- Left Outer Join
SELECT teams.team_name, players.player_name
FROM teams
LEFT OUTER JOIN players ON teams.team_id = players.team_id;

-- Right Outer Join
SELECT teams.team_name, players.player_name
FROM teams
RIGHT OUTER JOIN players ON teams.team_id = players.team_id;

-- Full Outer Join
SELECT teams.team_name, players.player_name
FROM teams
FULL OUTER JOIN players ON teams.team_id = players.team_id;

-- Step 5: Creation of regular and materialized views
CREATE VIEW top_scorers AS
SELECT players.player_name, COUNT(goals.goal_id) AS goals
FROM players
JOIN goals ON players.player_id = goals.player_id
GROUP BY players.player_name
ORDER BY goals DESC;

CREATE MATERIALIZED VIEW match_summary AS
SELECT matches.match_id, teams.team_name AS home_team, 
       matches.home_score, matches.away_score, teams2.team_name AS away_team
FROM matches
JOIN teams AS teams ON matches.home_team = teams.team_id
JOIN teams AS teams2 ON matches.away_team = teams2.team_id;

-- Step 6: Demonstrating CREATE AS SELECT and INSERT AS SELECT
CREATE TABLE players_backup AS
SELECT player_id, player_name, position, team_id FROM players;

CREATE TABLE new_players (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL
);

INSERT INTO new_players (name, role)
SELECT player_name, position FROM players;

-- Step 7: Demonstrating Commit and Rollback
BEGIN;
UPDATE players SET position = 'Midfielder' WHERE player_id = 1;
ROLLBACK;

BEGIN;
UPDATE players SET position = 'Forward' WHERE player_id = 1;
COMMIT;

-- Testing here

