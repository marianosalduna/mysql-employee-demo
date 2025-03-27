-- 1. Database Creation and Table Setup
CREATE DATABASE IF NOT EXISTS employee_management;
USE employee_management;

-- Departments Table with constraints
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL UNIQUE,  -- Added UNIQUE constraint
    location VARCHAR(100) CHECK (location IS NOT NULL),  -- Added CHECK constraint
    INDEX idx_dept_name (department_name)  -- Added index for frequent searches
);

-- Employees Table with various data types and constraints
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE CHECK (hire_date <= CURRENT_DATE),  -- Ensures valid hire dates
    salary DECIMAL(10,2) CHECK (salary >= 0),  -- Prevents negative salaries
    department_id INT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_department  -- Foreign key constraint
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON DELETE SET NULL  -- Sets department_id to NULL if department is deleted
        ON UPDATE CASCADE,  -- Updates department_id if department changes
    INDEX idx_salary (salary)  -- Index for salary-based queries
);

-- 2. Sample Data Insertion
INSERT INTO departments (department_name, location) VALUES
('Human Resources', 'New York'),
('Engineering', 'San Francisco'),
('Sales', 'Chicago'),
('Marketing', 'Boston');

INSERT INTO employees (first_name, last_name, email, hire_date, salary, department_id) VALUES
('John', 'Doe', 'john.doe@company.com', '2023-01-15', 75000.00, 2),
('Jane', 'Smith', 'jane.smith@company.com', '2022-06-20', 82000.00, 1),
('Mike', 'Johnson', 'mike.j@company.com', '2023-03-10', 65000.00, 3),
('Sarah', 'Williams', 'sarah.w@company.com', '2021-11-05', 90000.00, 2),
('Emily', 'Brown', 'emily.b@company.com', '2024-01-01', 60000.00, 4);

-- 3. Basic SELECT Queries
-- Simple select with filtering
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > 70000 
ORDER BY salary DESC;

-- Join with grouping
SELECT 
    d.department_name,
    COUNT(e.employee_id) as employee_count,
    AVG(e.salary) as avg_salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 1;

-- Select with date filtering
SELECT *
FROM employees
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY hire_date;

-- 4. UPDATE Operations
-- Single employee salary update
UPDATE employees 
SET salary = salary * 1.1
WHERE employee_id = 1;

-- Multiple employee status update
UPDATE employees 
SET 
    is_active = false,
    salary = 0
WHERE hire_date < '2022-01-01';

-- Update with join
UPDATE employees e
INNER JOIN departments d ON e.department_id = d.department_id
SET e.salary = e.salary * 1.05
WHERE d.department_name = 'Engineering';

-- 5. View Creation
CREATE VIEW active_employee_summary AS
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) as full_name,
    e.email,
    e.salary,
    d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE e.is_active = true;

-- Demonstrate the view
SELECT * FROM active_employee_summary;

-- Additional useful queries for demonstration
-- Employee count by department
SELECT 
    d.department_name,
    COUNT(*) as emp_count
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- Highest paid employee per department
SELECT 
    d.department_name,
    MAX(e.salary) as max_salary,
    e.first_name,
    e.last_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;
