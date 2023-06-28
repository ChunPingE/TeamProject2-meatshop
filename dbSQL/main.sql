DESC orders;
DESC orderitems;

SELECT * FROM orders;
SELECT * FROM orderitems;

SELECT p.product_id, p.product_name, p.country_of_origin, p.price, p.stock_quantity, c.*, f.file_name, o.sold
FROM products p JOIN categories c ON p.category_id = c.category_id
LEFT JOIN productfilename f ON p.product_id = f.product_id 
LEFT JOIN (SELECT product_id, COUNT(id) sold FROM orderitems GROUP BY product_id ORDER BY sold DESC) o ON  p.product_id = o.product_id
ORDER BY product_id;

SELECT p.*, COUNT(product_id) sold FROM products p JOIN orderitems o ON p.product_id = o.product_id GROUP BY product_id;
SELECT product_id, COUNT(id) sold FROM orderitems GROUP BY product_id ORDER BY sold DESC;

CREATE View mainitemview
AS
SELECT p.*, COUNT(o.product_id) AS sold, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id
LEFT JOIN orderitems o ON p.product_id = o.product_id
WHERE pub = 1
GROUP BY p.product_id
ORDER BY sold DESC, price DESC
LIMIT 3;

SELECT p.*, COUNT(o.product_id) AS sold, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id
LEFT JOIN orderitems o ON p.product_id = o.product_id
WHERE pub = 1
GROUP BY p.product_id
ORDER BY sold DESC, price DESC;

SELECT * FROM mainitemview;

SELECT p.*, COUNT(o.product_id) sold, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id
LEFT JOIN orderitems o ON p.product_id = o.product_id
GROUP BY p.product_id ORDER BY sold DESC LIMIT 3;

CREATE View mainitemview
AS
SELECT p.*, COUNT(ol.product_id) AS sold, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id
LEFT JOIN (SELECT oi.order_id, oi.product_id, o.status FROM orderitems oi JOIN orders o ON o.id = oi.order_id WHERE status != 'CANCEL') ol ON p.product_id = ol.product_id
WHERE pub = 1
GROUP BY p.product_id
ORDER BY sold DESC, price DESC LIMIT 3;

DROP View mainitemview;

SELECT COUNT(product_id), product_id  FROM (SELECT oi.order_id, oi.product_id, o.status FROM orderitems oi JOIN orders o ON o.id = oi.order_id WHERE status != 'CANCEL') C GROUP BY product_id;

SELECT 
    `p`.`product_id` AS `product_id`,
    `p`.`product_name` AS `product_name`,
    `p`.`country_of_origin` AS `country_of_origin`,
    `p`.`price` AS `price`,
    `p`.`stock_quantity` AS `stock_quantity`,
    `p`.`pub` AS `pub`,
    `c`.`category_id` AS `category_id`,
    `c`.`category_name` AS `category_name`,
    `c`.`description` AS `description`,
    (SELECT `f`.`file_name` FROM `productfilename` `f` WHERE `f`.`product_id` = `p`.`product_id` LIMIT 1) AS `file_name`
FROM
    `products` `p`
    JOIN `categories` `c` ON (`p`.`category_id` = `c`.`category_id`)
ORDER BY `p`.`product_id`;