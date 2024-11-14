--Q1.1. Create a table called employees with the following structure                                                   emp_id (integer, should not be NULL and should be a primary key) 
--emp_name (text, should not be NULL)
-- age (integer, should have a check constraint to ensure the age is at least 18)
-- email (text, should be unique for each employee)
-- salary (decimal, with a default value of 30,000).

/* CREATE TABLE employees (
    emp_id INTEGER NOT NULL PRIMARY KEY,       -- emp_id cannot be NULL and is the primary key
    emp_name TEXT NOT NULL,                    -- emp_name cannot be NULL
    age INTEGER CHECK (age >= 18),              -- age must be at least 18
    email TEXT UNIQUE NOT NULL,                 -- email must be unique and cannot be NULL
    salary DECIMAL DEFAULT 30000               -- salary has a default value of 30,000
); */


--Q2. 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide 
--      examples of common types of constraints.

/*Purpose of Constraints in a Database
Constraints are rules or restrictions applied to the columns of a table in a relational database to ensure the 
accuracy, consistency, and integrity of the data. They help to prevent invalid data from being inserted, updated, 
or deleted, ensuring that the database maintains its correctness over time. By enforcing these rules, constraints 
help maintain data integrity, which refers to the accuracy and consistency of the data stored in the database.

How Constraints Help Maintain Data Integrity:

Prevent Invalid Data: Constraints ensure that only valid data is entered into the database. For example, a CHECK 
constraint can prevent an invalid age (e.g., less than 18) from being entered.

Ensure Uniqueness: A UNIQUE constraint guarantees that no duplicate values are entered in a column (or combination 
of columns), which is essential for things like email addresses or usernames that must be unique.

Enforce Referential Integrity: The FOREIGN KEY constraint ensures that relationships between tables are valid, 
preventing the insertion of records that would violate the integrity of those relationships (e.g., ensuring an 
order cannot exist without a valid customer ID).

Preserve Consistency: By using constraints, you can enforce consistent business rules across the entire database, 
ensuring that all data meets specific conditions before it is accepted.

Protect Data Accuracy: Constraints can help ensure that certain values are entered only in specific formats, 
ensuring consistency in the type of data across the database. For example, a NOT NULL constraint makes sure that 
essential fields are always populated.

PRIMARY KEY: Uniquely identifies each record (cannot be NULL).
FOREIGN KEY: Ensures referential integrity by linking records across tables.
UNIQUE: Ensures no duplicate values in a column.
NOT NULL: Ensures a column cannot have NULL values.
CHECK: Enforces specific conditions (e.g., age >= 18).
DEFAULT: Provides a default value when no value is provided. */

--Q3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify 
--   your answer.

/* The NOT NULL constraint is used to ensure that a column cannot have NULL values. You apply this constraint when:

Essential Information: The column represents critical data that should always have a value (e.g., employee name, 
product ID). Allowing NULL would mean you could have incomplete or missing data.

Data Integrity: Preventing NULL values helps maintain the integrity and accuracy of your data. For example, if a 
column stores information that is required for further processing, NULL would create uncertainty or errors in 
operations.

Avoiding Errors: When performing calculations or generating reports, NULL values can interfere with operations like 
summing, averaging, or joining data. By enforcing NOT NULL, you avoid the need to handle NULL cases explicitly in 
queries.

No, a primary key cannot contain NULL values:

Uniqueness: A primary key must uniquely identify each record in a table. Since NULL represents an unknown or 
undefined value, two rows with NULL values in the primary key column would violate the uniqueness requirement, 
as NULL values are not considered equal to each other.

Non-nullability: By definition, a primary key must always have a value because it is used to uniquely identify 
records. If the primary key column allowed NULL, you could end up with records that are not uniquely identifiable.

Justification:
The primary key is the key mechanism used to identify and differentiate rows in a table, so it must have a unique, 
non-NULL value for every row. Allowing NULL would undermine the purpose of the primary key, which is to provide a 
unique identifier for each record. */

--Q 4.  Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an 
--      example for both adding and removing a constraint.


