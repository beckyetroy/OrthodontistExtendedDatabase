-- -----------------------------------------------------
-- Drop the 'StraightSmilesOrtho' database/schema
-- -----------------------------------------------------

drop schema if exists StraightSmilesOrtho;

-- -----------------------------------------------------
-- Create 'StraightSmilesOrtho' database/schema and use this database
-- -----------------------------------------------------

create database StraightSmilesOrtho;

use StraightSmilesOrtho;

-- -----------------------------------------------------
-- Drop tables
-- -----------------------------------------------------

-- drop table Patient;
-- drop table Consultation;
-- drop table Orthodontist;
-- drop table TreatmentPlan;
-- drop table FollowUpAppointment;
-- drop table Braces;
-- drop table PatientPhones;

-- -----------------------------------------------------
-- Create table Patient
-- -----------------------------------------------------

create table if not exists Patient
( 
  PPS varchar(9) not null, 
  fName varchar(40) not null,
  lName varchar(40) not null,
  streetNo varchar(3) not null,
  streetName varchar(50) not null,
  county varchar(20) not null,
  DOB date,
  primary key (PPS)
);

-- -----------------------------------------------------
-- Create table Orthodontist
-- -----------------------------------------------------

create table if not exists Orthodontist
( 
  staffId int auto_increment not null,
  firstName varchar(40) not null,
  lastName varchar(40) not null,
  salary decimal(7,2) not null,
  contractedHoursPerWeek decimal(3,1) not null,
  assistedStaffId int,
  primary key (staffId),
  foreign key (assistedStaffId) references Orthodontist(staffId) on update cascade on delete set null
);


-- -----------------------------------------------------
-- Create table Consultation
-- -----------------------------------------------------

create table if not exists Consultation
( 
  consultationId int auto_increment not null,
  consultationDate date not null,
  description varchar(250),
  dateBooked date,
  PPS varchar(9) not null,
  staffId int not null,
  primary key (consultationId),
  foreign key (PPS) references Patient(PPS) on update cascade on delete no action,
  foreign key (staffId) references Orthodontist(staffId) on update cascade on delete no action
);

-- -----------------------------------------------------
-- Create table TreatmentPlan
-- -----------------------------------------------------

create table if not exists TreatmentPlan
( 
  planId int auto_increment not null,
  planName varchar(40) not null,
  lengthOfPlan int not null,
  description varchar(250),
  cost decimal(6,2) not null,
  consultationId int not null,
  PPS varchar(9) not null,
  primary key (planId),
  foreign key (consultationId) references Consultation(consultationId) on update cascade on delete no action,
  foreign key (PPS) references Patient(PPS) on update cascade on delete no action
);

-- -----------------------------------------------------
-- Create table FollowUpAppointment
-- -----------------------------------------------------

create table if not exists FollowUpAppointment
( 
  appointmentId int auto_increment not null,
  appointmentDate date not null,
  description varchar(250),
  planId int not null,
  primary key (appointmentId),
  foreign key (planId) references TreatmentPlan(planId) on update cascade on delete cascade
);

-- -----------------------------------------------------
-- Create table Braces
-- -----------------------------------------------------

create table if not exists Braces
( 
  planId int not null,
  type varchar(50) not null,
  supplier varchar(80),
  primary key (planId, type),
  foreign key (planId) references TreatmentPlan(planId) on update cascade on delete cascade
);

-- -----------------------------------------------------
-- Create table PatientPhones
-- -----------------------------------------------------

create table if not exists PatientPhones
( 
  phoneNo varchar(15) not null,
  PPS varchar(9) not null,
  primary key (phoneNo),
  foreign key (PPS) references Patient(PPS) on update cascade on delete cascade
);

-- -----------------------------------------------------
-- Populate table Patient
-- -----------------------------------------------------

insert into Patient values
('1462289P', 'Lauren', 'O Neill', '24', 'Fairview Drive', 'Waterford', '1995-08-24');

insert into Patient values
('5954118OK', 'Kelsey', 'Burke', '3', 'Patrick Street', 'Kilkenny', '2001-03-18');

insert into Patient values
('3231866J', 'Darren', 'Williams', '73', 'Orchards Road', 'Wexford', '2000-01-06');

insert into Patient values
('0482114AS', 'Annie', 'Elliot', '14', 'John Street', 'Waterford', '2002-02-22');

