Create table Students(
student_id int Primary Key,
first_name varchar(20),
last_name varchar(30),
date_of_birth date,
email varchar(20),
phone_number varchar(10))


Create table Courses(
course_id int Primary Key,
course_name varchar(20),
credits int,
teacher_id int references Teacher(teacher_id))

Create table Teacher(
teacher_id int Primary Key,
first_name varchar(20),
last_name varchar(30),
email varchar(20))

Create table Payments(
payment_id int Primary Key,
student_id int references Students(student_id),
amount int,
payment_date date)

Create table Enrollments(
enrollment_id int Primary Key,
student_id int references Students(student_id),
course_id int references Courses(course_id),
enrollment_date date)


INSERT INTO Teacher (teacher_id, first_name, last_name, email) VALUES
(201, 'Adam', 'Brown', 'adam@email.com'),
(202, 'Laura', 'Davis', 'laura@email.com'),
(203, 'Mark', 'Garcia', 'mark@email.com'),
(204, 'Sarah', 'Martinez', 'sarah@email.com'),
(205, 'John', 'Wilson', 'john@email.com'),
(206, 'Emily', 'Taylor', 'emily@email.com'),
(207, 'Michael', 'Anderson', 'michael@email.com'),
(208, 'Jessica', 'Thomas', 'jessica@email.com'),
(209, 'David', 'Hernandez', 'david@email.com'),
(210, 'Jennifer', 'Lee', 'jennifer@email.com');

INSERT INTO Courses (course_id, course_name, credits, teacher_id) VALUES
(101, 'Mathematics', 3, 201),
(102, 'Data Structures', 4, 202),
(103, 'C Programming', 3, 203),
(104, 'Software Engineering', 4, 204),
(105, 'C++', 3, 202),
(106, 'Java', 4, 206),
(107, 'Python', 3, 207),
(108, 'Design Analysis', 4, 206),
(109, 'Web Development', 2, 209),
(110, 'Computer Networks', 4, 202);

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES
(1, 1, 101, '2024-01-10'),
(2, 2, 102, '2024-02-15'),
(3, 3, 103, '2024-03-20'),
(4, 4, 104, '2024-04-05'),
(5, 5, 105, '2024-01-25'),
(6, 6, 106, '2024-02-20'),
(7, 7, 107, '2024-03-15'),
(8, 8, 108, '2024-04-10'),
(9, 9, 109, '2024-01-05'),
(10, 10, 110, '2024-02-10');

INSERT INTO Payments (payment_id, student_id, amount, payment_date) VALUES
(1, 1, 60000, '2024-01-15'),
(2, 2, 40000, '2024-02-20'),
(3, 3, 27000, '2024-03-25'),
(4, 4, 87000, '2024-04-10'),
(5, 5, 17000, '2024-01-30'),
(6, 6, 28500, '2024-02-25'),
(7, 7, 47000, '2024-03-20'),
(8, 8, 95000, '2024-04-15'),
(9, 9, 19000, '2024-01-10'),
(10, 10, 14000, '2024-02-15');

/*2*/INSERT INTO Enrollments VALUES (11, 3, 105, '2024-04-10');

/*3*/ UPDATE Teacher SET email = 'adam123@email.com'
WHERE teacher_id = 201;

/*4*/ DELETE FROM Enrollments WHERE student_id = 3 AND course_id = 105;

/*5*/ UPDATE Courses SET teacher_id = 208 WHERE course_id = 101;

/*6*/ DELETE FROM Payments WHERE student_id = 10;
DELETE FROM Enrollments WHERE student_id = 10;
DELETE FROM Students WHERE student_id = 10;

/*6*/ALTER TABLE Enrollments
DROP CONSTRAINT FK_Studentid; 
ALTER TABLE Enrollments
ADD CONSTRAINT FK_Studentid 
FOREIGN KEY (student_id) REFERENCES Students(student_id)
ON DELETE CASCADE;

/*7*/ UPDATE Payments SET amount = 25000
WHERE payment_id = 9;

