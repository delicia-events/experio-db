CREATE TABLE IF NOT EXISTS staff_details (staff_id BIGINT NOT NULL AUTO_INCREMENT UNIQUE,
staff_name VARCHAR(50) NOT NULL,
staff_phone_no BIGINT NOT NULL PRIMARY KEY,
status_id INT NOT NULL DEFAULT 1,
created_on TIMESTAMP NOT NULL  DEFAULT CURRENT_TIMESTAMP,
modified_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS work_details (work_id BIGINT NOT NULL AUTO_INCREMENT UNIQUE,
work_name VARCHAR(50) NOT NULL,
work_date datetime NOT NULL, 
work_place VARCHAR(50) NOT NULL,
work_type VARCHAR(50) NOT NULL,
work_area INT NOT NULL,
work_estimate INT NOT NULL,
work_status INT DEFAULT 0,
created_on TIMESTAMP NOT NULL  DEFAULT CURRENT_TIMESTAMP,
modified_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE basic_configuration (
entry_id BIGINT NOT NULL AUTO_INCREMENT UNIQUE,
sqft_charge DECIMAL(5,2) NOT NULL,
total_labour_charge DECIMAL(5,2) NOT NULL,
setup_labour_charge DECIMAL(5,2) NOT NULL,
phaseout_labour_charge DECIMAL(5,2) NOT NULL,
stage_total_labour_charge DECIMAL(5,2) NOT NULL,
stage_setup_labour_charge DECIMAL(5,2) NOT NULL,
stage_phaseout_labour_charge DECIMAL(5,2) NOT NULL,
created_on TIMESTAMP NOT NULL  DEFAULT CURRENT_TIMESTAMP,
modified_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE account_settings (
user_id BIGINT NOT NULL AUTO_INCREMENT UNIQUE,
username VARCHAR(50) NOT NULL,
password  VARCHAR(50) NOT NULL,
created_on TIMESTAMP NOT NULL  DEFAULT CURRENT_TIMESTAMP,
modified_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS expences (
  expence_id BIGINT NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
  work_id BIGINT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  expence_date DATETIME NOT NULL,
  expence_name  VARCHAR(100) NOT NULL,
  expence_category VARCHAR(50) NOT NULL,
  settled INT NOT NULL  DEFAULT 1,
  FOREIGN KEY (work_id) REFERENCES work_details(work_id)
);

CREATE TABLE IF NOT EXISTS staff_slary_split (
  entry_id BIGINT NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
  work_id BIGINT NOT NULL,
  staff_id BIGINT NOT NULL,
  work_type varchar(10) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (work_id) REFERENCES work_details(work_id),
  FOREIGN KEY (staff_id) REFERENCES staff_details(staff_id)
);

CREATE TABLE IF NOT EXISTS staff_payment_log (
  entry_id BIGINT NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
  staff_id BIGINT NOT NULL,
  payment_date DATETIME NOT NULL,
  description VARCHAR(50) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (staff_id) REFERENCES staff_details(staff_id)
);


insert into basic_configuration
(sqft_charge,total_labour_charge,setup_labour_charge,phaseout_labour_charge,
stage_total_labour_charge, stage_setup_labour_charge,stage_phaseout_labour_charge ) values(5,2,1.30,0.70, 17.5, 11,6.5);

insert into account_settings (username,password) values('experiodesk','password');

-- drop table basic_configuration 
-- truncate table staff_details
-- truncate table work_details;
-- truncate table  staff_slary_split;
select * from basic_configuration;
/*
SET FOREIGN_KEY_CHECKS = 0;
truncate table staff_slary_split;
drop table if exists staff_details;
drop table if exists work_details;
drop table if exists basic_configuration;
drop table if exists account_settings;
drop table if exists expences;
drop table if exists staff_slary_split;
drop table if exists staff_payment_log;
SET FOREIGN_KEY_CHECKS = 1;
*/
/*
SET FOREIGN_KEY_CHECKS = 0;
truncate table staff_slary_split;
truncate table work_details;
truncate table expences;
truncate table staff_slary_split;
truncate table staff_payment_log;
SET FOREIGN_KEY_CHECKS = 1;
*/
SELECT labour_charge as labourCharge from basic_configuration WHERE entry_id=1;
select * from account_settings;
select * from work_details;
select * from staff_slary_split;
select * from staff_details;
select * from staff_payment_log;
select * from basic_configuration;
select * from expences;


SELECT SUM(amount) AS totalExpence FROM expences where work_id =1;
SELECT SUM(amount) AS paidSalary FROM staff_payment_log where staff_id =1;
SELECT expence_category AS expenceCategory,SUM(amount) as expenceAmount FROM expences account_settings WHERE work_id=1 GROUP BY expence_category;

/* Joins */

SELECT staff_slary_split.entry_id , staff_details.staff_id, staff_details.staff_name, staff_slary_split.work_type, staff_slary_split.amount
FROM staff_slary_split
INNER JOIN staff_details ON staff_slary_split.staff_id=staff_details.staff_id WHERE staff_slary_split.work_id =1;

SELECT * FROM staff_payment_log WHERE staff_id=1 AND payment_date BETWEEN '2021-03-2100:00:00' AND '2021-03-23 00:00:00';
SELECT staff_slary_split.entry_id,work_details.work_name,work_details.work_place,work_details.work_date, staff_slary_split.work_type, staff_slary_split.amount
FROM staff_slary_split
INNER JOIN work_details ON staff_slary_split.work_id=work_details.work_id WHERE staff_slary_split.staff_id =1;


SELECT * from work_details;

