DROP database MAIN_STORAGE;
CREATE database MAIN_STORAGE;
USE MAIN_STORAGE;


CREATE TABLE dim_Teams (
    team_id INT AUTO_INCREMENT,
    team_name VARCHAR(100),
    country VARCHAR(100),
    home_stadium VARCHAR(100),
    PRIMARY KEY (team_id)
);

CREATE TABLE dim_Date (
    date_id INT AUTO_INCREMENT,
    year INT,
    month INT,
    day INT,
    PRIMARY KEY (date_id)
);

CREATE TABLE dim_Season (
    season_id INT AUTO_INCREMENT,
    season VARCHAR(100),
    PRIMARY KEY (season_id)
);

CREATE TABLE dim_Country (
    country_id INT AUTO_INCREMENT,
    country VARCHAR(100),
    PRIMARY KEY (country_id)
);

CREATE TABLE dim_City (
    city_id INT AUTO_INCREMENT,
    country_id INT NOT NULL,
    city VARCHAR(100),
    PRIMARY KEY (city_id),
    FOREIGN KEY (country_id) REFERENCES dim_Country (country_id)
);

CREATE TABLE dim_Stadiums (
    stadium_id INT AUTO_INCREMENT,

    city_id INT NOT NULL,
    name VARCHAR(100),
    capacity VARCHAR(100),

    PRIMARY KEY (stadium_id),
    FOREIGN KEY (city_id) REFERENCES dim_City (city_id)
);

CREATE TABLE dim_Managers (
    manager_id INT AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    nationality VARCHAR(100),
    date_of_birth DATE,
    team VARCHAR(100),
    PRIMARY KEY (manager_id)
);

CREATE TABLE fact_Matches (
    match_id INT AUTO_INCREMENT,
    date_id INT,
    home_team_id INT,
    away_team_id INT,
    season_id INT,
    home_manager_id INT,
    away_manager_id INT,
    stadium_id INT,
    home_team_score INT,
    away_team_score INT,
    penalty_shoot_out BOOLEAN,
    attendance INT,
    PRIMARY KEY (match_id),
    FOREIGN KEY (date_id) REFERENCES dim_Date (date_id),
    FOREIGN KEY (home_team_id) REFERENCES dim_Teams (team_id),
    FOREIGN KEY (away_team_id) REFERENCES dim_Teams (team_id),
    FOREIGN KEY (season_id) REFERENCES dim_Season (season_id),
    FOREIGN KEY (home_manager_id) REFERENCES dim_Managers (manager_id),
    FOREIGN KEY (away_manager_id) REFERENCES dim_Managers (manager_id),
    FOREIGN KEY (stadium_id) REFERENCES dim_Stadiums (stadium_id)
);

USE MAIN_STORAGE;
SELECT * FROM dim_Teams;
SELECT * FROM dim_City;
SELECT * FROM dim_Date;
SELECT * FROM dim_Season;
SELECT * FROM dim_Country;
SELECT * FROM dim_Stadiums;
SELECT * FROM dim_Managers;
SELECT * FROM fact_Matches;



