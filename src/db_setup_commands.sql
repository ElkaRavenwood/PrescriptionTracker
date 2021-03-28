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
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1020741', 'Renvela', 'Strong', 4, 14, 1, null, 0, '2021-01-31 22:27:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4576310', 'SHENG CHUN HERBAL', 'Mild', 24, 7, 1, null, 0, '2020-06-27 13:41:43');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4244448', 'Heparin Sodium', 'Mild', 21, 14, 1, null, 0, '2020-06-30 04:48:40');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9392429', 'Tension Headache Relief', '', 17, 14, 1, null, 0, '2020-09-22 22:50:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2717566', 'Sudafed 12 Hour', '', 15, 14, 1, null, 0, '2020-10-01 06:43:48');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9776502', 'FLULAVAL', 'Medium', 12, 13, 1, null, 0, '2021-01-30 06:05:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2125647', 'Temazepam', 'Medium', 4, 2, 1, null, 0, '2020-11-25 11:35:11');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2620680', 'COUGH BE GONE', 'Strong', 28, 12, 1, null, 0, '2020-06-27 22:16:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9294782', 'Cephalexin', 'Mild', 20, 4, 1, null, 0, '2020-12-08 08:23:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4935972', 'Stool Softener', 'Strong', 22, 8, 1, null, 0, '2020-10-25 01:00:11');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6204729', 'Infants Gas Relief', 'Mild', 13, 13, 1, null, 0, '2021-03-20 21:28:40');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5128138', 'ESIKA', 'Strong', 19, 13, 1, null, 0, '2020-10-23 04:29:28');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1004080', 'Elm Mixture', 'Mild', 24, 14, 1, null, 0, '2020-06-09 23:16:05');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1251376', 'Cefoxitin', 'Medium', 5, 11, 1, null, 0, '2020-08-12 22:32:42');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8517255', 'Pleo Pin', 'Mild', 1, 3, 1, null, 0, '2021-03-08 23:56:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1094103', 'Halog', 'Strong', 24, 11, 1, null, 0, '2020-08-03 07:39:03');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9163378', 'Sodium Chloride', 'Mild', 19, 9, 1, null, 0, '2020-10-10 16:00:05');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1608602', 'Nitroglycerin Transdermal System', 'Medium', 24, 7, 1, null, 0, '2020-12-24 04:01:15');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2566438', 'ribavirin', '', 23, 12, 1, null, 0, '2020-09-04 14:36:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9102179', 'WINRHO', 'Mild', 25, 1, 1, null, 0, '2021-01-02 06:54:41');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1629625', 'HomeHealth Antifungal', '', 23, 4, 1, null, 0, '2020-12-13 02:11:57');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0963444', 'VYTORIN', '', 6, 10, 1, null, 0, '2020-04-06 21:53:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3826895', 'risperidone', 'Strong', 27, 6, 1, null, 0, '2020-12-05 02:59:57');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1516546', 'equaline childrens ibuprofen oral suspension', 'Strong', 3, 3, 1, null, 0, '2021-02-18 22:34:51');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8223709', 'Brain Power', 'Mild', 11, 4, 1, null, 0, '2020-10-14 23:21:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9313422', 'Sulfadiazine', 'Mild', 9, 6, 1, null, 0, '2020-05-20 15:52:23');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5794759', 'Lorazepam', 'Strong', 6, 9, 1, null, 0, '2020-04-17 00:49:01');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4726900', 'Night Time Cough Cherry', '', 5, 13, 1, null, 0, '2020-08-02 13:46:40');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3425878', 'COLGATE', 'Medium', 16, 15, 1, null, 0, '2021-01-27 01:27:19');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1312910', 'SUPER AQUA MAX WHITE C LUMINOUS AMPOULE', 'Medium', 11, 1, 1, null, 0, '2020-07-29 05:49:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1073230', 'Smart Sense Childrens Pain Relief', 'Medium', 17, 2, 1, null, 0, '2020-06-07 22:59:18');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8651658', 'Trimethoprim', 'Medium', 11, 9, 1, null, 0, '2020-11-07 14:47:02');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4384171', 'Hydrocodone Bitartrate and Acetaminophen', 'Medium', 22, 14, 1, null, 0, '2020-09-13 07:00:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8034962', 'TAXODIUM DISTICHUM POLLEN', 'Medium', 13, 2, 1, null, 0, '2020-06-02 16:49:42');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9806533', 'Laxative pills', 'Mild', 2, 12, 1, null, 0, '2020-11-29 18:52:10');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8629059', 'Hesol Rim', '', 23, 5, 1, null, 0, '2020-08-20 22:14:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7331848', 'Pantoprazole Sodium', 'Mild', 8, 10, 1, null, 0, '2021-03-08 14:05:10');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7981840', 'Horse Fly', 'Mild', 23, 14, 1, null, 0, '2020-07-28 09:53:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5174488', 'benzonatate', 'Strong', 13, 9, 1, null, 0, '2021-01-25 00:54:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5837346', 'Ondansetron', 'Medium', 24, 5, 1, null, 0, '2020-08-16 13:57:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0232122', 'Carvedilol', 'Medium', 5, 9, 1, null, 0, '2021-03-13 14:50:13');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0115604', 'Hydrogen Peroxide', 'Mild', 28, 11, 1, null, 0, '2020-12-16 19:35:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1552305', 'Food - Animal Products and Poultry Products, Pork Sus sp.', '', 26, 15, 1, null, 0, '2020-06-06 22:10:34');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2228832', 'Dextrose And Sodium Chloride', 'Strong', 6, 13, 1, null, 0, '2020-10-02 15:52:08');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4805469', 'DiorSnow White Reveal Instant Spot Concealer SPF 50 Ivory 010', 'Mild', 18, 7, 1, null, 0, '2020-06-06 08:25:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4598361', 'nasal decongestant pe', '', 22, 12, 1, null, 0, '2020-07-08 08:51:28');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3965957', 'ARUBA ALOE ISLAND REMEDY DAILY ULTRA ALOE', '', 26, 3, 1, null, 0, '2020-06-23 03:37:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9506447', 'TROSPIUM CHLORIDE', 'Mild', 29, 4, 1, null, 0, '2020-07-27 19:58:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3411949', 'Gonal-f RFF Redi-ject', 'Strong', 16, 15, 1, null, 0, '2021-01-13 02:11:28');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8112107', 'SOLU-MEDROL', 'Medium', 15, 12, 1, null, 0, '2021-01-12 17:13:48');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3998071', 'Tizanidine', 'Medium', 28, 3, 1, null, 0, '2021-01-05 02:34:16');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2710765', 'RAZADYNE', 'Mild', 30, 12, 1, null, 0, '2020-05-07 17:32:03');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4604772', 'Run Guard Sensitive', '', 9, 10, 1, null, 0, '2021-01-01 23:11:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2727687', 'PMS Tone', '', 29, 14, 1, null, 0, '2020-05-28 11:36:55');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1316980', 'GEMFIBROZIL', 'Medium', 3, 4, 1, null, 0, '2020-12-14 02:00:11');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9837151', 'Verapamil Hydrochloride', 'Strong', 23, 3, 1, null, 0, '2020-08-03 16:36:44');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0079733', 'Pain Relief Plus', 'Medium', 10, 2, 1, null, 0, '2021-02-15 08:23:30');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3691938', 'Felodipine', 'Strong', 3, 6, 1, null, 0, '2020-08-24 11:05:55');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5407115', 'Oxygen', 'Medium', 9, 15, 1, null, 0, '2020-12-09 05:31:31');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9182690', 'nasal decongestant', '', 16, 1, 1, null, 0, '2020-04-22 00:30:05');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5669181', 'CVS Medicated Chest Rub', 'Medium', 13, 2, 1, null, 0, '2020-05-04 09:22:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9726969', 'McKesson Skin Protectant', 'Strong', 10, 15, 1, null, 0, '2020-10-01 14:31:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7846522', 'Medicated Body Powder', 'Medium', 1, 13, 1, null, 0, '2020-09-16 17:07:57');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2256625', 'Pain and Fever', 'Medium', 14, 2, 1, null, 0, '2020-12-18 23:39:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7277712', 'Healthy Accents ibuprofen', 'Mild', 27, 6, 1, null, 0, '2021-03-15 00:09:26');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3654778', 'eB5 Age Sport Formula', 'Strong', 9, 5, 1, null, 0, '2020-11-17 20:30:03');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3736347', 'Methylphenidate Hydrochloride', '', 18, 5, 1, null, 0, '2020-12-16 13:34:21');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3441008', 'Pain Relief PM', '', 27, 7, 1, null, 0, '2020-07-31 18:41:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9872252', 'Chocolated Laxative', 'Strong', 25, 8, 1, null, 0, '2020-12-26 11:51:00');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0388598', 'Dilantin', 'Mild', 15, 9, 1, null, 0, '2020-08-06 10:39:28');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0419249', 'Silk', 'Strong', 7, 15, 1, null, 0, '2020-07-12 11:51:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3328569', 'allergy relief', 'Medium', 20, 8, 1, null, 0, '2020-09-19 19:32:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0281853', 'Phrenilin', '', 19, 3, 1, null, 0, '2020-10-06 01:06:46');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2275373', 'New Hawaiian Tropic Sensitive Skin Lotion Sunscreen', 'Medium', 5, 11, 1, null, 0, '2020-06-16 04:39:27');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7044842', 'Neutrogena Rapid Clear Stubborn Acne Spot', 'Medium', 10, 12, 1, null, 0, '2020-05-03 17:19:10');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0842441', 'COLGATE 2IN1', 'Medium', 19, 10, 1, null, 0, '2021-03-26 13:34:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2684525', 'Omeprazole', 'Mild', 22, 5, 1, null, 0, '2020-12-02 01:41:01');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8044525', 'ENALAPRIL MALEATE', 'Medium', 12, 10, 1, null, 0, '2020-10-03 07:22:05');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2636290', 'Lamotrigine', 'Strong', 5, 8, 1, null, 0, '2020-08-29 16:51:15');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7184037', 'Amlodipine Besylate and Benazepril Hydrochloride', 'Strong', 24, 11, 1, null, 0, '2020-04-10 13:04:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9805217', 'AMOREPACIFIC', 'Medium', 18, 9, 1, null, 0, '2020-09-08 06:48:15');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6691360', 'Tiger Balm White', 'Medium', 11, 10, 1, null, 0, '2020-10-01 07:22:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5716445', 'smart sense triacting', 'Medium', 17, 4, 1, null, 0, '2020-08-22 21:16:40');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5136809', 'Viral Infection', '', 24, 6, 1, null, 0, '2020-12-29 09:07:04');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1162639', 'AcipHex', 'Mild', 28, 12, 1, null, 0, '2020-08-29 22:36:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1242235', 'Amantadine Hydrochloride', '', 4, 11, 1, null, 0, '2021-01-26 11:54:37');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6322702', 'ESZOPICLONE', 'Strong', 19, 10, 1, null, 0, '2020-08-14 12:11:29');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6244655', 'Clarithromycin', 'Strong', 11, 5, 1, null, 0, '2020-08-21 07:35:38');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8209797', 'TABACUM', 'Strong', 19, 2, 1, null, 0, '2020-05-23 21:01:15');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1693295', 'ADCIRCA', 'Strong', 18, 15, 1, null, 0, '2020-06-13 16:52:45');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8528281', 'Ropivacaine Hydrochloride', '', 29, 14, 1, null, 0, '2020-05-27 03:40:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3972308', 'Famotidine', 'Strong', 29, 11, 1, null, 0, '2021-03-18 11:25:28');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1824862', 'Ketorolac Tromethamine', 'Medium', 20, 8, 1, null, 0, '2020-10-25 18:02:08');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6702988', 'OLUX', 'Strong', 2, 3, 1, null, 0, '2020-12-28 08:39:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4661901', 'False Ragweed', 'Medium', 7, 11, 1, null, 0, '2021-01-07 00:48:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4630106', 'DILTZAC', 'Strong', 3, 2, 1, null, 0, '2020-07-13 06:18:02');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8166938', 'SUPRESS-PE', '', 17, 14, 1, null, 0, '2020-10-08 17:22:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4899881', 'Glimepiride', 'Medium', 8, 2, 1, null, 0, '2020-05-03 02:47:08');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6384098', 'Reboost', 'Medium', 24, 11, 1, null, 0, '2020-05-31 09:11:44');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7485654', 'XtraCare Creamy Petroleum Jelly', 'Medium', 10, 1, 1, null, 0, '2020-06-10 12:03:02');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3241014', 'PLETAL', 'Medium', 7, 10, 1, null, 0, '2020-09-15 13:55:01');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8456381', 'simvastatin', 'Medium', 16, 11, 1, null, 0, '2021-02-05 09:11:12');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6385404', 'Ramipril', 'Strong', 26, 3, 1, null, 0, '2020-06-30 00:55:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1369527', 'Night Time Cherry', 'Mild', 11, 8, 1, null, 0, '2020-08-03 19:54:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3771895', 'Metaxalone', 'Strong', 11, 7, 1, null, 0, '2020-04-13 09:54:59');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0144191', 'TIS-U-SOL', 'Medium', 11, 3, 1, null, 0, '2020-11-10 21:28:43');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1389549', 'Acetaminophen', '', 19, 11, 1, null, 0, '2020-09-10 18:31:41');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1456632', 'Vectibix', '', 22, 2, 1, null, 0, '2020-10-09 19:21:10');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6619851', 'Good Sense Triple Antibiotic', 'Strong', 9, 7, 1, null, 0, '2020-08-12 07:09:31');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4444631', 'ORTHO GUARD', 'Strong', 28, 4, 1, null, 0, '2021-02-01 11:43:21');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9280906', 'Lamivudine', 'Mild', 3, 8, 1, null, 0, '2020-06-24 13:49:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4842759', 'levocetirizine dihydrochloride', 'Mild', 18, 7, 1, null, 0, '2021-03-10 23:22:32');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1538965', 'Guinea Pig Epithelium', 'Strong', 16, 6, 1, null, 0, '2020-10-23 03:06:46');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6726938', 'Losartan Potassium', '', 17, 8, 1, null, 0, '2021-01-20 22:11:19');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0326721', 'Bacitracin Zinc', 'Strong', 27, 7, 1, null, 0, '2020-08-11 10:09:26');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3598868', 'St. Ives', 'Mild', 22, 10, 1, null, 0, '2020-10-04 10:46:38');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8305076', 'GOAT MILK AND LAVENDER SUN', 'Strong', 7, 11, 1, null, 0, '2020-11-05 10:06:38');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8715144', 'SPF 30 Sunscreen', '', 30, 3, 1, null, 0, '2020-09-08 20:23:14');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2578270', 'Equaline Daytime Nighttime Cold and Flu Relief', 'Medium', 18, 13, 1, null, 0, '2020-03-29 08:56:59');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8394046', 'Zevalin', 'Mild', 23, 5, 1, null, 0, '2020-11-20 12:03:11');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2152859', 'PARURE DE LUMIERE LIGHT-DIFFUSING FOUNDATION WITH SUNSCREEN MOISTURE INFUSION BROAD SPECTRUM SPF 25 02 BEIGE CLAIR', '', 10, 4, 1, null, 0, '2020-05-08 08:50:57');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8270087', 'equate nitetime', 'Strong', 2, 5, 1, null, 0, '2021-02-26 09:25:01');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1223464', 'Clearasil Ultra', 'Medium', 4, 5, 1, null, 0, '2020-06-07 06:28:30');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9202538', 'Bio White Chestnut', 'Mild', 17, 5, 1, null, 0, '2021-01-08 03:23:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5073937', 'Total Barium', 'Mild', 4, 2, 1, null, 0, '2020-10-17 11:18:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0167651', 'Caduet', 'Strong', 17, 9, 1, null, 0, '2021-02-22 03:37:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2891400', 'Famotidine', 'Strong', 28, 9, 1, null, 0, '2020-11-15 05:08:24');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4543248', 'Oxycodone and Acetaminophen', '', 28, 5, 1, null, 0, '2020-11-01 05:32:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7632596', 'Moisturizing Lip BalmSPF30', 'Mild', 5, 2, 1, null, 0, '2020-09-03 01:35:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3980991', 'Metformin Hydrochloride', '', 2, 12, 1, null, 0, '2020-05-13 12:57:48');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6626385', 'Childrens Pain and Fever', 'Strong', 17, 14, 1, null, 0, '2020-09-02 09:33:45');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9762059', 'Perphenazine and Amitriptyline Hydrochloride', 'Mild', 19, 11, 1, null, 0, '2020-03-30 15:50:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6616855', 'Glucotrol', 'Strong', 11, 4, 1, null, 0, '2020-08-14 03:03:43');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6253440', 'fiber laxative', 'Mild', 19, 5, 1, null, 0, '2020-05-31 00:20:20');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7325857', 'Paroxetine', '', 2, 6, 1, null, 0, '2021-02-05 06:35:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4475130', 'Hemorrhoidal Cooling Gel', 'Mild', 22, 3, 1, null, 0, '2020-12-18 22:03:21');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2792237', 'Perphenazine and Amitriptyline Hydrochloride', 'Mild', 15, 13, 1, null, 0, '2020-08-05 14:27:57');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0670217', 'Organic Wear 100% Natural Origin Tinted Moisturizer', 'Strong', 15, 13, 1, null, 0, '2020-08-15 17:45:46');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3895415', 'Justice Vanilla Scent ANTI BAC HAND SANITIZER', '', 16, 10, 1, null, 0, '2020-06-09 04:00:23');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0357143', 'Sentralopram AM-10', 'Mild', 13, 12, 1, null, 0, '2020-12-18 22:45:14');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4538993', 'Hydrastis', 'Medium', 8, 4, 1, null, 0, '2020-09-26 15:07:24');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0022845', 'Trimethobenzamide Hydrochloride', 'Medium', 29, 12, 1, null, 0, '2020-06-24 08:54:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8320834', 'Icy Hot', 'Mild', 20, 7, 1, null, 0, '2020-06-16 13:07:18');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3614578', 'SALSOLA KALI POLLEN', '', 12, 11, 1, null, 0, '2020-06-10 01:58:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3546017', 'CareOne Adult Tussin DM', 'Strong', 13, 5, 1, null, 0, '2020-11-05 12:47:15');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7036871', 'nicotine', 'Mild', 9, 9, 1, null, 0, '2020-08-17 11:38:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8863076', 'CLIV Barrier Power Ampoule', 'Strong', 6, 6, 1, null, 0, '2020-04-18 00:46:03');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7294899', 'Day Time Sinus', 'Strong', 5, 12, 1, null, 0, '2020-11-16 04:37:38');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9555320', 'Mint and Aloe Antibacterial Foaming Hand Wash', 'Strong', 20, 8, 1, null, 0, '2021-02-20 14:03:19');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9307177', 'Toms Wicked Fresh Spearmint Ice', '', 3, 15, 1, null, 0, '2020-12-06 07:53:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4127798', 'Oil of Beauty', 'Medium', 17, 3, 1, null, 0, '2020-08-26 06:41:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5755899', 'Carbidopa', 'Medium', 29, 10, 1, null, 0, '2020-07-17 20:47:09');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6094744', 'Pain Relief Aspirin', 'Medium', 4, 15, 1, null, 0, '2020-09-30 12:16:28');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9899122', 'IHS 2000 INSTANT HAND SANITIZER', 'Medium', 25, 3, 1, null, 0, '2020-10-14 06:52:40');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4626923', 'Cold-EEZE', 'Mild', 12, 12, 1, null, 0, '2020-11-26 06:20:25');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3028275', 'Calamine', 'Strong', 12, 9, 1, null, 0, '2020-08-13 06:58:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8741361', 'Oxycodone Hydrochloride', 'Medium', 24, 2, 1, null, 0, '2020-06-18 05:26:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3108218', 'Babies R Us Pain and Fever', 'Strong', 7, 14, 1, null, 0, '2020-08-09 01:34:30');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2335385', 'Terbutaline Sulfate', 'Strong', 15, 8, 1, null, 0, '2020-04-16 18:24:53');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0269584', 'INSTANT HAND SANITIZER', '', 16, 4, 1, null, 0, '2020-09-20 00:37:29');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7339896', '7 select night time relief', 'Strong', 18, 7, 1, null, 0, '2020-06-26 05:25:43');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1609185', 'Cedar Elm', 'Mild', 29, 7, 1, null, 0, '2021-01-07 22:13:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9095127', 'Extra Strength Back and Body', 'Medium', 13, 12, 1, null, 0, '2021-03-23 20:31:46');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9156951', 'Dextrose And Sodium Chloride', '', 19, 2, 1, null, 0, '2021-02-10 23:52:31');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0511955', 'Hand Essentials Skin Repair', '', 13, 8, 1, null, 0, '2020-10-26 12:39:23');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0526963', 'Concealing Spot Treatment', 'Strong', 7, 15, 1, null, 0, '2020-06-26 16:18:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2196862', 'PureLife Topical Anesthetic', 'Medium', 5, 14, 1, null, 0, '2020-07-22 04:56:20');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2971957', 'Proctofoam', 'Mild', 14, 9, 1, null, 0, '2020-06-30 19:42:59');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6873766', 'Digitalis Purpurea Kit Refill', '', 26, 3, 1, null, 0, '2020-07-23 00:18:04');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8815910', 'Denti-Care Denti-Rinse', '', 10, 9, 1, null, 0, '2020-09-23 08:39:55');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4921796', 'Zincoxide', 'Mild', 24, 11, 1, null, 0, '2020-09-24 13:15:34');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4988726', 'Ropinirole', 'Strong', 17, 4, 1, null, 0, '2020-04-26 01:25:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1806605', 'Winter Vanilla Hand Sanitizer', 'Mild', 17, 1, 1, null, 0, '2021-01-20 07:14:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7413554', 'Gabapentin', 'Strong', 18, 8, 1, null, 0, '2021-01-08 16:52:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6568352', 'Treatment Set TS338618', 'Medium', 11, 2, 1, null, 0, '2020-09-14 16:03:21');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7392631', 'ADD', '', 19, 10, 1, null, 0, '2020-08-14 12:04:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6021274', 'Nisoldipine', 'Strong', 24, 1, 1, null, 0, '2020-04-19 12:59:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2918105', 'Nystatin', 'Strong', 14, 15, 1, null, 0, '2020-03-30 18:37:13');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1646762', 'Wal-Finite', 'Medium', 22, 11, 1, null, 0, '2020-03-31 15:19:00');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8911667', 'Rice Grain', 'Mild', 11, 2, 1, null, 0, '2020-06-27 02:37:40');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1258496', 'ASPIRIN', 'Medium', 4, 6, 1, null, 0, '2020-10-06 03:27:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3694046', 'ZERIT', '', 10, 12, 1, null, 0, '2020-08-20 14:08:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8004600', 'Mamma (sinistra) 6', 'Strong', 29, 14, 1, null, 0, '2020-05-21 00:12:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4490233', 'Bite Beauty SPF 15 Sheer Balm', '', 20, 11, 1, null, 0, '2020-08-25 14:56:11');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2935428', 'Heparin Sodium', 'Mild', 26, 8, 1, null, 0, '2020-11-26 16:44:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4499514', 'Fosinopril Sodium', 'Mild', 14, 3, 1, null, 0, '2020-07-27 16:11:46');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4536978', 'Aqua Maris Isotonised', 'Strong', 22, 1, 1, null, 0, '2020-07-17 17:50:28');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2054888', 'Lornamead', 'Medium', 17, 4, 1, null, 0, '2020-06-11 05:34:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7235327', 'GenRx Daily Defense Antifungal', 'Medium', 27, 14, 1, null, 0, '2020-12-08 21:08:10');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8358290', 'EO HAND SANITIZER', '', 8, 14, 1, null, 0, '2021-02-26 01:29:01');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2102206', 'Nux Vomica', 'Mild', 5, 5, 1, null, 0, '2020-08-27 13:45:34');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9105046', 'Celexa', '', 2, 3, 1, null, 0, '2020-05-03 18:56:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5967103', 'AcneFree Clear Skin Treatments', 'Mild', 13, 7, 1, null, 0, '2020-12-24 00:04:21');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9801958', 'RISPERDAL M-TAB', 'Strong', 22, 9, 1, null, 0, '2020-04-18 11:15:12');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0457163', 'LANEIGE SATIN FINISH TWIN PACT NO. 21', 'Medium', 5, 12, 1, null, 0, '2020-10-25 07:17:03');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2884943', 'Diltiazem Hydrochloride', 'Strong', 14, 3, 1, null, 0, '2020-03-28 04:28:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0168354', 'Acid Controller', 'Strong', 25, 2, 1, null, 0, '2020-12-29 03:37:02');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8382746', 'Alprazolam', 'Mild', 3, 7, 1, null, 0, '2020-11-19 07:11:23');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0268414', 'Sweet Vernal Grass, Standardized', 'Strong', 26, 1, 1, null, 0, '2020-08-04 06:57:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5633856', 'Lice Complete', 'Medium', 22, 11, 1, null, 0, '2021-01-20 19:21:08');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2688092', 'Oral Dent', 'Strong', 22, 11, 1, null, 0, '2020-05-29 08:09:42');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0070907', 'Equate nicotine', 'Mild', 8, 1, 1, null, 0, '2020-07-03 17:43:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8282014', 'BACTEX Antiseptic Hand Sanitizer', 'Strong', 26, 1, 1, null, 0, '2021-01-14 06:35:53');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6707462', 'Disney FROZEN BERRY SCENTED ANTISEPTIC HAND CLEANSING', '', 17, 10, 1, null, 0, '2021-02-24 02:45:40');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8361228', 'Dexamethasone', 'Mild', 30, 6, 1, null, 0, '2020-09-04 10:30:46');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4754417', 'Kids Crest Cavity Protection', 'Mild', 5, 12, 1, null, 0, '2021-03-20 08:03:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8033897', 'Phenobarbital', 'Medium', 25, 11, 1, null, 0, '2020-05-29 13:43:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0086700', 'Theraflu', '', 8, 4, 1, null, 0, '2020-09-13 03:34:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7509804', 'Irbesartan and Hydrochlorothiazide', 'Strong', 4, 11, 1, null, 0, '2021-01-28 19:24:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6870845', 'Artistry Hydrating Foundation', '', 29, 9, 1, null, 0, '2020-08-06 01:53:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1420130', 'Meperidine HCl', 'Medium', 15, 4, 1, null, 0, '2020-07-01 15:41:41');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6718590', 'Osphena', '', 10, 13, 1, null, 0, '2020-08-28 19:34:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9823880', 'Sotalol Hydrochloride', '', 11, 12, 1, null, 0, '2020-04-12 07:29:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0733017', 'ESIKA 3-IN-1 PRO MAKE UP FOUNDATION SPF 20 BASE DE MAQUILLAJE PARA ROSTRO 3-EN-1 PRO FPS 20', 'Strong', 8, 5, 1, null, 0, '2020-10-07 17:02:33');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4293809', 'Extra Strength Pain Reliever', '', 30, 10, 1, null, 0, '2020-10-14 16:29:48');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7164599', 'Varicose Veins - Phlebitis', 'Strong', 15, 3, 1, null, 0, '2021-03-24 10:33:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6994110', 'Chafe Rescue', 'Mild', 21, 3, 1, null, 0, '2020-12-21 23:42:12');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3476015', 'Perphenazine', 'Mild', 9, 5, 1, null, 0, '2020-05-11 22:58:42');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3706042', 'acetaminophen pm', '', 7, 2, 1, null, 0, '2020-08-04 02:13:40');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7562119', 'Topiramate', 'Mild', 29, 9, 1, null, 0, '2021-02-11 09:57:12');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3909865', 'Aveeno Skin Relief 24hr Moisturizing', 'Mild', 4, 14, 1, null, 0, '2020-04-10 17:53:51');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6965039', 'Warm Deep Matte', 'Mild', 11, 10, 1, null, 0, '2020-05-05 09:10:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1846698', 'SACCHAROMYCES CEREVISIAE', 'Strong', 29, 8, 1, null, 0, '2020-08-27 00:07:41');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1405365', 'Alendronate Sodium', 'Strong', 15, 12, 1, null, 0, '2021-02-24 07:12:40');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0692369', 'Lorazepam', '', 29, 3, 1, null, 0, '2020-12-28 17:50:40');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4667630', 'Metformin Hydrochloride', 'Mild', 20, 10, 1, null, 0, '2020-10-12 17:24:10');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7846866', 'Ergocalciferol', '', 24, 12, 1, null, 0, '2020-10-11 00:30:07');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3019362', 'sunmark day time cold and cough', 'Mild', 20, 11, 1, null, 0, '2020-03-27 14:28:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2371265', 'Instant Hand Sanitizer', 'Strong', 28, 3, 1, null, 0, '2020-09-19 10:39:30');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5160281', 'BANANA BOAT', 'Strong', 27, 8, 1, null, 0, '2020-11-28 09:07:33');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9579913', 'SHISEIDO SUN PROTECTION FOUNDATION', 'Strong', 14, 15, 1, null, 0, '2021-03-09 16:39:03');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7337964', 'Tinidazole', '', 28, 7, 1, null, 0, '2021-01-01 19:07:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9467002', 'Dexamethasone', '', 25, 6, 1, null, 0, '2020-11-12 02:34:01');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8433908', 'Diclofenac Sodium', '', 29, 12, 1, null, 0, '2020-06-12 04:42:48');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6538699', 'RETROVIR', 'Mild', 23, 11, 1, null, 0, '2020-08-29 15:40:15');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6808447', 'Lean Love', 'Strong', 21, 9, 1, null, 0, '2021-03-08 22:31:09');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7246869', 'Vapor Inhaler', 'Medium', 30, 2, 1, null, 0, '2020-12-05 14:44:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2136566', 'CLE DE PEAU BEAUTE RADIANT FLUID FOUNDATION', 'Strong', 16, 11, 1, null, 0, '2020-11-14 00:27:04');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0134380', 'Right Guard Sport Fresh Invisible Solid Antiperspirant and Deodorant', 'Medium', 27, 9, 1, null, 0, '2021-02-26 16:21:08');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1151453', 'Octinoxate', 'Mild', 27, 9, 1, null, 0, '2020-08-07 06:52:50');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4824657', 'Dry Idea Advanced Dry-Powder Fresh', '', 14, 14, 1, null, 0, '2020-11-18 11:36:45');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6131524', 'ADVANCED HYDRO-LIQUID COMPACT (REFILL)', 'Strong', 6, 2, 1, null, 0, '2021-03-15 00:46:59');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1542067', 'REPAGLINIDE', 'Medium', 9, 12, 1, null, 0, '2020-10-01 07:20:54');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9704772', 'Lovastatin', '', 6, 8, 1, null, 0, '2020-03-29 11:50:24');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0752556', 'Argatroban', 'Strong', 27, 2, 1, null, 0, '2021-02-11 08:06:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5128384', 'HUMCO Camphor Spirit', 'Mild', 24, 8, 1, null, 0, '2020-11-08 04:19:04');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3614559', 'Hydrocodone Bitartrate and Acetaminophen', 'Mild', 12, 10, 1, null, 0, '2020-05-28 15:11:49');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6882334', 'FRAXINUS AMERICANA POLLEN', 'Medium', 28, 5, 1, null, 0, '2020-10-29 17:57:25');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4158449', 'Vicks NyQuil', 'Medium', 8, 9, 1, null, 0, '2021-03-13 02:14:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9864119', 'DIOR SNOW PROTECTION UV', 'Medium', 27, 1, 1, null, 0, '2021-03-24 10:02:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6182390', 'House Dust', 'Medium', 1, 10, 1, null, 0, '2020-04-13 18:34:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8061186', 'Hydrochlorothiazide', '', 3, 6, 1, null, 0, '2020-08-13 09:59:31');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5221587', 'Chafe Rescue', '', 7, 2, 1, null, 0, '2020-04-07 11:03:57');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6765792', 'Oxygen', 'Strong', 13, 7, 1, null, 0, '2020-08-11 03:54:15');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5154952', 'careone milk of magnesia', 'Mild', 27, 12, 1, null, 0, '2020-12-31 17:48:59');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1844232', 'Ovace', 'Strong', 20, 5, 1, null, 0, '2020-12-15 10:55:16');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0662188', 'Normosol-R', 'Strong', 6, 12, 1, null, 0, '2021-02-15 18:49:48');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2007410', 'Daysee', 'Strong', 8, 15, 1, null, 0, '2020-12-29 22:54:01');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4390818', 'Oxygen', '', 21, 10, 1, null, 0, '2020-05-24 08:20:33');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6569095', 'Escavite', 'Mild', 25, 8, 1, null, 0, '2020-07-01 05:58:25');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7060202', 'Metformin Hydrochloride', 'Strong', 3, 8, 1, null, 0, '2020-09-04 22:22:04');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6506131', 'Compre Tox', 'Strong', 21, 11, 1, null, 0, '2020-09-17 19:25:44');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0164780', 'Healthy Accents Famotidine', 'Medium', 29, 14, 1, null, 0, '2020-12-07 01:21:35');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4564813', 'Medique Medicidin D', '', 15, 2, 1, null, 0, '2021-03-11 21:37:52');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1427298', 'Clearskin', 'Strong', 10, 13, 1, null, 0, '2020-06-03 20:32:26');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1266477', 'SAFEWAY', 'Medium', 8, 8, 1, null, 0, '2020-09-27 01:54:48');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1948341', 'Malin and Goetz', '', 12, 4, 1, null, 0, '2020-05-05 01:11:39');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8643462', 'TERUFLEX Blood Bag System with Diversion Blood Sampling Arm Anticoagulant Citrate Phosphate Dextrose (CPD) AND OPTISOL (AS-5) Red Cell Preservative', 'Strong', 13, 12, 1, null, 0, '2021-01-25 11:36:46');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9772373', 'ATOMY BB', 'Mild', 5, 5, 1, null, 0, '2020-06-29 07:48:26');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2797388', 'KETOROLAC TROMETHAMINE', 'Strong', 20, 4, 1, null, 0, '2020-08-07 02:39:58');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4328848', 'sunmark fexofenadine hydrochloride', '', 25, 5, 1, null, 0, '2020-06-20 19:29:43');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9592248', 'Pioglitazone and Metformin Hydrocholride', 'Strong', 7, 8, 1, null, 0, '2020-08-26 16:21:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2177560', 'Well Beginnings Baby Eczema', '', 3, 3, 1, null, 0, '2021-01-11 10:59:03');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9533866', 'CENTER-AL - ACER SACCHARUM POLLEN', 'Strong', 10, 11, 1, null, 0, '2020-07-31 19:31:09');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('8441229', 'Hydromorphone Hydrochloride', 'Mild', 4, 10, 1, null, 0, '2020-12-14 07:55:51');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4703049', 'Triamterene and Hydrochlorothiazide', 'Medium', 2, 1, 1, null, 0, '2020-12-16 13:49:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0053362', 'DOCTORS CHOICE', 'Strong', 24, 5, 1, null, 0, '2020-07-26 05:48:48');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('7040811', 'Xylocaine', '', 24, 5, 1, null, 0, '2020-07-06 08:05:31');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0413221', 'Endopath-F', '', 23, 2, 1, null, 0, '2020-10-08 11:23:14');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('0063663', 'Gelato APF', 'Mild', 19, 12, 1, null, 0, '2020-08-01 20:48:12');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1969929', 'Warfarin Sodium', 'Strong', 14, 7, 1, null, 0, '2020-10-27 17:49:27');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3511609', 'HAHNEMANN HEADACHE', '', 7, 9, 1, null, 0, '2020-12-30 21:17:05');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4615878', 'Metoclopramide', 'Medium', 16, 7, 1, null, 0, '2020-09-10 23:24:28');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('3369934', 'SENSAI SILKY BRONZE SUN PROTECTIVE EMULSION FOR BODY SPF20', 'Strong', 2, 3, 1, null, 0, '2020-11-10 10:04:48');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6733174', 'KETOROLAC TROMETHAMINE', '', 30, 3, 1, null, 0, '2020-12-30 19:14:30');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6615826', 'Magnesium Sulfate', 'Mild', 20, 1, 1, null, 0, '2020-09-20 22:17:36');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4312662', 'ASSURED ACNE CREAM', 'Mild', 14, 14, 1, null, 0, '2020-07-19 21:02:48');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4334867', 'Misoprostol', '', 26, 3, 1, null, 0, '2021-01-30 15:56:57');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2186821', 'Nifedipine', 'Strong', 5, 3, 1, null, 0, '2020-07-14 18:48:47');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2795879', 'CLONIDINE HYDROCHLORIDE', '', 27, 12, 1, null, 0, '2020-05-19 04:27:01');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('2377451', 'OXYGEN', 'Mild', 20, 3, 1, null, 0, '2020-10-28 02:18:21');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('1312141', 'Ultracruz Antibacterial', 'Mild', 10, 3, 1, null, 0, '2020-05-11 16:59:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4130402', 'Food - Plant Source, Peach Prunus persica', 'Mild', 27, 4, 1, null, 0, '2020-05-03 11:39:06');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4354376', 'Gambil Oak', '', 6, 3, 1, null, 0, '2021-02-17 00:25:10');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('6679003', 'ARTHRITIS CARE', 'Strong', 5, 1, 1, null, 0, '2020-06-01 04:12:09');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4279997', 'Body', 'Mild', 14, 10, 1, null, 0, '2020-12-14 11:14:22');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4662588', 'Benefect Natural Hand Sanitizer', '', 20, 3, 1, null, 0, '2020-07-06 23:00:05');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('9008491', 'Herbon Berry Buddies/Watermelon Goodypops', 'Medium', 27, 9, 1, null, 0, '2020-09-18 16:13:16');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('5213549', 'SEROQUEL', 'Medium', 7, 15, 1, null, 0, '2021-03-16 08:38:17');
insert into prec_info (rx, med_name, med_strength, user_id, pharm_id, status_step_id, status_msg, is_completed, status_date) values ('4321894', 'Sunscreen Mist Broad Spectrum SPF 30', 'Medium', 29, 1, 1, null, 0, '2021-01-29 06:37:00');