insert into Patient values
('1224771S', 'Matthew', 'Atkins', '12', 'Knockhouse Close', 'Waterford', '1999-12-02');

insert into Patient values
('8923444BA', 'Craig', 'Power', '2', 'Prairy Lawn', 'Kilkenny', '2005-10-30');

insert into Patient values
('7355512E', 'Sarah', 'O Brien', '23', 'Woodlawn Grove', 'Waterford', '2004-07-12');

insert into Patient values
('9451478O', 'Tristan', 'Clarke', '68', 'Fairfield Avenue', 'Wexford', '1996-09-01');

insert into Patient values
('1239891MO', 'Eoin', 'Finnigan', '6', 'Fiodh Mor', 'Waterford', '2002-06-26');

insert into Patient values
('2044867Q', 'Elle', 'Lonergan', '34', 'Airview Point', 'Kilkenny', '1992-02-13');

insert into Patient values
('4900513W', 'Anthony', 'O Connor', '51', 'Green Terrace', 'Waterford', '1986-04-28');

insert into Patient values
('9833236BT', 'Grace', 'Dowling', '19', 'Priory Road', 'Waterford', '2005-05-09');

insert into Patient values
('1175470O', 'Jack', 'Hogan', '36', 'Michael Street', 'Kilkenny', '2003-01-18');

insert into Patient values
('7247897E', 'Michaela', 'Quinn', '1', 'Farthing Grove', 'Wexford', '2004-03-31');

insert into Patient values
('2935714U', 'Sean', 'McNamara', '11', 'Airfield Close', 'Waterford', '1999-12-31');

insert into Patient values
('6323290QK', 'Brooke', 'Anderson', '103', 'Clement Drive', 'Waterford', '2004-12-31');

-- -----------------------------------------------------
-- Populate table Orthodontist
-- -----------------------------------------------------

insert into Orthodontist(firstName, lastName, salary, contractedHoursPerWeek) values
('Jane', 'Morris', '80000', 37.5);

insert into Orthodontist(firstName, lastName, salary, contractedHoursPerWeek) values
('Joe', 'Power', '85000', 40);

insert into Orthodontist(firstName, lastName, salary, contractedHoursPerWeek) values
('Claire', 'Rogers', '90000', 40);

insert into Orthodontist(firstName, lastName, salary, contractedHoursPerWeek) values
('Marian', 'Moore', '80000', 37.5);

insert into Orthodontist(firstName, lastName, salary, contractedHoursPerWeek) values
('Patrick', 'Jones', '85000', 40);

insert into Orthodontist(firstName, lastName, salary, contractedHoursPerWeek) values
('Pauline', 'O Keefe', '80000', 37.5);

insert into Orthodontist(firstName, lastName, salary, contractedHoursPerWeek) values
('Sheila', 'Donovan', '80000', 37.5);

-- -----------------------------------------------------
-- Update table Orthodontist to include assistedStaffId
-- -----------------------------------------------------

update Orthodontist 
set assistedStaffId = 2
where staffId = 1;

update Orthodontist 
set assistedStaffId = 4
where staffId = 2;

update Orthodontist 
set assistedStaffId = 6
where staffId = 3;

update Orthodontist 
set assistedStaffId = 1
where staffId = 4;

update Orthodontist 
set assistedStaffId = 7
where staffId = 5;

update Orthodontist 
set assistedStaffId = 4
where staffId = 6;

update Orthodontist 
set assistedStaffId = 5
where staffId = 7;

