--Create Package spec
create or replace package sales_emp_maint as
	procedure sal_update(p_empid employee.emp_id%type, perf_ind varchar2, p_percentage number);
	procedure emp_addition(p_empid employee.emp_id%type, p_empname varchar2, p_job varchar2, p_mid number,p_date date,p_sal number,p_deptid number);
	procedure emp_transfer(p_empid employee.emp_id%type, p_cur_deptid number, p_new_deptid number, p_new_title varchar2, p_new_mid number,p_new_date date);
	function emp_salary(p_empid employee.emp_id%type) return number;
	procedure emp_all_dept(p_deptid employee.dept_id%type);
	function emp_dept_sal(p_deptid employee.dept_id%type) return number;
end sales_emp_maint;