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
