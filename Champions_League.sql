-- Dropping tables
DROP TABLE IF EXISTS teams;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS matches;

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
('Barcelona', 'Spain', 'Camp Nou');

INSERT INTO players (player_name, position, team_id) VALUES
('Kylian Mbappe', 'Forward', 1),
('Kevin De Bruyne', 'Midfielder', 2),
('Virgil Van Dijk', 'Defender', 3),
('Lamine Yamal', 'Forward', 4);

INSERT INTO matches (home_team, away_team, match_date, home_score, away_score) VALUES
(1, 2, '2025-03-10', 2, 1),
(3, 4, '2025-03-11', 3, 2);

INSERT INTO goals (player_id, match_id, minute_scored) VALUES
(1, 1, 45),
(2, 1, 60),
(3, 2, 30),
(4, 2, 75);

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

