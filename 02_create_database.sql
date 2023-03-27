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
