select employees.emp_no,
		employees.first_name,
		employees.last_name,
		titles.title,
		titles.from_date,
		titles.to_date
into retirement_titles
from employees
inner join titles
on (employees.emp_no = titles.emp_no)
where (employees.birth_date between '1952-01-01' and '1955-12-31')
order by employees.emp_no;

select * from retirement_titles;

select distinct on (emp_no) emp_no,
		first_name,
		last_name,
		title
into unique_titles
from retirement_titles
where (retirement_titles.to_date = '9999-01-01')
order  by emp_no, from_date desc;

select * from unique_titles;

select count(emp_no), title
into retiring_titles
from unique_titles
group by title
order by count(title) desc;

select * from retiring_titles;

select distinct on(e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
into mentorship_eligibility
from employees as e
inner join dept_emp as de
on (e.emp_no = de.emp_no)
left outer join titles as t
on (e.emp_no = t.emp_no)
where (e.birth_date between '1965-01-01' and '1965-12-31')
and (de.to_date = '9999-01-01')
order by (e.emp_no);

select * from mentorship_eligibility;


