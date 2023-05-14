select last_name, hire_date 
from employees
where last_name not like 'Zlotkey' and department_id = (select department_id 
														from employees 
														where last_name like 'Zlotkey');

select last_name, salary
from employees
where salary > (select avg(salary) 
				from employees)
order by salary;

select last_name, (select department_name 
				   from departments 
				   where department_id = employees.department_id) 
from employees;

select last_name 
from employees
where manager_id in (select employee_id 
					 from employees 
					 where last_name like 'King');
					 
select last_name
from employees
where department_id = (select department_id 
					   from departments 
					   where department_name like 'Executive');
					   
select last_name
from employees
where department_id in (select department_id 
						from departments 
						where department_name like '%u%')
and salary > (select avg(salary) 
			  from employees);
			  
select department_id, min(salary) 
from employees
where salary > (select avg(salary) 
				from employees)
group by department_id;
 
select department_name 
from departments
where department_id in (select distinct department_id 
						from employees 
						where job_id = 'SA_REP');

select department_name 
from departments
where department_id in (select distinct department_id 
						from employees 
						where job_id = 'SA_REP')
and department_id is not null;