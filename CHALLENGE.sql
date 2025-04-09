
INSERT INTO Companies (CompanyID, CompanyName, Location) VALUES
(1, 'Hexaware', 'France'),
(2, 'Microsoft', 'Pune'),
(3, 'Amazon', 'Chennai'),
(4, 'Facebook', 'Europe'),
(5, 'Apple', 'Paris'),
(6, 'Hexaware', 'Chennai'),
(7, 'Microsoft', 'New York'),
(8, 'Cognizant', 'Banglore'),
(9, 'Facebook', 'Chicago'),
(10, 'Apple', 'Germany');

INSERT INTO Jobs (JobID, CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate) VALUES
(1, 1, 'Software Engineer', 'Develop and maintain software.', 'France', 120000.00, 'Contract', NOW()),
(2, 2, 'Software Engineer', 'Develop applications.', 'Pune', 115000.00, 'Full-time', NOW()),
(3, 3, 'Data Scientist', 'Analyze data.', 'Chennai', 110000.00, 'Full-time', NOW()),
(4, 4, 'Cloud Engineer', 'Manage cloud solutions.', 'Europe', 118000.00, 'Full-time', NOW()),
(5, 5, 'UI/UX Designer', 'Design user interfaces.', 'Paris', 65000.00, 'Part-time', NOW()),
(6, 6, 'Software Engineer', 'Write backend code.', 'Chennai', 122000.00, 'Full-time', NOW()),
(7, 7, 'Cloud Engineer', 'Deploy cloud applications.', 'New York', 77000.00, 'Full-time', NOW()),
(8, 8, 'Data Scientist', 'Analyze business data.', 'Banglore', 112000.00, 'Full-time', NOW()),
(9, 9, 'Software Developer', 'Develop system software.', 'Chicago', 119000.00, 'Part-time', NOW()),
(10, 10, 'UI/UX Designer', 'Improve user experience.', 'Germany', 80000.00, 'Contract', NOW());

INSERT INTO Applicants (ApplicantID, FirstName, LastName, Email, Phone, Resume) VALUES
(1, 'Aara', 'Johnson', 'aara@example.com', '1234567890', 'Resume_Aara'),
(2, 'Babu', 'Smith', 'babu@example.com', '1234567891', 'Resume_Babu'),
(3, 'Durga', 'Devi', 'durgadevi@example.com', '1234567892', 'Resume_Durga'),
(4, 'Ram', 'Kumara', 'ramkumar@example.com', '1234567893', 'Resume_Ram'),
(5, 'Smriti', 'Davis', 'davis@example.com', '1234567894', 'Resume_Smriti'),
(6, 'Arun', 'Johnson', 'arunjohn@example.com', '1234567895', 'Resume_Arun'),
(7, 'Bob', 'Smith', 'bobsmithp@example.com', '1234567896', 'Resume_Bob_Dup'),
(8, 'Frank', 'Miller', 'frank@example.com', '1234567897', 'Resume_Frank'),
(9, 'Durga', 'Devi', 'durga_dup@example.com', '1234567898', 'Resume_Durga_devi'),
(10, 'Jack', 'Taylor', 'jack@example.com', '1234567899', 'Resume_Jack');

INSERT INTO Applications (ApplicationID, JobID, ApplicantID, ApplicationDate, CoverLetter) VALUES
(1, 1, 1, NOW(), 'Cover Letter for Software Engineer at Hexaware'),
(2, 2, 1, NOW(), 'Cover Letter for Software Engineer at Microsoft'),
(3, 3, 2, NOW(), 'Cover Letter for Data Scientist at Amazon'),
(4, 1, 3, NOW(), 'Cover Letter for Data Scientist at Amazon'),
(5, 4, 4, NOW(), 'Cover Letter for Cloud Engineer at Facebook'),
(6, 5, 5, NOW(), 'Cover Letter for UI/UX Designer at Apple'),
(7, 8, 6, NOW(), 'Cover Letter for Software Engineer at Cognizant'),
(8, 7, 7, NOW(), 'Cover Letter for Cloud Engineer at Microsoft (NY)'),
(9, 6, 8, NOW(), 'Cover Letter for Data Scientist at Hexaware (Chennai)'),
(10, 9, 9, NOW(), 'Cover Letter for Data Scientist at Facebook (Chicago)'),
(11, 10, 10, NOW(), 'Cover Letter for UI/UX Designer at Apple (Germany)'),
(12, 2, 5, NOW(), 'Cover Letter for Software Engineer at Microsoft'),
(13, 4, 3, NOW(), 'Cover Letter for Cloud Engineer at Facebook'),
(14, 5, 1, NOW(), 'Cover Letter for UI/UX Designer at Apple'),
(15, 10, 7, NOW(), 'Cover Letter for UI/UX Designer at Apple (Paris)');

