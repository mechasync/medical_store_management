-- Medical Store Management System Database Schema
-- Database: pharma
-- This schema includes all necessary tables for inventory, sales, customer, and employee management

-- Create Database
CREATE DATABASE IF NOT EXISTS pharma;
USE pharma;

-- ============================================
-- 1. USERS TABLE (Authentication)
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    role ENUM('admin', 'pharmacy_staff', 'employee') NOT NULL DEFAULT 'pharmacy_staff',
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- 2. CUSTOMERS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    customer_type ENUM('regular', 'premium', 'wholesale') DEFAULT 'regular',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- 3. SUPPLIERS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    payment_terms VARCHAR(100),
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- 4. INVENTORY/MEDICINES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS medicines (
    medicine_id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_name VARCHAR(150) NOT NULL,
    generic_name VARCHAR(150),
    medicine_type VARCHAR(50),
    manufacturer VARCHAR(100),
    batch_number VARCHAR(50),
    quantity_in_stock INT NOT NULL DEFAULT 0,
    unit_price DECIMAL(10, 2) NOT NULL,
    selling_price DECIMAL(10, 2) NOT NULL,
    expiry_date DATE,
    mfg_date DATE,
    description TEXT,
    supplier_id INT,
    status ENUM('in_stock', 'out_of_stock', 'discontinued') DEFAULT 'in_stock',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- ============================================
-- 5. EMPLOYEES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255),
    date_of_birth DATE,
    gender ENUM('male', 'female', 'other'),
    designation VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE,
    status ENUM('active', 'inactive', 'on_leave') DEFAULT 'active',
    user_id INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ============================================
-- 6. PURCHASES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT NOT NULL,
    purchase_date DATE NOT NULL,
    total_amount DECIMAL(15, 2),
    payment_status ENUM('pending', 'partial', 'paid') DEFAULT 'pending',
    delivery_status ENUM('pending', 'in_transit', 'delivered') DEFAULT 'pending',
    notes TEXT,
    created_by INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- ============================================
