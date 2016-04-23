DROP TABLE ratingZipCode;

CREATE TABLE ratingZipCode AS
SELECT a.*, b.count, b.avg FROM
(SELECT zipcodes.zipcode AS zipcode, categories.category AS category FROM categories FULL JOIN zipcodes) AS a LEFT JOIN
(SELECT manhattanyelp.zipcode as zipcode, categories.category AS category, count(manhattanyelp.id) AS count, avg(manhattanyelp.rating) AS avg 
FROM manhattanyelp LEFT JOIN categories ON categories.category = manhattanyelp.category
GROUP BY manhattanyelp.zipcode, categories.category) AS b
ON a.zipcode = b.zipcode AND a.category = b.category
ORDER BY a.zipcode, a.category;

DROP TABLE ratingNeighborhood;

CREATE TABLE ratingNeighborhood AS
SELECT a.*, b.count, b.avg FROM
(SELECT DISTINCT zipcodes.neighborhood AS neighborhood, categories.category AS category FROM categories FULL JOIN zipcodes) AS a LEFT JOIN
(SELECT manhattanyelp.neighborhood as neighborhood, categories.category AS category, count(manhattanyelp.id) AS count, avg(manhattanyelp.rating) AS avg 
FROM manhattanyelp LEFT JOIN categories ON categories.category = manhattanyelp.category
GROUP BY manhattanyelp.neighborhood, categories.category) AS b
ON a.neighborhood = b.neighborhood AND a.category = b.category
ORDER BY a.neighborhood, a.category;