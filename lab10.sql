--Lab 10
--Siting Wang

DROP TABLE IF EXISTS Courses;
create table Courses (
    num      integer not null,
    name     text    not null,
    credits  integer not null,
  primary key (num)
);


insert into Courses(num, name, credits)
values (499, 'CS/ITS Capping', 3 );

insert into Courses(num, name, credits)
values (308, 'Database Systems', 4 );

insert into Courses(num, name, credits)
values (221, 'Software Development Two', 4 );

insert into Courses(num, name, credits)
values (220, 'Software Development One', 4 );

insert into Courses(num, name, credits)
values (120, 'Introduction to Programming', 4);

select * 
from courses
order by num ASC;


-- Courses and their prerequisites
create table Prerequisites (
    courseNum integer not null references Courses(num),
    preReqNum integer not null references Courses(num),
  primary key (courseNum, preReqNum)
);

insert into Prerequisites(courseNum, preReqNum)
values (499, 308);

insert into Prerequisites(courseNum, preReqNum)
values (499, 221);

insert into Prerequisites(courseNum, preReqNum)
values (308, 120);

insert into Prerequisites(courseNum, preReqNum)
values (221, 220);

insert into Prerequisites(courseNum, preReqNum)
values (220, 120);

select *
from Prerequisites
order by courseNum DESC;

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
	FROM Courses c
	WHERE num in (select p.PreReqNum
		      from Prerequisites p
		      where coursr_num = p.courseNum);
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
	WHERE num in (select p.courseNum
		      from Prerequisites p
		      where course = p.PreReqNum);
		      return resultset;
END;
$$
language plpgsql;
select PreReqsFor(120, 'results');
Fetch all from results;
