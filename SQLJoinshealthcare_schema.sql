-- =================================================================
-- SQL Query Script: Merging Data with JOINs
-- =================================================================
-- This script demonstrates how to combine rows from two or more
-- tables based on a related column between them. We will use the
-- Patients, Doctors, and Appointments tables.
-- =================================================================
-- Selects the 'healthcare' database to ensure all subsequent commands are run against it.
use healthcare;
-- =================================================================
-- 1. INNER JOIN (The Overlap)
-- =================================================================
-- This is the most common join. It returns only the rows where
-- the join condition is met in BOTH tables. Think of it as the
-- perfect overlap, the prime cut.

-- Query 1: Get a list of all appointments with patient and doctor names.
-- This will only show appointments where both the patient and doctor exist.
SELECT
    A.AppointmentID,
    A.AppointmentDateTime,
    P.FirstName AS PatientFirstName,
    P.SecondName AS PatientSecondName,
    D.FirstName AS DoctorFirstName,
    D.SecondName AS DoctorSecondName
FROM
    Appointments AS A
INNER JOIN
    Patients AS P ON A.PatientID = P.PatientID
INNER JOIN
    Doctors AS D ON A.DoctorID = D.DoctorID;

-- Query 2: Find which patients have appointments with a Cardiologist.
SELECT
    P.FirstName,
    P.SecondName,
    P.Email
FROM
    Patients AS P
INNER JOIN
    Appointments AS A ON P.PatientID = A.PatientID
INNER JOIN
    Doctors AS D ON A.DoctorID = D.DoctorID
WHERE
    D.Specialization = 'Cardiology';


-- =================================================================
-- 2. LEFT JOIN (All from the Left, Matches from the Right)
-- =================================================================
-- This returns ALL rows from the left table, and the matched rows
-- from the right table. If there's no match, the right side is NULL.

-- Query 1: Show ALL patients and any appointments they may have.
-- Patients without any appointments will still be listed, but their appointment details will be NULL.
SELECT
    P.FirstName,
    P.SecondName,
    A.AppointmentID,
    A.AppointmentDateTime
FROM
    Patients AS P
LEFT JOIN
    Appointments AS A ON P.PatientID = A.PatientID;

-- Query 2: Find patients who have NEVER booked an appointment.
-- We do a LEFT JOIN and then filter for the rows where the right side (Appointments) is NULL.
SELECT
    P.FirstName,
    P.SecondName,
    P.PhoneNumber
FROM
    Patients AS P
LEFT JOIN
    Appointments AS A ON P.PatientID = A.PatientID
WHERE
    A.AppointmentID IS NULL;


-- =================================================================
-- 3. RIGHT JOIN (All from the Right, Matches from the Left)
-- =================================================================
-- This is the reverse of a LEFT JOIN. It returns ALL rows from the
-- right table, and the matched rows from the left.

-- Query 1: Show ALL doctors and any appointments they have scheduled.
-- Doctors with no appointments will still be listed.
SELECT
    D.FirstName,
    D.SecondName,
    D.Specialization,
    A.AppointmentID,
    A.AppointmentDateTime
FROM
    Appointments AS A
RIGHT JOIN
    Doctors AS D ON A.DoctorID = D.DoctorID;

-- Query 2: Find doctors who have no appointments scheduled.
-- We do a RIGHT JOIN and then filter for where the left side (Appointments) is NULL.
SELECT
    D.FirstName,
    D.SecondName,
    D.Specialization
FROM
    Appointments AS A
RIGHT JOIN
    Doctors AS D ON A.DoctorID = D.DoctorID
WHERE
    A.AppointmentID IS NULL;


-- =================================================================
-- 4. FULL OUTER JOIN (All from Both Sides)
-- =================================================================
-- This returns all rows when there is a match in either the left or
-- the right table. It's like combining a LEFT and RIGHT JOIN.
-- NOTE: MySQL does not have a dedicated FULL OUTER JOIN keyword.
-- You have to simulate it by combining a LEFT and RIGHT JOIN with UNION.

-- Query 1: Show every patient and every doctor, matched up where they have an appointment.
-- This will list all patients (even those without appointments), and all doctors (even those without appointments).
SELECT
    P.FirstName AS PatientFirstName,
    P.SecondName AS PatientSecondName,
    D.FirstName AS DoctorFirstName,
    D.SecondName AS DoctorSecondName
FROM
    Patients AS P
LEFT JOIN
    Appointments AS A ON P.PatientID = A.PatientID
LEFT JOIN
    Doctors AS D ON A.DoctorID = D.DoctorID

UNION

SELECT
    P.FirstName AS PatientFirstName,
    P.SecondName AS PatientSecondName,
    D.FirstName AS DoctorFirstName,
    D.SecondName AS DoctorSecondName
FROM
    Doctors AS D
LEFT JOIN
    Appointments AS A ON D.DoctorID = A.DoctorID
LEFT JOIN
    Patients AS P ON A.PatientID = P.PatientID;