/*5.Write an SQL query to count the number of applications received for each job listing in the
"Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all
jobs, even if they have no applications.*/
SELECT j.JobTitle, COUNT(a.ApplicationID) AS ApplicationCount
FROM Jobs j LEFT JOIN Applications a ON j.JobID = a.JobID
GROUP BY j.JobID, j.JobTitle ORDER BY ApplicationCount DESC;

/*6.Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary
range. Allow parameters for the minimum and maximum salary values. Display the job title,
company name, location, and salary for each matching job.*/
SELECT 
    j.JobTitle, 
    c.CompanyName, 
    j.JobLocation, 
    j.Salary
FROM Jobs j
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary BETWEEN 100000  AND 120000
ORDER BY j.Salary DESC;

/*7.Write an SQL query that retrieves the job application history for a specific applicant. Allow a
parameter for the ApplicantID, and return a result set with the job titles, company names, and
application dates for all the jobs the applicant has applied to.*/

SELECT 
    j.JobTitle, 
    c.CompanyName, 
    a.ApplicationDate
FROM Applications a
JOIN Jobs j ON a.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE a.ApplicantID = 3
ORDER BY a.ApplicationDate DESC;

/*8.Create an SQL query that calculates and displays the average salary offered by all companies for
job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero.*/

SELECT AVG(Salary) AS AverageSalary
FROM Jobs WHERE Salary > 0;

/*9.Write an SQL query to identify the company that has posted the most job listings. Display the
company name along with the count of job listings they have posted. Handle ties if multiple
companies have the same maximum count.*/

WITH JobCounts AS ( SELECT c.CompanyName, COUNT(j.JobID) AS JobCount
FROM Jobs j JOIN Companies c ON j.CompanyID = c.CompanyID GROUP BY c.CompanyName)
SELECT CompanyName, JobCount FROM JobCounts WHERE JobCount = (SELECT MAX(JobCount) FROM JobCounts);

/*10.Find the applicants who have applied for positions in companies located in 'CityX' and have at
least 3 years of experience.*/

ALTER TABLE Applicants 
ADD Experience INT DEFAULT 0;

UPDATE Applicants SET Experience = 3 WHERE ApplicantID = 1;
UPDATE Applicants SET Experience = 5 WHERE ApplicantID = 2;
UPDATE Applicants SET Experience = 1 WHERE ApplicantID = 3;
UPDATE Applicants SET Experience = 4 WHERE ApplicantID = 4;
UPDATE Applicants SET Experience = 2 WHERE ApplicantID = 5;
UPDATE Applicants SET Experience = 6 WHERE ApplicantID = 6;
UPDATE Applicants SET Experience = 0 WHERE ApplicantID = 7;
UPDATE Applicants SET Experience = 7 WHERE ApplicantID = 8;
UPDATE Applicants SET Experience = 2 WHERE ApplicantID = 9;
UPDATE Applicants SET Experience = 3 WHERE ApplicantID = 10;


SELECT DISTINCT a.ApplicantID, a.FirstName, a.LastName, a.Email, a.Phone, a.Experience
FROM Applications app JOIN Jobs j ON app.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
JOIN Applicants a ON app.ApplicantID = a.ApplicantID
WHERE c.Location = 'Chennai' AND a.Experience >= 3;

/*11.Retrieve a list of distinct job titles with salaries between $60,000 and $80,000.*/

SELECT DISTINCT JobTitle ,Salary FROM Jobs
WHERE Salary BETWEEN 60000 AND 80000;

/*12.Find the jobs that have not received any applications.*/

SELECT j.JobID, j.JobTitle, c.CompanyName, j.JobLocation FROM Jobs j JOIN Companies c 
ON j.CompanyID = c.CompanyID LEFT JOIN Applications a 
ON j.JobID = a.JobID WHERE a.ApplicationID IS NULL;

