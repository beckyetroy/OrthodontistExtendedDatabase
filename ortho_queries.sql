 

-- -----------------------------------------------------
-- Returns all patients and their details
-- -----------------------------------------------------

select concat(fname, ' ', lname) as 'Name', PPS as 'PPS Number', 
concat(streetNo, ' ', streetName, ', ', county) as 'Address', date_format(DOB, '%d/%m/%Y') as 'Date of Birth'
from Patient;

-- -----------------------------------------------------
-- Returns all patients and their contact details
-- -----------------------------------------------------

select distinct concat(fname, ' ', lname) as 'Name',  phoneNo as 'Phone Number(s)'
from Patient join PatientPhones
on Patient.PPS = PatientPhones.PPS
order by lname, fname;

-- -----------------------------------------------------
-- Returns all orthodontists and their details
-- -----------------------------------------------------

select staffId as 'Staff ID', concat(firstName, ' ', lastName) as 'Name',
format(salary,2) as 'Annual Salary', contractedHoursPerWeek as 'Weekly Hours'
from Orthodontist
order by lastName, firstName;

-- -----------------------------------------------------
-- Returns all orthodontist and corresponding assistant names
-- -----------------------------------------------------

select concat(Orthodontist.firstName, ' ', Orthodontist.lastName) as 'Orthodontist Name',
ifnull(concat (AssistedOrthodontist.firstName, ' ', AssistedOrthodontist.lastName), 'N/A') as 'Is Assisted By'
from Orthodontist as Orthodontist
left join Orthodontist as AssistedOrthodontist
on Orthodontist.staffId = AssistedOrthodontist.assistedStaffId
order by Orthodontist.lastName, Orthodontist.firstName;

-- -----------------------------------------------------
-- Returns all consultation details
-- -----------------------------------------------------

select consultationId as 'Consultation ID', date_format(consultationDate, '%D %b %Y') as 'Consultation Date',
concat(fName, ' ', lName) as 'Patient Name', concat(firstName, ' ', lastName) as 'Staff Member', description as 'Description'
from Consultation join Patient
on Consultation.PPS = Patient.PPS
join Orthodontist
on Consultation.staffId = Orthodontist.staffId
order by consultationDate desc;

-- -----------------------------------------------------
-- Returns all consultation details, carried out by a particular staff member by searching staff name (Claire Rogers)
-- -----------------------------------------------------

select concat(firstName, ' ', lastName) as 'Staff Member', consultationId as 'Consultation ID',
date_format(consultationDate, '%D %b %Y') as 'Consultation Date',
concat(fName, ' ', lName) as 'Patient Name', description as 'Description'
from Consultation join Orthodontist
on Consultation.staffId = Orthodontist.staffId
join Patient
on Patient.PPS = Consultation.PPS
where lastName = 'Rogers' and firstName = 'Claire'
order by consultationDate desc;

-- -----------------------------------------------------
-- Returns all consultation details carried out in the year 2020
-- -----------------------------------------------------

select concat(firstName, ' ', lastName) as 'Staff Member', consultationId as 'Consultation ID',
date_format(consultationDate, '%D %b %Y') as 'Consultation Date',
concat(fName, ' ', lName) as 'Patient Name', description as 'Description'
from Consultation join Orthodontist
on Consultation.staffId = Orthodontist.staffId
join Patient
on Patient.PPS = Consultation.PPS
where consultationDate > '2019-12-31' and consultationDate < '2021-01-01'
order by consultationDate desc;

-- -----------------------------------------------------
-- Returns all treatment plans details
-- -----------------------------------------------------

select planId as 'Plan ID', planName as 'Name of Plan',
concat(fName, ' ', lName) as 'Patient Name', cost as 'Cost of Plan', 
description as 'Description'
from TreatmentPlan join Patient
on TreatmentPlan.PPS = Patient.PPS;

-- -----------------------------------------------------
-- Returns the average, maximum, and minimum cost for all treatment plans recorded
-- -----------------------------------------------------

select max(cost) as 'Most Expensive Plan', min(cost) as 'Least Expensive Plan',
round(avg(cost),2) as 'Average Cost for Plans'
from TreatmentPlan;

