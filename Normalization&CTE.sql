-- Normalization & CTE

--1. First Normal Form (1NF):
/*a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.

               To understand how a table in the Sakila database might violate First Normal Form (1NF) and how to normalize it, we first need to understand what 1NF is. A table is in 1NF if:

All columns contain atomic (indivisible) values.
Each record in the table is unique (no duplicate rows).
Each column contains only one value for each record (no repeating groups).
Identifying a Table that Violates 1NF.


Suppose we have a table like this:

customer_id 	first_name	    last_name	 address    phone_numbers
1	     	    John	         Doe         Address1	555-1234, 555-5678
2		        Jane	         Smith       Address2	555-2345
3	       	    Alice	         Johnson     Address3	555-6789, 555-3456

In this case, the phone_numbers column contains multiple phone numbers (a repeating group), which violates 1NF 
because:

The phone_numbers column contains non-atomic values (a list of phone numbers), which violates the atomicity rule.
There are multiple phone numbers in a single row, which is a repeating group.

How to Normalize the Table to Achieve 1NF:

To bring the table into 1NF, we need to eliminate the repeating groups by creating a new row for each phone number. 
Each column should only contain one value per record.

Step 1: Create a new table for phone numbers.
The new table could be structured like this:

customer_phone table:

customer_id	 phone_number
1	         555-1234
1	         555-5678
2	         555-2345
3	         555-6789
3	         555-3456

Step 2: Remove the phone_numbers column from the customer table.
The original customer table now looks like this:

customer_id	 first_name	  last_name	  address
1	         John	      Doe	      Address1
2	         Jane	      Smith	      Address2
3	         Alice	      Johnson	  Address3

To bring it to 1NF:

Eliminate repeating groups by creating a separate row for each phone number.

CustomerID	Name	 Address	  PhoneNumber
1	        John	 Address1	  555-1234
1	        John	 Address1	  555-5678
2	        Jane	 Address2	  555-2345
3	        Alice	 Address3	  555-6789
3	        Alice	 Address3	  555-3456  */

--Q2. Second Normal Form (2NF):
               /* a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
            If it violates 2NF, explain the steps to normalize it.

Second Normal Form (2NF)
A table is in Second Normal Form (2NF) if:

It is in First Normal Form (1NF) (i.e., all columns have atomic values and there are no repeating groups).
It eliminates partial dependencies, which means that all non-key columns must depend on the entire primary key, not just part of it.
To determine whether a table is in 2NF, you should:

Check if the table is already in 1NF.
If the primary key is composite (consisting of more than one column), ensure that every non-key attribute depends on all parts of the composite key, not just some of them.
Example: Checking 2NF for the order_items Table
Let's use the order_items table from the Sakila database as an example:

order_id	product_id	quantity	price	order_date
1	100	2	20.00	2024-11-01
1	101	1	15.00	2024-11-01
2	100	3	20.00	2024-11-02
In this case, the primary key of the order_items table is a composite key made up of order_id and product_id because the combination of these two columns uniquely identifies each record (i.e., each product in an order).

Step 1: Verify 1NF
The table appears to be in 1NF because:
Each cell contains atomic values (no lists or sets).
Each record is unique.
All columns contain values of a single type.
So, the table is in 1NF.

Step 2: Check for Partial Dependencies
Partial dependency occurs when a non-key attribute depends on only part of the composite key.

Let's examine the non-key columns: quantity, price, and order_date.

quantity and price depend on the combination of order_id and product_id, which is fine because both columns are part of the order-item relationship.

order_date, however, only depends on order_id (not on product_id). This means that order_date does not depend on the entire composite key (order_id and product_id), but rather just on part of it (order_id).

Since order_date is dependent on only part of the composite key (order_id), it violates 2NF. This is a partial dependency.

Step 3: Normalize the Table to 2NF
To normalize the table to 2NF, we need to eliminate the partial dependency. We can do this by splitting the table into two smaller tables:

Create a table to store order details (which will include order_id and order_date).
Create another table to store item details (which will include order_id, product_id, quantity, and price).

Step 3a: Create a new table for order_details:
The order_details table will store information about the order (including order_id and order_date).

order_id	order_date
1	        2024-11-01
2	        2024-11-02

Step 3b: Update the order_items table:
The order_items table will now only store the order_id, product_id, quantity, and price, which depend on the combination of order_id and product_id.

order_id	product_id	quantity	price
1	        100	          2	         20.00
1	        101	          1	         15.00
2	        100	          3	         20.00  */


