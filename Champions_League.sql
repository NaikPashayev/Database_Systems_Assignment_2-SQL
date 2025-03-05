--Step 1 Demonstrate the usage of PK and FK: Create two tables with the PK/FK relation.

DROP TABLE IF EXISTS players CASCADE;
DROP TABLE IF EXISTS teams CASCADE;

CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(100) UNIQUE NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE players (
    player_id SERIAL PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    position VARCHAR(50) CHECK (position IN ('Goalkeeper', 'Defender', 'Midfielder', 'Forward')),
    team_id INT REFERENCES teams(team_id) ON DELETE CASCADE
);

--Step 2 Demonstrate ALTER command to add a new column and update the column type.
ALTER TABLE teams ADD COLUMN stadium_name VARCHAR(100);
ALTER TABLE teams ALTER COLUMN country TYPE TEXT;

--Step 3 