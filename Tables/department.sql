-- create table department
create table department
(dept_id number(5),
dept_name varchar2(50) NOT NULL,
location varchar2(50) NOT NULL,
constraint dep_cons_p primary key (dept_id)
);
/
