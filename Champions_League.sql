--Step 1 Demonstrate the usage of PK and FK: Create two tables with the PK/FK relation.

DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS teams;

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

