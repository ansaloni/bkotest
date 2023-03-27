CREATE DATABASE bkotest
	DEFAULT CHARACTER SET UTF8MB4
	DEFAULT COLLATE UTF8MB4_GENERAL_CI
    ;

USE bkotest;

CREATE TABLE clientes(
	user_id MEDIUMINT UNSIGNED NOT NULL,
	cnpj VARCHAR(14),
	nome_do_cliente VARCHAR(30),
	PRIMARY KEY (user_id)
) DEFAULT CHARSET = UTF8MB4
;

CREATE TABLE `status`(
	user_id MEDIUMINT UNSIGNED NOT NULL,
	`status` VARCHAR(16),
	data_horario_do_status DATETIME(6),
	FOREIGN KEY (user_id) REFERENCES clientes(user_id)
) DEFAULT CHARSET = UTF8MB4
;

-- load customer data - change address path to match file location
LOAD DATA LOCAL INFILE '/Users/adria/Desktop/bkotest/clientes.csv'
	INTO TABLE clientes
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS
    ;

-- load status data - change address path to match file location
LOAD DATA LOCAL INFILE '/Users/adria/Desktop/bkotest/status.csv'
	INTO TABLE `status`
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS
    ;
    
    CREATE VIEW time_of_approval AS
SELECT 
	c.cnpj AS CNPJs, 
	MAX(s2.data_horario_do_status) AS date_of_purchase, 
	TIME_FORMAT(
		TIMEDIFF(
			MAX(s1.data_horario_do_status),
			MAX(s2.data_horario_do_status)), 
		'%H:%i:00') 
	AS time_of_approval
FROM 
	clientes c
	JOIN `status` s1 ON c.user_id = s1.user_id 
	JOIN `status` s2 ON s1.user_id = s2.user_id
WHERE 
	s1.`status` = 'approved' AND s2.`status` = 'pending_kyc'
GROUP BY 
	c.cnpj
ORDER BY 
	date_of_purchase DESC
;

SELECT
	TIME_FORMAT(
		SEC_TO_TIME(AVG(TIME_TO_SEC(time_of_approval))),
		'%H:%i:00')
        AS avg_time_of_approval
FROM
	time_of_approval
;

SELECT
	TIME_FORMAT(
		SEC_TO_TIME(MAX(TIME_TO_SEC(time_of_approval))),
		'%H:%i:00')
        AS max_time_of_approval
FROM
	time_of_approval
;

SELECT
	TIME_FORMAT(
		SEC_TO_TIME(MIN(TIME_TO_SEC(time_of_approval))),
		'%H:%i:00')
        AS min_time_of_approval
FROM
	time_of_approval
;