**SQL JOIN Operations | Task 05**
This repository contains the SQL script **SQLJoinshealthcare_schema.sql**, which provides a practical demonstration of merging data from multiple related tables. Using a healthcare database schema (Patients, Doctors, Appointments), the script showcases the four primary types of SQL JOINs to answer real-world questions and construct comprehensive datasets.

A key highlight of this task is the simulation of a FULL OUTER JOIN in MySQL, which does not natively support this operation.


**Tasks Performed & Core Concepts**
The script is structured to clearly demonstrate each type of JOIN, explaining its purpose and providing practical query examples.



**1. INNER JOIN (The Intersection)**
This section focuses on the most common type of join, which retrieves only the rows that have matching values in both tables.

**Query 1**: Constructs a detailed list of all appointments, pulling in the names of the patient and the doctor from their respective tables.

**Query 2**: Performs a multi-table join to answer a specific business question: "Which patients have an appointment with a Cardiologist?"



**2. LEFT JOIN (All from the Left)**
This join retrieves all records from the "left" table and the matched records from the "right" table. If no match is found, NULL is returned for the columns from the right table.

**Query 1**: Lists all patients and any appointments they have scheduled. Patients without appointments are still included in the result.

**Query 2**: A classic use case for LEFT JOIN, this query identifies which patients have never booked an appointment by filtering for records where the appointment information is NULL.



**3. RIGHT JOIN (All from the Right)**
This is the logical reverse of the LEFT JOIN, retrieving all records from the "right" table and any matching records from the "left" table.

**Query 1**: Lists all doctors in the system and any appointments they are assigned to. Doctors who have no scheduled appointments are still included.

**Query 2**: Identifies all doctors who currently have no appointments by filtering for records where the appointment information is NULL.



**4. FULL OUTER JOIN (All from Both)**
This join retrieves all records when there is a match in either the left or the right table. It effectively combines the results of both LEFT and RIGHT JOINs.

**Challenge**: MySQL does not have a native FULL OUTER JOIN keyword.

**Diagnosis & Solution**: The script demonstrates the standard workaround to simulate this join by combining a LEFT JOIN and a RIGHT JOIN (or two LEFT JOINs on swapped tables) using the UNION operator. The query successfully produces a master list of all patients and all doctors, linking them where an appointment relationship exists.



**How to Use**
Ensure the healthcare database schema is created and populated with data.

Open the SQLJoinshealthcare_schema.sql file in a MySQL-compatible client.

Execute the queries individually to observe how each JOIN type merges data from the tables in a unique way.