/*13.Retrieve a list of job applicants along with the companies they have applied to and the positions
they have applied for.*/

SELECT a.ApplicantID, a.FirstName, a.LastName, a.Email, c.CompanyName, j.JobTitle, 
app.ApplicationDate FROM Applications app
JOIN Applicants a ON app.ApplicantID = a.ApplicantID
JOIN Jobs j ON app.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
ORDER BY app.ApplicationDate DESC;

/*14.Retrieve a list of companies along with the count of jobs they have posted, even if they have not
received any applications.*/

SELECT c.CompanyID, c.CompanyName, COUNT(j.JobID) AS JobCount FROM Companies c
LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyID, c.CompanyName
ORDER BY JobCount DESC;

/*15.List all applicants along with the companies and positions they have applied for, including those
who have not applied.*/

SELECT a.ApplicantID, a.FirstName, a.LastName, a.Email, c.CompanyName, j.JobTitle, app.ApplicationDate
FROM Applicants a LEFT JOIN Applications app ON a.ApplicantID = app.ApplicantID
LEFT JOIN Jobs j ON app.JobID = j.JobID LEFT JOIN Companies c ON j.CompanyID = c.CompanyID
ORDER BY a.ApplicantID;

/*16.Find companies that have posted jobs with a salary higher than the average salary of all jobs.*/

SELECT DISTINCT c.CompanyID, c.CompanyName FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE j.Salary > (SELECT AVG(Salary) FROM Jobs);

/*17. Display a list of applicants with their names and a concatenated string of their city and state.*/

ALTER TABLE Applicants 
ADD City VARCHAR(100), 
ADD State VARCHAR(100);

UPDATE Applicants SET City = 'Chennai', State = 'Tamil Nadu' WHERE ApplicantID = 1;
UPDATE Applicants SET City = 'Bangalore', State = 'Karnataka' WHERE ApplicantID = 2;
UPDATE Applicants SET City = 'Hyderabad', State = 'Telangana' WHERE ApplicantID = 3;
UPDATE Applicants SET City = 'Pune', State = 'Maharashtra' WHERE ApplicantID = 4;
UPDATE Applicants SET City = 'Delhi', State = 'Delhi' WHERE ApplicantID = 5;
UPDATE Applicants SET City = 'Mumbai', State = 'Maharashtra' WHERE ApplicantID = 6;
UPDATE Applicants SET City = 'Kolkata', State = 'West Bengal' WHERE ApplicantID = 7;
UPDATE Applicants SET City = 'Chennai', State = 'Tamil Nadu' WHERE ApplicantID = 8;
UPDATE Applicants SET City = 'Bangalore', State = 'Karnataka' WHERE ApplicantID = 9;
UPDATE Applicants SET City = 'Hyderabad', State = 'Telangana' WHERE ApplicantID = 10;

SELECT ApplicantID, FirstName, LastName, CONCAT(City, ', ', State) AS Location
FROM Applicants;

/*18.Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'.*/

SELECT JobID, JobTitle, CompanyID, JobLocation, Salary, JobType, PostedDate FROM Jobs
WHERE JobTitle LIKE '%Developer%' OR JobTitle LIKE '%Engineer%';

/*19.Retrieve a list of applicants and the jobs they have applied for, including those who have not
applied and jobs without applicants.*/
SELECT a.ApplicantID, a.FirstName, a.LastName, j.JobID, j.JobTitle, c.CompanyName FROM Applicants a
LEFT JOIN Applications app ON a.ApplicantID = app.ApplicantID
LEFT JOIN Jobs j ON app.JobID = j.JobID
LEFT JOIN Companies c ON j.CompanyID = c.CompanyID

UNION

SELECT NULL AS ApplicantID, NULL AS FirstName, NULL AS LastName, j.JobID, 
j.JobTitle, c.CompanyName FROM Jobs j
LEFT JOIN Applications app ON j.JobID = app.JobID
LEFT JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE app.ApplicationID IS NULL
ORDER BY ApplicantID, JobID;

/*20.List all combinations of applicants and companies where the company is in a specific city and the
applicant has more than 2 years of experience. For example: city=Chennai*/

SELECT a.ApplicantID, a.FirstName, a.LastName, c.CompanyID, c.CompanyName, c.Location,
a.Experience FROM Applicants a CROSS JOIN Companies c
WHERE c.Location = 'Chennai' AND a.Experience > 2;

