# 📦 Inventory Tracking System 

A structured **MySQL database schema** designed to track products, categories, suppliers, warehouses, inventory levels, and stock transactions.  
This system helps businesses manage their inventory effectively by maintaining stock records, suppliers, and warehouse allocations.

---

## 🚀 Features
- ✅ Categories for product classification  
- ✅ Supplier management with contact details  
- ✅ Warehouse storage with capacity limits  
- ✅ Products linked to suppliers & categories  
- ✅ Real-time inventory tracking per warehouse  
- ✅ Inventory transactions (stock IN/OUT logs)  
- ✅ Data integrity with foreign keys & constraints  

---

## 🛠️ Database Schema Overview
1. **Categories** – Stores product categories (e.g., Electronics, Furniture, Stationery) and enforces unique category names.  
2. **Suppliers** – Stores supplier/company information, contact details, and created date.  
3. **Warehouses** – Stores warehouse details and enforces capacity > 0.  
4. **Products** – Stores product details (name, SKU, supplier, unit price) and links products to suppliers.  
5. **Product_Category** – Junction table for the many-to-many relationship between products and categories.  
6. **Inventory** – Tracks stock quantity per product per warehouse, ensuring unique product-warehouse pairs.  
7. **InventoryTransactions** – Logs all stock movements (IN / OUT) with quantity, warehouse, product, and transaction date.  

---

## 📊 Entity Relationship Diagram (ERD)

Categories --< Product_Category >-- Products --< Inventory >-- Warehouses
|
|--< InventoryTransactions
|
|-- Suppliers


---

## 📥 Sample Data Included
- **Categories**: Electronics, Furniture, Stationery  
- **Suppliers**: TechGiant Inc., OfficeWorld  
- **Warehouses**: Main Warehouse, East Storage  
- **Products**: Laptop XYZ, Office Chair, Notebook A5  
- **Initial Inventory**: Stock quantities in warehouses  
- **Transactions**: Example stock IN movements  

---

## ▶️ How to Use
1. Clone the repository (or copy the SQL file).  
2. Open MySQL Workbench or CLI.  
3. Run the SQL script:  
   ```bash
   mysql -u your_username -p < inventory_tracking_system.sql

