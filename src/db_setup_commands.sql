-- if you have postgres installed
-- simply run \i <file path for this file>
-- so if it was in your downloads
-- \i downloads/db_setup_commands.sql
CREATE DATABASE meditrack_db;

\c meditrack_db

CREATE TABLE prec_info(
	rx VARCHAR(10) PRIMARY KEY NOT NULL,
	med_name VARCHAR(150) NULL,
	med_strength VARCHAR(12) NULL,
	user_id BIGINT NOT NULL,
	pharm_id BIGINT NOT NULL,
	max_refills BIGINT NULL,
	cur_refills BIGINT NULL,
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
	phone_no VARCHAR(15) NULL
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
	postal_code VARCHAR(20) NULL
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
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Toddie','Petters','tpetters0@walmart.com','827-326-9651');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Lamar','Lamping','llamping1@privacy.gov.au','192-293-0350');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Addia','Zellick','azellick2@omniture.com','735-232-5276');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Frederigo','Peperell','fpeperell3@skyrock.com','650-973-6340');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Millie','Baike','mbaike4@fotki.com','169-172-4022');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Lyndsey','Rillstone','lrillstone5@booking.com','544-556-7146');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Margi','Westphal','mwestphal6@typepad.com','931-200-3729');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Finn','Leathart','fleathart7@ca.gov','538-304-4146');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Clim','McCabe','cmccabe8@chicagotribune.com','741-472-5430');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Janean','Drever','jdrever9@marketwatch.com','407-633-6486');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Spike','Ogdahl','sogdahla@youku.com','165-937-9782');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Eachelle','Whitmell','ewhitmellb@indiegogo.com','351-568-6508');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Law','Locket','llocketc@soup.io','527-701-3275');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Jervis','Castagnier','jcastagnierd@wikipedia.org','786-564-9169');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Marshal','Champneys','mchampneyse@washington.edu','626-722-8119');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Nichole','Hudless','nhudlessf@booking.com','899-620-7385');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Riva','Scottrell','rscottrellg@telegraph.co.uk','346-553-1442');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Ulrikaumeko','Gibby','ugibbyh@about.com','663-930-4213');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Flemming','Wrotham','fwrothami@google.com','827-772-4842');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Cecelia','Caldairou','ccaldairouj@google.com.au','826-944-6130');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Rosmunda','Ferras','rferrask@indiatimes.com','885-799-0550');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Parke','Frankiewicz','pfrankiewiczl@bandcamp.com','348-824-2927');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Lindsey','Macura','lmacuram@4shared.com','704-524-5614');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Pierette','Bagniuk','pbagniukn@sciencedirect.com','927-235-9661');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Nanci','Sarch','nsarcho@merriam-webster.com','466-573-6485');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Perrine','Breckin','pbreckinp@flavors.me','284-219-7295');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Stevy','Thorowgood','sthorowgoodq@g.co','977-787-4860');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Annora','Blofield','ablofieldr@nba.com','550-239-3649');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Gabriela','Garrie','ggarries@msn.com','473-931-1489');
INSERT INTO user_info(first_name,last_name,email,phone_no) VALUES ('Fleming','Castagne','fcastagnet@spotify.com','106-334-2284');




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




