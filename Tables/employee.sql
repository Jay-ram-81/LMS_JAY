-- create table employee
create table employee
(emp_id number(10),
emp_name varchar2(50) NOT NULL,
job_title varchar2(50) NOT NULL,
manager_id number(10),
date_hired date NOT NULL,
salary number(10) NOT NULL,
dept_id number(5) NOT NULL,
constraint emp_cons_pk primary key (emp_id),
constraint emp_cons_fk foreign key (dept_id) references department (dept_id)
);
/
