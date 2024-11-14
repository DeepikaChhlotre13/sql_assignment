1.Identify the primary keys and foreign keys in the Maven Movies database. Discuss the differences.*/
/*   

Aspect                            	Primary Key	                               Foreign Key

Purpose	      Ensures that each record in a table is unique.        Links one table to another, ensuring referential
                                                                    integrity.

Uniqueness	  Must be unique for each row in the table.	             Can be duplicated, as it refers to a primary 
                                                                     key in another table.

Nullability	  Cannot contain NULL values.	                         Can contain NULL values, unless constrained 
                                                                     otherwise.

                                               
Example	      actor_id in actor table                                city_id in address table
              actor_award_id in actor_award table                    country_id in city table
              address_id in address table                            address_id in coustomer table
              advisor_id in advisor table                            store_id in customer table

/* 2. List al
l details of actors.*/
Use mavenmovies;
SELECT * FROM actor;

/* 3. List all customer information from the database. */

SELECT * FROM customer;

/* 4. List different countries. */

SELECT * FROM country;

/* 5. Display all active customers. */

SELECT customer_id,first_name,active
 FROM customer
WHERE active = 1;

/* 6. List all rental IDs for customers with ID 1. */

select * from rental
where customer_id in (1);

/* 7. Display all the films whose rental duration is greater than 5. */

SELECT film_id,title,rental_duration
FROM film
WHERE rental_duration > 5;

/* 8. List the total number of films whose replacement cost is greater than $15 and less than $20. */


SELECT film_id , title , replacement_cost 
FROM film
WHERE replacement_cost BETWEEN 15 and 20;

/* 9. Display the count of unique first names of actors. */

SELECT  count(distinct first_name ) 
AS Unique_fist_name_count
 FROM customer;

/* 10. Display the first 10 records from the customer table. */

SELECT * FROM customer
LIMIT 10;

/* 11. Display the first 3 records from the customer table whose first name starts with 'b'. */

SELECT * FROM customer
WHERE first_name like "B%"
LIMIT 3;

/* 12. Display the names of the first 5 movies which are rated as 'G'. */

SELECT film_id,title,rating FROM film
WHERE rating LIKE "G%";

/* 13. Find all customers whose first name starts with "a". */


SELECT customer_id ,CONCAT(first_name, ' ', last_name) AS full_name,email
FROM customer
WHERE first_name LIKE 'A%';

/* 14. Find all customers whose first name ends with "a". */

SELECT customer_id ,first_name,CONCAT(first_name, ' ', last_name) AS full_name,email
FROM customer
WHERE first_name LIKE "%A";

/* 15. Display the list of first 4 cities which start and end with 'a'. */

SELECT * FROM city
WHERE city LIKE "%A"
LIMIT 4;

/* 16. Find all customers whose first name contains "NI" in any position. */

SELECT * FROM customer
WHERE first_name LIKE "%NI%";

/* 17. Find all customers whose first name has "r" in the second position. */

SELECT * FROM customer
WHERE first_name LIKE "_r%";

/* 18. Find all customers whose first name starts with "a" and are at least 5 characters in length. */

SELECT * FROM customer
WHERE first_name LIKE "a___%";


/* 19. Find all customers whose first name starts with "a" and ends with "o". */

SELECT * FROM customer
WHERE first_name LIKE "a%o";

/* 20. Get the films with PG and PG-13 ratings using the IN operator. */

SELECT * FROM film
WHERE rating In ("PG","PG-13"); 

/* 21. Get the films with lengths between 50 to 100 using the BETWEEN operator. */

SELECT film_id,title,length 
FROM film
WHERE length BETWEEN 50 AND 100;

/* 22. Get the top 50 actors using the LIMIT operator. */

SELECT actor_id, concat(first_name," ",last_name) AS full_name
FROM actor
ORDER BY actor_id ASC
LIMIT 50;

/* 23. Get the distinct film IDs from the inventory table. */

SELECT  DISTINCT film_id FROM inventory;