select now() as "Date";

select employee_id, last_name, salary, round(salary*1.155, 0) as "New Salary" 
from employees; 

select employee_id, first_name, last_name 
from employees 
where substring(last_name from 2 for 1) = 'a';

select employee_id, last_name, salary, 
round(salary*1.155, 0) as "New Salary", round(salary*1.155 - salary, 0) as "Increase"
from employees;

select last_name, initcap(last_name), length(last_name)
from employees
where substring(last_name from 1 for 1) in ('J', 'M', 'A')
order by length(last_name);

select last_name, first_name, 
extract(year from age(now()::date, hire_date))*12 
+ extract(month from age(now()::date, hire_date)) as "Months"
from employees;

select format('%1$s earns %2$s monthly, but wants %3$s', last_name, salary, 3*salary) 
as "Dream Salary"
from employees;

select last_name, first_name, lpad(salary::text, 15, '$')
from employees;

select format('%1$s earns %2$s monthly, but wants %3$s', upper(last_name), salary, 3*salary) 
as "Dream Salary"
from employees;

select upper(last_name), lower(first_name), 
extract(year from age(now()::date, hire_date))*12 
+ extract(month from age(now()::date, hire_date)) as "Months"
from employees;

select last_name, first_name, rpad(salary::text, 10, '0')
from employees;

select * 
from employees
where substring(last_name from 4 for 1) != '';

select *
from employees
where length(last_name) > 3;

select employee_id, first_name, trim('Kk' from last_name), email, phone_number, hire_date,
job_id, salary, commission_pct, manager_id, department_id
from employees;

select *
from employees
where position('in' in last_name) != 0;

select employee_id, first_name, replace(last_name, 'in',  'pm'), email, phone_number, hire_date,
job_id, salary, commission_pct, manager_id, department_id
from employees;

select *
from employees
where position('i' in last_name) = 2;

select concat_ws(', ', employee_id, first_name, last_name, email, phone_number, hire_date, 
job_id, salary, commission_pct, manager_id, department_id) as "THE OUTPUT"
from employees;
				