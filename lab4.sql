select round(max(salary)) as "Maximum", round(min(salary)) as "Minimum", 
round(avg(salary)) as "Average", round(sum(salary)) as "Sum"
from employees;

select job_id, round(max(salary)) as "Maximum", round(min(salary)) as "Minimum", 
round(avg(salary)) as "Average", round(sum(salary)) as "Sum"
from employees
group by job_id;

select job_id, count(*)
from employees
group by job_id;

select count(distinct manager_id) as "Number Of Manager"
from employees;

select max(salary) - min(salary) as "DIFFERENCE"
from employees;

select manager_id, min(salary)
from employees
group by manager_id;

select manager_id, min(salary)
from employees
group by manager_id having min(salary) >= 6000 and manager_id is not null
order by min(salary) desc;

select manager_id, round(avg(salary), 2) as avg
from employees
group by manager_id;