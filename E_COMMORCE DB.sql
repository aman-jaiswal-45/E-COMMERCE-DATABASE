CREATE DATABASE IF NOT EXISTS e_commerce CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE e_commerce;

-- 1. USER MANAGEMENT

CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- Store hashed passwords ONLY
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    phone_number VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CHECK (email LIKE '%_@_%._%')
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    is_default_shipping BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 2. PRODUCT CATALOG & INVENTORY

CREATE TABLE IF NOT EXISTS Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id INT,
    FOREIGN KEY (parent_category_id) REFERENCES Categories(category_id)
        ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    contact_name VARCHAR(100),
    contact_email VARCHAR(255),
    phone VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    supplier_id INT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL,
    main_image_url TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Product_Variants (
    variant_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    sku VARCHAR(100) UNIQUE NOT NULL,
    size VARCHAR(50),
    color VARCHAR(50),
    price_adjustment DECIMAL(10, 2) DEFAULT 0.00,
    stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0),
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    UNIQUE (product_id, size, color)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Product_Images (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    image_url TEXT NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 💡 3. CART SYSTEM

CREATE TABLE IF NOT EXISTS Carts (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,  -- One active cart per user
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Cart_Items (
    cart_item_id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    variant_id INT NOT NULL,        -- Always link to Product_Variants for stock accuracy
    quantity INT NOT NULL CHECK (quantity > 0),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES Carts(cart_id) ON DELETE CASCADE,
    FOREIGN KEY (variant_id) REFERENCES Product_Variants(variant_id),
    UNIQUE (cart_id, variant_id)    -- Prevent duplicate variants in the same cart
) ENGINE=InnoDB;

-- 4. WISHLISTS & REVIEWS

CREATE TABLE IF NOT EXISTS Wishlists (
    wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Wishlist_Items (
    wishlist_id INT NOT NULL,
    product_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (wishlist_id, product_id),
    FOREIGN KEY (wishlist_id) REFERENCES Wishlists(wishlist_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    UNIQUE (product_id, user_id)
) ENGINE=InnoDB;

-- 5. COUPONS, ORDERS & PAYMENTS

CREATE TABLE IF NOT EXISTS Coupons (
    coupon_id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    discount_type ENUM('PERCENTAGE', 'FIXED_AMOUNT') NOT NULL,
    discount_value DECIMAL(10, 2) NOT NULL,
    valid_from TIMESTAMP NULL,
    valid_until TIMESTAMP NULL,
    usage_limit INT,
    times_used INT DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    shipping_address_id INT NOT NULL,
    coupon_id INT,
    order_status ENUM('PENDING', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED') DEFAULT 'PENDING',
    total_amount DECIMAL(10, 2) NOT NULL,
    shipping_cost DECIMAL(10, 2) DEFAULT 0.00,
    tax_amount DECIMAL(10, 2) DEFAULT 0.00,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    delivered_at TIMESTAMP NULL,
    cancelled_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (shipping_address_id) REFERENCES Addresses(address_id),
    FOREIGN KEY (coupon_id) REFERENCES Coupons(coupon_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Order_Details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    variant_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price_at_purchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (variant_id) REFERENCES Product_Variants(variant_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method ENUM('CREDIT_CARD', 'PAYPAL', 'BANK_TRANSFER', 'COD') NOT NULL,
    payment_status ENUM('PENDING', 'COMPLETED', 'FAILED', 'REFUNDED') DEFAULT 'PENDING',
    amount DECIMAL(10, 2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    gateway_transaction_id VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
) ENGINE=InnoDB;

-- 6. INDEXES FOR PERFORMANCE

CREATE INDEX idx_products_category ON Products(category_id);
CREATE INDEX idx_variants_product ON Product_Variants(product_id);
CREATE INDEX idx_orders_user ON Orders(user_id);
CREATE INDEX idx_order_details_order ON Order_Details(order_id);
CREATE INDEX idx_product_name ON Products(name);
CREATE INDEX idx_orders_status ON Orders(order_status);
