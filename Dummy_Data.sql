USE e_commerce;

-- INSERTION OF DUMMY DATA

INSERT INTO Users (email, password_hash, first_name, last_name, phone_number, is_active)
VALUES
('aman.jaiswal@gmail.com', 'hash123', 'Aman', 'Jaiswal', '9876543210', TRUE),
('neha.sharma@yahoo.com', 'hash456', 'Neha', 'Sharma', '9812345678', TRUE),
('rohit.verma@gmail.com', 'hash789', 'Rohit', 'Verma', '9898989898', TRUE),
('kiran.patel@gmail.com', 'hash159', 'Kiran', 'Patel', '9823456789', TRUE),
('ravi.kumar@hotmail.com', 'hash753', 'Ravi', 'Kumar', '9908765432', TRUE);

INSERT INTO Addresses (user_id, address_line1, city, state, postal_code, country, is_default_shipping)
VALUES
(1, '123, Sector 12', 'Noida', 'Uttar Pradesh', '201301', 'India', TRUE),
(2, '45, MG Road', 'Bengaluru', 'Karnataka', '560001', 'India', TRUE),
(3, '67, Baner Road', 'Pune', 'Maharashtra', '411045', 'India', TRUE),
(4, '8, Navrangpura', 'Ahmedabad', 'Gujarat', '380009', 'India', TRUE),
(5, '22, Anna Nagar', 'Chennai', 'Tamil Nadu', '600040', 'India', TRUE);

INSERT INTO Categories (name, description)
VALUES
('Electronics', 'All electronic gadgets and accessories'),
('Mobiles', 'Smartphones and mobile accessories'),
('Laptops', 'Personal and gaming laptops'),
('Fashion', 'Clothing, shoes, and accessories'),
('Home Appliances', 'Daily use home appliances');

INSERT INTO Suppliers (company_name, contact_name, contact_email, phone)
VALUES
('TechWorld India Pvt Ltd', 'Suresh Nair', 'contact@techworld.in', '080-4567890'),
('SmartShop Distributors', 'Priya Desai', 'sales@smartshop.in', '022-3344556'),
('GadgetZone', 'Vikram Mehta', 'info@gadgetzone.in', '040-2233445');

INSERT INTO Products (category_id, supplier_id, name, description, base_price, main_image_url)
VALUES
(2, 1, 'Samsung Galaxy S23', 'Flagship Android smartphone with AMOLED display', 74999.00, 'https://example.com/s23.jpg'),
(2, 2, 'iPhone 15', 'Latest Apple iPhone with A16 chip', 89999.00, 'https://example.com/iphone15.jpg'),
(3, 1, 'HP Pavilion 15', 'Intel i5, 16GB RAM, 512GB SSD Laptop', 62999.00, 'https://example.com/hp15.jpg'),
(4, 2, 'Men’s Denim Jacket', 'Blue denim jacket for casual wear', 1999.00, 'https://example.com/jacket.jpg'),
(5, 3, 'Philips Mixer Grinder', '750W powerful motor with 3 jars', 3499.00, 'https://example.com/mixer.jpg');

INSERT INTO Product_Variants (product_id, sku, size, color, price_adjustment, stock_quantity)
VALUES
(1, 'SAMS23BLK128', '128GB', 'Black', 0.00, 25),
(1, 'SAMS23GLD256', '256GB', 'Gold', 5000.00, 15),
(2, 'IPH15BLU128', '128GB', 'Blue', 0.00, 20),
(3, 'HPPAV15GRY', 'Standard', 'Grey', 0.00, 10),
(4, 'DENIMJKT_M', 'M', 'Blue', 0.00, 50),
(4, 'DENIMJKT_L', 'L', 'Blue', 100.00, 40),
(5, 'MIXGRND750', 'Standard', 'White', 0.00, 30);

