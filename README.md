# Database_Systems_Assignment_2-SQL

Champions League Database

# Overview

This project is a PostgreSQL database that models a Champions League tournament. It demonstrates relational database concepts, SQL commands, joins, constraints, transactions, and views. The database includes teams, players, matches, and goals, providing a structured dataset for learning and testing SQL queries.

# Features

Primary & Foreign Keys: Maintains referential integrity between teams and players.

Constraints: Enforces CHECK, UNIQUE, and NOT NULL rules.

Joins: Demonstrates INNER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN, and NATURAL JOIN.

Views: Implements both regular views and materialized views.

Transactions: Demonstrates COMMIT and ROLLBACK.

Data Insertion: Sample data includes top football clubs and players.

# Database Schema

The database consists of the following tables:

Teams: Stores team information (team_id, team_name, country, stadium_name).

Players: Holds player details with a foreign key to teams.

Matches: Records match results between teams.

Goals: Tracks goals scored by players in matches.

# Installation & Setup

Prerequisites

PostgreSQL installed (version 13+ recommended)

pgAdmin 4 or a PostgreSQL client

# Steps

Clone the repository:

git clone https://github.com/ADA-SITE-JML/a2-sql-NaikPashayev
cd a2-sql-NaikPashayev

Open pgAdmin or any PostgreSQL client.

Run the Champions_League.sql file:

psql -U your_user -d your_database -f Champions_League.sql

# Verify the data:

SELECT * FROM teams;
SELECT * FROM players;

# Video Submission

https://adauniversity-my.sharepoint.com/:v:/g/personal/npashayev13148_ada_edu_az/ERyedSu_h21Io3Ms3O9CvU4Boo_Gky8zza8cX4aATGN5XQ?e=DbgcHv&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D

# Author

Naik Pashayev
npashayev13148@ada.edu.az

