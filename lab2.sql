select last_name, first_name, salary from employees where salary > 12000;

select last_name, department_id, employee_id from employees where employee_id = 176;

select last_name, first_name, salary, department_id, salary from employees 
where salary not between 5000 and 12000;

select last_name, job_id, hire_date from employees where last_name in ('Matos', 'Taylor');

select last_name, department_id from employees where department_id in (20, 50);

select last_name || ' ' || first_name as "Employee", salary as "Monthly Salary", department_id from employees 
where salary between 5000 and 12000;

select last_name, employee_id from employees where extract('year' from hire_date) = 2002;

select last_name, job_id from employees where manager_id is null;

select first_name, last_name, salary, (1+commission_pct)*salary-salary from employees 
where commission_pct is not null
order by salary desc, (1+commission_pct)*salary-salary desc;

select first_name, last_name, salary from employees where salary > 10000;

select employee_id, first_name, last_name, salary, department_id from employees
where manager_id in (103, 201, 124) order by last_name;

select employee_id, first_name, last_name from employees where last_name like '__a%';

select employee_id, first_name, last_name from employees 
where last_name like '%a%' or last_name like '%e%' or last_name like '%A%' or last_name like '%E%'

select employee_id, first_name, last_name, salary from employees
where job_id = 'SA_REP' and salary not in (2500, 3500, 7000);

select employee_id, first_name, last_name, salary, (1+commission_pct)*salary as salary_with_comm
from employees where commission_pct = 0.20;

select last_name, job_id, salary, commission_pct, (1+commission_pct)*salary as salary_with_comm
from employees where commission_pct is not null

select employee_id, last_name, job_id from employees
where job_id like 'SA_%'