-- -----------------------------------------------------
-- Populate table Consultation
-- -----------------------------------------------------

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2019-03-31', 'Patient has misaligned incisors and canines top and bottom. Treatment plan recommended.', '2019-03-28', '5954118OK', 5);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2019-04-02', 'Patient has severely misaligned teeth all across top and bottom. Treatment plan recommended.', '2019-03-31', '1462289P', 3);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2019-06-10', 'Patient has slightly misaligned incisors but nothing drastic. Treatment plan optional.', '2019-06-07', '0482114AS', 1);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2019-07-16', 'Patient has misaligned canines and molars top and bottom. Treatment plan recommended.', '2019-07-09', '3231866J', 4);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2019-10-03', 'Patient has slightly misaligned bottom teeth but nothing drastic. Treatment plan optional.', '2019-09-30', '1224771S', 7);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2019-10-19', 'Patient has misaligned bottom teeth and slightly misaligned top teeth. Treatment plan recommended.', '2019-10-15', '7355512E', 2);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2019-12-12', 'Patient has misaligned bottom teeth and severely misaligned top teeth. Treatment plan recommended.', '2019-12-04', '9451478O', 3);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2019-12-12', 'Patient has misaligned bottom teeth and severely misaligned top teeth. Treatment plan recommended.', '2019-12-06', '1239891MO', 6);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2020-01-07', 'Patient has severely misaligned bottom teeth and moderately misaligned top teeth. Treatment plan recommended.', '2020-01-03', '2044867Q', 3);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2020-01-28', 'Patient has severely misaligned teeth top and bottom. Treatment plan recommended.', '2020-01-24', '4900513W', 3);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2020-03-20', 'Patient has slightly misaligned teeth top and bottom. Treatment plan optional.', '2020-03-14', '9833236BT', 5);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2020-05-17', 'Patient has misaligned teeth top and bottom. Treatment plan recommended.', '2020-05-13', '1175470O', 4);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2020-08-25', 'Patient has severely misaligned teeth top and and slighly misaligned bottom. Treatment plan recommended.', '2020-08-19', '7247897E', 1);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2020-10-01', 'Patient has severely misaligned incisors bottom. Treatment plan recommended.', '2020-09-24', '2935714U', 7);

insert into Consultation(consultationDate, description, dateBooked, PPS, staffId) values
('2020-12-08', 'Patient has misaligned incisors and molars top and bottom. Treatment plan recommended.', '2020-12-03', '6323290QK', 2);

-- -----------------------------------------------------
-- Populate table TreatmentPlan
-- -----------------------------------------------------

insert into TreatmentPlan(planName, lengthOfPlan, description, cost, consultationId, PPS) values
('Full set medium term', 24, 'Full train tracks top and bottom to be tightened once a month every month for 24 months at least.', 3000, 1, '5954118OK');

insert into TreatmentPlan(planName, lengthOfPlan, description, cost, consultationId, PPS) values
('Clear set long term', 36, 'Clear train tracks top and bottom to be tightened once a month every month for 36 months at least.', 4000, 2, '1462289P');

insert into TreatmentPlan(planName, lengthOfPlan, description, cost, consultationId, PPS) values
('Bottom set short term', 12, 'Train tracks bottom to be tightened once a month every month for 12 months at least.', 750, 5, '1224771S');

insert into TreatmentPlan(planName, lengthOfPlan, description, cost, consultationId, PPS) values
('Bottom set medium term', 24, 'Full train tracks bottom to be tightened once a month every month for 24 months at least.', 2000, 6, '7355512E');

insert into TreatmentPlan(planName, lengthOfPlan, description, cost, consultationId, PPS) values
('Full set long term', 36, 'Full train tracks bottom and top to be tightened once a month every month for 36 months at least.', 4500, 7, '9451478O');

insert into TreatmentPlan(planName, lengthOfPlan, description, cost, consultationId, PPS) values
('Full set long term', 36, 'Full train tracks bottom and top to be tightened once a month every month for 36 months at least.', 4500, 8, '1239891MO');

insert into TreatmentPlan(planName, lengthOfPlan, description, cost, consultationId, PPS) values
('Full set long term', 36, 'Full train tracks top and bottom to be tightened once a month every month for 36 months at least.', 4500, 9, '2044867Q');

insert into TreatmentPlan(planName, lengthOfPlan, description, cost, consultationId, PPS) values
('Clear set long term', 36, 'Clear train tracks top and bottom to be tightened once a month every month for 36 months at least.', 4000, 10, '4900513W');

insert into TreatmentPlan(planName, lengthOfPlan, description, cost, consultationId, PPS) values
('Full set medium term', 24, 'Full train tracks top and bottom to be tightened once a month every month for 24 months at least.', 3500, 12, '1175470O');

insert into TreatmentPlan(planName, lengthOfPlan, description, cost, consultationId, PPS) values
('Top set long term', 36, 'Full train tracks top to be tightened once a month every month for 36 months at least.', 3500, 13, '7247897E');

insert into TreatmentPlan(planName, lengthOfPlan, description, cost, consultationId, PPS) values
('Bottom set long term', 36, 'Full train tracks bottom to be tightened once a month every month for 36 months at least.', 3500, 14, '2935714U');