INSERT INTO Product_Images (product_id, image_url, is_primary)
VALUES
(1, 'https://example.com/s23-front.jpg', TRUE),
(1, 'https://example.com/s23-back.jpg', FALSE),
(2, 'https://example.com/iphone15-front.jpg', TRUE),
(3, 'https://example.com/hp15-top.jpg', TRUE),
(4, 'https://example.com/jacket-front.jpg', TRUE),
(5, 'https://example.com/mixer-jar.jpg', TRUE);

INSERT INTO Carts (user_id)
VALUES
(1), (2), (3), (4), (5);

INSERT INTO Cart_Items (cart_id, variant_id, quantity)
VALUES
(1, 1, 1),   -- Aman Jaiswal has 1 Samsung Galaxy S23 128GB
(1, 5, 2),   -- + 2 Denim Jackets
(2, 3, 1),   -- Neha Sharma has 1 iPhone 15
(3, 4, 1),   -- Rohit Verma has 1 HP Laptop
(5, 7, 1);   -- Ravi Kumar has 1 Mixer Grinder

INSERT INTO Wishlists (user_id)
VALUES (1), (2), (3), (4), (5);

INSERT INTO Wishlist_Items (wishlist_id, product_id)
VALUES
(1, 2),  -- Aman likes iPhone 15
(2, 3),  -- Neha likes HP Pavilion
(3, 1),  -- Rohit likes Samsung S23
(4, 4),  -- Kiran likes Denim Jacket
(5, 5);  -- Ravi likes Mixer

INSERT INTO Reviews (product_id, user_id, rating, comment)
VALUES
(1, 1, 5, 'Excellent phone, very smooth performance!'),
(2, 2, 4, 'Great camera but a bit expensive.'),
(3, 3, 5, 'Best laptop for daily use!'),
(4, 4, 4, 'Comfortable and stylish denim jacket.'),
(5, 5, 5, 'Powerful mixer grinder, works perfectly.');

INSERT INTO Coupons (code, discount_type, discount_value, valid_from, valid_until, usage_limit)
VALUES
('DIWALI10', 'PERCENTAGE', 10.00, '2025-10-15', '2025-11-15', 100),
('FIRSTBUY100', 'FIXED_AMOUNT', 100.00, '2025-01-01', '2025-12-31', 500);

INSERT INTO Orders (user_id, shipping_address_id, coupon_id, order_status, total_amount, shipping_cost, tax_amount)
VALUES
(1, 1, 1, 'DELIVERED', 69999.00, 100.00, 500.00),
(2, 2, 2, 'PROCESSING', 88999.00, 150.00, 600.00);

INSERT INTO Order_Details (order_id, variant_id, quantity, unit_price_at_purchase)
VALUES
(1, 1, 1, 74999.00),
(2, 3, 1, 89999.00);

INSERT INTO Payments (order_id, payment_method, payment_status, amount, gateway_transaction_id)
VALUES
(1, 'CREDIT_CARD', 'COMPLETED', 70599.00, 'TXN123INPAY'),
(2, 'PAYPAL', 'PENDING', 89749.00, 'TXN124INPAY');

-- ******* Add More Data *******
INSERT INTO Users (email, password_hash, first_name, last_name, phone_number, is_active)
VALUES
('priya.singh@gmail.com', 'hash111', 'Priya', 'Singh', '9876501234', TRUE),
('arjun.mehra@yahoo.com', 'hash222', 'Arjun', 'Mehra', '9001234567', TRUE),
('sneha.rana@gmail.com', 'hash333', 'Sneha', 'Rana', '9822012345', TRUE),
('alok.tripathi@yahoo.com', 'hash444', 'Alok', 'Tripathi', '9812341200', TRUE),
('ruchi.pandey@gmail.com', 'hash000', 'Ruchi', 'Pandey', '9810034567', TRUE);

INSERT INTO Addresses (user_id, address_line1, city, state, postal_code, country, is_default_shipping)
VALUES
(6, 'A-55, Janakpuri', 'New Delhi', 'Delhi', '110058', 'India', TRUE),
(7, 'Plot 9, Salt Lake', 'Kolkata', 'West Bengal', '700064', 'India', TRUE),
(8, '92, BTM Layout', 'Bengaluru', 'Karnataka', '560076', 'India', TRUE),
(9, '10, Charminar Road', 'Hyderabad', 'Telangana', '500002', 'India', TRUE),
(10, '44, Civil Lines', 'Prayagraj', 'Uttar Pradesh', '211001', 'India', TRUE);

