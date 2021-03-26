-- if you have postgres installed
-- simply run \i <file path for this file>
-- so if it was in your downloads
-- \i downloads/db_setup_commands.sql
CREATE DATABASE meditrack_db;

\c meditrack_db

CREATE TABLE prec_info(
	rx VARCHAR(10) PRIMARY KEY NOT NULL,
	med_name VARCHAR(50) NULL,
	med_strength VARCHAR(12) NULL,
	user_id BIGINT NOT NULL,
	pharm_id BIGINT NOT NULL,
	status_step_id BIGINT NOT NULL,
	status_msg VARCHAR(200) NULL,
	is_completed BIGINT NOT NULL,
	status_date TIMESTAMP NOT NULL
);

CREATE TABLE status_steps(
	status_step_id BIGSERIAL PRIMARY KEY NOT NULL,
	status_msg VARCHAR(50) NOT NULL
);

CREATE TABLE user_info(
	user_id BIGSERIAL PRIMARY KEY NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	email VARCHAR(50) NULL,
	phone_no VARCHAR(15) NULL, 
	precs_active JSON NULL,
	precs_history JSON NULL
);


CREATE TABLE user_sec_info(
	user_id BIGINT PRIMARY KEY NOT NULL,
	email VARCHAR(50) NULL,
	phone_no VARCHAR(15) NULL,
	password VARCHAR(50) NOT NULL,
	healthcard_no CHAR(12) NULL,
	street_address VARCHAR(50) NULL,
	city VARCHAR(30) NULL,
	postal_code VARCHAR(20) NULL,
	sec_quest_1 VARCHAR(100) NULL,
	sec_ans_1 VARCHAR(50) NULL,
	sec_quest_2 VARCHAR(100) NULL,
	sec_ans_2 VARCHAR(50) NULL,
	sec_quest_3 VARCHAR(100) NULL,
	sec_ans_3 VARCHAR(50) NULL
);

CREATE TABLE pharm_info(
	pharm_id BIGSERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(50) NULL,
	phone_no VARCHAR(15) NULL,
	street_address VARCHAR(50) NULL,
	city VARCHAR(30) NULL,
	postal_code VARCHAR(20) NULL,
	precs_active JSON NULL,
	precs_history JSON NULL,
	patients JSON NULL
);

CREATE TABLE pharm_sec_info(
	pharm_id BIGINT PRIMARY KEY NOT NULL,
	email VARCHAR(50) NULL,
	phone_no VARCHAR(15) NULL,
	password VARCHAR(50) NOT NULL,
	sec_quest_1 VARCHAR(100) NULL,
	sec_ans_1 VARCHAR(50) NULL,
	sec_quest_2 VARCHAR(100) NULL,
	sec_ans_2 VARCHAR(50) NULL,
	sec_quest_3 VARCHAR(100) NULL,
	sec_ans_3 VARCHAR(50) NULL
);


CREATE TABLE sec_questions(
	sec_quest_id BIGSERIAL PRIMARY KEY NOT NULL,
	sec_quest VARCHAR(75) NOT NULL
);

-- https://www.postgresql.org/docs/9.5/arrays.html
-- https://www.postgresql.org/docs/9.5/datatype.html
-- https://www.postgresql.org/docs/9.5/datatype-datetime.html
-- https://www.convertcsv.com/csv-to-sql.htm

-- STATUS QUESTIONS------------------------------------------------------------------------------------------
INSERT INTO status_steps (status_msg) VALUES ('Received');
INSERT INTO status_steps (status_msg) VALUES ('Logged');
INSERT INTO status_steps (status_msg) VALUES ('Pharmacist Verification');
INSERT INTO status_steps (status_msg) VALUES ('Packaging');
INSERT INTO status_steps (status_msg) VALUES ('Ready For Pick Up');
INSERT INTO status_steps (status_msg) VALUES ('NOMESSAGE');

