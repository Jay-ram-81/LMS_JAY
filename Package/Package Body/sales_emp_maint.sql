--Create Package body
create or replace package body sales_emp_maint as
emp_check number(2);
mid_check number(2);
tfr_check number(2);
err_code varchar(20);
err_msg varchar(200);
--Database object to allow the Salary for an Employee to be increased or decreased by a percentage
procedure sal_update(p_empid employee.emp_id%type, perf_ind varchar2, p_percentage number) is
BEGIN
    BEGIN
    	INSERT INTO debug_table (error_no, error_msg) VALUES ('1', 'First message');
	SELECT count(1) INTO emp_check FROM employee
    	WHERE emp_id = p_empid;
    EXCEPTION
    	WHEN OTHERS THEN
          err_code := SQLCODE;
          err_msg := SUBSTR(SQLERRM, 1, 200);
          INSERT INTO debug_table (error_no, error_msg) VALUES (err_code, err_msg);
    END;
	IF emp_check <> '1' then
        err_msg := 'EMPLOYEE ID IS NOT VALID';
        INSERT INTO debug_table (error_no, error_msg) VALUES (err_code, err_msg);
        return;
	END IF;
    dbms_output.put_line('After select'|| emp_check);
    INSERT INTO debug_table (error_no, error_msg) VALUES ('After Select', 'value '||emp_check);
        
	-- I (Inrement) 
    IF perf_ind = 'I' then
	    dbms_output.put_line('Inside I IF Loop');
    INSERT INTO debug_table (error_no, error_msg) VALUES ('2', 'I Loop');

		UPDATE employee SET salary = salary+(salary*p_percentage/100)
        WHERE emp_id = p_empid;
    END IF;

	-- D (Decrement)
    IF perf_ind = 'D' then
	    dbms_output.put_line('Inside I ELSE Loop');
    INSERT INTO debug_table (error_no, error_msg) VALUES ('3', 'D Loop');


        UPDATE employee SET salary = salary-(salary*p_percentage/100)
        WHERE emp_id = p_empid;
    END IF;
	COMMIT;
END;
--Database object to allow an Employee to be created
procedure emp_addition(p_empid employee.emp_id%type, p_empname varchar2, p_job varchar2, p_mid number,p_date date,p_sal number,p_deptid number) is
BEGIN
    --check manager id available
    BEGIN
	SELECT count(1) INTO mid_check FROM employee
    	WHERE emp_id = p_mid;
    EXCEPTION
    	WHEN OTHERS THEN
          err_code := SQLCODE;
          err_msg := SUBSTR(SQLERRM, 1, 200);
          INSERT INTO debug_table (error_no, error_msg) VALUES (err_code, err_msg);
    END;
    IF mid_check <> '1' then
	err_code:='MID CHECK';
	err_msg := 'Manager EmpId is not Valid';
	INSERT INTO debug_table (error_no, error_msg) VALUES (err_code, err_msg);
	return;
    END IF;
    dbms_output.put_line('After select'|| mid_check);
      
    BEGIN
    	INSERT INTO employee (EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID)
    	VALUES (p_empid,p_empname,p_job,p_mid,p_date,p_sal,p_deptid);
    EXCEPTION
    	WHEN OTHERS THEN
          err_code := SQLCODE;
          err_msg := SUBSTR(SQLERRM, 1, 200);
          INSERT INTO debug_table (error_no, error_msg) VALUES (err_code, err_msg);
    END;
    COMMIT;
END;
--Database object to allow the transfer for an employee to a different department
procedure emp_transfer(p_empid employee.emp_id%type, p_cur_deptid number, p_new_deptid number, p_new_title varchar2, p_new_mid number,p_new_date date) is
BEGIN
    --check employee exists for given dept id
    BEGIN
    	INSERT INTO debug_table (error_no, error_msg) VALUES ('1', 'First message');
	SELECT count(1) INTO tfr_check FROM employee
    	WHERE emp_id = p_empid
	AND dept_id = p_cur_deptid;
    EXCEPTION
    	WHEN OTHERS THEN
          err_code := SQLCODE;
          err_msg := SUBSTR(SQLERRM, 1, 200);
          INSERT INTO debug_table (error_no, error_msg) VALUES (err_code, err_msg);
    END;
	IF tfr_check <> '1' then
        err_msg := 'EMPLOYEE ID AND DEPT ID NOT AVAILABLE...';
        INSERT INTO debug_table (error_no, error_msg) VALUES (err_code, err_msg);
        return;
	END IF;
    dbms_output.put_line('After select'|| tfr_check);

    -- Move existing employee details to transfer table
    BEGIN
    	INSERT INTO employee_transfer (EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID,DATE_OF_TRANSFER)
    	SELECT EMP_ID,EMP_NAME,JOB_TITLE,MANAGER_ID,DATE_HIRED,SALARY,DEPT_ID,SYSDATE FROM employee
	WHERE emp_id = p_empid
        AND dept_id = p_cur_deptid;
    EXCEPTION
    	WHEN OTHERS THEN
          err_code := SQLCODE;
          err_msg := SUBSTR(SQLERRM, 1, 200);
          INSERT INTO debug_table (error_no, error_msg) VALUES (err_code, err_msg);
    END;

    -- update employee table with new department details
    BEGIN
    	UPDATE employee SET DEPT_ID= p_new_deptid,
						JOB_TITLE= p_new_title,
                        MANAGER_ID= p_new_mid,
						DATE_HIRED= p_new_date
		WHERE emp_id = p_empid
        AND dept_id = p_cur_deptid;
    EXCEPTION
    	WHEN OTHERS THEN
          err_code := SQLCODE;
          err_msg := SUBSTR(SQLERRM, 1, 200);
          INSERT INTO debug_table (error_no, error_msg) VALUES (err_code, err_msg);
    END;
    COMMIT;
END;
--To return the salary for an employee
function emp_salary(p_empid employee.emp_id%type) return number is
f_sal number := 0;
BEGIN
	SELECT salary into f_sal
	FROM employee
	WHERE emp_id = p_empid;
	return f_sal;
END;
--To list all employees in a department
procedure emp_all_dept(p_deptid employee.dept_id%type) is
BEGIN
	for cur in (select emp_id, emp_name, manager_id from employee where dept_id = p_deptid)
	loop
		dbms_output.put_line('Emp ID: '||cur.emp_id||' Emp name: '||cur.emp_name||'Manager ID: '||cur.manager_id);
	end loop;
END;
--show the total of employee salary in a department
function emp_dept_sal(p_deptid employee.dept_id%type)  return number is
f_dpt_sal number(30) := 0;
BEGIN
	SELECT sum(salary) into f_dpt_sal
	FROM employee
	WHERE dept_id = p_deptid;
	return f_dpt_sal;
END;
end sales_emp_maint;
/