--Q3. Third Normal Form (3NF):
/*a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps 
  to normalize the table to 3NF.

  Third Normal Form (3NF)
A table is in Third Normal Form (3NF) if:

It is in Second Normal Form (2NF) (i.e., it is already free of partial dependencies).
It has no transitive dependencies. A transitive dependency occurs when a non-key column depends on another non-key column, rather than directly on the primary key.
In simpler terms, if Column A depends on Column B, and Column B depends on the primary key, then Column A is transitively dependent on the primary key through Column B. This kind of dependency must be eliminated to achieve 3NF.

Example: Identifying Transitive Dependencies in the actor Table
Let's use the actor table from the Sakila database as an example:

actor_id	first_name	last_name	film_id	title
1	         John	     Doe	     100	"Movie A"
2	         Jane	     Smith	     101	"Movie B"
3	         Alice	     Johnson	 100	"Movie A"
In this case, the actor table contains:

actor_id, which is the primary key.
first_name, last_name, which are attributes of the actor.
film_id, which refers to the films in which the actor has appeared.
title, which is the name of the film.

Step 1: Identify Transitive Dependencies
Let's examine the non-key columns and their dependencies:

first_name and last_name depend directly on actor_id (which is the primary key), so there are no issues with these columns.

However, title depends on film_id, which in turn depends on actor_id. This is a transitive dependency because:

actor_id → film_id → title
title depends on actor_id indirectly through film_id.
This means that title should not be in the actor table because it is indirectly dependent on the primary key through film_id.

Step 2: Normalize the Table to 3NF
To normalize the table to 3NF, we need to eliminate the transitive dependency by moving the title (which depends on film_id) to a separate table, and leaving only the actor-related data in the actor table.

We will break the table into two:

Step 2a: Create a new table for film data
We will create a new table called film to store information about the films.

film table:

film_id	 title
100	     "Movie A"
101	     "Movie B"
Step 2b: Create a new actor table
The actor table will now only store actor-specific information. The actor_id will remain the primary key.

actor table:

actor_id	first_name	last_name
1	         John	    Doe
2	         Jane	    Smith
3	         Alice	    Johnson
Step 2c: Create a new actor_film table to link actors with films
Now, we need a table to associate actors with the films in which they appear. This is a many-to-many relationship (one actor can appear in many films, and one film can have many actors).

actor_film table:

actor_id	film_id
1	        100
2	        101
3	        100
Step 3: Why This Works
By splitting the table, we eliminate the transitive dependency:

actor_id → title is removed because the title now resides in the film table and is only related to film_id.
actor table now stores only actor-related data, and the actor_film table stores the relationship between actors and films.
film table now stores film-related data (like the title), and the relationship between actors and films is handled by the actor_film table.
Final Structure After Normalization:

actor table:
actor_id	first_name	last_name
1	        John	    Doe
2	        Jane	    Smith
3	        Alice	    Johnson
film table:
film_id	  title
100	      "Movie A"
101	      "Movie B"

actor_film table:
actor_id	film_id
1	        100
2	        101
3	        100 */

