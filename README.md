# E-Commerce Platform (MySQL) — Project README

## Project Overview
This repository contains a full-featured **E-Commerce** platform database schema (MySQL 8+), sample data, and supporting artifacts.  
The database models Users, Addresses, Categories, Suppliers, Products (with Variants & Images), Wishlists, Carts, Orders, Payments, Coupons, and Reviews.

Included:
- MySQL-compatible schema (`schema.sql`)
- Extensive sample/dump data for India-based test data (`seed.sql`)
- ER Diagram (visual) — `A_2D_entity-relationship_diagram_(ERD)_displays_an.png`
- Useful queries & examples in `queries.md`

---

## Files in this package
- `schema.sql` — DDL for creating the database (InnoDB, utf8mb4, constraints, indexes).
- `seed.sql` — Sample data inserts (Indian realistic names, addresses, products).
- `A_2D_entity-relationship_diagram_(ERD)_displays_an.png` — Visual ER diagram.
- `ECOMMERCE_README.md` — This README file (you are reading it).
- `queries.md` — Common SQL queries (get cart, wishlist, orders by user, ratings, etc).

> Note: If you received only a subset of files, run the schema (`schema.sql`) first, then load `seed.sql`.

---

## Quickstart — Local MySQL (Development)
1. Install MySQL 8+ and MySQL Workbench.
2. Open MySQL Workbench and connect to your local server.
3. Create the database and run the schema:
   ```sql
   -- from MySQL Workbench SQL editor
   SOURCE /path/to/schema.sql;
   ```
4. Load seed data:
   ```sql
   SOURCE /path/to/seed.sql;
   ```
5. Open the ER diagram in MySQL Workbench:
   - File → Open Model → select the `.mwb` if provided, or
   - Import the schema and use the Model editor / reverse engineer.

---

## How to use the ER Diagram
- The ER diagram (`A_2D_entity-relationship_diagram_(ERD)_displays_an.png`) visually maps tables and foreign keys:
  - Users → Addresses, Wishlists, Carts, Orders
  - Products → Product_Variants, Product_Images, Reviews
  - Orders → Order_Details → Product_Variants
  - Carts → Cart_Items → Product_Variants
- Open the PNG in any image viewer or embed it in your documentation.

---

## Key Features to Showcase (Interview Talking Points)
- Normalized relational schema with enforced constraints and indexes.
- Product variants & SKUs design for inventory accuracy.
- Cart and Wishlist separation (cart for transient intent, wishlist for save-for-later).
- Audit fields, ENUMs, and CHECK constraints for data integrity.
- Order lifecycle and payment separation — supports multiple payments per order.
- Realistic seeding data (Indian names, cities, festival coupons).
- Extendable: recommendation engine, Elasticsearch integration, Redis caching.

---

## Suggested Next Steps / Enhancements
1. Add role-based auth + admin panel.
2. Integrate payment gateway (Razorpay / Stripe) and webhooks.
3. Implement Redis caching for product details and cart sessions.
4. Add Elasticsearch for fuzzy product search and auto-suggest.
5. Build analytics dashboard (Chart.js / Recharts) for admin.
6. Containerize with Docker and add CI/CD.

---

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

---

## License
MIT License — feel free to reuse and adapt for your projects and interviews.

---

## Contact / Credits
Prepared for Aman Jaiswal — database schema, sample data, and ER diagram were created and arranged for learning and project use.

