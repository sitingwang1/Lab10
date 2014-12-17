--Lab 10
--Siting Wang

--Q1
CREATE OR REPLACE FUNCTION PreReqFor(int, REFCURSOR)
RETURNS REFCURSOR AS
$$
DECLARE 
	course_num int :=$1;
	resulter REFCURSOR :=$2;
BEGIN 
	OPEN RESULTSET FOR 
	SELECT num,name,credits
	FROM Courses
	Join Prerequisities
	ON Courses.num=prerequisities.preReqNum
	WHERE Prerequisites.courseNum=course;
	return resultset;
END;
$$
language plpgsql;
select PreReqsFor(499, 'results');
Fetch all from results;

--Q2
CREATE OR REPLACE FUNCTION isPreReqFor(int, REFCURSOR)
RETURNS REFCURSOR AS
$$
DECLARE 
	course int :=$1;
	resulter REFCURSOR :=$2;
BEGIN 
	OPEN RESULTSET FOR 
	SELECT num,name,credits
	FROM Courses 
	JOIN Prerequisites
	ON Courses.num=Prerequisites.courseNum
	WHERE Prerequisites.preReqNum=course;
	return resultset;
END;
$$
language plpgsql;
select PreReqsFor(120, 'results');
Fetch all from results;