-- SAMPLE PHARM INFO -----------------------------------------------------------------------------------
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('Alternative Pharmacy','lstoltz0@dedecms.com','113-484-2912','42678 Carberry Pass','Kingston',NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('Ningbo Heyi Daily Chemical Products Co., Ltd.','nwooddisse1@npr.org','425-459-2231','62 Russell Hill','Kingston',NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('Laser Pharmaceuticals, LLC','ewinear2@dailymotion.com','919-940-5099','04 Saint Paul Road','Kingston','184653');
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('MallyGirl, LLC','nphilpott3@facebook.com','442-880-4838','965 Luster Avenue','Kingston',NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('Morton Grove Pharmaceuticals, Inc.','jmacneely4@state.gov','862-764-7392','0 Cherokee Center','Kingston','7505');
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('REMEDYREPACK INC.','rcowup5@reference.com','969-375-3263','27417 Hazelcrest Hill','Kingston',NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('Uriel Pharmacy Inc.','jvondrak6@blogspot.com','777-292-5822','98466 Barby Center','Kingston',NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('Space Brands Limited','wleggat7@biglobe.ne.jp','914-160-7725','08232 Ridgeway Lane','Kingston','62070 CEDEX 9');
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('A&Z Pharmaceutical, Inc.','rkeneforde8@cafepress.com','142-173-5071','809 Hazelcrest Place','Kingston',NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('Medimetriks Pharmaceuticals','mszymanowski9@example.com','953-959-3692','02 Alpine Lane','Kingston','265 40');
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('REMEDYREPACK INC.','bsladea@google.co.jp','857-952-9676','22 Fordem Parkway','Kingston','10902');
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('Sanofi-Aventis U.S. LLC','mlarkingb@reverbnation.com','136-439-0067','8 Truax Road','Kingston',NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('DIRECT RX','cemberyc@list-manage.com','966-685-3092','16 Center Center','Kingston',NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('The Man Can, LLC','xpeersd@redcross.org','160-407-1107','35259 Drewry Point','Kingston',NULL);
INSERT INTO pharm_info(name,email,phone_no,street_address,city,postal_code) VALUES ('Vi-Jon','nrumbellowe@multiply.com','342-978-5836','58399 Anniversary Street','Kingston',NULL);




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


-- SAMPLE PREC INFO -------------------------------------------------------------------------------------------------------------
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7527686', 'Night Time Cherry', 'Strong', 19, 8, 3, 0, 1, null, 0, '2020-10-16 02:57:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1424863', 'TAMSULOSIN HYDROCHLORIDE', '', 10, 9, 1, 0, 1, null, 0, '2020-08-28 01:33:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1286602', 'Furosemide', 'Medium', 1, 11, 1, 0, 1, null, 0, '2020-03-30 10:16:56');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3664652', 'Nateglinide', '', 26, 1, 4, 0, 1, null, 0, '2021-03-08 16:02:53');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2874707', 'CEFOTAXIME', '', 3, 5, 5, 0, 1, null, 0, '2020-04-08 13:13:33');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6981399', 'Levothyroxine sodium', 'Strong', 13, 14, 2, 0, 1, null, 0, '2020-08-22 03:54:23');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6370494', 'Panatuss PED', 'Strong', 26, 1, 3, 0, 1, null, 0, '2020-10-02 11:47:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7690973', 'IBUPROFEN', 'Medium', 2, 11, 1, 0, 1, null, 0, '2020-06-19 08:04:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3705092', 'HEALTHMART NICOTINE TRANSDERMAL SYSTEM', 'Strong', 4, 5, 3, 0, 1, null, 0, '2020-07-11 10:11:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4307186', 'Betaseron', '', 30, 11, 4, 0, 1, null, 0, '2020-06-13 20:08:24');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5937715', 'Complete Menstrual Relief', '', 6, 15, 2, 0, 1, null, 0, '2021-03-02 06:32:31');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0018122', 'pain relief', 'Strong', 7, 8, 4, 0, 1, null, 0, '2021-01-02 23:58:11');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5279675', 'Moisturizing Sunblock', 'Strong', 23, 1, 2, 0, 1, null, 0, '2020-11-01 10:46:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9412368', 'Dr G deWrinkle FORTIFIER by EGF', 'Mild', 10, 1, 4, 0, 1, null, 0, '2021-01-30 11:56:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6771715', 'FUROSEMIDE', '', 18, 14, 1, 0, 1, null, 0, '2020-08-11 18:03:20');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7610333', 'Citalopram', 'Mild', 17, 8, 1, 0, 1, null, 0, '2020-06-27 12:38:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9984402', 'Adderall', 'Medium', 1, 11, 4, 0, 1, null, 0, '2020-04-03 11:17:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1586830', 'Naproxen', 'Medium', 30, 10, 2, 0, 1, null, 0, '2020-12-04 06:13:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1062804', 'Cefoxitin', '', 1, 5, 4, 0, 1, null, 0, '2020-06-15 09:07:41');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6477533', 'Fluocinonide', 'Strong', 19, 8, 2, 0, 1, null, 0, '2020-04-12 20:07:59');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7791021', 'Viscum Salicis', 'Mild', 24, 8, 4, 0, 1, null, 0, '2020-04-06 19:07:50');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4660587', 'Blossom HP 3', 'Mild', 12, 11, 3, 0, 1, null, 0, '2021-01-24 21:36:28');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8363403', 'Lisinopril', '', 21, 7, 4, 0, 1, null, 0, '2020-04-07 13:55:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2250006', 'HGH Vitality', 'Medium', 23, 10, 5, 0, 1, null, 0, '2021-01-18 02:29:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6204396', 'Moisturizing Face Screen Light Tint SPF 30', 'Strong', 10, 13, 2, 0, 1, null, 0, '2020-09-26 14:32:51');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3417611', 'CATFISH', '', 10, 2, 4, 0, 1, null, 0, '2020-05-06 06:06:21');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3563884', 'Actos', 'Mild', 25, 15, 4, 0, 1, null, 0, '2021-03-01 15:37:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0084626', 'Metformin Hydrochloride', 'Medium', 6, 7, 4, 0, 1, null, 0, '2021-03-08 06:16:25');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6034734', 'DAY WEAR ADVANCED MULTI-PROTECTION ANTI-OXIDANT AND UV DEFENSE', '', 1, 1, 5, 0, 1, null, 0, '2020-07-06 21:51:19');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0409418', 'Lemon and Olive Oil Antibacterial Foaming Hand Wash', '', 19, 5, 4, 0, 1, null, 0, '2020-10-13 18:52:59');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4711664', 'OPANA', '', 6, 7, 4, 0, 1, null, 0, '2020-11-19 10:31:27');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5899186', 'GLIPIZIDE', '', 12, 14, 2, 0, 1, null, 0, '2020-08-22 08:16:26');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1925909', 'Burr Oak', 'Strong', 16, 7, 4, 0, 1, null, 0, '2020-10-05 03:14:31');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9611162', 'ATORVASTATIN CALCIUM', 'Medium', 19, 11, 5, 0, 1, null, 0, '2020-10-18 10:32:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0576430', 'Cyclobenzaprine Hydrochloride', 'Medium', 25, 14, 1, 0, 1, null, 0, '2020-06-25 15:59:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9740699', 'Minocycline Hydrochloride', 'Mild', 11, 14, 4, 0, 1, null, 0, '2020-07-09 16:24:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9930595', 'Standardized Grass Pollen, Bluegrass, Kentucky (June)', 'Strong', 29, 13, 2, 0, 1, null, 0, '2020-08-31 16:59:15');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2616454', 'Hydroxyzine Hydrochloride', 'Strong', 21, 12, 4, 0, 1, null, 0, '2020-07-19 17:30:43');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5585550', 'Fluconazole', 'Strong', 11, 12, 2, 0, 1, null, 0, '2021-03-02 02:50:57');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6102838', 'Ceramide Lift And Firm Makeup Broad Spectrum Sunscreen SPF 15 Cream', 'Mild', 15, 5, 3, 0, 1, null, 0, '2021-03-04 13:51:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1352309', 'Elta MD UV Clear', 'Medium', 8, 2, 4, 0, 1, null, 0, '2020-10-02 21:00:05');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7398803', 'Famotidine', '', 5, 5, 4, 0, 1, null, 0, '2020-07-27 11:35:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4857213', 'METHADOSE', 'Strong', 3, 8, 5, 0, 1, null, 0, '2021-02-01 06:15:37');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3191056', 'Potassium Chloride', 'Strong', 26, 10, 1, 0, 1, null, 0, '2020-12-03 08:32:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4904169', 'Sinus and Cold D', 'Strong', 27, 5, 3, 0, 1, null, 0, '2020-11-07 17:53:59');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4406905', 'UV LOCK FLOWER DAILY POWERFUL SUN', 'Mild', 26, 13, 1, 0, 1, null, 0, '2020-09-25 14:04:05');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9574255', 'Walgreens', '', 24, 13, 2, 0, 1, null, 0, '2020-12-10 18:25:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8478432', 'Lady Speed Stick', 'Mild', 13, 11, 1, 0, 1, null, 0, '2020-04-06 03:50:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2673445', 'Leader Extra Moisturizing Nasal', '', 9, 10, 4, 0, 1, null, 0, '2020-04-27 11:04:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7293640', 'Leader Nasal', 'Mild', 26, 13, 3, 0, 1, null, 0, '2021-03-15 15:39:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7182179', 'Equate Sore Throat', 'Mild', 11, 7, 5, 0, 1, null, 0, '2020-05-15 11:28:53');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9548288', 'up and up cold flu relief', 'Medium', 10, 6, 5, 0, 1, null, 0, '2020-08-11 04:40:04');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8973268', 'IGF-1 Endurance Plus', 'Medium', 23, 9, 3, 0, 1, null, 0, '2020-06-08 03:00:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1064747', 'ZITHROMAX', 'Mild', 19, 9, 1, 0, 1, null, 0, '2020-12-26 10:50:08');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1306660', 'Fluoride', 'Strong', 13, 1, 2, 0, 1, null, 0, '2020-05-19 04:01:46');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7228729', 'OSCIMIN', 'Strong', 16, 14, 1, 0, 1, null, 0, '2020-05-13 05:19:12');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5729683', 'Phenylalanine', '', 16, 6, 5, 0, 1, null, 0, '2021-03-05 00:06:44');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9531285', 'Clear Eyes Triple Action', '', 19, 1, 5, 0, 1, null, 0, '2020-07-31 03:14:29');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0634952', 'SHISEIDO FUTURE SOLUTION LX TOTAL RADIANCE FOUNDATION', 'Strong', 28, 11, 5, 0, 1, null, 0, '2020-08-11 09:30:56');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4322097', 'Irbesartan', 'Strong', 4, 15, 5, 0, 1, null, 0, '2021-01-27 00:43:23');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6798212', 'Colchicine', 'Strong', 11, 8, 5, 0, 1, null, 0, '2021-03-04 10:28:41');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0940418', 'Broad Spectrum SPF 30 Up The Anti', 'Mild', 17, 1, 4, 0, 1, null, 0, '2021-02-27 19:52:11');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4549599', 'SENSAI CELLULAR PERFORMANCE POWDER FOUNDATION', 'Mild', 7, 10, 3, 0, 1, null, 0, '2021-03-17 19:35:03');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7922066', 'Olive Pollen', 'Mild', 5, 3, 4, 0, 1, null, 0, '2020-09-29 12:49:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1394691', 'Caraway Seed', 'Medium', 3, 11, 3, 0, 1, null, 0, '2020-08-30 01:14:02');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9683763', 'Tri-Vitamin with Fluoride', '', 5, 9, 2, 0, 1, null, 0, '2020-05-05 13:50:21');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0390991', 'RevitaDERM Wound Care', 'Mild', 21, 8, 4, 0, 1, null, 0, '2021-01-14 12:55:34');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9957678', 'Inspired by Color', 'Medium', 29, 5, 2, 0, 1, null, 0, '2020-12-14 13:50:44');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5333939', 'Almacone', 'Strong', 20, 9, 3, 0, 1, null, 0, '2021-03-12 17:23:05');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9066526', 'Muscle Ice', 'Medium', 6, 1, 2, 0, 1, null, 0, '2020-09-29 13:29:05');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6318071', 'BIOFREEZE', '', 25, 12, 2, 0, 1, null, 0, '2020-11-09 03:22:03');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9643405', 'Isoniazid', 'Mild', 6, 4, 4, 0, 1, null, 0, '2020-08-26 06:16:09');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8673039', 'AMOXICILLIN', 'Medium', 2, 5, 2, 0, 1, null, 0, '2020-06-18 12:40:24');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5490432', 'Ranitidine', 'Medium', 19, 7, 1, 0, 1, null, 0, '2021-01-14 20:00:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7296648', 'Buspirone Hydrochloride', '', 20, 3, 4, 0, 1, null, 0, '2021-01-31 02:41:51');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6618754', 'CARISOPRODOL', '', 14, 6, 2, 0, 1, null, 0, '2021-02-14 02:14:23');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2754935', 'Amoxicillin', '', 24, 11, 2, 0, 1, null, 0, '2020-04-05 19:06:05');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1751938', 'Couch Quack Grass', 'Strong', 8, 12, 5, 0, 1, null, 0, '2020-06-09 14:49:24');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2975158', 'Naproxen Sodium', '', 23, 11, 1, 0, 1, null, 0, '2020-08-18 16:39:26');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2892372', 'Prednisone', 'Mild', 7, 3, 1, 0, 1, null, 0, '2020-10-19 12:52:41');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6984023', 'Aricept', 'Medium', 27, 11, 1, 0, 1, null, 0, '2021-02-03 00:02:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7816758', 'Diclofenac Sodium', 'Strong', 4, 7, 5, 0, 1, null, 0, '2021-02-23 03:43:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6032097', 'Oyster Shell Calcium with Vitamin D', '', 20, 1, 1, 0, 1, null, 0, '2020-10-24 22:17:08');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4319950', 'Thiamine Hydrochloride', 'Medium', 26, 15, 4, 0, 1, null, 0, '2020-06-16 20:04:33');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1087572', 'Hydrochlorothiazide', 'Mild', 1, 6, 4, 0, 1, null, 0, '2021-02-26 11:45:02');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0930093', 'Heparin Sodium and Sodium Chloride', 'Strong', 7, 9, 4, 0, 1, null, 0, '2021-03-26 02:57:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6585018', 'cool heat', '', 15, 8, 4, 0, 1, null, 0, '2021-03-02 19:46:19');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8955449', 'Alcohol Prep Pad', 'Mild', 13, 5, 2, 0, 1, null, 0, '2020-09-06 02:50:13');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0101057', 'HUMCO Merthiolate', 'Strong', 16, 13, 1, 0, 1, null, 0, '2021-03-26 06:05:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4552418', 'Octreotide acetate', 'Mild', 16, 15, 5, 0, 1, null, 0, '2021-02-23 13:21:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3173369', 'Retaine CMC Lubricant Eye Drops', 'Mild', 27, 5, 5, 0, 1, null, 0, '2020-05-21 03:05:38');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1194321', 'FEMCON Fe', 'Mild', 22, 7, 4, 0, 1, null, 0, '2020-12-12 10:48:26');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1652631', 'Trospium Chloride', 'Mild', 21, 8, 4, 0, 1, null, 0, '2020-08-28 10:40:27');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1216503', 'Morphine Sulfate', 'Strong', 25, 14, 1, 0, 1, null, 0, '2021-03-17 20:24:13');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8629299', 'Portia', 'Strong', 25, 1, 4, 0, 1, null, 0, '2020-06-27 18:52:03');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6474415', 'Molds, Rusts and Smuts, Alternaria tenuis', 'Strong', 20, 6, 4, 0, 1, null, 0, '2020-09-11 00:57:37');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8900956', 'Anti-Bacterial Hand', 'Medium', 21, 4, 2, 0, 1, null, 0, '2020-11-23 09:48:53');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7104324', 'Travoprost Ophthalmic Solution 0.004%', 'Medium', 12, 15, 5, 0, 1, null, 0, '2020-06-03 01:36:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1415599', 'Fentanyl', 'Strong', 19, 3, 4, 0, 1, null, 0, '2020-05-26 04:30:40');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8526976', 'Methimazole', 'Mild', 12, 11, 5, 0, 1, null, 0, '2021-03-23 04:33:28');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7590416', 'Suave', 'Medium', 10, 14, 4, 0, 1, null, 0, '2020-09-13 10:27:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3691924', 'Levothyroxine Sodium', 'Medium', 1, 14, 3, 0, 1, null, 0, '2020-06-18 05:31:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8820343', 'Riomet', 'Strong', 21, 8, 4, 0, 1, null, 0, '2020-10-24 05:48:13');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0116313', 'Furosemide', 'Strong', 5, 14, 3, 0, 1, null, 0, '2021-01-25 22:53:55');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6175245', 'Lithium Carbonate', 'Strong', 27, 13, 3, 0, 1, null, 0, '2021-01-14 12:11:34');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5145965', 'Calamine Phenolated Topical Suspension', 'Medium', 23, 10, 4, 0, 1, null, 0, '2020-06-18 20:43:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1520094', 'Nesacaine', 'Strong', 21, 12, 1, 0, 1, null, 0, '2020-09-01 15:36:09');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5904169', '4 in 1 Pressed Mineral SPF 15 Light', '', 17, 5, 1, 0, 1, null, 0, '2020-12-23 18:14:30');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5645795', 'Oxymorphone hydrochloride', 'Mild', 28, 9, 2, 0, 1, null, 0, '2020-08-30 10:33:55');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3544689', 'Abstral', '', 5, 14, 3, 0, 1, null, 0, '2020-10-16 15:06:24');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6111038', 'PerioChip', 'Strong', 25, 15, 5, 0, 1, null, 0, '2020-09-04 07:24:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3447943', 'IBUPROFEN', 'Medium', 29, 1, 1, 0, 1, null, 0, '2020-11-06 11:09:46');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3920976', 'Original Extra Strong All Natural Fishermans Friend Menthol Cough Suppressant', '', 16, 8, 5, 0, 1, null, 0, '2020-09-12 05:34:01');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4046723', 'Methyldopa', 'Mild', 26, 15, 1, 0, 1, null, 0, '2020-09-02 22:44:23');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6525246', 'Kidney Stone Clear', 'Strong', 2, 12, 5, 0, 1, null, 0, '2020-12-29 15:27:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1959373', 'MINOXIDIL', 'Mild', 10, 3, 5, 0, 1, null, 0, '2021-01-05 09:39:41');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4675704', 'Glipizide and Metformin HCl', '', 28, 13, 3, 0, 1, null, 0, '2020-08-21 11:45:13');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6035340', 'Millipred', '', 2, 6, 4, 0, 1, null, 0, '2021-02-27 23:44:29');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3827608', 'Piroxicam', '', 26, 7, 4, 0, 1, null, 0, '2020-06-24 12:26:37');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1379681', 'Oxycodone Hydrochloride', 'Strong', 22, 15, 4, 0, 1, null, 0, '2020-06-18 23:53:08');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5614038', 'Regular Strength Antacid Calcium Supplement', 'Medium', 4, 4, 4, 0, 1, null, 0, '2021-02-28 14:55:38');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2614778', 'SELZENTRY', 'Strong', 22, 9, 3, 0, 1, null, 0, '2021-03-19 07:44:15');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0413361', 'SPF 50 Broad Spectrum', 'Mild', 7, 14, 3, 0, 1, null, 0, '2020-04-07 15:15:10');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5939232', 'Mucor plumbeus', 'Strong', 15, 1, 2, 0, 1, null, 0, '2021-01-06 01:43:46');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4602867', 'Mycogone perniciosa', 'Mild', 25, 10, 1, 0, 1, null, 0, '2020-05-25 11:51:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4329248', 'CARBON DIOXIDE', '', 14, 8, 3, 0, 1, null, 0, '2020-06-13 10:59:19');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5219217', 'pain relief', 'Mild', 8, 11, 1, 0, 1, null, 0, '2021-01-05 23:59:23');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0023345', 'Temazepam', '', 5, 14, 5, 0, 1, null, 0, '2021-02-19 12:46:21');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4080318', 'OXYCODONE HYDROCHLORIDE', '', 23, 9, 4, 0, 1, null, 0, '2020-07-04 06:11:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9654228', 'Mirtazapine', 'Medium', 21, 12, 4, 0, 1, null, 0, '2020-08-07 18:22:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3823524', 'Low Dose Aspirin', '', 1, 14, 1, 0, 1, null, 0, '2020-06-29 16:09:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3501179', 'Ofloxacin', 'Medium', 18, 4, 3, 0, 1, null, 0, '2021-02-10 22:51:26');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1170687', 'PROMACTA', 'Medium', 1, 1, 5, 0, 1, null, 0, '2021-03-02 06:08:29');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0385910', 'Trillium', 'Strong', 21, 5, 3, 0, 1, null, 0, '2020-06-27 01:56:33');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9171108', 'Mupirocin', 'Medium', 22, 10, 2, 0, 1, null, 0, '2020-07-27 23:35:51');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2168484', 'Cyclobenzaprine Hydrochloride', 'Mild', 28, 5, 1, 0, 1, null, 0, '2020-10-20 18:36:12');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2430916', 'Topiramate', 'Mild', 6, 2, 5, 0, 1, null, 0, '2020-04-24 08:52:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2811779', 'Metronidazole', 'Mild', 6, 9, 4, 0, 1, null, 0, '2020-07-30 23:31:29');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9932324', 'Triticum Cerebri', 'Medium', 21, 13, 2, 0, 1, null, 0, '2021-01-03 13:22:00');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2782074', 'Extra Strength Pain Reliever', 'Strong', 15, 5, 3, 0, 1, null, 0, '2020-08-24 08:14:30');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7531733', 'Stavudine', 'Mild', 23, 14, 2, 0, 1, null, 0, '2021-03-13 04:57:41');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4626458', 'Cactus Crataegus', 'Strong', 7, 1, 5, 0, 1, null, 0, '2020-04-20 04:47:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0371835', 'CLE DE PEAU BEAUTE SILKY FOUNDATION I', 'Medium', 13, 4, 1, 0, 1, null, 0, '2020-08-31 13:29:33');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1339698', 'Sun-Defying Sunscreen Oil Broad Spectrum SPF 50', '', 26, 10, 5, 0, 1, null, 0, '2020-09-19 11:07:12');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0157036', 'Allopurinol', 'Medium', 24, 8, 4, 0, 1, null, 0, '2021-02-02 18:37:30');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7424163', 'Ringers', 'Medium', 2, 14, 3, 0, 1, null, 0, '2020-03-31 10:45:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0084388', 'MonoNessa', 'Strong', 16, 11, 1, 0, 1, null, 0, '2020-09-17 19:43:59');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1646500', 'Pravastatin', 'Medium', 28, 15, 3, 0, 1, null, 0, '2020-09-01 10:30:50');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5112635', 'No Sweat Anti Perspirant', 'Mild', 18, 9, 5, 0, 1, null, 0, '2021-03-19 09:14:50');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6569319', 'Quinapril', '', 25, 2, 5, 0, 1, null, 0, '2020-04-07 01:05:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0037832', 'Ropinirole Hydrochloride', 'Medium', 22, 2, 5, 0, 1, null, 0, '2020-04-09 07:38:20');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1288535', 'Mercaptopurine', 'Medium', 6, 12, 1, 0, 1, null, 0, '2020-05-21 17:45:09');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7705340', 'Acyclovir', 'Mild', 14, 14, 3, 0, 1, null, 0, '2020-10-27 17:11:20');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7729716', 'Meaningful Beauty Cindy Crawford Maintenance 1', 'Mild', 10, 6, 2, 0, 1, null, 0, '2020-05-24 21:25:29');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6883015', 'Ursodiol', 'Strong', 28, 5, 2, 0, 1, null, 0, '2020-04-07 20:41:08');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8285305', 'Fluocinonide', '', 21, 2, 5, 0, 1, null, 0, '2020-08-01 05:50:26');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7449115', 'Benzoyl Peroxide', 'Medium', 3, 4, 5, 0, 1, null, 0, '2020-10-25 10:00:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3072825', 'Sumatriptan Succinate', 'Strong', 27, 14, 4, 0, 1, null, 0, '2021-01-08 11:44:27');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5318792', 'ALENDRONATE SODIUM', 'Medium', 12, 6, 1, 0, 1, null, 0, '2020-09-28 15:06:21');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4379599', 'AMITRIPTYLINE HYDROCHLORIDE', 'Medium', 25, 3, 3, 0, 1, null, 0, '2020-07-11 04:19:43');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2297135', 'Simvastatin', 'Medium', 26, 9, 4, 0, 1, null, 0, '2020-04-09 07:07:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2986891', 'Phendimetrazine Tartrate', '', 21, 10, 3, 0, 1, null, 0, '2021-01-18 20:48:50');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7403001', 'Quinapril Hydrochloride and Hydrochlorothiazide', 'Medium', 9, 9, 1, 0, 1, null, 0, '2021-02-23 07:05:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7013213', 'Anti-Bacterial Gentle Foaming Hand', 'Medium', 10, 8, 3, 0, 1, null, 0, '2020-09-19 02:18:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4270809', 'Fruit of the Earth Aloe Vera Cool Blue', 'Medium', 10, 11, 4, 0, 1, null, 0, '2020-12-14 09:25:30');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2075194', 'ciclopirox olamine', '', 28, 5, 4, 0, 1, null, 0, '2020-08-24 06:06:38');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9300241', 'Fexofenadine Hydrochloride', '', 9, 5, 3, 0, 1, null, 0, '2020-08-22 19:38:16');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6816293', 'Psorent', 'Medium', 18, 6, 5, 0, 1, null, 0, '2021-02-02 04:09:16');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2346128', 'New Terocin', 'Strong', 7, 4, 5, 0, 1, null, 0, '2020-10-31 08:54:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6631554', 'Clarithromycin', '', 5, 8, 3, 0, 1, null, 0, '2020-07-29 02:33:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4802328', 'METHSCOPOLAMINE BROMIDE', 'Medium', 28, 7, 2, 0, 1, null, 0, '2020-05-03 14:53:45');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3509022', 'Ibuprofen', '', 24, 7, 1, 0, 1, null, 0, '2020-11-09 16:41:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8635313', 'Chlorthalidone', 'Mild', 24, 6, 1, 0, 1, null, 0, '2020-08-01 15:07:14');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8973082', 'CLARINS Broad Spectrum SPF 15 Everlasting Foundation Tint 110', '', 29, 6, 5, 0, 1, null, 0, '2020-03-31 02:26:42');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3496425', 'everyone Hand Sanitizer', 'Strong', 24, 1, 4, 0, 1, null, 0, '2020-04-08 03:37:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0494181', 'Sodium Chloride', 'Mild', 17, 6, 3, 0, 1, null, 0, '2021-02-07 13:40:44');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1425641', 'Captopril', 'Medium', 15, 12, 5, 0, 1, null, 0, '2021-02-11 16:04:55');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9344932', 'Zohar Toothpaste', 'Medium', 25, 10, 1, 0, 1, null, 0, '2020-10-31 17:55:02');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5093932', 'Flaxseed', 'Medium', 29, 14, 2, 0, 1, null, 0, '2021-02-25 03:38:20');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6009257', 'Good Sense Lubricant Eye', 'Mild', 30, 15, 5, 0, 1, null, 0, '2020-12-24 07:39:51');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2920176', 'smart sense nighttime', 'Strong', 5, 4, 3, 0, 1, null, 0, '2020-09-20 09:48:04');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1770705', 'doxycycline hyclate', 'Medium', 30, 1, 2, 0, 1, null, 0, '2020-09-10 00:14:00');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9449253', 'Moisture Renew', '', 26, 8, 5, 0, 1, null, 0, '2020-07-21 13:14:53');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9232611', 'Miacalcin', '', 3, 7, 4, 0, 1, null, 0, '2020-10-15 01:05:00');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3664155', 'Tolnaftate', '', 7, 6, 2, 0, 1, null, 0, '2020-06-26 08:04:14');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3368959', 'Carvedilol', '', 17, 1, 1, 0, 1, null, 0, '2020-10-04 03:59:08');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7960012', 'Medi-First Sinus Decongestant', '', 15, 5, 3, 0, 1, null, 0, '2021-02-03 22:48:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1938589', 'Live Better', 'Strong', 18, 2, 3, 0, 1, null, 0, '2020-12-14 00:12:21');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7510182', 'ESIKA', '', 16, 4, 3, 0, 1, null, 0, '2020-04-10 06:03:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3625885', 'Topcare Nite Time Cold and Flu', 'Strong', 1, 12, 3, 0, 1, null, 0, '2020-12-25 07:30:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0306352', 'Torsemide', 'Medium', 4, 4, 5, 0, 1, null, 0, '2020-11-09 12:36:37');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2504242', 'Claravis', '', 28, 14, 2, 0, 1, null, 0, '2020-04-29 15:26:20');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6426754', 'Norepinephrine Bitartrate', '', 27, 8, 5, 0, 1, null, 0, '2020-06-19 07:07:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0912435', 'all day relief', '', 28, 8, 4, 0, 1, null, 0, '2020-05-13 05:10:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7705194', 'pharMAX rebuild', '', 22, 5, 1, 0, 1, null, 0, '2021-01-10 00:09:37');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5275359', 'health mart pain and fever', 'Medium', 26, 6, 2, 0, 1, null, 0, '2020-06-21 21:00:34');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3063622', 'Bupropion Hydrochloride', 'Medium', 24, 3, 1, 0, 1, null, 0, '2020-08-17 22:17:04');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6770819', 'Xodol', '', 17, 7, 3, 0, 1, null, 0, '2020-11-04 07:28:30');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0697565', 'Carvedilol', 'Medium', 22, 12, 1, 0, 1, null, 0, '2020-05-07 22:39:27');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9280161', 'Petroleum Skin Protectant', 'Strong', 5, 10, 2, 0, 1, null, 0, '2020-09-28 16:55:13');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8364447', 'Goat Epithelium', '', 13, 13, 2, 0, 1, null, 0, '2021-03-14 16:49:43');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2981944', 'Medi First Plus Antacid', 'Mild', 11, 10, 5, 0, 1, null, 0, '2020-09-11 08:44:10');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3589388', 'Hevert', 'Medium', 19, 5, 4, 0, 1, null, 0, '2020-10-27 11:39:12');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5898176', 'Metformin Hydrochloride', '', 6, 5, 4, 0, 1, null, 0, '2020-11-18 17:25:31');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4274164', 'Doxazosin Mesylate', 'Strong', 11, 11, 5, 0, 1, null, 0, '2020-05-09 03:07:48');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0339753', 'Fentanyl', '', 13, 3, 5, 0, 1, null, 0, '2020-08-25 17:59:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7060480', 'Klonopin', 'Mild', 22, 10, 2, 0, 1, null, 0, '2020-10-17 11:27:33');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4850188', 'Aruba Aloe Very Water Resistant Sunscreen', '', 3, 4, 5, 0, 1, null, 0, '2021-02-09 12:44:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7607666', 'Cyproheptadine Hydrochloride', 'Mild', 25, 7, 3, 0, 1, null, 0, '2021-02-17 19:33:56');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6672450', 'Theophylline', '', 29, 15, 3, 0, 1, null, 0, '2020-11-12 16:29:43');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9012572', 'Mirapex', 'Mild', 11, 4, 1, 0, 1, null, 0, '2021-01-18 00:03:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9710495', 'Leflunomide', 'Mild', 3, 4, 5, 0, 1, null, 0, '2020-06-15 09:24:14');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4255625', 'Kapok', 'Strong', 3, 8, 1, 0, 1, null, 0, '2020-11-18 05:28:20');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2585748', 'CALCIUM SULPHATE', 'Medium', 3, 8, 1, 0, 1, null, 0, '2020-09-25 17:38:41');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6080378', 'ZENPEP', 'Medium', 27, 1, 4, 0, 1, null, 0, '2020-08-21 07:59:38');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3538987', 'LOESTRIN Fe 1.5/30', '', 3, 8, 2, 0, 1, null, 0, '2021-02-23 17:25:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0626873', 'IPKN MOIST AND FIRM BB 01 FAIR', 'Mild', 5, 7, 1, 0, 1, null, 0, '2020-05-21 07:25:28');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2824369', 'Whole Care', 'Strong', 1, 1, 5, 0, 1, null, 0, '2021-01-20 16:00:01');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2522656', 'Indomethacin', 'Strong', 28, 6, 1, 0, 1, null, 0, '2020-06-19 13:59:43');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3857543', 'Tramadol Hydrochloride', 'Medium', 21, 13, 5, 0, 1, null, 0, '2020-04-18 16:45:42');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2781530', 'Anti-Bacterial Hand', '', 29, 12, 1, 0, 1, null, 0, '2020-11-01 14:08:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8085471', 'Pollens - Weeds and Garden Plants, Plantain, English Plantago lanceolata', 'Medium', 21, 3, 5, 0, 1, null, 0, '2020-09-25 03:30:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5310628', 'Mometasone Furoate', 'Strong', 18, 6, 1, 0, 1, null, 0, '2020-06-09 13:38:13');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0745279', 'voriconazole', 'Strong', 24, 12, 2, 0, 1, null, 0, '2021-03-12 13:36:27');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2422576', 'Bisoprolol Fumarate', 'Strong', 6, 13, 2, 0, 1, null, 0, '2020-04-02 23:39:10');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7641547', 'HOT FLASH RESCUE', 'Strong', 16, 14, 3, 0, 1, null, 0, '2020-06-21 19:09:14');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2493641', 'Risperidone', 'Medium', 1, 9, 5, 0, 1, null, 0, '2021-01-31 12:01:10');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1917255', 'AZITHROMYCIN', 'Mild', 18, 1, 2, 0, 1, null, 0, '2020-06-09 01:11:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0326079', 'Mirapex', 'Medium', 4, 6, 2, 0, 1, null, 0, '2021-01-09 15:58:41');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6225324', 'ropinirole hydrochloride', 'Medium', 1, 3, 5, 0, 1, null, 0, '2020-08-26 17:56:40');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3788131', 'Lidocaine Hydrochloride and Dextrose', 'Medium', 18, 12, 4, 0, 1, null, 0, '2020-08-23 13:27:02');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9551222', 'Felodipine', 'Medium', 20, 3, 5, 0, 1, null, 0, '2021-01-24 08:35:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9669094', 'Ethyl Rubbing Alcohol', 'Mild', 25, 6, 5, 0, 1, null, 0, '2020-10-23 16:44:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6573169', 'Ziprasidone Hydrochloride', 'Mild', 12, 14, 4, 0, 1, null, 0, '2020-08-12 02:56:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7901407', 'Arroyo Willow', 'Strong', 18, 9, 3, 0, 1, null, 0, '2021-03-07 23:09:51');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6901620', 'Diclofenac Sodium', '', 6, 13, 5, 0, 1, null, 0, '2020-03-30 07:38:55');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9569928', 'Vancomycin Hydrochloride', 'Mild', 26, 4, 1, 0, 1, null, 0, '2020-09-15 02:11:18');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1667947', 'Eucalyptus Pollen', 'Medium', 2, 12, 2, 0, 1, null, 0, '2020-10-27 16:20:51');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8269946', 'Cefazolin', 'Medium', 1, 13, 3, 0, 1, null, 0, '2021-01-09 02:58:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7751035', 'Mirapex', 'Mild', 26, 12, 4, 0, 1, null, 0, '2020-10-07 12:18:45');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0849210', 'Paroxetine', 'Strong', 2, 6, 1, 0, 1, null, 0, '2020-03-29 00:27:29');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2081129', 'OXYGEN', 'Medium', 4, 2, 4, 0, 1, null, 0, '2020-04-11 18:42:34');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4838446', 'Pollens - Trees, Alder, Red Alnus rubra', 'Mild', 17, 10, 4, 0, 1, null, 0, '2020-07-21 23:27:27');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4409386', 'Honey Almond Antibacterial Foaming Hand Wash', '', 11, 9, 2, 0, 1, null, 0, '2021-02-21 15:29:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3203000', 'Azathioprine', 'Mild', 23, 15, 1, 0, 1, null, 0, '2021-02-22 08:31:02');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2156931', 'Birth Ease', 'Strong', 19, 11, 5, 0, 1, null, 0, '2020-06-04 23:01:55');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4853298', 'Ranitidine Hydrochloride', 'Medium', 12, 1, 1, 0, 1, null, 0, '2020-04-22 20:15:13');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2359001', 'Zolpidem Tartrate', '', 25, 11, 2, 0, 1, null, 0, '2020-06-26 07:25:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2211651', 'Quinapril Hydrochloride and Hydrochlorothiazide', 'Medium', 18, 3, 5, 0, 1, null, 0, '2020-08-15 09:21:08');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6340972', 'Petroleum Jelly', 'Mild', 5, 7, 3, 0, 1, null, 0, '2020-09-22 20:22:18');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2318429', 'Vistaril', '', 12, 15, 3, 0, 1, null, 0, '2020-09-20 05:41:03');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5757743', 'Oxycodone Hydrochloride', 'Medium', 17, 8, 1, 0, 1, null, 0, '2020-04-23 10:58:51');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7572861', 'Loperamide Hydrochloride', '', 20, 10, 4, 0, 1, null, 0, '2020-11-03 10:22:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0537665', 'DayTime Cold and Flu', 'Mild', 10, 10, 1, 0, 1, null, 0, '2021-02-02 03:03:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2941772', 'Carduus Oxalis Special Order', 'Strong', 4, 14, 2, 0, 1, null, 0, '2021-03-19 06:24:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0267701', 'Black Willow Pollen', '', 30, 8, 3, 0, 1, null, 0, '2020-08-11 01:33:48');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5280151', 'Bupropion Hydrochloride', '', 30, 8, 4, 0, 1, null, 0, '2021-02-07 08:29:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2661703', 'Allergy and Cold', 'Strong', 12, 14, 5, 0, 1, null, 0, '2020-07-30 01:43:20');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9637151', 'Hydrochlorothiazide', 'Medium', 15, 7, 1, 0, 1, null, 0, '2020-07-21 22:38:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4216281', 'Amlodipine Besylate', 'Medium', 9, 4, 5, 0, 1, null, 0, '2020-06-28 11:19:56');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3051742', 'Hair and Scalp anti-dandruff', '', 28, 8, 3, 0, 1, null, 0, '2020-12-20 18:20:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0767054', 'BestHealth Cherry', 'Mild', 18, 15, 3, 0, 1, null, 0, '2021-01-25 20:13:38');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4948510', 'Antibacterial Soap', 'Strong', 4, 4, 5, 0, 1, null, 0, '2020-10-26 15:51:10');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9128343', 'ibuprofen', 'Strong', 28, 8, 5, 0, 1, null, 0, '2020-11-18 16:14:25');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8382395', 'Sulfacetamide Sodium', 'Medium', 27, 3, 3, 0, 1, null, 0, '2020-05-14 06:17:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3792811', 'Fluoxetine', 'Medium', 2, 9, 4, 0, 1, null, 0, '2020-10-28 20:51:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8849615', 'Lithium Carbonate', 'Strong', 6, 14, 4, 0, 1, null, 0, '2020-08-09 03:14:01');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6401190', 'Pleo Poly A', 'Medium', 21, 15, 2, 0, 1, null, 0, '2020-12-27 02:38:14');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2285937', 'A-METHAPRED', 'Strong', 12, 5, 1, 0, 1, null, 0, '2020-10-30 09:25:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0455631', 'Diovan', '', 6, 11, 4, 0, 1, null, 0, '2021-01-27 04:52:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5526313', 'Lorazepam', 'Medium', 20, 5, 1, 0, 1, null, 0, '2020-10-01 20:52:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7948145', 'SOTALOL HYDROCHLORIDE', 'Strong', 21, 12, 4, 0, 1, null, 0, '2020-08-02 15:27:02');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8192977', 'SHISEIDO PERFECT REFINING FOUNDATION', '', 26, 7, 1, 0, 1, null, 0, '2020-07-06 19:54:11');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1257890', 'PANTOPRAZOLE SODIUM', '', 27, 7, 2, 0, 1, null, 0, '2020-06-07 10:26:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6290667', 'smart sense cold and allergy', 'Medium', 24, 7, 4, 0, 1, null, 0, '2020-10-07 12:01:30');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3973351', 'Propranolol Hydrochloride', 'Strong', 24, 15, 4, 0, 1, null, 0, '2020-12-02 18:33:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4374991', 'Colgate Max Clean', '', 19, 4, 1, 0, 1, null, 0, '2020-09-27 03:20:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4573913', 'My Fair Baby', 'Strong', 6, 7, 5, 0, 1, null, 0, '2020-12-03 20:00:21');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('6954516', 'Nan San MUSFLEX External Analgesic', 'Mild', 20, 1, 4, 0, 1, null, 0, '2020-08-11 14:41:59');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8408367', 'Aveeno Skin Relief 24hr Moisturizing', 'Strong', 15, 8, 1, 0, 1, null, 0, '2020-12-13 00:21:53');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('8865182', 'e-HCG', 'Mild', 5, 9, 4, 0, 1, null, 0, '2021-02-23 23:02:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2856359', 'Icy Hot', 'Medium', 10, 6, 1, 0, 1, null, 0, '2021-02-14 13:16:25');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0509056', 'Menstrual Relief', 'Strong', 19, 6, 3, 0, 1, null, 0, '2020-04-23 01:31:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7897679', 'Cymbalta', 'Medium', 17, 2, 2, 0, 1, null, 0, '2020-12-18 05:14:09');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3009292', 'Rainbow Baby', 'Medium', 16, 15, 4, 0, 1, null, 0, '2020-11-03 13:26:33');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4047691', 'MEDICATED DANDRUFF', 'Mild', 14, 15, 1, 0, 1, null, 0, '2020-06-19 21:46:14');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2352573', 'Whoo Gong Jin Hyang Jin Hae Yoon Sun', '', 19, 3, 3, 0, 1, null, 0, '2020-05-22 23:11:33');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3252238', 'DiorSkin Nude 022 Cameo', 'Medium', 23, 12, 2, 0, 1, null, 0, '2020-04-15 08:42:24');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('5106600', 'Proctofoam', '', 16, 11, 5, 0, 1, null, 0, '2021-02-13 03:45:08');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0166438', 'Glyset', '', 3, 6, 2, 0, 1, null, 0, '2020-12-03 21:04:05');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('4892834', 'Quinapril', '', 21, 4, 5, 0, 1, null, 0, '2021-02-17 11:24:11');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('7380270', 'Mugwort', 'Medium', 3, 4, 3, 0, 1, null, 0, '2020-09-01 10:27:44');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('1567120', 'Carbon Dioxide-Air Mixture', 'Strong', 17, 13, 4, 0, 1, null, 0, '2020-08-17 09:22:33');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2738128', 'Perindopril Erbumine', '', 25, 7, 2, 0, 1, null, 0, '2020-10-10 17:01:03');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('3897987', 'Kindest Kare Antimicrobial Foaming Handwash', 'Medium', 23, 13, 5, 0, 1, null, 0, '2020-05-10 03:57:13');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2313536', 'NARS ALL DAY LUMINOUS FOUNDATION', 'Mild', 6, 5, 4, 0, 1, null, 0, '2020-10-15 18:22:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0886156', 'Mobic', 'Mild', 11, 8, 5, 0, 1, null, 0, '2020-06-09 14:27:15');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('2188640', 'BIO Dtuss', 'Medium', 29, 10, 4, 0, 1, null, 0, '2020-04-20 18:15:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('0544135', 'Aspirin', 'Medium', 13, 14, 5, 0, 1, null, 0, '2020-11-03 17:33:44');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, max_refills, cur_refills, status_step_id, status_msg, is_completed, status_date) values ('9141391', 'Lithium Carbonate', '', 26, 5, 4, 0, 1, null, 0, '2021-02-11 08:50:00');



