DROP database STAGE;
CREATE database STAGE;
USE  STAGE;

CREATE TABLE Stadiums (
    stadiums_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    capacity INT,
    PRIMARY KEY (stadiums_id)
);

CREATE TABLE Teams (
    teams_id INT AUTO_INCREMENT,
    team_name VARCHAR(100),
    country VARCHAR(100),
    home_stadium VARCHAR(100),
    PRIMARY KEY (teams_id)
);

CREATE TABLE Managers (
    managers_id INT AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    nationality VARCHAR(100),
    date_of_birth DATE,
    team VARCHAR(100),
    PRIMARY KEY (managers_id)
);

CREATE TABLE Matches (
    match_id INT,
    season VARCHAR(100),
    date_time DATETIME,
    home_team VARCHAR(100),
    away_team VARCHAR(255),
    stadium VARCHAR(255),
    home_team_score INT,
    away_team_score INT,
    penalty_shoot_out BOOLEAN,
    attendance INT,
    PRIMARY KEY (match_id)
);




