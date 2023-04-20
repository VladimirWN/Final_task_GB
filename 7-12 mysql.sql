DROP DATABASE IF EXISTS human_friend;
CREATE DATABASE IF NOT EXISTS human_friend;
USE human_friend;

DROP TABLE IF EXISTS human_friend;
CREATE TABLE human_friend
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(45)
);

INSERT human_friend
VALUES
	(1, "pet"),
    (2, "pack_animal");


DROP TABLE IF EXISTS pet;
CREATE TABLE pet
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(45),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES human_friend(id)
);

INSERT pet
VALUES
	(1, "dog", 1),
    (2, "cat", 1),
    (3, "humster", 1);


DROP TABLE IF EXISTS pack_animal;
CREATE TABLE pack_animal
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(45),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES human_friend(id)
);

INSERT pack_animal
VALUES
	(1, "horse", 2),
    (2, "camel", 2),
    (3, "dunkey", 2);
    

DROP TABLE IF EXISTS dog;
CREATE TABLE dog
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    animal_name VARCHAR(45),
    birth DATE,
    commands VARCHAR(45),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES pet(id)
);

INSERT dog
VALUE
	(1, "Bob", "2020.04.28", "sit, get", 1);
    

DROP TABLE IF EXISTS cat;
CREATE TABLE cat
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    animal_name VARCHAR(45),
    birth DATE,
    commands VARCHAR(45),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES pet(id)
);

INSERT cat
VALUE
	(1, "Dod", "2022.01.01", "sit, jrat", 2);

DROP TABLE IF EXISTS humster;
CREATE TABLE humster
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    animal_name VARCHAR(45),
    birth DATE,
    commands VARCHAR(45),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES pet(id)
);

INSERT humster
VALUE
	(1, "Wow", "2021.01.03", "no", 3);
    

DROP TABLE IF EXISTS horse;
CREATE TABLE horse
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    animal_name VARCHAR(45),
    birth DATE,
    commands VARCHAR(45),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES pet(id)
);

INSERT horse
VALUE
	(1, "Ror", "2022.08.01", "go, stop", 1);
    

DROP TABLE IF EXISTS camel;
CREATE TABLE camel
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    animal_name VARCHAR(45),
    birth DATE,
    commands VARCHAR(45),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES pet(id)
);

INSERT camel
VALUE
	(1, "Eheo", "2019.01.01", "go, stop, hm", 2);
    

DROP TABLE IF EXISTS dunkey;
CREATE TABLE dunkey
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    animal_name VARCHAR(45),
    birth DATE,
    commands VARCHAR(45),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES pet(id)
);

INSERT dunkey
VALUE
	(1, "Gebr", "2021.10.01", "go, stop, carrot", 3);


DROP TABLE IF EXISTS camel;


DROP TABLE IF EXISTS young_animal;
CREATE TABLE young_animal
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    animal_name VARCHAR(45),
    birth DATE,
    age_months INT
);

INSERT  young_animal (animal_name, birth, age_months)
SELECT animal_name, birth, TIMESTAMPDIFF(MONTH, birth, CURDATE()) AS age_months
FROM (
    SELECT animal_name, birth
    FROM dog
    WHERE birth <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND birth > DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
    UNION ALL
    SELECT animal_name, birth
    FROM cat
    WHERE birth <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND birth > DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
    UNION ALL
    SELECT animal_name, birth
    FROM humster
    WHERE birth <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND birth > DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
    UNION ALL
    SELECT animal_name, birth
    FROM horse
    WHERE birth <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND birth > DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
    UNION ALL
    SELECT animal_name, birth
    FROM dunkey
    WHERE birth <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND birth > DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
) AS subquery;

SELECT * FROM young_animal;

DROP TABLE IF EXISTS all_animals;
CREATE TABLE all_animals
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    animal_name VARCHAR(45),
    birth DATE,
    commands VARCHAR(45),
    animal_type VARCHAR(45),
    animal_origin VARCHAR(45)
);

INSERT all_animals (animal_name, birth, commands, animal_type, animal_origin)
SELECT animal_name, birth, commands, type_name, origin_name
FROM (
	SELECT f.animal_name AS animal_name, f.birth AS birth, f.commands AS commands, c.type_name AS type_name, c.origin_name AS origin_name
    FROM dog f 
	JOIN (SELECT s.id, s.type_id, s.type_name, t.type_name as origin_name
		FROM pet s
		JOIN human_friend t
		ON s.type_id = t.id) AS c
	ON f.type_id = c.id
    
    UNION ALL
	SELECT f.animal_name AS animal_name, f.birth AS birth, f.commands AS commands, c.type_name AS type_name, c.origin_name AS origin_name
    FROM cat f 
	JOIN (SELECT s.id, s.type_id, s.type_name, t.type_name as origin_name
		FROM pet s
		JOIN human_friend t
		ON s.type_id = t.id) AS c
	ON f.type_id = c.id
    
	UNION ALL
	SELECT f.animal_name AS animal_name, f.birth AS birth, f.commands AS commands, c.type_name AS type_name, c.origin_name AS origin_name
    FROM humster f 
	JOIN (SELECT s.id, s.type_id, s.type_name, t.type_name as origin_name
		FROM pet s
		JOIN human_friend t
		ON s.type_id = t.id) AS c
	ON f.type_id = c.id
    
	UNION ALL
	SELECT f.animal_name AS animal_name, f.birth AS birth, f.commands AS commands, c.type_name AS type_name, c.origin_name AS origin_name
    FROM horse f 
	JOIN (SELECT s.id, s.type_id, s.type_name, t.type_name as origin_name
		FROM pack_animal s
		JOIN human_friend t
		ON s.type_id = t.id) AS c
	ON f.type_id = c.id
    
	UNION ALL
	SELECT f.animal_name AS animal_name, f.birth AS birth, f.commands AS commands, c.type_name AS type_name, c.origin_name AS origin_name
    FROM dunkey f 
	JOIN (SELECT s.id, s.type_id, s.type_name, t.type_name as origin_name
		FROM pack_animal s
		JOIN human_friend t
		ON s.type_id = t.id) AS c
	ON f.type_id = c.id) AS a;


SELECT * FROM all_animals;
