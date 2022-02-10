--Deliverable 1: The Number of Retiring Employees by Title
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t ON
e.emp_no=t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

--Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (r.emp_no) 
r.emp_no,
r.first_name,
r.last_name,
r.title
INTO unique_titles
FROM retirement_titles as r
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

--Number of employees who are about to retire by job title
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles 
GROUP BY title
ORDER BY COUNT(title) DESC;

--Deliverable 2: The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees as e
JOIN titles as t ON
(e.emp_no = t.emp_no)
JOIN dept_emp as de ON
(e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01') AND
(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
