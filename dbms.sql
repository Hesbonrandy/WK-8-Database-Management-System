-- =============================================
-- INVENTORY TRACKING SYSTEM - MySQL DATABASE
-- =============================================

-- Step 1: Create the Database
CREATE DATABASE IF NOT EXISTS InventoryTrackingSystem;
USE InventoryTrackingSystem;

-- Step 2: Create Tables with Constraints and Relationships

-- Table: Categories (for product categorization)
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Table: Suppliers (companies or persons supplying products)
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    contact_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: Warehouses (physical or logical storage locations)
CREATE TABLE Warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_name VARCHAR(150) NOT NULL UNIQUE,
    location VARCHAR(255) NOT NULL,
    capacity INT CHECK (capacity > 0),
    manager_name VARCHAR(100),
    phone VARCHAR(20)
);

-- Table: Products (items tracked in inventory)
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    sku VARCHAR(50) NOT NULL UNIQUE, -- Stock Keeping Unit
    supplier_id INT,
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE SET NULL
);

-- Junction Table: Product_Category (Many-to-Many relationship)
CREATE TABLE Product_Category (
    product_id INT,
    category_id INT,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

-- Table: Inventory (current stock levels per product per warehouse)
CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id) ON DELETE CASCADE,
    UNIQUE (product_id, warehouse_id) -- One product can only have one record per warehouse
);

-- Table: InventoryTransactions (log of stock movements: IN/OUT)
CREATE TABLE InventoryTransactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    transaction_type ENUM('IN', 'OUT') NOT NULL, -- Stock in or out
    quantity INT NOT NULL CHECK (quantity > 0),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id) ON DELETE CASCADE
);

INSERT INTO Categories (category_name, description) VALUES
('Electronics', 'Devices and gadgets'),
('Furniture', 'Home and office furniture'),
('Stationery', 'Office and school supplies');

INSERT INTO Suppliers (supplier_name, contact_name, phone, email, address) VALUES
('TechGiant Inc.', 'John Smith', '+1234567890', 'john@techgiant.com', '123 Tech Blvd, Silicon Valley'),
('OfficeWorld', 'Lisa Ray', '+0987654321', 'lisa@officeworld.com', '456 Stationery St, New York');

INSERT INTO Warehouses (warehouse_name, location, capacity, manager_name, phone) VALUES
('Main Warehouse', 'Downtown', 10000, 'Alice Brown', '+1122334455'),
('East Storage', 'Eastside Industrial Park', 5000, 'Bob Green', '+5566778899');

INSERT INTO Products (product_name, sku, supplier_id, unit_price, description) VALUES
('Laptop XYZ', 'LAP-XYZ-001', 1, 999.99, 'High-performance laptop'),
('Office Chair', 'CHR-OFF-100', 2, 149.50, 'Ergonomic office chair'),
('Notebook A5', 'NTB-A5-200', 2, 2.99, 'A5 Spiral Notebook');

INSERT INTO Product_Category (product_id, category_id) VALUES
(1, 1), -- Laptop → Electronics
(2, 2), -- Chair → Furniture
(3, 3); -- Notebook → Stationery

INSERT INTO Inventory (product_id, warehouse_id, quantity) VALUES
(1, 1, 50),
(2, 1, 100),
(3, 2, 500);

INSERT INTO InventoryTransactions (product_id, warehouse_id, transaction_type, quantity, notes) VALUES
(1, 1, 'IN', 20, 'Initial stock received'),
(2, 1, 'IN', 50, 'Bulk delivery'),
(3, 2, 'IN', 300, 'Back to school promo stock');

