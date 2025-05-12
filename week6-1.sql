-- view is mainly use SELECT function; but stored procedures focus on insert, drop/alter data--
-- backup data before modify it: set backup schemas and play on it, if failed, go back to origenal data--
CALL sp_week6(2);
drop procedure sp_week6;

INSERT INTO week6.birthdata (State, Date, Births) VALUES
('NH', '1986-10-01', 211),
('NH', '1986-10-02', 205),
('NH', '1986-10-03', 310),
('NH', '1986-10-04', 410),
('NH', '1986-10-05', 153);
SELECT * FROM week6.birthdata 
WHERE Date BETWEEN '1986-10-01' AND '1986-10-05'
AND State = 'NH';

 
 SET birthdata.Year = YEAR(birthdata.Date);

select Year(labdata.Birth.Date);

CALL week6lab('MA', @totalMA);
SELECT @totalMA AS 'Total Births in MA';
CALL week6lab('NH', @totalNH);
SELECT @totalNH AS 'Total Births in NH';
SELECT FORMAT(@totalNH, 0) AS 'Total Births in New Hampshire';

Create TABLE T1 lIKE birthdata;