USE STAGE;
-- Завантажте нові команди в таблицю dim_Teams
INSERT INTO MAIN_STORAGE.dim_Teams (team_name, country, home_stadium)
SELECT DISTINCT team_name, country, home_stadium
FROM STAGE.Teams t
WHERE NOT EXISTS (
SELECT 1
FROM MAIN_STORAGE.dim_Teams dt
WHERE dt.team_name = t.team_name
);

-- Завантажте нові стадіони в таблицю dim_Stadiums
INSERT INTO MAIN_STORAGE.dim_Stadiums (name, city_id, capacity)
SELECT DISTINCT s.name, c.city_id, s.capacity
FROM STAGE.Stadiums s
JOIN MAIN_STORAGE.dim_City c ON s.city = c.city 
WHERE NOT EXISTS (
SELECT 1
FROM MAIN_STORAGE.dim_Stadiums ds
WHERE ds.name = s.name
);

-- Завантажте нових менеджерів в таблицю dim_Managers
INSERT INTO MAIN_STORAGE.dim_Managers (first_name, last_name, nationality, date_of_birth, team)
SELECT DISTINCT first_name, last_name, nationality, date_of_birth, team
FROM STAGE.Managers m
WHERE NOT EXISTS (
SELECT 1
FROM MAIN_STORAGE.dim_Managers dm
WHERE dm.first_name = m.first_name AND dm.last_name = m.last_name
);

-- Завантажте нові матчі в таблицю fact_Matches
INSERT INTO MAIN_STORAGE.fact_Matches (date_id, home_team_id, away_team_id, season_id, home_manager_id, away_manager_id, stadium_id, home_team_score, away_team_score, penalty_shoot_out, attendance)
SELECT d.date_id, ht.team_id, at.team_id, s.season_id, hm.manager_id, am.manager_id, st.stadium_id, m.home_team_score, m.away_team_score, m.penalty_shoot_out, m.attendance
FROM STAGE.Matches m
JOIN MAIN_STORAGE.dim_Date d ON DATE(m.date_time) = CONCAT(d.year, '-', d.month, '-', d.day)
JOIN MAIN_STORAGE.dim_Teams ht ON m.home_team = ht.team_name
JOIN MAIN_STORAGE.dim_Teams at ON m.away_team = at.team_name
JOIN MAIN_STORAGE.dim_Season s ON m.season = s.season
JOIN MAIN_STORAGE.dim_Managers hm ON ht.team_name = hm.team
JOIN MAIN_STORAGE.dim_Managers am ON at.team_name = am.team
JOIN MAIN_STORAGE.dim_Stadiums st ON m.stadium = st.name
WHERE NOT EXISTS (
SELECT 1
FROM MAIN_STORAGE.fact_Matches fm
WHERE fm.match_id = m.match_id
);
