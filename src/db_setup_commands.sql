-- if you have postgres installed
-- simply run \i <file path for this file>
-- so if it was in your downloads
-- \i downloads/db_setup_commands.sql
CREATE DATABASE meditrack_db;

CREATE TABLE prec_table (
	rx_no VARCHAR(50) PRIMARY KEY NOT NULL, --prescription rxno
	user_id BIGINT NOT NULL,
	pharm_id BIGINT NOT NULL,
	status VARCHAR(200) NOT NULL
	--creation_date
);

CREATE TABLE user_table(
	user_id BIGSERIAL PRIMARY KEY NOT NULL,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	active_precs JSON,
	prec_history JSON
);

CREATE TABLE pharm_table(
	pharm_id BIGSERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL,
	street_address VARCHAR(100),
	city VARCHAR(50),
	zip_code VARCHAR(10),
	active_precs JSON, --precs they are currently filling
	prec_history JSON --no longer active precs
);