-- -----------------------------------------------------
-- Returns the number of treatment plans by plan name
-- -----------------------------------------------------

select planName as 'Name of Treatment Plan', count(planId) as 'Number of Plans'
from TreatmentPlan
group by planName;

-- -----------------------------------------------------
-- Returns the patients who didn't agree to a treatment plan
-- -----------------------------------------------------

select concat(fname, ' ', lname) as 'Patients who have not received a Treatment Plan'
from Patient left join TreatmentPlan
on Patient.PPS = TreatmentPlan.PPS
where planId is null
order by lname, fname;

-- -----------------------------------------------------
-- Returns the patients who received a consultation but didn't agree to a treatment plan
-- -----------------------------------------------------

select concat(fname, ' ', lname) as 'Patients who have not received a Treatment Plan'
from Patient left join TreatmentPlan
on Patient.PPS = TreatmentPlan.PPS
left join Consultation
on Patient.PPS = Consultation.PPS
where planId is null and Consultation.consultationId is not null
order by lname, fname;

-- -----------------------------------------------------
-- Returns the number of Follow Up Appointments had by each Patient
-- -----------------------------------------------------

select distinct concat(fName, ' ', lName) as 'Patient Name', ifNull(planName, 'N/A') as 'Name of Plan',
count(appointmentId) as 'Number of Follow Up Appointments'
from TreatmentPlan right join Patient
on TreatmentPlan.PPS = Patient.PPS
left join FollowUpAppointment 
on TreatmentPlan.planId = FollowUpAppointment.planId
group by lName, fName
order by lName, fName;

-- -----------------------------------------------------
-- Returns the amount of months / appointments left for each patient to complete their plan
-- -----------------------------------------------------

select concat(fName, ' ', lName) as 'Patient Name', planName as 'Name of Plan',
lengthOfPlan - count(appointmentId) as 'Months Remaining in Plan'
from TreatmentPlan left join FollowUpAppointment
on TreatmentPlan.planId = FollowUpAppointment.planId
join Patient
on TreatmentPlan.PPS = Patient.PPS
group by lName, fName
order by lName, fName;

-- -----------------------------------------------------
-- Returns all follow up appointment details of a particular patient (Anthony O Connor)
-- -----------------------------------------------------

select concat(fName, ' ', lName) as 'Patient Name', appointmentId as 'Appointment ID',
date_format(appointmentDate, '%D %b %Y') as 'Appointment Date', FollowUpAppointment.description as 'Description'
from FollowUpAppointment join TreatmentPlan
on FollowUpAppointment.planId = TreatmentPlan.planId
join Patient
on Patient.PPS = TreatmentPlan.PPS
where lName = 'O Connor' and fName = 'Anthony'
order by appointmentDate desc;

-- -----------------------------------------------------
-- Returns braces details
-- -----------------------------------------------------

select type as 'Brace Type', supplier as 'Supplier', planName as 'Name of Plan',
concat(fname, ' ', lname) as 'Name of Patient'
from Braces join TreatmentPlan
on Braces.planId = TreatmentPlan.planId
join Patient
on TreatmentPlan.PPS = Patient.PPS
order by type;

-- -----------------------------------------------------
-- Returns single braces details
-- -----------------------------------------------------

select type as 'Brace Type', supplier as 'Supplier', planName as 'Name of Plan',
concat(fname, ' ', lname) as 'Name of Patient'
from Braces join TreatmentPlan
on Braces.planId = TreatmentPlan.planId
join Patient
on TreatmentPlan.PPS = Patient.PPS
where type like '%single%'
order by type;

-- -----------------------------------------------------
-- Returns braces details from supplier 'Ace Braces'
-- -----------------------------------------------------

select type as 'Brace Type', supplier as 'Supplier', planName as 'Name of Plan',
concat(fname, ' ', lname) as 'Name of Patient'
from Braces join TreatmentPlan
on Braces.planId = TreatmentPlan.planId
join Patient
on TreatmentPlan.PPS = Patient.PPS
where supplier like '%Ace Braces%'
order by type;