--Q4. Normalization Process:
/* a. Take a specific table in Sakila and guide through the process of normalizing it from the initial  
  unnormalized form up to at least 2NF.

To demonstrate the normalization process, we'll use a table from the Sakila database. We'll focus on normalizing a table from its unnormalized form (UNF) to at least 2NF (Second Normal Form). For this example, let's assume we are working with a table that stores information about rentals, such as the rental table from the Sakila database.

Step 1: The Unnormalized Form (UNF)
In the unnormalized form, we may have a table that stores repetitive data or mixed attributes that could be separated into different columns. Let's consider a hypothetical "Rental" table that includes multiple values in one column or redundant data.

Example of a table in UNF:
rental_id	customer_id	 rental_date	return_date	 film_id	film_title	customer_name	customer_email
1	          1001	     2024-10-01	    2024-10-05	  1	        "The Matrix"   John Doe	    johndoe@example.com
2	          1001	     2024-10-02	    2024-10-06	  2	        "Inception"	   John Doe	    johndoe@example.com
3	          1002	     2024-10-03	    2024-10-07	  1	        "The Matrix"   Jane Smith	janesmith@example.com
Issues in UNF:
Repeating groups of attributes: There are multiple films rented by the same customer.
Redundancy: Customer name and email are repeated for each rental.
Non-atomic data: "film_title" and other customer-related data could be split into separate entities.

Step 2: First Normal Form (1NF)
In 1NF, we eliminate repeating groups of columns and ensure each column contains only atomic (indivisible) values. To achieve 1NF, we remove the multi-valued attributes (i.e., each rental should have only one film per row) and ensure all columns have unique and atomic values.

Example of the table in 1NF:
rental_id	customer_id	rental_date	return_date	film_id	 film_title	  customer_name	 customer_email
1	         1001	    2024-10-01	2024-10-05	 1	     "The Matrix"	John Doe	  johndoe@example.com
2	         1001	    2024-10-02	2024-10-06	 2	     "Inception"	John Doe	  johndoe@example.com
3	         1002	    2024-10-03	2024-10-07	 1	      "The Matrix"	Jane Smith	  janesmith@example.com



Step 3: Second Normal Form (2NF)
In 2NF, we eliminate partial dependencies, meaning that all non-key attributes must depend on the whole primary key. A table is in 2NF if:

It is in 1NF.
It has no partial dependency, i.e., non-key attributes should depend on the entire primary key.
In our table, we have a composite key of (rental_id, film_id), but non-key attributes like customer_name and customer_email only depend on customer_id, not on the entire composite key. Therefore, we need to create separate tables to eliminate this partial dependency.

Step 4: Decomposing to Achieve 2NF
We'll break the original table into multiple tables:

Rental table: stores rental details.
Customer table: stores customer details.
Film table: stores film details.
1. The Rental table:
This table stores information specific to each rental.

rental_id	customer_id	 rental_date	 return_date	film_id
1	         1001	     2024-10-01	     2024-10-05	     1
2	         1001	     2024-10-02	     2024-10-06	     2
3	         1002	     2024-10-03	      2024-10-07	 1

2. The Customer table:
This table stores information about customers.

customer_id	customer_name	customer_email
1001	    John Doe	     johndoe@example.com
1002	    Jane Smith	     janesmith@example.com

3. The Film table:
This table stores information about films.

film_id	 film_title
1	    "The Matrix"
2	    "Inception" */

--Q5. CTE Basics
/* a.Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in 
     from the actor and film_actor tables.

To create a CTE that combines information from the film and language tables to display the film title, language 
name, and rental rate, we'll need to perform a JOIN between these two tables. The film table contains information 
about films, including the film_id, title, rental_rate, and the language_id. The language table contains the languag
-e_id and name of each language.

Steps:
Join the film table with the language table on the language_id field to match each film with its corresponding 
language.
Select the necessary columns: title from the film table, name from the language table, and rental_rate from the 
film table.
Use a CTE to organize this data before selecting the results.     

In SQL, a Common Table Expression (CTE) is used to create a temporary result set that can be referenced within a 
SELECT, INSERT, UPDATE, or DELETE statement. It improves the readability and organization of complex queries. */

WITH ActorFilmCount AS (
    -- This CTE joins the actor and film_actor tables to count the films per actor
    SELECT
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM
        actor a
    JOIN
        film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY
        a.actor_id, a.first_name, a.last_name
)
-- Now, select the distinct actor names and film counts
SELECT
    actor_name,
    film_count
FROM
    ActorFilmCount
ORDER BY
    film_count DESC;  -- Order by film count in descending order 

--Q6.. CTE with Joins:
/*  a. Create a CTE that combines information from the film and language tables to display the film title, language 
       name, and rental rate.    */

WITH FilmLanguageDetails AS (
    -- This CTE joins the film and language tables
    SELECT
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM
        film f
    JOIN
        language l ON f.language_id = l.language_id
)
-- Now, select the data from the CTE
SELECT
    film_title,
    language_name,
    rental_rate
FROM
    FilmLanguageDetails
ORDER BY
    film_title;  -- Order by film title alphabetically   

--Q7.CTE for Aggregation: 
/*  a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
      from the customer and payment tables.*/

WITH CustomerRevenue AS (
    -- This CTE calculates the total revenue for each customer
    SELECT
        p.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM
        payment p
    JOIN
        customer c ON p.customer_id = c.customer_id
    GROUP BY
        p.customer_id, c.first_name, c.last_name
)
-- Now, select the customer name and total revenue
SELECT
    customer_name,
    total_revenue
FROM
    CustomerRevenue
ORDER BY
    total_revenue DESC;  -- Order by total revenue in descending order 

--Q8.CTE with Window Functions:
a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.

WITH FilmRanked AS (
    -- This CTE ranks films based on their rental_duration
    SELECT
        f.title AS film_title,
        f.rental_duration,
        RANK() OVER (ORDER BY f.rental_duration DESC) AS rental_rank
    FROM
        film f
)
-- Select the film title, rental duration, and its rank
SELECT
    film_title,
    rental_duration,
    rental_rank