-- 7. PURCHASE ITEMS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS purchase_items (
    purchase_item_id INT PRIMARY KEY AUTO_INCREMENT,
    purchase_id INT NOT NULL,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_cost DECIMAL(10, 2),
    total_cost DECIMAL(15, 2),
    FOREIGN KEY (purchase_id) REFERENCES purchases(purchase_id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- ============================================
-- 8. SALES TABLE (POS Transactions)
-- ============================================
CREATE TABLE IF NOT EXISTS sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(15, 2),
    discount DECIMAL(10, 2) DEFAULT 0,
    tax DECIMAL(10, 2) DEFAULT 0,
    net_amount DECIMAL(15, 2),
    payment_method ENUM('cash', 'card', 'cheque', 'online') DEFAULT 'cash',
    payment_status ENUM('paid', 'pending') DEFAULT 'paid',
    created_by INT,
    notes TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- ============================================
-- 9. SALES ITEMS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS sales_items (
    sales_item_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id INT NOT NULL,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2),
    total_price DECIMAL(15, 2),
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- ============================================
-- 10. STOCK MOVEMENTS TABLE (Tracking)
-- ============================================
CREATE TABLE IF NOT EXISTS stock_movements (
    movement_id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT NOT NULL,
    movement_type ENUM('in', 'out', 'adjustment', 'return') NOT NULL,
    quantity INT NOT NULL,
    reference_type VARCHAR(50),
    reference_id INT,
    reason TEXT,
    previous_quantity INT,
    new_quantity INT,
    created_by INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- ============================================
-- 11. EXPIRY TRACKING TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS expiry_tracking (
    expiry_id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT NOT NULL,
    batch_number VARCHAR(50),
    quantity INT,
    expiry_date DATE NOT NULL,
    warning_date DATE,
    status ENUM('active', 'expired', 'disposed') DEFAULT 'active',
    disposal_date DATE,
    disposal_notes TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- ============================================
-- 12. AUDIT LOG TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS audit_log (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    action VARCHAR(100),
    table_name VARCHAR(50),
    record_id INT,
    old_values JSON,
    new_values JSON,
    ip_address VARCHAR(45),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

-- User indexes
CREATE INDEX idx_user_username ON users(username);
CREATE INDEX idx_user_role ON users(role);

-- Customer indexes
CREATE INDEX idx_customer_name ON customers(customer_name);
CREATE INDEX idx_customer_phone ON customers(phone);
CREATE INDEX idx_customer_email ON customers(email);

-- Supplier indexes
CREATE INDEX idx_supplier_name ON suppliers(supplier_name);
CREATE INDEX idx_supplier_email ON suppliers(email);

-- Medicine indexes
CREATE INDEX idx_medicine_name ON medicines(medicine_name);
CREATE INDEX idx_medicine_batch ON medicines(batch_number);
CREATE INDEX idx_medicine_expiry ON medicines(expiry_date);
CREATE INDEX idx_medicine_supplier ON medicines(supplier_id);
CREATE INDEX idx_medicine_status ON medicines(status);

-- Employee indexes
CREATE INDEX idx_employee_name ON employees(employee_name);
CREATE INDEX idx_employee_email ON employees(email);
CREATE INDEX idx_employee_status ON employees(status);

-- Purchase indexes
CREATE INDEX idx_purchase_date ON purchases(purchase_date);
CREATE INDEX idx_purchase_supplier ON purchases(supplier_id);
CREATE INDEX idx_purchase_status ON purchases(payment_status);

-- Sales indexes
CREATE INDEX idx_sale_date ON sales(sale_date);
CREATE INDEX idx_sale_customer ON sales(customer_id);
CREATE INDEX idx_sale_status ON sales(payment_status);

-- Stock movement indexes
CREATE INDEX idx_movement_date ON stock_movements(created_date);
CREATE INDEX idx_movement_medicine ON stock_movements(medicine_id);
CREATE INDEX idx_movement_type ON stock_movements(movement_type);

-- Expiry tracking indexes
CREATE INDEX idx_expiry_date ON expiry_tracking(expiry_date);
CREATE INDEX idx_expiry_status ON expiry_tracking(status);

-- ============================================
-- SAMPLE DATA (Optional)
-- ============================================

-- Insert sample user
INSERT INTO users (username, password, email, role, status) VALUES 
('admin', SHA2('admin123', 256), 'admin@pharma.com', 'admin', 'active'),
('pharmacy1', SHA2('pharma123', 256), 'pharmacy@pharma.com', 'pharmacy_staff', 'active');

-- Insert sample suppliers
INSERT INTO suppliers (supplier_name, contact_person, email, phone, address, city, state, status) VALUES 
('ABC Pharmaceuticals', 'John Doe', 'contact@abc.com', '9876543210', '123 Business St', 'Mumbai', 'Maharashtra', 'active'),
('XYZ Medical Supplies', 'Jane Smith', 'info@xyz.com', '9123456789', '456 Trade Road', 'Delhi', 'Delhi', 'active');

-- Insert sample medicines
INSERT INTO medicines (medicine_name, generic_name, manufacturer, batch_number, quantity_in_stock, unit_price, selling_price, expiry_date, supplier_id, status) VALUES 
('Aspirin 500mg', 'Acetylsalicylic Acid', 'ABC Pharma', 'BATCH001', 100, 2.50, 5.00, '2026-12-31', 1, 'in_stock'),
('Amoxicillin 250mg', 'Amoxicillin', 'XYZ Medical', 'BATCH002', 50, 1.50, 3.00, '2026-11-30', 2, 'in_stock'),
('Paracetamol 650mg', 'Acetaminophen', 'ABC Pharma', 'BATCH003', 200, 1.00, 2.50, '2027-01-15', 1, 'in_stock');

-- Insert sample customer
INSERT INTO customers (customer_name, email, phone, address, city, state, customer_type) VALUES 
('Ram Kumar', 'ram@email.com', '9876543210', '100 Main St', 'Mumbai', 'Maharashtra', 'regular'),
('Priya Singh', 'priya@email.com', '9123456789', '200 Park Ave', 'Delhi', 'Delhi', 'premium');

-- ============================================
-- END OF SCHEMA
-- ============================================