/* Adding or Removing Constraints on an Existing Table
In SQL, constraints are typically defined when a table is created. However, it is possible to add or remove 
constraints after the table has been created. The steps and commands to do so vary slightly depending on the type 
of constraint and the SQL database system (e.g., MySQL, PostgreSQL, SQL Server). Below are the general steps and 
SQL commands for both adding and removing constraints.

1. Adding a Constraint to an Existing Table
To add a constraint to an existing table, you can use the ALTER TABLE statement with the ADD CONSTRAINT clause.

General Syntax for Adding a Constraint:

ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type (column_name);

2. Removing a Constraint from an Existing Table
To remove a constraint from an existing table, you use the ALTER TABLE statement with the DROP CONSTRAINT clause.

General Syntax for Dropping a Constraint:
ALTER TABLE table_name
DROP CONSTRAINT constraint_name; */

--Q5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. 
--    Provide an example of an error message that might occur when violating a constraint.

/*Consequences of Violating Constraints:

When you attempt to insert, update, or delete data in a way that violates a database constraint, the database 
management system (DBMS) will prevent the operation from succeeding. The violation of constraints ensures that the 
integrity of the database is maintained, preventing erroneous, incomplete, or inconsistent data from being entered.

-- Inserting a record with a duplicate email
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (1, 'John Doe', 28, 'john.doe@example.com', 35000);

-- Trying to insert another employee with the same email, which violates the UNIQUE constraint
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (2, 'Jane Smith', 30, 'john.doe@example.com', 40000);

Error Message:
ERROR 1062 (23000): Duplicate entry 'john.doe@example.com' for key 'email' */

--Q 6. You created a products table without constraints as follows:
/* CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 2));

 Now, you realise that
 The product_id should be a primary key
 The price should have a default value of 50.00

 1. Add a Primary Key on product_id:
To make product_id the primary key, you will add a PRIMARY KEY constraint to it. This ensures that each product_id 
is unique and not null.

2. Set a Default Value for price:
You will also need to set a default value of 50.0 for the price column, so that if no value is provided for price 
when inserting a record, 50.0 will be used by default.

SQL Commands to Modify the Table:
-- Add PRIMARY KEY constraint to product_id
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

-- Set the default value for the price column to 50.0
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.0; */

--Q7. You have two tables:
/*Students:
stu_id	stu_name	class_id
1	    Alice	     101
2	    Bob	         102
3	    Charlie	     101

class:
class_id	class_name
101        	 Math
102	         Science
103	         History

Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

SQL query:

SELECT s.stu_name, c.class_name
FROM students s
INNER JOIN classes c ON s.class_id = c.class_id;  */

--Q8 Consider the following three tables:

/* orders table:

order_id	order_date	customer_id
1	        2024-01-01	101
2	        2024-01-03	102


customers table:

customer_id	 customer_name
101	         Alice
102	         Bob


products table:

product_id	product_name	order_id
1	        Laptop	         1
2	        Phone	         NULL

Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are 
listed even if they are not associated with an order 
Hint: (use INNER JOIN and LEFT JOIN).

SELECT 
    o.order_id,
    c.customer_name,
    p.product_name
FROM 
    products p
LEFT JOIN 
    orders o ON p.order_id = o.order_id
INNER JOIN 
    customers c ON o.customer_id = c.customer_id; */

--Q9.Given the following tables:

/*Sales:
sales_id	product_id	amount
1	        101	        500
2	        102	        300
3	        101	        700

Products:
product_id	product_name
101	        Laptop
102	        Phone

Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

SELECT 
    p.product_name, 
    SUM(s.amount) AS total_sales_amount
FROM 
    sales s
INNER JOIN 
    products p ON s.product_id = p.product_id
GROUP BY 
    p.product_name;  */


--Q10. You are given three tables:

/* Orders:

order_id	order_date	customer_id
1	        2024-01-02	        1
2	        2024-01-05	        2   

Customers:
customer_id  customer_name
1	         Alice
2	         Bob

Order_details:
order_id	product_id	quantity
1	        101	        2
1	        102	        1
2	        101	        3

Write a query to display the order_id, customer_name, and the quantity of products ordered by each 
customer using an INNER JOIN between all three tables.

SELECT 
    o.order_id, 
    c.customer_name, 
    od.quantity
FROM 
    orders o
INNER JOIN 
    customers c ON o.customer_id = c.customer_id
INNER JOIN 
    order_details od ON o.order_id = od.order_id;  */






  







