-- Retrieve the Information from the given data in crime_scene_report.
-- crime_scene_report describes about the two witnesses present at the time of incident.
select * from crime_scene_report
where date = 20180115 and city = 'SQL City' and type = 'murder'

-- Data regarding the two witnesess including their name, address_number, street_name and also their interviews regarding the incident. 
with Person_data as (
  select * from (
  	select id, name, license_id, ssn from person 
  	where address_street_name = 'Northwestern Dr'
  	order by address_number desc
  	limit 1)
  
  union 
 
  select * from (
    select id, name, license_id, ssn from person
    where address_street_name = 'Franklin Ave'
    and name like 'Annabel%'))
select *
from Person_data as p
join interview as i
on p.id = i.person_id

-- Checking the Morty Schapiro (1st Witness) interview for validation.
with Criminals_data as (
	select dl.age, dl.car_make, p.id, p.name, p.address_number, p.address_street_name, p.ssn
	from drivers_license as dl
	join person as p
	on dl.id = p.license_id
	where dl.gender = 'male' and dl.plate_number like '%H42W%')

select Cd.name, Cd.address_number, cd.address_street_name, gf.membership_start_date, gf.membership_status
from Criminals_data as Cd
join get_fit_now_member as gf
on Cd.id = gf.person_id

-- Murderer is found out and also confirmed by the data present in the interview of Annabel Miller(2nd Witness)
select *
from get_fit_now_check_in as gf
join get_fit_now_member as gm 
on gm.id = gf.membership_id
join person as p
on p.id = gm.person_id
where gf.membership_id like '48Z%' and gm.membership_status = 'gold'

-- *** "Jeremy Bowers" is the Muderer ***

-- Now the goal is to find out the real villian behind this crime.

-- Interview of Muderer.
select * from interview
where person_id =67318

-- Checking Woman
select 	dl.plate_number, p.id, p.name, p.address_number, p.address_street_name, i.annual_income 
from  person as p
join  drivers_license as dl
on dl.id = p.license_id
join income as i
on p.ssn = i.ssn
where dl.height in (65,66,67) and dl.gender = 'female' and dl.hair_color = 'red' 
and dl.car_make = 'Tesla' and dl.car_model = 'Model S'

select *
from person as p
join facebook_event_checkin as fe
on p.id = fe.person_id
where fe.event_name = 'SQL Symphony Concert' and p.name in ('Miranda Priestly', 'Red Korb')

-- *** Mastermind of the murder is 'Miranda Priestly' ***

