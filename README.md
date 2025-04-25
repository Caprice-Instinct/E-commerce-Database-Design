# E-Commerce Database Schema
## Group 712

This project defines a comprehensive **MySQL relational database schema** for an e-commerce platform. It covers everything from product listings and variations to images, brands, attributes, and inventory tracking.

---

## 📁 Database: `ecommerce`

### 🧱 Core Tables

| Table               | Description                                                  |
| ------------------- | ------------------------------------------------------------ |
| `product`           | Stores product details (name, description, base price, etc.) |
| `brand`             | Brand information, including logo and description            |
| `product_category`  | Hierarchical categories (e.g., Apparel > T-Shirts)           |
| `product_image`     | Product images with ordering and alt text                    |
| `product_variation` | Variants by size, color, and SKU                             |
| `product_item`      | Inventory for each variation with barcodes                   |

---

### 🎨 Attributes & Customization

| Table                | Description                                     |
| -------------------- | ----------------------------------------------- |
| `attribute_type`     | Types like Material, Style, Fit                 |
| `attribute_category` | Groups of attributes (Basic Info, Design, etc.) |
| `product_attribute`  | Values of specific attributes per product       |

---

### 👕 Size & Color Options

| Table           | Description                              |
| --------------- | ---------------------------------------- |
| `size_category` | Category of sizes (e.g., Clothing Sizes) |
| `size_option`   | Specific sizes (S, M, L, etc.)           |
| `color`         | Product colors with hex codes            |

---

## 🚀 Setup Instructions

1. **Clone the Repository (if applicable):**

   ```bash
   git clone https://github.com/your-username/ecommerce-schema.git
   cd ecommerce-schema

   ```

2. **Import the Database Schema into MySQL:**

Open your preferred MySQL client (e.g., MySQL Workbench, DBeaver, or command-line interface), then run the provided SQL script to create the database and all associated tables.

If using the MySQL command line, run:

```bash
mysql -u your_username -p < schema.sql
```

3. **Verify the Database Setup:**

   After successfully importing the schema, you can verify that all tables and sample data were created correctly.

   In your MySQL client, run the following queries to check the tables:

   ```sql
   USE ecommerce;
   SHOW TABLES;
   SELECT * FROM product;
   ```

### Happy Coding!