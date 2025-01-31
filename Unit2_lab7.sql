# Unit 2 Lab 7
USE sakila;

# 1. In the table actor, which are the actors whose last names are not repeated? 
# For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. So we do not want to include this last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.
-- decided to create a temp table to store the unique last names
CREATE TEMPORARY TABLE unique_surnames as (
	SELECT last_name, COUNT(last_name) as unique_surname_count
	FROM actor
	GROUP BY last_name
	HAVING unique_surname_count = 1
    );
#check
SELECT *
FROM unique_surnames;

SELECT first_name, last_name
FROM actor
RIGHT JOIN unique_surnames
USING (last_name);

# 2. Which last names appear more than once? We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once
SELECT last_name, COUNT(last_name) as repeating_surname_count
FROM actor
GROUP BY last_name
HAVING repeating_surname_count > 1;

# 3. Using the rental table, find out how many rentals were processed by each employee.
SELECT staff_id, COUNT(rental_id) as films_rented
FROM rental
GROUP BY staff_id;

# 4. Using the film table, find out how many films were released each year.
SELECT release_year, COUNT(film_id) as film_count
FROM film
GROUP BY release_year;

# 5. Using the film table, find out for each rating how many films were there.
SELECT rating, COUNT(film_id) as film_count
FROM film
GROUP BY rating;

# 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
SELECT rating, ROUND(AVG(length),2) as mean_length
FROM film
GROUP BY rating;

# 7. Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating, ROUND(AVG(length),2) as mean_length
FROM film
GROUP BY rating
HAVING mean_length > 120;