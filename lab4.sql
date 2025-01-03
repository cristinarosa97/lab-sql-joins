
USE sakila;

# 1. List the number of films per category.
SELECT name as category_name, fc.category_id, COUNT(film_id) as films_per_category
FROM film_category as fc
INNER JOIN category as c
ON fc.category_id = c.category_id
GROUP BY category_id;

# 2. Retrieve the store ID, city, and country for each store.

SELECT store_id, city, country
FROM store
INNER JOIN address
ON store.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id;


# 3. Calculate the total revenue generated by each store in dollars.

SELECT store.store_id, SUM(payment.amount) AS total_revenue
FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;


# 4. Determine the average running time of films for each category.

SELECT  c.name as category_name, ROUND(AVG(length),2) as avg_film_lenght
FROM film as f
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.category_id;

# 5. Identify the film categories with the longest average running time.

SELECT  c.name as category_name, AVG(length) as avg_film_length
FROM film as f
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.category_id
ORDER BY avg_film_length DESC; 

# 6. Display the top 10 most frequently rented movies in descending order.

SELECT title, COUNT(*) as rented_times
FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
Group by title
ORDER by rented_times desc
Limit 10;


# 7. Determine if "Academy Dinosaur" can be rented from Store 1.

SELECT title, inventory_id, film.film_id, store_id
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
WHERE title LIKE "Academy Dinosaur" AND store_id = 1;

# 8. Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 
#'NOT available.' 
# Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."

SELECT title,
	CASE 
		WHEN ISNULL(i.film_id) THEN "Not available"
		ELSE "Available"
	END AS film_availability
FROM film as f
LEFT JOIN inventory as i
ON f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY f.film_id ASC;

