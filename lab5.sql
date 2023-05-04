select location_id, street_address, city, state_province, country_id, country_name
from locations
natural join countries;

select last_name, department_id, department_name
from employees
natural join departments;

select last_name, job_id, department_id, department_name
from employees
natural join departments
natural join locations
where city = 'Toronto';

select emp.employee_id, emp.last_name, emp.manager_id, man.last_name as "manager_last_name"
from employees emp
inner join employees man
on (emp.manager_id = man.employee_id);

/* 5 задание неправильный вывод
select emp.employee_id, emp.last_name, emp.manager_id, man.last_name as "manager_last_name"
from employees emp
inner join employees man
on emp.manager_id is null; --??
*/

select employee_id, last_name, manager_id
from employees
where manager_id is null;

select dep.department_id, dep.department_name, emp.employee_id, emp.last_name
from departments dep
inner join employees emp
on (dep.manager_id = emp.employee_id);

select dep.department_id, dep.department_name, man.last_name as "manager_last_name", emp.employee_id, emp.last_name
from departments dep
inner join employees man
on (dep.manager_id = man.employee_id)
inner join employees emp
on (emp.manager_id = man.employee_id);

select emp.employee_id, emp.last_name, emp.hire_date, dav.hire_date as "Davies_hire_date"
from employees emp
inner join employees dav
on (emp.hire_date - dav.hire_date > 0) and (dav.last_name = 'Davies');

select emp.employee_id, emp.last_name as "employee_last_name", emp.hire_date as "employee_hire_date", emp.manager_id, man.last_name as "manager_last_name", man.hire_date as "manager_hire_date"
from employees emp
inner join employees man
on (emp.hire_date - man.hire_date < 0) and (emp.manager_id = man.employee_id);

/* проверка для 10
select dep.department_id, dep.department_name, emp.last_name
from departments dep
inner join employees emp
on (emp.department_id = dep.department_id);
*/

select dep.department_id, dep.department_name, count(emp.employee_id) as employees_count
from departments dep
inner join employees emp
on (dep.department_id = emp.department_id)
group by dep.department_id;

/* 10 другой вариант решения
select department_id, department_name, (select count(1) from employees where employees.department_id = departments.department_id) as "count_employees"
from departments;
*/

/* проверка для 11
select emp.employee_id, emp.last_name, job.job_id
from employees emp
inner join job_history job
on (emp.employee_id = job.employee_id);
*/

/* 11 другой вариант решения недоделанный
select employee_id, last_name, (select count(1) from job_history where job_history.employee_id = employees.employee_id) as jobs_count
from employees;
*/

select emp.employee_id, emp.last_name, count(his.job_id) as job_count
from employees emp
join job_history his
on(emp.employee_id = his.employee_id)
group by emp.employee_id having count(his.job_id) > 1;

select emp.employee_id, emp.last_name as employee_last_name, emp.salary as employee_salary, emp.manager_id, man.last_name as manager_last_name, man.salary as manager_salary
from employees emp
inner join employees man
on (emp.salary > man.salary) and (emp.manager_id = man.employee_id);