/*task-3*/
/*1*/
SELECT s.student_id,s.first_name,s.last_name,sum(p.amount) as total_payment
FROM Payments p
JOIN Students s ON p.student_id=s.student_id
WHERE s.student_id=4
GROUP BY s.student_id,s.first_name,s.last_name

/*2*/
SELECT c.course_id,count(e.student_id) as no_of_Students
FROM Courses c
JOIN Enrollments e ON e.course_id=c.course_id
GROUP BY c.course_id

/*3 not working*/
SELECT s.first_name FROM Students s
JOIN Enrollments e on s.student_id=e.student_id
WHERE s.student_id IS NULL

/*4*/
SELECT s.first_name,s.last_name,c.course_name
FROM Students s
JOIN Enrollments e on e.student_id=s.student_id
JOIN Courses c on c.course_id=e.course_id

/*5*/
SELECT t.first_name,c.course_name
FROM Teacher t
JOIN Courses c on c.teacher_id=t.teacher_id

/*6*/
SELECT s.first_name,e.enrollment_date
FROM Students s
JOIN Enrollments e on e.student_id=s.student_id
JOIN Courses c on c.course_id=e.course_id
WHERE c.course_name='JAVA'

/*7*/
SELECT s.first_name
FROM Students s
LEFT JOIN Payments p ON p.student_id=s.student_id
WHERE p.student_id IS NULL

/*8*/
SELECT c.course_name
FROM Courses c
LEFT JOIN Enrollments e ON e.course_id=c.course_id
WHERE e.course_id IS NULL

/*9*/
SELECT e.student_id,count(DISTINCT e.course_id) as noof_enrollments
FROM Enrollments e
JOIN Enrollments e1 ON e1.student_id=e.student_id
GROUP BY e.student_id
HAVING count(DISTINCT e.course_id)>1

/*10*/
SELECT t.first_name
FROM Teacher t
LEFT JOIN Courses c ON c.teacher_id=t.teacher_id
WHERE c.teacher_id IS NULL

/*task-4*/

/*1*/
select course_id, avg(enrollmentcount) as avgenrollment
from (select course_id, count(student_id) as enrollmentcount
from enrollments 
group by course_id
) as totenrollment
group by course_id

/*2*/
select student_id, amount from payments
where amount=(select max(amount) from payments)

/*3*/
select course_id,count(student_id) as noofStudents
from Enrollments
group by course_id 
having count(student_id)=(select max(stu_count) 
from (select course_id,count(student_id) as stu_count from Enrollments
group by course_id) as innerq)

/*4*/
select teacher_id, sum(payment) as totpayments
from(select c.teacher_id, p.amount as payment
from courses c
join enrollments e on c.course_id = e.course_id
join payments p on e.student_id = p.student_id
) as payments
group by teacher_id


/*5*/
select student_id from enrollments
group by student_id
having count(distinct course_id)=(
select count(distinct course_id) from courses)

/*6*/
select first_name
from teacher
where teacher_id not in(
select distinct teacher_id from courses)

/*7*/
select avg(age) as Average_Age from
(select DATEDIFF(year,date_of_birth,getdate()) as age from students)as age_of_students

/*8*/
select course_name from courses
where course_id not in (
select distinct course_id from enrollments)

/*9*/
select e.student_id,sum(amount) as totalpayments
from payments p
join enrollments e on p.student_id = e.student_id
group by e.student_id

/*10*/
select s.student_id, payment_count.totpayments
from students s
join (select p.student_id, count(p.payment_id) as totpayments
from payments p
group by p.student_id
having count(p.payment_id) > 1
)as payment_count on s.student_id = payment_count.student_id

/*11*/
select s.student_id,s.first_name, sum(p.amount) as totpayment
from students s
join payments p on s.student_id = p.student_id
group by s.student_id, s.first_name

/*12*/
select c.course_name, count(e.student_id) as noofstudents
from courses c
join enrollments e on c.course_id = e.course_id
group by c.course_name

/*13*/
select s.first_name, avg(p.amount) as avgpayment
from students s
join payments p on s.student_id = p.student_id
group by s.first_name












