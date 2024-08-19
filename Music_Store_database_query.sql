--Q1:Who is the senior and junior must employee based on job title?

SELECT * FROM employee    -- JUNIOR EMPLOYEE BASED ON THE JOB TITLE 
ORDER BY levels ASC
LIMIT 1
SELECT * FROM employee    -- SENIOR OF EMPLOYEE BASED ON JOB TITLE
ORDER BY levels DESC
LIMIT 1

-- 2.Which countries have the most and less invoices?

SELECT * FROM invoice
SELECT billing_country,COUNT (billing_country) AS TOTAL_COUNT     -- Most invoices of the country
FROM invoice
GROUP BY billing_country
ORDER BY TOTAL_COUNT DESC
LIMIT 1


SELECT billing_country,COUNT (billing_country) AS TOTAL_COUNT    -- Less invoices of the country
FROM invoice
GROUP BY billing_country
ORDER BY TOTAL_COUNT ASC
LIMIT 1


--Q3: What are 3 top and bottom invoice of total invoice?

SELECT * FROM INVOICE   -- TOP 3 INVOICE OF TOTAL
ORDER BY TOTAL DESC LIMIT 3

SELECT * FROM INVOICE
ORDER BY TOTAL ASC LIMIT 3     -- BOTTOM 3 INVOICE OF TOTAL

/* Q.4: Which city has the best customers? We would like to throw apromotional
music festival in the city we made the most money.write a quety that returns
one city that has the highest sum of invoice totals. return both the city names 
& sum of all invoice totals */

SELECT * FROM INVOICE
SELECT billing_city, SUM(total) AS Sum_of_Total
from invoice 
GROUP BY billing_city
ORDER BY Sum_of_Total DESC
LIMIT 1


/*Q.5: Who is the best customer? The customer who hase
spent the most money will be declared the best customer.
Write the query that returns the person who has spent the 
most money */

SELECT * FROM CUSTOMER
SELECT * FROM INVOICE
SELECT customer.customer_id,customer.first_name, customer.last_name, SUM(invoice.total) AS total
FROM CUSTOMER
JOIN INVOICE ON customer.customer_id=invoice.customer_id
group by customer.customer_id
order by total desc
limit 1

/*Q.6: Write query to return the email, first name , last name & genre of all rock music listeners. 
Return your list ordered alphabeticallyby email starting with A */


SELECT email, first_name, last_name FROM customer
JOIN invoice on customer.customer_id = invoice.customer_id
JOIN invoice_line on invoice.invoice_id=invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre on track.genre_id=genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;


/*Q.7: Let's invite the artists who have written the most rock music in our dataset.
Write a query that returns the Artist name  and total track count of the top 10 rock brands */


SELECT  artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_Of_Songs
FROM track
JOIN album ON album.album_id=track.album_id
JOIN artist ON artist.artist_id=album.artist_id
JOIN genre ON genre.genre_id= track.genre_id
WHERE genre.name LIKE 'ROCK'
GROUP BY artist.artist_id
ORDER BY number_Of_Songs DESC
LIMIT 10;
 
/*Q.8: Return all the track names that have a song length longer than 
the average song length.Return the Name and Milliseconds for each track
Order by the song length with the longest song linsted first.*/

SELECT name,milliseconds FROM track
WHERE milliseconds> (
	SELECT AVG(milliseconds) AS Song_Length
	FROM track
)
ORDER BY milliseconds desc
limit 1