INSERT INTO Products (category_id, supplier_id, name, description, base_price, main_image_url)
VALUES
(2, 1, 'OnePlus 12R', 'Premium smartphone with Snapdragon 8 Gen 2', 42999, 'https://example.com/1p12r.jpg'),
(2, 1, 'Redmi Note 13 Pro', 'Best budget smartphone', 19999, 'https://example.com/redmi13pro.jpg'),
(4, 2, 'Women Kurti Set', 'Cotton kurti with leggings', 1499, 'https://example.com/kurti.jpg'),
(4, 2, 'Men Formal Shirt', 'Pure cotton office shirt', 899, 'https://example.com/formalshirt.jpg'),
(5, 3, 'Bajaj Electric Kettle 1.5L', 'Stainless steel kettle', 1199, 'https://example.com/kettle.jpg'),
(5, 3, 'Usha Ceiling Fan 1200mm', 'High-speed ceiling fan', 2499, 'https://example.com/usha-fan.jpg'),
(3, 1, 'Dell Inspiron i5 12th Gen', 'Latest Dell laptop for office and home', 58999, 'https://example.com/dell-inspiron.jpg'),
(3, 2, 'Lenovo Legion 5 Gaming', 'Ryzen 7, RTX 3060', 109999, 'https://example.com/legion5.jpg');

INSERT INTO Product_Variants (product_id, sku, size, color, price_adjustment, stock_quantity)
VALUES
(6, 'ONE12RBLK', '256GB', 'Black', 0, 40),
(6, 'ONE12RGRN', '256GB', 'Green', 500, 25),
(7, 'REDMI13PROBLU', '8GB/128GB', 'Blue', 0, 60),
(7, 'REDMI13PROGRY', '8GB/256GB', 'Grey', 1000, 30),
(8, 'KURTI_L', 'L', 'Pink', 0, 80),
(8, 'KURTI_XL', 'XL', 'Blue', 100, 50),
(9, 'FORMAL_M', 'M', 'White', 0, 100),
(9, 'FORMAL_L', 'L', 'Sky Blue', 50, 90),
(10, 'KETTLE15L', 'Standard', 'Silver', 0, 70),
(11, 'USHA1200', 'Standard', 'Brown', 0, 45),
(12, 'DELLI5STD', '16GB', 'Grey', 0, 20),
(13, 'LEGION5RTX', '16GB', 'Black', 20000, 10);


INSERT INTO Reviews (product_id, user_id, rating, comment)
VALUES
(6, 6, 5, 'OnePlus delivers best performance at this price.'),
(7, 7, 4, 'Great budget phone. Display is awesome.'),
(8, 8, 5, 'Comfortable and looks beautiful.'),
(9, 9, 4, 'Perfect for office use.'),
(10, 10, 5, 'Heats fast, great quality.');

INSERT INTO Coupons (code, discount_type, discount_value, valid_from, valid_until, usage_limit)
VALUES
('HOLI20', 'PERCENTAGE', 20, '2025-03-01', '2025-03-31', 300),
('NEWUSER150', 'FIXED_AMOUNT', 150, '2025-01-01', '2025-12-31', 1000),
('SUMMER500', 'FIXED_AMOUNT', 500, '2025-04-01', '2025-06-30', 200),
('FESTIVE7', 'PERCENTAGE', 7, '2025-09-01', '2025-12-31', 500);

INSERT INTO Orders (user_id, shipping_address_id, coupon_id, order_status, total_amount, shipping_cost, tax_amount)
VALUES
(6, 6, 3, 'DELIVERED', 41999, 80, 500),
(7, 7, 4, 'SHIPPED', 18999, 99, 350),
(8, 8, NULL, 'PROCESSING', 1499, 50, 60),
(9, 9, 2, 'DELIVERED', 62999, 150, 800),
(10, 10, 1, 'PENDING', 9999, 100, 200);

