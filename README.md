# Overview of Project
Many current employees at Pewlett Hackard are about to reach retirement age. I was asked to create an analysis to determine the number of retiring employees per title at Pewlett Hackard and identify the employees eligible to participate in a mentorship program based on their age.

Programs used: PgAdmin 4, PostGreSQL 14, and Visual Studio Code 1.50.0
Data files: ![]()
            ![]()
            ![]()
            ![]()
            ![]()
  

 # Methods
## Step 1

* Create a Retirement Titles table that holds all the titles of employees who were born between January 1, 1952 and December 31, 1955. 
* Because some employees may have multiple titles in the database—for example, due to promotions—use the DISTINCT ON statement to create a table that contains the most recent title of each employee. 
* Then, use the COUNT() function to create a table that has the number of retirement-age employees by most recent job title. 
* Finally, exclude those employees who have already left the company by only adding those with a to_date of "9999-01-01."

 ```sql
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
   ```
  ## Step 2
  
  * Create a Mentorship Eligibility table that holds the current employees who were born between January 1, 1965 and December 31, 1965.
  * Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
  * Create a new table using the INTO clause.
  * Join the Employees and the Department Employee tables on the primary key.
  * Join the Employees and the Titles tables on the primary key.
  * Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
  * Order the table by the employee number.
   
  ```sql
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
 ```

* Point 1:
* Point 2:
* Point 3:
* Point 4:
# Summary
How many roles will need to be filled as the "silver tsunami" begins to make an impact? 
Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