insert into TreatmentPlan(planName, lengthOfPlan, description, cost, consultationId, PPS) values
('Full set medium term', 24, 'Full train tracks top and bottom to be tightened once a month every month for 24 months at least.', 3500, 15, '6323290QK');

-- -----------------------------------------------------
-- Populate table FollowUpAppointment
-- -----------------------------------------------------

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-04-30', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-06-04', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-07-03', 'Fixed top set brace popped off. Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-08-10', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-09-09', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-10-04', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-11-06', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-12-08', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-01-20', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-02-25', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-03-24', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-04-30', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-06-03', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-07-05', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-08-10', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-09-13', 'Both tracks tightened. Patient making good progress', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-10-12', 'Both tracks tightened.', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-11-14', 'Both tracks tightened. Appointment next month not necesary. Patient will have braces removed in next follow up appointment in January (date TBC)', 1);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-05-03', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-06-06', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-07-05', 'Both tracks tightened. Progress unusually slow, assigned patient tightening bands.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-08-10', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-09-12', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-10-15', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-11-18', 'Both tracks tightened. Progress back on track. Tightening bands removed.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-12-14', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-01-24', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-02-25', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-04-02', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-05-06', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-06-07', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-07-10', 'Both tracks tightened. Progress slowing again. Assigned tightening bands.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-08-13', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-09-16', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-10-14', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-11-14', 'Both tracks tightened. Progress back on track. Tightening bands removed.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-12-10', 'Both tracks tightened.', 2);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-10-03', 'Tracks tightened.', 3);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-11-06', 'Tracks tightened.', 3);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-12-12', 'Tracks tightened.', 3);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-01-20', 'Tracks tightened.', 3);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-02-23', 'Tracks tightened.', 3);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-03-20', 'Tracks tightened. Patient is progressing well.', 3);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-04-30', 'Tracks tightened.', 3);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-06-03', 'Tracks tightened.', 3);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-07-09', 'Tracks tightened.', 3);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-08-12', 'Tracks tightened.', 3);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-09-15', 'Tracks tightened. Patient is ready to have braces removed at the next appointment', 3);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-10-03', 'Braces removed. Patient is happy with the results', 3);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2019-11-19', 'Tracks tightened.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-01-06', 'Tracks tightened.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-02-04', 'Tracks tightened.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-03-04', 'Tracks tightened.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-04-04', 'Tracks tightened.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-05-06', 'Tracks tightened.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-06-09', 'Tracks tightened.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-07-12', 'Tracks tightened.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-08-11', 'Tracks tightened.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-09-17', 'Tracks tightened.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-10-22', 'Tracks tightened.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-10-21', 'Tracks tightened.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-11-24', 'Tracks tightened. Patient is progressing well.', 4);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-01-11', 'Both tracks tightened.', 5);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-02-13', 'Both tracks tightened.', 5);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-03-13', 'Both tracks tightened.', 5);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-04-15', 'Both tracks tightened.', 5);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-05-17', 'Both tracks tightened.', 5);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-06-17', 'Both tracks tightened. Progress moving slow. Assigned tightening bands.', 5);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-07-20', 'Both tracks tightened.', 5);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-08-22', 'Both tracks tightened.', 5);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-09-28', 'Both tracks tightened.', 5);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-11-02', 'Both tracks tightened. Progress back on track. Tightening bands removed.', 5);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-12-03', 'Both tracks tightened.', 5);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-01-10', 'Both tracks tightened.', 6);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-02-12', 'Both tracks tightened.', 6);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-03-14', 'Both tracks tightened.', 6);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-04-14', 'Both tracks tightened.', 6);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-05-12', 'Both tracks tightened. Struggling to get progress with top braces. Assigned top tightening bands.', 6);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-06-14', 'Both tracks tightened.', 6);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-07-17', 'Both tracks tightened.', 6);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-08-20', 'Both tracks tightened.', 6);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-10-20', 'Both tracks tightened.', 6);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-11-20', 'Both tracks tightened. Progress moving well. Removed top tightening bands.', 6);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-02-08', 'Both tracks tightened.', 7);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-03-09', 'Both tracks tightened.', 7);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-03-10', 'Both tracks tightened.', 7);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-03-12', 'Both tracks tightened.', 7);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-04-12', 'Both tracks tightened.', 7);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-05-13', 'Both tracks tightened.', 7);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-06-15', 'Both tracks tightened.', 7);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-07-17', 'Both tracks tightened.', 7);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-08-16', 'Both tracks tightened.', 7);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-09-20', 'Both tracks tightened.', 7);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-10-23', 'Both tracks tightened.', 7);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-11-20', 'Both tracks tightened. Top braces progressing much quicker than bottom. Bottom tightening braces assigned.', 7);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-03-03', 'Both tracks tightened.', 8);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-04-05', 'Top brace popped off. Fixed this and both tracks tightened.', 8);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-05-05', 'Both tracks tightened.', 8);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-06-10', 'Both tracks tightened.', 8);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-07-09', 'Both tracks tightened.', 8);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-08-11', 'Both tracks tightened.', 8);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-09-13', 'Both tracks tightened. Progress moving slowly. Assigned clear bands top and bottom.', 8);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-10-18', 'Both tracks tightened.', 8);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-11-21', 'Both tracks tightened.', 8);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-09-27', 'Both tracks tightened. Bottom braces progressing fast and expected to be removed in 12 months.', 9);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-10-28', 'Both tracks tightened.', 9);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-11-30', 'Both tracks tightened.', 9);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-12-01', 'Both tracks tightened.', 9);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-09-27', 'Both tracks tightened. Bottom braces expected to be removed in 10 months.', 10);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-11-02', 'Both tracks tightened.', 10);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-12-03', 'Both tracks tightened.', 10);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-11-03', 'Tracks tightened.', 11);