INSERT INTO Order_Details (order_id, variant_id, quantity, unit_price_at_purchase)
VALUES
(3, 8, 1, 42999),
(4, 9, 1, 18999),
(5, 10, 1, 1499),
(6, 12, 1, 58999),
(7, 13, 1, 109999);

SELECT * FROM users;
SELECT * FROM products;
SELECT * FROM WISHLISTS;

-- SELECT ALL PRODUCTS FROM SAME CATEGORY
SELECT p.*
FROM Products AS p
JOIN Categories AS c ON p.category_id = c.category_id
WHERE c.name = 'Mobiles';

-- LIST OF ALL ORDERS OF A SPECIFIC USER
SELECT 
    order_id,
    order_status,
    total_amount,
    shipping_cost,
    tax_amount,
    order_date
FROM Orders
WHERE user_id = 1
ORDER BY order_date DESC;

-- LIST OF ORDERS WITH ORDER DETAILS
SELECT 
    o.order_id,
    o.order_date,
    p.name AS product_name,
    pv.color,
    pv.size,
    od.quantity,
    od.unit_price_at_purchase
FROM Orders o
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Product_Variants pv ON od.variant_id = pv.variant_id
JOIN Products p ON pv.product_id = p.product_id
WHERE o.user_id = 2
ORDER BY o.order_date DESC;

-- GET ALL PRODUCTS FROM A USER'S WISHLIST
SELECT 
    p.product_id,
    p.name AS product_name,
    p.base_price,
    c.name AS category_name,
    wi.added_at
FROM Wishlists w
JOIN Wishlist_Items wi ON w.wishlist_id = wi.wishlist_id
JOIN Products p ON wi.product_id = p.product_id
JOIN Categories c ON p.category_id = c.category_id
WHERE w.user_id = 1;

-- ALL PRODUCT OF A USER'S CART
SELECT 
    p.product_id,
    p.name AS product_name,
    p.description,
    p.base_price,
    pv.variant_id,
    pv.size,
    pv.color,
    pv.price_adjustment,
    (p.base_price + pv.price_adjustment) AS final_price,
    ci.quantity,
    ((p.base_price + pv.price_adjustment) * ci.quantity) AS total_price,
    img.image_url
FROM
    Carts c
        JOIN
    Cart_Items ci ON c.cart_id = ci.cart_id
        JOIN
    Product_Variants pv ON ci.variant_id = pv.variant_id
        JOIN
    Products p ON pv.product_id = p.product_id
        LEFT JOIN
    Product_Images img ON img.product_id = p.product_id
        AND img.is_primary = TRUE
WHERE
    c.user_id = 1
ORDER BY ci.added_at DESC;

-- TOTAL REVIEWS AND AVG RATING OF A PRODUCT
SELECT 
    p.product_id,
    p.name AS product_name,
    COUNT(r.review_id) AS total_reviews,
    AVG(r.rating) AS average_rating
FROM Products p
LEFT JOIN Reviews r ON p.product_id = r.product_id
WHERE p.product_id = 5
GROUP BY p.product_id, p.name;

-- ALL USERS WIT THEIR ADDRESS
SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    u.email,
    a.address_line1,
    a.city,
    a.state,
    a.postal_code,
    a.country,
    a.is_default_shipping
FROM Users u
LEFT JOIN Addresses a ON u.user_id = a.user_id
ORDER BY u.user_id, a.is_default_shipping DESC;

-- ALL PRODUCT WITH THEIR CATEGORY AND PARENT CATEGORY NAME
SELECT 
    p.product_id,
    p.name AS product_name,
    c.name AS category_name,
    pc.name AS parent_category
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
LEFT JOIN Categories pc ON c.parent_category_id = pc.category_id;

-- PRODUCTS BELOW A CERTIAN AMOUNT
SELECT *
FROM Products
WHERE base_price <= 20000;


