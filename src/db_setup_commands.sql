-- if you have postgres installed
-- simply run \i <file path for this file>
-- so if it was in your downloads
-- \i downloads/db_setup_commands.sql
CREATE DATABASE meditrack_db;

CREATE TABLE prec_info(
	rx VARCHAR(10) PRIMARY KEY NOT NULL,
	med_name VARCHAR(25) NULL,
	med_strength VARCHAR(25) NULL,
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
	street_address VARCHAR(75) NULL,
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
	street_address VARCHAR(100) NULL,
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

-- STATUS QUESTIONS------------------------------------------------------------------------------------------
INSERT INTO status_steps (status_msg) VALUES ('Received');
INSERT INTO status_steps (status_msg) VALUES ('Logged');
INSERT INTO status_steps (status_msg) VALUES ('Pharmacist Verification');
INSERT INTO status_steps (status_msg) VALUES ('Packaging');
INSERT INTO status_steps (status_msg) VALUES ('Ready For Pick Up');
INSERT INTO status_steps (status_msg) VALUES ('Received');
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
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (1,'Toddie','Petters','tpetters0@walmart.com','827-326-9651',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (2,'Lamar','Lamping','llamping1@privacy.gov.au','192-293-0350',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (3,'Addia','Zellick','azellick2@omniture.com','735-232-5276',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (4,'Frederigo','Peperell','fpeperell3@skyrock.com','650-973-6340',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (5,'Millie','Baike','mbaike4@fotki.com','169-172-4022',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (6,'Lyndsey','Rillstone','lrillstone5@booking.com','544-556-7146',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (7,'Margi','Westphal','mwestphal6@typepad.com','931-200-3729',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (8,'Finn','Leathart','fleathart7@ca.gov','538-304-4146',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (9,'Clim','McCabe','cmccabe8@chicagotribune.com','741-472-5430',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (10,'Janean','Drever','jdrever9@marketwatch.com','407-633-6486',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (11,'Spike','Ogdahl','sogdahla@youku.com','165-937-9782',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (12,'Eachelle','Whitmell','ewhitmellb@indiegogo.com','351-568-6508',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (13,'Law','Locket','llocketc@soup.io','527-701-3275',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (14,'Jervis','Castagnier','jcastagnierd@wikipedia.org','786-564-9169',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (15,'Marshal','Champneys','mchampneyse@washington.edu','626-722-8119',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (16,'Nichole','Hudless','nhudlessf@booking.com','899-620-7385',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (17,'Riva','Scottrell','rscottrellg@telegraph.co.uk','346-553-1442',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (18,'Ulrikaumeko','Gibby','ugibbyh@about.com','663-930-4213',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (19,'Flemming','Wrotham','fwrothami@google.com','827-772-4842',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (20,'Cecelia','Caldairou','ccaldairouj@google.com.au','826-944-6130',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (21,'Rosmunda','Ferras','rferrask@indiatimes.com','885-799-0550',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (22,'Parke','Frankiewicz','pfrankiewiczl@bandcamp.com','348-824-2927',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (23,'Lindsey','Macura','lmacuram@4shared.com','704-524-5614',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (24,'Pierette','Bagniuk','pbagniukn@sciencedirect.com','927-235-9661',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (25,'Nanci','Sarch','nsarcho@merriam-webster.com','466-573-6485',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (26,'Perrine','Breckin','pbreckinp@flavors.me','284-219-7295',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (27,'Stevy','Thorowgood','sthorowgoodq@g.co','977-787-4860',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (28,'Annora','Blofield','ablofieldr@nba.com','550-239-3649',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (29,'Gabriela','Garrie','ggarries@msn.com','473-931-1489',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (30,'Fleming','Castagne','fcastagnet@spotify.com','106-334-2284',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (31,'Byrle','Cramb','bcrambu@engadget.com','570-647-7128',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (32,'Francine','Heams','fheamsv@pinterest.com','299-484-8193',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (33,'Lidia','Coomes','lcoomesw@utexas.edu','870-226-0015',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (34,'Vi','De Filippo','vdefilippox@friendfeed.com','586-413-1655',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (35,'Gwen','Vaggs','gvaggsy@slashdot.org','799-137-7178',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (36,'Nerita','Kettel','nkettelz@boston.com','186-749-2727',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (37,'Nico','McKiddin','nmckiddin10@businesswire.com','816-374-0454',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (38,'Osmond','Foakes','ofoakes11@wix.com','473-533-4000',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (39,'Ashlee','Cherm','acherm12@mozilla.org','614-398-1494',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (40,'Arch','Thomasset','athomasset13@netlog.com','447-311-3305',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (41,'Rice','Shwenn','rshwenn14@prweb.com','749-545-5489',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (42,'Asher','Coulton','acoulton15@domainmarket.com','742-451-7521',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (43,'Alic','Phidgin','aphidgin16@issuu.com','391-698-7923',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (44,'Garrard','Lyle','glyle17@reddit.com','397-347-0953',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (45,'Ynez','Tompkin','ytompkin18@oakley.com','461-117-7471',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (46,'Roth','Elcoat','relcoat19@sakura.ne.jp','806-206-5535',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (47,'Helenka','Dollin','hdollin1a@scientificamerican.com','970-876-3867',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (48,'Alfonse','Sandercock','asandercock1b@deviantart.com','760-547-2763',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (49,'Rogers','Semaine','rsemaine1c@icio.us','723-303-8035',NULL,NULL);
INSERT INTO user_info(user_id,first_name,last_name,email,phone_no,precs_active,precs_history) VALUES (50,'Rem','Rawnsley','rrawnsley1d@cdc.gov','964-615-2678',NULL,NULL);
-- SAMPLE USER SEC INFO -----------------------------------------------------------------------------------
-- SAMPLE PHARM INFO -----------------------------------------------------------------------------------
-- SAMPLE PHARM SEC INFO -----------------------------------------------------------------------------------
