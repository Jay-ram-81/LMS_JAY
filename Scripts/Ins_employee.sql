--Insert data for employee    
insert into employee (EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID) values (90001,'John Smith','CEO',NULL,to_date('01/01/1995','DD/MM/YYYY'),100000,1);
insert into employee (EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID) values (90002,'Jimmy Willis','Manager',90001,to_date('23/09/2003','DD/MM/YYYY'),52500,4);
insert into employee (EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID) values (90003,'Roxy Jones','Salesperson',90002,to_date('11/02/2017','DD/MM/YYYY'),35000,4);
insert into employee (EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID) values (90004,'Selwyn Field','Salesperson',90003,to_date('20/05/2015','DD/MM/YYYY'),32000,4);
insert into employee (EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID) values (90005,'David Hallett','Engineer',90006,to_date('17/04/2018','DD/MM/YYYY'),40000,2);
insert into employee (EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID) values (90006,'Sarah Phelps','Manager',90001,to_date('21/03/2015','DD/MM/YYYY'),45000,2);
insert into employee (EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID) values (90007,'Louise Harper','Engineer',90006,to_date('01/01/2013','DD/MM/YYYY'),47000,2);
insert into employee (EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID) values (90008,'Tina Hart','Engineer',90009,to_date('28/07/2014','DD/MM/YYYY'),45000,3);
insert into employee (EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID) values (90009,'Gus Jones','Manager',90001,to_date('15/05/2018','DD/MM/YYYY'),50000,3);
insert into employee (EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID) values (90010,'Mildred Hall','Secretary',90001,to_date('12/10/1996','DD/MM/YYYY'),35000,1);
/