FROM
    FilmRanked
ORDER BY
    rental_rank;  -- Order by rank (lowest rank first)

-- Q9.CTE and Filtering:
/* a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
   customer table to retrieve additional customer details. */
   WITH CustomerRentalCount AS (
    -- This CTE finds customers with more than two rentals
    SELECT
        p.customer_id,
        COUNT(p.payment_id) AS rental_count
    FROM
        payment p
    GROUP BY
        p.customer_id
    HAVING
        COUNT(p.payment_id) > 2  -- Only customers who made more than two rentals
)
-- Now, join the CTE with the customer table to get additional customer details
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    crc.rental_count
FROM
    CustomerRentalCount crc
JOIN
    customer c ON crc.customer_id = c.customer_id
ORDER BY
    crc.rental_count DESC;  -- Order by the number of rentals (most rentals first)

--Q10.CTE for Date Calculations:
 /*a. Write a query using a CTE to find the total number of rentals made each month, considering the 
rental_date from the rental table. */

/* Steps:
Create the CTE: In the CTE, we will extract the year and month from the rental_date using date functions (YEAR() 
and MONTH()).Aggregate Rentals: We will count the number of rentals (COUNT(rental_id)) for each unique combination 
of year and month.Select the Results: After defining the CTE, we will select the aggregated results and order them 
by month. */

SQL Query:

WITH MonthlyRentals AS (
    -- This CTE calculates the total rentals for each month
    SELECT
        YEAR(r.rental_date) AS rental_year,
        MONTH(r.rental_date) AS rental_month,
        COUNT(r.rental_id) AS total_rentals
    FROM
        rental r
    GROUP BY
        YEAR(r.rental_date), MONTH(r.rental_date)
)
-- Select the results from the CTE and order by year and month
SELECT
    rental_year,
    rental_month,
    total_rentals
FROM
    MonthlyRentals
ORDER BY
    rental_year DESC, rental_month DESC;  -- Order by year and month (most recent first)

--Q11. CTE and Self-Join:
/*a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
together, using the film_actor table.  

Steps:
CTE: Create a CTE to join the film_actor table with itself to identify pairs of actors who share the same film_id.
Avoid Duplicate Pairs: To avoid listing the same pair of actors multiple times (e.g., Actor A with Actor B and 
Actor B with Actor A), we can enforce a condition that ensures each pair is listed only once by ensuring that the 
first actor's actor_id is less than the second actor's actor_id.
Select the Results: After defining the CTE, select the pairs of actors, along with the title of the film they 
appeared in.

SQL Query using CTE and Self-Join:*/
WITH ActorPairs AS (
    -- This CTE joins the film_actor table with itself to find pairs of actors in the same film
    SELECT
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        fa1.film_id,
        f.title AS film_title
    FROM
        film_actor fa1
    JOIN
        film_actor fa2 ON fa1.film_id = fa2.film_id
    JOIN
        film f ON fa1.film_id = f.film_id
    WHERE
        fa1.actor_id < fa2.actor_id  -- Ensures each pair is only listed once (avoids duplicates)
)
-- Now, select the actor pairs and the corresponding film title
SELECT
    a1.first_name || ' ' || a1.last_name AS actor1_name,
    a2.first_name || ' ' || a2.last_name AS actor2_name,
    ap.film_title
FROM
    ActorPairs ap
JOIN
    actor a1 ON ap.actor1_id = a1.actor_id
JOIN
    actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY
    ap.film_title, actor1_name, actor2_name;

--Q12.. CTE for Recursive Search:
/* a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 
considering the reports_to column.

Steps:
Base Case:Select the direct reports of the specific manager.
Recursive Case: Recursively find employees who report to the employees selected in the previous step.
Termination: The recursion stops when no more direct reports can be found for the current set of employees.*/

WITH RECURSIVE EmployeeHierarchy AS (
    -- Base case: select the manager (who is at the top of the hierarchy)
    SELECT
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM
        staff s
    WHERE
        s.reports_to = <specific_manager_id>  -- Replace with the manager's staff_id

    UNION ALL

    -- Recursive case: select employees who report to the previously selected employees
    SELECT
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM
        staff s
    JOIN
        EmployeeHierarchy eh ON s.reports_to = eh.staff_id  -- Employees reporting to the current level
)
-- Select the result from the CTE
SELECT
    staff_id,
    first_name,
    last_name
FROM
    EmployeeHierarchy;

    



     





