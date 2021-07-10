--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

-- Started on 2021-07-10 22:23:22 AEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;
SET default_tablespace = '';
SET default_table_access_method = heap;

--1.List the following details of each employee: employee number, last name, first name, sex, and salary.
CREATE TABLE public.employees_salary AS
 SELECT e.emp_no,
    e.first_name,
    e.last_name,
    e.sex,
    s.salary
   FROM public.employees e
     JOIN public.salaries s ON e.emp_no = s.emp_no;



--2.List first name, last name, and hire date for employees who were hired in 1986.
CREATE TABLE public.hire_1986 AS
 SELECT e.first_name,
    e.last_name,
    e.hire_date
   FROM public.employees e
  WHERE e.hire_date >= '1986-01-01' AND e.hire_date <= '1986-12-31';


--3.List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

CREATE TABLE manager_department AS
SELECT 
    d.dept_no,
    d.dept_name,
    dm.emp_no,
    dm.from_date,
    dm.to_date
from departments d
    JOIN dept_manager dm on dm.dept_no = d.dept_no

--4.List the department of each employee with the following information: employee number, last name, first name, and department name.
CREATE TABLE public.employee_department AS
 SELECT e.emp_no,
    e.first_name,
    e.last_name,
    d.dept_name
   FROM public.employees e
     JOIN public.dept_emp ON e.emp_no = dept_emp.emp_no
     JOIN public.departments d ON dept_emp.dept_no= d.dept_no;



--5.List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
CREATE TABLE public.hercules_table AS
 SELECT e.first_name,
    e.last_name,
    e.sex
   FROM public.employees e
  WHERE e.first_name= 'Hercules' AND e.last_name like 'B%';


--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
CREATE TABLE public.sales_department AS
 SELECT d.dept_name,
    dept_emp.emp_no,
    e.first_name,
    e.last_name
   FROM public.employees e
     JOIN public.dept_emp ON dept_emp.emp_no = e.emp_no
     JOIN public.departments d ON d.dept_no = dept_emp.dept_no
  WHERE d.dept_name= 'Sales';


--7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
CREATE TABLE public.development_sales AS
 SELECT d.dept_name,
    dept_emp.emp_no,
    e.first_name,
    e.last_name
   FROM ((public.employees e
     JOIN public.dept_emp ON ((dept_emp.emp_no = e.emp_no)))
     JOIN public.departments d ON (((d.dept_no)::text = (dept_emp.dept_no)::text)))
  WHERE ((d.dept_name)::text = ANY ((ARRAY['Sales'::character varying, 'Development'::character varying])::text[]));


--8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
CREATE TABLE descending_frequency AS
 SELECT e.last_name,
    count(e.last_name) AS count_last_name
   FROM public.employees e
  GROUP BY e.last_name
  ORDER BY (count(e.last_name)) DESC;



