#### Employee Management Database Demo

This project provides a MySQL script to set up and manage an employee management database. It includes table creation, sample data insertion, and demonstrations of various SQL operations such as queries, updates, and views.

##### Prerequisites
- MySQL server (version 8.0 or later recommended)
- A MySQL client or command-line tool to run the script

##### Setup Instructions
1. Download the `employee-demo.sql` file from this repository.
2. Open your MySQL client and connect to your MySQL server with a user that has privileges to create databases and tables.
3. Run the script using:
   ```sql
   SOURCE path/to/employee-demo.sql;
   ```
   Or, from the command line:
   ```bash
   mysql -u [username] -p [password] < path/to/employee-demo.sql
   ```
   Replace `[username]` and `[password]` with your MySQL credentials.

##### Verification
To verify the script ran successfully:
1. List all databases:
   ```sql
   SHOW DATABASES;
   ```
   You should see `employee_management`.
2. Use the database:
   ```sql
   USE employee_management;
   ```
3. List tables:
   ```sql
   SHOW TABLES;
   ```
   You should see `departments` and `employees`.
4. Check data:
   ```sql
   SELECT * FROM employees LIMIT 5;
   ```

##### Usage
After setup, try these example queries:
1. List high earners:
   ```sql
   SELECT first_name, last_name, salary FROM employees WHERE salary > 70000 ORDER BY salary DESC;
   ```
2. Department stats:
   ```sql
   SELECT d.department_name, COUNT(e.employee_id) as employee_count, AVG(e.salary) as average_salary
   FROM departments d
   JOIN employees e ON d.department_id = e.department_id
   GROUP BY d.department_id
   HAVING employee_count > 1;
   ```
3. Update salary:
   ```sql
   UPDATE employees SET salary = salary * 1.1 WHERE employee_id = 1;
   ```
4. Create a view:
   ```sql
   CREATE VIEW active_employee_summary AS
   SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) as full_name, e.email, e.salary, d.department_name
   FROM employees e
   JOIN departments d ON e.department_id = d.department_id
   WHERE e.is_active = 1;
   ```
   Then query:
   ```sql
   SELECT * FROM active_employee_summary;
   ```

##### SQL Concepts Demonstrated
This project shows skills in:
- Database and table creation
- Data insertion
- SELECT queries
- JOIN operations
- UPDATE statements
- Views
- Indices

##### License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

