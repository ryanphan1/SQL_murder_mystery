--Exploring the crime scene report data
SELECT *
FROM crime_scene_report

SELECT *
FROM crime_scene_report
WHERE date = 20180115 AND city = 'SQL City'

SELECT *
FROM person

--Querying the witnesses
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number

--14887	Morty Schapiro	118009	4919 Northwestern Dr	111564949 - Witness 1
SELECT *
FROM person
WHERE address_street_name = 'Franklin Ave'
ORDER BY address_number
--16371	Annabel Miller	490173	103	Franklin Ave 318771143 = Witness 2

--Connecting the relationship between the witnesses, Annabel is a member of the gym and Morty is not.
SELECT DISTINCT *
FROM get_fit_now_check_in as C
INNER JOIN get_fit_now_member as M
ON C.membership_id = M.id
INNER JOIN person as P
ON M.person_id = P.id
WHERE M.name = 'Annabel Miller'
              
--90081(membership_id)	90081(id)	16371(person_id)	Annabel Miller	20160208	gold	16371(id)	Annabel Miller	490173	103	Franklin Ave	318771143

SELECT DISTINCT *
FROM interview AS i
JOIN get_fit_now_member AS m
ON i.person_id = m.person_id
WHERE i.person_id = '16371'
--Annabel witness interview
--16371	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th. 20160208 gold

 SELECT *
FROM interview AS i
WHERE i.person_id = '14887'
--Morty witness interview
--14887	I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".

--Exploring Mortys interview report
SELECT C.membership_id, m.name, m.membership_status, p.license_id, l.plate_number
FROM get_fit_now_check_in AS c
JOIN get_fit_now_member AS m
ON c.membership_id = m.id
JOIN person AS p
ON m.person_id = p.id
JOIN drivers_license AS l
ON p.license_id = l.id
WHERE c.membership_id LIKE '%48Z%'


--Exploring Annabels interview report
SELECT check_in_date
FROM get_fit_now_check_in
WHERE check_in_date LIKE '____0109'
              
SELECT check_in_date, membership_id, m.name
FROM get_fit_now_check_in AS C
JOIN get_fit_now_member AS m
ON c.membership_id = m.id
WHERE check_in_date LIKE '20180109'

SELECT check_in_date, membership_id, m.name, i.transcript
FROM get_fit_now_check_in AS C
JOIN get_fit_now_member AS m
ON c.membership_id = m.id
JOIN interview AS i
ON m.person_id = i.person_id
WHERE check_in_date LIKE '20180109'
-- Jeremys interview report
--20180109	48Z55	Jeremy Bowers	I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.

SELECT *
FROM facebook_event_checkin AS f
JOIN get_fit_now_member AS m
ON f.person_id = m.person_id
WHERE date = 20180115
              
--The Funky Grooves Tour	20180115	48Z55	67318	Jeremy Bowers	20160101	gold
--Connecting the killer with the person that hired him

SELECT *
FROM facebook_event_checkin 
WHERE event_name ='SQL Symphony Concert' AND date LIKE '201712__'

SELECT p.name, count(f.person_id) AS count
FROM facebook_event_checkin AS f
JOIN person AS p
ON f.person_id = p.id
WHERE event_name ='SQL Symphony Concert' AND date LIKE '201712__'
GROUP BY f.person_id, p.name
HAVING count = 3

SELECT PERSON_id, count(person_id) as COUNT
FROM facebook_event_checkin AS f
WHERE event_name ='SQL Symphony Concert' AND date LIKE '201712__'
GROUP BY person_id
HAVING COUNT = 3

--24556	Bryan Pardo	3 99716	Miranda Priestly 3

SELECT d.hair_color, d.car_model, d.height, p.name
FROM person AS p
JOIN drivers_license AS d
ON p.license_id = d.id
WHERE p.id = '24556' OR p.id = '99716'

--ANSWER = Jeremy Bowers AND Miranda Priestly

              



