USE STAGE;

INSERT INTO MAIN_STORAGE.dim_Date(year, month, day)
SELECT DISTINCT YEAR(date_time), MONTH(date_time), DAY(date_time)
FROM matches;

INSERT INTO MAIN_STORAGE.dim_Season(season)
SELECT DISTINCT season
FROM matches;

INSERT INTO MAIN_STORAGE.dim_Teams(team_name, country, home_stadium)
SELECT DISTINCT team_name, country, home_stadium
FROM teams;

INSERT INTO MAIN_STORAGE.dim_Managers(first_name, last_name, nationality, date_of_birth, team)
SELECT DISTINCT first_name, last_name, nationality, date_of_birth, team
FROM managers;

INSERT INTO MAIN_STORAGE.dim_Country(country)
SELECT DISTINCT country
FROM stadiums;

INSERT INTO MAIN_STORAGE.dim_City(country_id, city)
SELECT DISTINCT dc.country_id, city
FROM stadiums
JOIN MAIN_STORAGE.dim_Country dc ON dc.country = stadiums.country;

INSERT INTO MAIN_STORAGE.dim_Stadiums(city_id, name, capacity)
SELECT DISTINCT city_id, name, capacity
FROM stadiums
JOIN MAIN_STORAGE.dim_City ds ON ds.city = stadiums.city;



-- Вставляємо date_id
INSERT INTO MAIN_STORAGE.fact_Matches(date_id)
SELECT dd.date_id
FROM STAGE.Matches m
JOIN MAIN_STORAGE.dim_Date dd ON YEAR(m.date_time) = dd.year AND MONTH(m.date_time) = dd.month AND DAY(m.date_time) = dd.day;

-- Вставляємо home_team_id
UPDATE MAIN_STORAGE.fact_Matches fm
JOIN STAGE.Matches m ON fm.match_id = m.match_id
JOIN MAIN_STORAGE.dim_Teams dt ON m.home_team = dt.team_name
SET fm.home_team_id = dt.team_id;

-- Вставляємо away_team_id
UPDATE MAIN_STORAGE.fact_Matches fm
JOIN STAGE.Matches m ON fm.match_id = m.match_id
JOIN MAIN_STORAGE.dim_Teams dt ON m.away_team = dt.team_name
SET fm.away_team_id = dt.team_id;

-- Вставляємо season_id
UPDATE MAIN_STORAGE.fact_Matches fm
JOIN STAGE.Matches m ON fm.match_id = m.match_id
JOIN MAIN_STORAGE.dim_Season ds ON m.season = ds.season
SET fm.season_id = ds.season_id;

-- Вставляємо stadium_id
UPDATE MAIN_STORAGE.fact_Matches fm
JOIN STAGE.Matches m ON fm.match_id = m.match_id
JOIN MAIN_STORAGE.dim_Stadiums dst ON m.stadium = dst.name
SET fm.stadium_id = dst.stadium_id;

-- Вставляємо home_team_score
UPDATE MAIN_STORAGE.fact_Matches fm
JOIN STAGE.Matches m ON fm.match_id = m.match_id
SET fm.home_team_score = m.home_team_score;

-- Вставляємо away_team_score
UPDATE MAIN_STORAGE.fact_Matches fm
JOIN STAGE.Matches m ON fm.match_id = m.match_id
SET fm.away_team_score = m.away_team_score;

SET SQL_SAFE_UPDATES = 0;


-- Вставляємо penalty_shoot_out
UPDATE MAIN_STORAGE.fact_Matches fm
JOIN STAGE.Matches m ON fm.match_id = m.match_id
SET fm.penalty_shoot_out = m.penalty_shoot_out;

-- Вставляємо attendance
UPDATE MAIN_STORAGE.fact_Matches fm
JOIN STAGE.Matches m ON fm.match_id = m.match_id
SET fm.attendance = m.attendance;

-- Вставляємо away_manager_id
UPDATE MAIN_STORAGE.fact_Matches fm
JOIN STAGE.Matches m ON fm.match_id = m.match_id
JOIN MAIN_STORAGE.dim_Teams dt ON m.away_team = dt.team_name
SET fm.away_manager_id = dt.team_id;


-- Вставляємо home_manager_id
UPDATE MAIN_STORAGE.fact_Matches fm
JOIN STAGE.Matches m ON fm.match_id = m.match_id
JOIN MAIN_STORAGE.dim_Teams dt ON m.home_team = dt.team_name
SET fm.home_manager_id = dt.team_id;