insert into FollowUpAppointment(appointmentDate, description, planId) values
('2020-12-05', 'Tracks tightened.', 11);

-- -----------------------------------------------------
-- Populate table Braces
-- -----------------------------------------------------

insert into Braces values
(1, 'Standard silver multi top and bottom train tracks', 'Ace Braces');
 
insert into Braces values
(2, 'Clear aligner multi top and bottom', 'Clear Braces');

insert into Braces values
(3, 'Standard silver single bottom train tracks', 'Alibaba');

insert into Braces values
(4, 'Standard silver single bottom train tracks', 'Ace Braces');

insert into Braces values
(5, 'Standard silver multi top and bottom train tracks', 'Alibaba');

insert into Braces values
(6, 'Standard silver multi top and bottom train tracks', 'Alibaba');

insert into Braces values
(7, 'Standard silver multi top and bottom train tracks', 'Ace Braces');

insert into Braces values
(8, 'Clear aligner multi top and bottom', 'Clear Braces');

insert into Braces values
(9, 'Standard silver multi top and bottom train tracks', 'Ace Braces');

insert into Braces values
(10, 'Standard silver single top train tracks', 'Ace Braces');

insert into Braces values
(11, 'Standard silver single bottom train tracks', 'Alibaba');

insert into Braces values
(12, 'Standard silver multi top and bottom train tracks', 'Alibaba');

-- -----------------------------------------------------
-- Populate table PatientPhones
-- -----------------------------------------------------

insert into PatientPhones values
('0873015448', '1462289P');

insert into PatientPhones values
('0860273927', '1462289P');

insert into PatientPhones values
('0869957849', '5954118OK');

insert into PatientPhones values
('0859098309', '3231866J');

insert into PatientPhones values
('0830587450', '3231866J');

insert into PatientPhones values
('0830294978', '3231866J');

insert into PatientPhones values
('0859137145', '0482114AS');

insert into PatientPhones values
('0874199682', '1224771S');

insert into PatientPhones values
('0851814367', '8923444BA');

insert into PatientPhones values
('0867298243', '7355512E');

insert into PatientPhones values
('0857815708', '7355512E');

insert into PatientPhones values
('0865743801', '9451478O');

insert into PatientPhones values
('0871292902', '1239891MO');

insert into PatientPhones values
('0877046761', '2044867Q');

insert into PatientPhones values
('0860151012', '4900513W');

insert into PatientPhones values
('0872722748', '9833236BT');

insert into PatientPhones values
('0867303593', '1175470O');

insert into PatientPhones values
('0853247096', '7247897E');

insert into PatientPhones values
('0877728142', '7247897E');

insert into PatientPhones values
('0832231395', '2935714U');

insert into PatientPhones values
('0862197459', '6323290QK');