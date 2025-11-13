# E-Commerce Platform (MySQL) — Project README

## Project Overview
This repository contains a full-featured **E-Commerce** platform database schema (MySQL 8+), sample data, and supporting artifacts.  
The database models Users, Addresses, Categories, Suppliers, Products (with Variants & Images), Wishlists, Carts, Orders, Payments, Coupons, and Reviews.

Included:
- MySQL-compatible schema (`E-COMMERCE.sql`)
- Extensive sample/dump data for testing (`Dummy_Data.sql`)
- ER Diagram (visual) — `E_Commerce.png`
- Useful queries & examples in `queries.md`

---

## Files in this package
- `E-COMMERCE.sql` — DDL for creating the database (InnoDB, utf8mb4, constraints, indexes).
- `Dummy_Data.sql` — Sample data inserts (Realistic names, addresses, products ....).
- `E_Commerce.png` — Visual ER diagram.
- `ECOMMERCE_README.md` — This README file (you are reading it).

> Note: If you received only a subset of files, run the schema (`schema.sql`) first, then load `seed.sql`.

---

## Quickstart — Local MySQL (Development)
1. Install MySQL 8+ and MySQL Workbench.
2. Open MySQL Workbench and connect to your local server.
3. Create the database and run the schema:
   ```sql
   -- from MySQL Workbench SQL editor
   SOURCE /path/to/E-COMMERCE..sql;
   ```
4. Load seed data:
   ```sql
   SOURCE /path/to/Dummy_Data.sql;
   ```
5. Open the ER diagram in MySQL Workbench:
   - File → Open Model → select the `.mwb` if provided, or
   - Import the schema and use the Model editor / reverse engineer.

---

## How to use the ER Diagram
- The ER diagram (`E-Commerce.png`) visually maps tables and foreign keys:
  - Users → Addresses, Wishlists, Carts, Orders
  - Products → Product_Variants, Product_Images, Reviews
  - Orders → Order_Details → Product_Variants
  - Carts → Cart_Items → Product_Variants
- Open the PNG in any image viewer or embed it in your documentation.

---

## Relational Image
<img width="1833" height="1245" alt="Relational Diagram" src="https://github.com/user-attachments/assets/0ade27dd-9cd2-46b7-b6f5-ff069fdaa913" />

---

## ER Diagram


## Useful SQL Snippets (examples)
- Get user cart:
```sql
SELECT p.product_id, p.name, pv.variant_id, (p.base_price + pv.price_adjustment) AS final_price, ci.quantity
FROM Carts c
JOIN Cart_Items ci ON c.cart_id = ci.cart_id
JOIN Product_Variants pv ON ci.variant_id = pv.variant_id
JOIN Products p ON pv.product_id = p.product_id
WHERE c.user_id = 1;
```

- Get product rating summary:
```sql
SELECT p.product_id, p.name, COUNT(r.review_id) AS total_reviews, IFNULL(AVG(r.rating),0) AS avg_rating
FROM Products p
LEFT JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name;
```

