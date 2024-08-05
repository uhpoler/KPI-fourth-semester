USE MAIN_STORAGE;
DROP PROCEDURE IF EXISTS slow_change_teams;
DELIMITER //
CREATE PROCEDURE slow_change_teams(old_name VARCHAR(100), new_name VARCHAR(100))
BEGIN
 DECLARE old_id INT DEFAULT NULL;
 DECLARE old_country VARCHAR(100);
 DECLARE old_home_stadium VARCHAR(100);

 SELECT team_id, country, home_stadium
 INTO old_id, old_country, old_home_stadium
 FROM dim_Teams
 WHERE team_name = old_name;

 IF old_id IS NULL THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The old name of the team does not exist';
 ELSE
  INSERT INTO dim_Teams (team_name, country, home_stadium)
  VALUES (new_name, old_country, old_home_stadium);

  UPDATE fact_Matches
  SET home_team_id = (SELECT team_id FROM dim_Teams WHERE team_name = new_name)
  WHERE home_team_id = old_id;

  UPDATE fact_Matches
  SET away_team_id = (SELECT team_id FROM dim_Teams WHERE team_name = new_name)
  WHERE away_team_id = old_id;
 END IF;
END //
DELIMITER ;


CALL slow_change_teams('Atalanta', 'New Team Name');