-- SEC QUESTIONS------------------------------------------------------------------------------------------
INSERT INTO sec_questions(sec_quest) VALUES ('What was the house number and street name you lived in as a child?');
INSERT INTO sec_questions(sec_quest) VALUES ('What were the last four digits of your childhood telephone number?');
INSERT INTO sec_questions(sec_quest) VALUES ('What primary school did you attend?');
INSERT INTO sec_questions(sec_quest) VALUES ('In what town or city was your first full time job?');
INSERT INTO sec_questions(sec_quest) VALUES ('In what town or city did you meet your spouse or partner?');
INSERT INTO sec_questions(sec_quest) VALUES ('What is the middle name of your oldest child?');
INSERT INTO sec_questions(sec_quest) VALUES ('In what town or city did your parents meet?');
INSERT INTO sec_questions(sec_quest) VALUES ('What time of the day were you born? (hh:mm)');
INSERT INTO sec_questions(sec_quest) VALUES ('What time of the day was your first child born? (hh:mm)');

-- SAMPLE USER INFO -----------------------------------------------------------------------------------
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Toddie','Petters','tpetters0@walmart.com','827-326-9651',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Lamar','Lamping','llamping1@privacy.gov.au','192-293-0350',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Addia','Zellick','azellick2@omniture.com','735-232-5276',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Frederigo','Peperell','fpeperell3@skyrock.com','650-973-6340',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Millie','Baike','mbaike4@fotki.com','169-172-4022',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Lyndsey','Rillstone','lrillstone5@booking.com','544-556-7146',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Margi','Westphal','mwestphal6@typepad.com','931-200-3729',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Finn','Leathart','fleathart7@ca.gov','538-304-4146',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Clim','McCabe','cmccabe8@chicagotribune.com','741-472-5430',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Janean','Drever','jdrever9@marketwatch.com','407-633-6486',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Spike','Ogdahl','sogdahla@youku.com','165-937-9782',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Eachelle','Whitmell','ewhitmellb@indiegogo.com','351-568-6508',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Law','Locket','llocketc@soup.io','527-701-3275',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Jervis','Castagnier','jcastagnierd@wikipedia.org','786-564-9169',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Marshal','Champneys','mchampneyse@washington.edu','626-722-8119',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Nichole','Hudless','nhudlessf@booking.com','899-620-7385',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Riva','Scottrell','rscottrellg@telegraph.co.uk','346-553-1442',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Ulrikaumeko','Gibby','ugibbyh@about.com','663-930-4213',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Flemming','Wrotham','fwrothami@google.com','827-772-4842',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Cecelia','Caldairou','ccaldairouj@google.com.au','826-944-6130',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Rosmunda','Ferras','rferrask@indiatimes.com','885-799-0550',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Parke','Frankiewicz','pfrankiewiczl@bandcamp.com','348-824-2927',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Lindsey','Macura','lmacuram@4shared.com','704-524-5614',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Pierette','Bagniuk','pbagniukn@sciencedirect.com','927-235-9661',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Nanci','Sarch','nsarcho@merriam-webster.com','466-573-6485',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Perrine','Breckin','pbreckinp@flavors.me','284-219-7295',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Stevy','Thorowgood','sthorowgoodq@g.co','977-787-4860',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Annora','Blofield','ablofieldr@nba.com','550-239-3649',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Gabriela','Garrie','ggarries@msn.com','473-931-1489',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Fleming','Castagne','fcastagnet@spotify.com','106-334-2284',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Byrle','Cramb','bcrambu@engadget.com','570-647-7128',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Francine','Heams','fheamsv@pinterest.com','299-484-8193',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Lidia','Coomes','lcoomesw@utexas.edu','870-226-0015',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Vi','De Filippo','vdefilippox@friendfeed.com','586-413-1655',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Gwen','Vaggs','gvaggsy@slashdot.org','799-137-7178',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Nerita','Kettel','nkettelz@boston.com','186-749-2727',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Nico','McKiddin','nmckiddin10@businesswire.com','816-374-0454',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Osmond','Foakes','ofoakes11@wix.com','473-533-4000',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Ashlee','Cherm','acherm12@mozilla.org','614-398-1494',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Arch','Thomasset','athomasset13@netlog.com','447-311-3305',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Rice','Shwenn','rshwenn14@prweb.com','749-545-5489',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Asher','Coulton','acoulton15@domainmarket.com','742-451-7521',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Alic','Phidgin','aphidgin16@issuu.com','391-698-7923',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Garrard','Lyle','glyle17@reddit.com','397-347-0953',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Ynez','Tompkin','ytompkin18@oakley.com','461-117-7471',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Roth','Elcoat','relcoat19@sakura.ne.jp','806-206-5535',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Helenka','Dollin','hdollin1a@scientificamerican.com','970-876-3867',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Alfonse','Sandercock','asandercock1b@deviantart.com','760-547-2763',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Rogers','Semaine','rsemaine1c@icio.us','723-303-8035',NULL,NULL);
INSERT INTO user_info(first_name,last_name,email,phone_no,precs_active,precs_history) VALUES ('Rem','Rawnsley','rrawnsley1d@cdc.gov','964-615-2678',NULL,NULL);


