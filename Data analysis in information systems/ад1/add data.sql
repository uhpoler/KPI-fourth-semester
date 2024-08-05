USE  STAGE;
SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stadiums.csv'
INTO TABLE Stadiums
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(name, city, country, capacity);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/teams.csv'
INTO TABLE Teams
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(team_name, country, home_stadium);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/managers.csv'
INTO TABLE Managers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(first_name, last_name, nationality, date_of_birth, team);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/matches.csv'
INTO TABLE Matches
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(match_id, season, date_time, home_team, away_team, stadium, home_team_score, away_team_score, penalty_shoot_out, attendance);

SELECT * FROM Stadiums;
SELECT * FROM Teams;
SELECT * FROM Managers;
SELECT * FROM Matches;


