DROP TABLE ratingZipCode;

CREATE TABLE ratingZipCode AS
SELECT manhattanyelp.zipcode, categories.category AS category, count(manhattanyelp.id), avg(manhattanyelp.rating) 
FROM manhattanyelp LEFT JOIN categories ON categories.category = manhattanyelp.category
GROUP BY manhattanyelp.zipcode, categories.category;