-- SAMPLE USER SEC INFO -----------------------------------------------------------------------------------
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (1,'tpetters0@walmart.com','827-326-9651','epfHyxOLpN7',1754,'0582 Barnett Plaza','Kingston','98000',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (2,'llamping1@privacy.gov.au','192-293-0350','YUfnCe',118,'555 Miller Alley','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (3,'azellick2@omniture.com','735-232-5276','YiJakBSgM6OZ',192,'670 Donald Street','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (4,'fpeperell3@skyrock.com','650-973-6340','SimBSrLP5c',812,'4103 Mandrake Place','Kingston','396647',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (5,'mbaike4@fotki.com','169-172-4022','oVkKuic1Mza9',49,'43 Spaight Park','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (6,'lrillstone5@booking.com','544-556-7146','kYVwSH4',8,'7439 Garrison Plaza','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (7,'mwestphal6@typepad.com','931-200-3729','rB3EHc',9,'71 Monterey Lane','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (8,'fleathart7@ca.gov','538-304-4146','008AESWSRLwC',8,'72 Maryland Junction','Kingston','1862',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (9,'cmccabe8@chicagotribune.com','741-472-5430','TH50NOZox',9583,'45 Donald Drive','Kingston','373 82',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (10,'jdrever9@marketwatch.com','407-633-6486','mX5kH1NL',83,'52994 Melody Alley','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (11,'sogdahla@youku.com','165-937-9782','eHHTQcVtUIaI',641,'19 Hallows Terrace','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (12,'ewhitmellb@indiegogo.com','351-568-6508','Orv0BoDbqL0',6,'93803 Hayes Lane','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (13,'llocketc@soup.io','527-701-3275','rSATarW6j8',9,'4 Debra Lane','Kingston','5020',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (14,'jcastagnierd@wikipedia.org','786-564-9169','P7hp5qF6G',1,'99 Huxley Way','Kingston','36980-000',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (15,'mchampneyse@washington.edu','626-722-8119','8IYz1KeURkNp',97,'81 Kipling Drive','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (16,'nhudlessf@booking.com','899-620-7385','rcFdc45Xcj1m',2317,'83 6th Crossing','Kingston','13674 CEDEX',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (17,'rscottrellg@telegraph.co.uk','346-553-1442','V04GrI',838,'373 Express Terrace','Kingston','666021',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (18,'ugibbyh@about.com','663-930-4213','lcE82Pf',4,'71861 Daystar Trail','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (19,'fwrothami@google.com','827-772-4842','FiJovTwhgqe',6,'9 Mayer Junction','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (20,'ccaldairouj@google.com.au','826-944-6130','hVgDv4zNegB',12360,'56433 Ronald Regan Parkway','Kingston','9201',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (21,'rferrask@indiatimes.com','885-799-0550','2953n9l8',99393,'8245 Northridge Avenue','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (22,'pfrankiewiczl@bandcamp.com','348-824-2927','5oeGUyMP',2862,'494 Dawn Avenue','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (23,'lmacuram@4shared.com','704-524-5614','KQi6FzIn',3904,'4 Oriole Crossing','Kingston','2785-025',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (24,'pbagniukn@sciencedirect.com','927-235-9661','zffBhxT',493,'487 Red Cloud Trail','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (25,'nsarcho@merriam-webster.com','466-573-6485','ej8sTmDDYsM',6,'7 Longview Pass','Kingston','84104 CEDEX',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (26,'pbreckinp@flavors.me','284-219-7295','6I2Q3rC0uRFJ',0,'3467 Ruskin Avenue','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (27,'sthorowgoodq@g.co','977-787-4860','iYeHXuQz',2,'4 Sunbrook Circle','Kingston','1216',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (28,'ablofieldr@nba.com','550-239-3649','XZ0LABu0LJ',47,'8 Fulton Place','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (29,'ggarries@msn.com','473-931-1489','hMB5camTA',457,'374 Carberry Hill','Kingston','91275',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (30,'fcastagnet@spotify.com','106-334-2284','6pvcRwEeVaSo',26204,'71835 Homewood Drive','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (31,'bcrambu@engadget.com','570-647-7128','JivEN4l8kX',97343,'6 Dexter Circle','Kingston','3310',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (32,'fheamsv@pinterest.com','299-484-8193','mdWj8Mq',7532,'590 Annamark Terrace','Kingston','76124 CEDEX',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (33,'lcoomesw@utexas.edu','870-226-0015','it69fFomsFY',47,'41932 Golf Course Parkway','Kingston','3109',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (34,'vdefilippox@friendfeed.com','586-413-1655','FXjrEj0PnK',89,'515 Bonner Drive','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (35,'gvaggsy@slashdot.org','799-137-7178','bLA4tQJr9RU',27,'30710 Prairieview Hill','Kingston','2690-147',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (36,'nkettelz@boston.com','186-749-2727','mWv0Ow6tvz',816,'1 Norway Maple Parkway','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (37,'nmckiddin10@businesswire.com','816-374-0454','5Kjcu2g',3,'94466 International Avenue','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (38,'ofoakes11@wix.com','473-533-4000','XZIFDpJJs',1,'4501 Toban Street','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (39,'acherm12@mozilla.org','614-398-1494','czm33avdIB',8,'7 Twin Pines Point','Kingston','29027',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (40,'athomasset13@netlog.com','447-311-3305','6V9dAg',0,'91921 Mosinee Lane','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (41,'rshwenn14@prweb.com','749-545-5489','5AZIUxE45M',87,'38 Moose Alley','Kingston','277',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (42,'acoulton15@domainmarket.com','742-451-7521','cagNnH7',5,'7820 Almo Street','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (43,'aphidgin16@issuu.com','391-698-7923','Wx80vrkhvQw',66,'54 Grayhawk Circle','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (44,'glyle17@reddit.com','397-347-0953','A4JYfrYj',95529,'4 Lyons Plaza','Kingston','581 86',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (45,'ytompkin18@oakley.com','461-117-7471','88IwebhpcasP',68415,'19 Westerfield Avenue','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (46,'relcoat19@sakura.ne.jp','806-206-5535','SQiePYKDgB',1,'32657 Quincy Center','Kingston','291 81',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (47,'hdollin1a@scientificamerican.com','970-876-3867','A8NNzUCa',9415,'6 Tennyson Street','Kingston','646620',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (48,'asandercock1b@deviantart.com','760-547-2763','MzhrNjN0R2',6253,'881 Kropf Road','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (49,'rsemaine1c@icio.us','723-303-8035','avoQE2b',44,'01832 Comanche Pass','Kingston',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO user_sec_info(user_id,email,phone_no,password,healthcard_no,street_address,city,postal_code,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (50,'rrawnsley1d@cdc.gov','964-615-2678','8Ugdd2yB',7186,'8 Russell Street','Kingston','106 32',NULL,NULL,NULL,NULL,NULL,NULL);


-- SAMPLE PHARM INFO -----------------------------------------------------------------------------------
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Alternative Pharmacy','lstoltz0@dedecms.com','113-484-2912','42678 Carberry Pass','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Ningbo Heyi Daily Chemical Products Co., Ltd.','nwooddisse1@npr.org','425-459-2231','62 Russell Hill','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Laser Pharmaceuticals, LLC','ewinear2@dailymotion.com','919-940-5099','04 Saint Paul Road','Kingston','184653',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('MallyGirl, LLC','nphilpott3@facebook.com','442-880-4838','965 Luster Avenue','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Morton Grove Pharmaceuticals, Inc.','jmacneely4@state.gov','862-764-7392','0 Cherokee Center','Kingston','7505',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('REMEDYREPACK INC.','rcowup5@reference.com','969-375-3263','27417 Hazelcrest Hill','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Uriel Pharmacy Inc.','jvondrak6@blogspot.com','777-292-5822','98466 Barby Center','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Space Brands Limited','wleggat7@biglobe.ne.jp','914-160-7725','08232 Ridgeway Lane','Kingston','62070 CEDEX 9',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('A&Z Pharmaceutical, Inc.','rkeneforde8@cafepress.com','142-173-5071','809 Hazelcrest Place','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Medimetriks Pharmaceuticals','mszymanowski9@example.com','953-959-3692','02 Alpine Lane','Kingston','265 40',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('REMEDYREPACK INC.','bsladea@google.co.jp','857-952-9676','22 Fordem Parkway','Kingston','10902',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Sanofi-Aventis U.S. LLC','mlarkingb@reverbnation.com','136-439-0067','8 Truax Road','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('DIRECT RX','cemberyc@list-manage.com','966-685-3092','16 Center Center','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('The Man Can, LLC','xpeersd@redcross.org','160-407-1107','35259 Drewry Point','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Vi-Jon','nrumbellowe@multiply.com','342-978-5836','58399 Anniversary Street','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Procter & Gamble Manufacturing Company','bnowickf@chronoengine.com','280-375-0854','129 Clove Pass','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Paramesh Banerji Life Sciences LLC','rrawsthorneg@examiner.com','705-921-6899','3 Jana Park','Kingston','9601',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('REMEDYREPACK INC.','kjanecekh@dell.com','365-333-7701','3863 School Terrace','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Chang Hwa Dang Co., Ltd.','mthrasheri@irs.gov','970-473-7071','9 Roxbury Terrace','Kingston','3109',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Ranbaxy Pharmaceuticals Inc.','kashburnerj@bandcamp.com','480-166-6084','07013 Northview Court','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('REMEDYREPACK INC.','kduiguidk@eventbrite.com','901-628-5124','7 Milwaukee Lane','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('SJ Creations, Inc.','svonwelldunl@diigo.com','732-728-9212','37 Mccormick Point','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Eon Labs, Inc.','dseifertm@ucoz.ru','266-501-7348','962 Londonderry Pass','Kingston','391237',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('REMEDYREPACK INC.','lpitkinsn@goodreads.com','531-537-1718','975 Dottie Hill','Kingston','30902',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Lake Erie Medical DBA Quality Care Products LLC','mwhitfordo@technorati.com','180-522-0464','40 Browning Trail','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Eon Labs, Inc.','fspunerp@furl.net','623-385-9923','97984 Sachs Avenue','Kingston','331 85',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('A-S Medication Solutions LLC','groscherq@google.nl','516-985-0950','09 Montana Circle','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Publix Super Markets Inc','tmorsomr@dell.com','331-841-6661','0808 Beilfuss Road','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Rite Aid Corporation','bblatherwicks@gov.uk','284-147-0017','62705 Sommers Center','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Energetix Corp','arapaportt@theatlantic.com','246-855-3381','8 Mcguire Park','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Meijer Distribution, Inc.','bsoaperu@devhub.com','339-939-6880','90 Cordelia Point','Kingston','4950-208',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Actavis Pharma, Inc.','ufawcettv@comcast.net','502-728-4872','119 Montana Alley','Kingston','386150',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('AuroMedics Pharma LLC','rmenezesw@amazon.de','725-428-8388','78807 Stephen Parkway','Kingston','2610-006',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Sato Pharmaceutical Co., Ltd.','bjewsonx@ed.gov','821-909-9452','9265 Golf View Court','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Uriel Pharmacy Inc.','eebunoluway@squidoo.com','955-423-7693','1805 Anderson Crossing','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Topco Associates LLC','jhurdmanz@friendfeed.com','133-256-8468','076 Sage Drive','Kingston','95-045',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('REMEDYREPACK INC.','ptingley10@360.cn','966-693-4806','973 Glendale Park','Kingston','386245',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Bayer HealthCare Pharmaceuticals Inc.','gesbrook11@unc.edu','597-424-1575','855 Lunder Place','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Aidarex Pharmaceuticals LLC','dgoseling12@yolasite.com','372-791-4614','0 Summit Parkway','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Aurolife Pharma LLC','ayandell13@miitbeian.gov.cn','826-919-1734','3703 Browning Circle','Kingston','49900-000',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Natural Health Supply','rburchnall14@spiegel.de','734-975-3244','59541 Barby Point','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Sunovion','cargo15@desdev.cn','574-503-8449','3 Mendota Lane','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Taro Pharmaceuticals U.S.A., Inc.','vkeeling16@mozilla.com','121-531-6856','28 Holy Cross Center','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Forest Laboratories, Inc.','psellers17@economist.com','225-425-4052','5 Village Junction','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('SHANGHAI YINJING MEDICAL SUPPLIES CO., LTD.','ahucklesby18@springer.com','808-405-0442','7 Bashford Center','Kingston','MD-4734',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Budpak Inc.','cweildish19@nba.com','749-857-3602','6 West Drive','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Stephen L. LaFrance Pharmacy, Inc.','bdominik1a@google.pl','183-882-4672','5 Northland Park','Kingston','699',NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('Apotheca Company','cdavydochkin1b@stumbleupon.com','692-120-3762','2256 Clarendon Parkway','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('E. FOUGERA & CO','smccarlie1c@fastcompany.com','420-540-6408','02795 Riverside Crossing','Kingston',NULL,NULL,NULL,NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code,precs_active,precs_history,patients) VALUES ('LABORATORIOS DE COSMETICA SCIENTIFICA ATACHE SA','rhaye1d@tamu.edu','288-893-8190','7 Little Fleur Avenue','Kingston','6341',NULL,NULL,NULL);



-- SAMPLE PHARM SEC INFO -----------------------------------------------------------------------------------
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (1,'lstoltz0@dedecms.com','113-484-2912','XsaN9SG25zZQ',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (2,'nwooddisse1@npr.org','425-459-2231','RsXhxylrm',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (3,'ewinear2@dailymotion.com','919-940-5099','MxKByHaJf',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (4,'nphilpott3@facebook.com','442-880-4838','2DSYr8N',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (5,'jmacneely4@state.gov','862-764-7392','kwwl1c',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (6,'rcowup5@reference.com','969-375-3263','ZrdMi7D4JU',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (7,'jvondrak6@blogspot.com','777-292-5822','qb3m0qBNQgoW',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (8,'wleggat7@biglobe.ne.jp','914-160-7725','3CeYeKp',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (9,'rkeneforde8@cafepress.com','142-173-5071','BiIIxXsZZ',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (10,'mszymanowski9@example.com','953-959-3692','lEPWdz6k5',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (11,'bsladea@google.co.jp','857-952-9676','nVYn0e',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (12,'mlarkingb@reverbnation.com','136-439-0067','YgAyuBTm',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (13,'cemberyc@list-manage.com','966-685-3092','0e8RApqgCFIv',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (14,'xpeersd@redcross.org','160-407-1107','hwzfossI',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (15,'nrumbellowe@multiply.com','342-978-5836','NUVBSAxkS0',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (16,'bnowickf@chronoengine.com','280-375-0854','LcSeBMy3xhat',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (17,'rrawsthorneg@examiner.com','705-921-6899','mUVRkQ',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (18,'kjanecekh@dell.com','365-333-7701','pUHmv3s8XVJ',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (19,'mthrasheri@irs.gov','970-473-7071','kuSFwR',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (20,'kashburnerj@bandcamp.com','480-166-6084','M5FBawxKo',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (21,'kduiguidk@eventbrite.com','901-628-5124','8uKHbe',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (22,'svonwelldunl@diigo.com','732-728-9212','p15Y1XNqAxj',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (23,'dseifertm@ucoz.ru','266-501-7348','LC8hebjXgSZ',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (24,'lpitkinsn@goodreads.com','531-537-1718','X80fbIFKcBMn',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (25,'mwhitfordo@technorati.com','180-522-0464','msago857p',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (26,'fspunerp@furl.net','623-385-9923','xWrSttK',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (27,'groscherq@google.nl','516-985-0950','aow0vuabE92',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (28,'tmorsomr@dell.com','331-841-6661','5Fhxbgj',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (29,'bblatherwicks@gov.uk','284-147-0017','2CvZf4Lh7',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (30,'arapaportt@theatlantic.com','246-855-3381','O3IH0QyE32',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (31,'bsoaperu@devhub.com','339-939-6880','oFEpUr',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (32,'ufawcettv@comcast.net','502-728-4872','wUzZBeHG40C',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (33,'rmenezesw@amazon.de','725-428-8388','HLWiQQrNTd',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (34,'bjewsonx@ed.gov','821-909-9452','KFCuG0Z3CI',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (35,'eebunoluway@squidoo.com','955-423-7693','G3XC4KCW',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (36,'jhurdmanz@friendfeed.com','133-256-8468','ujSmhiCPrw0',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (37,'ptingley10@360.cn','966-693-4806','n8BYZl',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (38,'gesbrook11@unc.edu','597-424-1575','OmmtVy',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (39,'dgoseling12@yolasite.com','372-791-4614','kacqInDVTRBC',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (40,'ayandell13@miitbeian.gov.cn','826-919-1734','hdSRJTB5x',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (41,'rburchnall14@spiegel.de','734-975-3244','PO8SMiRxJ',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (42,'cargo15@desdev.cn','574-503-8449','8ZU9caLCcd7j',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (43,'vkeeling16@mozilla.com','121-531-6856','xk6lyS',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (44,'psellers17@economist.com','225-425-4052','8LCL3giKan7',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (45,'ahucklesby18@springer.com','808-405-0442','LT5wCn7kxxb',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (46,'cweildish19@nba.com','749-857-3602','NosOiM',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (47,'bdominik1a@google.pl','183-882-4672','Kgow2qpcWK',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (48,'cdavydochkin1b@stumbleupon.com','692-120-3762','m49Ow6IuuZw',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (49,'smccarlie1c@fastcompany.com','420-540-6408','XImwGI',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO pharm_sec_info(pharm_id,email,phone_no,password,sec_quest_1,sec_ans_1,sec_quest_2,sec_ans_2,sec_quest_3,sec_ans_3) VALUES (50,'rhaye1d@tamu.edu','288-893-8190','yWxGtAz',NULL,NULL,NULL,NULL,NULL,NULL);

