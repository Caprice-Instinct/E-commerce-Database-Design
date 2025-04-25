CREATE TABLE `attribute_type` (
  `attr_type_id` int PRIMARY KEY AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  `description` varchar(255),
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `attribute_category` (
  `attr_category_id` int PRIMARY KEY AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `description` text,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `size_category` (
  `size_category_id` int PRIMARY KEY AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  `description` varchar(255),
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `color` (
  `color_id` int PRIMARY KEY AUTO_INCREMENT,
  `color_name` varchar(50) NOT NULL,
  `hex_code` varchar(7),
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `brand` (
  `brand_id` int PRIMARY KEY AUTO_INCREMENT,
  `brand_name` varchar(100) NOT NULL,
  `description` text,
  `logo_url` varchar(255),
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `product_category` (
  `category_id` int PRIMARY KEY AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `parent_category_id` int,
  `description` text,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `product` (
  `product_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `description` text,
  `base_price` decimal(10,2) NOT NULL,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now()),
  `brand_id` int,
  `category_id` int
);

CREATE TABLE `product_image` (
  `image_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `alt_text` varchar(255),
  `is_primary` boolean DEFAULT false,
  `display_order` int DEFAULT 0,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `size_option` (
  `size_id` int PRIMARY KEY AUTO_INCREMENT,
  `size_category_id` int,
  `size_value` varchar(20) NOT NULL,
  `description` varchar(100),
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `product_variation` (
  `variation_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `color_id` int,
  `size_id` int,
  `sku` varchar(50) UNIQUE,
  `additional_price` decimal(10,2) DEFAULT 0,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `product_item` (
  `item_id` int PRIMARY KEY AUTO_INCREMENT,
  `variation_id` int NOT NULL,
  `quantity_in_stock` int NOT NULL DEFAULT 0,
  `barcode` varchar(50),
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `product_attribute` (
  `attribute_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `attr_category_id` int,
  `attr_type_id` int,
  `attribute_name` varchar(100) NOT NULL,
  `attribute_value` text NOT NULL,
  `display_order` int DEFAULT 0,
  `created_at` timestamp DEFAULT (now())
);

ALTER TABLE `product_category` ADD FOREIGN KEY (`parent_category_id`) REFERENCES `product_category` (`category_id`);

ALTER TABLE `product` ADD FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`);

ALTER TABLE `product` ADD FOREIGN KEY (`category_id`) REFERENCES `product_category` (`category_id`);

ALTER TABLE `product_image` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `size_option` ADD FOREIGN KEY (`size_category_id`) REFERENCES `size_category` (`size_category_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`color_id`) REFERENCES `color` (`color_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`size_id`) REFERENCES `size_option` (`size_id`);

ALTER TABLE `product_item` ADD FOREIGN KEY (`variation_id`) REFERENCES `product_variation` (`variation_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`attr_category_id`) REFERENCES `attribute_category` (`attr_category_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`attr_type_id`) REFERENCES `attribute_type` (`attr_type_id`);

-- Sample Data Insertion
INSERT INTO attribute_type (type_name, description) VALUES 
('Material', 'Type of material used'),
('Style', 'Product style');

INSERT INTO attribute_category (category_name, description) VALUES 
('Basic Info', 'General product details'),
('Design Features', 'Attributes related to design');

INSERT INTO size_category (category_name, description) VALUES 
('Clothing Sizes', 'Standard clothing sizes like S, M, L');

INSERT INTO color (color_name, hex_code) VALUES 
('Red', '#FF0000'),
('Blue', '#0000FF');

INSERT INTO brand (brand_name, description, logo_url) VALUES 
('EcoWear', 'Sustainable clothing brand', 'https://example.com/logo1.png'),
('UrbanFit', 'Modern activewear', 'https://example.com/logo2.png');

INSERT INTO product_category (category_name, description) VALUES 
('Apparel', 'All clothing items'),
('T-Shirts', 'Short-sleeve shirts');

-- Setting parent category for T-Shirts
UPDATE product_category SET parent_category_id = 1 WHERE category_id = 2;

INSERT INTO product (product_name, description, base_price, brand_id, category_id) VALUES 
('Classic T-Shirt', '100% cotton t-shirt', 19.99, 1, 2),
('Athletic T-Shirt', 'Moisture-wicking athletic tee', 24.99, 2, 2);

INSERT INTO product_image (product_id, image_url, alt_text, is_primary, display_order) VALUES  
(1, 'https://example.com/shirt1.jpg', 'Front view of classic t-shirt', TRUE, 1),  
(1, 'https://example.com/shirt1-back.jpg', 'Back view of classic t-shirt', FALSE, 2);

INSERT INTO size_option (size_category_id, size_value, description) VALUES 
(1, 'S', 'Small'),
(1, 'M', 'Medium'),
(1, 'L', 'Large');

INSERT INTO product_variation (product_id, color_id, size_id, sku, additional_price) VALUES 
(1, 1, 2, 'CLT-RD-M', 0),
(1, 2, 3, 'CLT-BL-L', 1.00);

INSERT INTO product_item (variation_id, quantity_in_stock, barcode) VALUES 
(1, 100, '1234567890'),
(2, 50, '0987654321');

INSERT INTO product_attribute (product_id, attr_category_id, attr_type_id, attribute_name, attribute_value) VALUES 
(1, 1, 1, 'Material', '100% Cotton'),
(1, 2, 2, 'Style', 'Casual Fit');

-- Queries to Retrieve Data
SELECT 
  p.product_id,
  p.product_name,
  b.brand_name,
  pc.category_name AS category
FROM product p
JOIN brand b ON p.brand_id = b.brand_id
JOIN product_category pc ON p.category_id = pc.category_id;

SELECT 
  pi.product_id,
  p.product_name,
  pi.image_url,
  pi.is_primary
FROM product_image pi
JOIN product p ON pi.product_id = p.product_id;

SELECT 
  pv.variation_id,
  p.product_name,
  c.color_name,
  so.size_value,
  pv.sku,
  pv.additional_price
FROM product_variation pv
JOIN product p ON pv.product_id = p.product_id
LEFT JOIN color c ON pv.color_id = c.color_id
LEFT JOIN size_option so ON pv.size_id = so.size_id;

SELECT 
  pa.product_id,
  p.product_name,
  ac.category_name AS attribute_category,
  at.type_name AS attribute_type,
  pa.attribute_name,
  pa.attribute_value
FROM product_attribute pa
JOIN product p ON pa.product_id = p.product_id
JOIN attribute_category ac ON pa.attr_category_id = ac.attr_category_id
JOIN attribute_type at ON pa.attr_type_id = at.attr_type_id;

SELECT 
  pi.item_id,
  pv.sku,
  pi.quantity_in_stock,
  pi.barcode
FROM product_item pi
JOIN product_variation pv ON pi.variation_id = pv.variation_id;