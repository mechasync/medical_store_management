-- Medical Store Management System Database Schema
-- Database: pharma
-- This schema includes all necessary tables for inventory, sales, customer, and employee management
-- ============================================
-- IMPORTANT: Table structure matches existing PHP code
-- Password Hashing: MD5 (for consistency with PHP application)
-- ============================================

-- Create Database
CREATE DATABASE IF NOT EXISTS pharma;
USE pharma;

-- ============================================
-- 1. ADMIN TABLE (Admin Authentication)
-- ============================================
CREATE TABLE IF NOT EXISTS admin (
    id INT PRIMARY KEY AUTO_INCREMENT,
    a_username VARCHAR(50) NOT NULL UNIQUE,
    a_password VARCHAR(255) NOT NULL,
    a_email VARCHAR(100),
    a_status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- 2. EMPLOGIN TABLE (Pharmacy Staff Authentication)
-- ============================================
CREATE TABLE IF NOT EXISTS emplogin (
    e_id INT PRIMARY KEY AUTO_INCREMENT,
    e_username VARCHAR(50) NOT NULL UNIQUE,
    e_pass VARCHAR(255) NOT NULL,
    e_email VARCHAR(100),
    e_status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- 3. CUSTOMER TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS customer (
    c_id INT PRIMARY KEY AUTO_INCREMENT,
    c_fname VARCHAR(100) NOT NULL,
    c_lname VARCHAR(100),
    c_age INT,
    c_sex VARCHAR(10),
    c_phno VARCHAR(15),
    c_mail VARCHAR(100),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- 4. EMPLOYEE TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS employee (
    e_id INT PRIMARY KEY AUTO_INCREMENT,
    e_fname VARCHAR(100) NOT NULL,
    e_lname VARCHAR(100),
    bdate DATE,
    e_age INT,
    e_sex VARCHAR(10),
    e_type VARCHAR(50),
    e_jdate DATE,
    e_sal DECIMAL(10, 2),
    e_phno VARCHAR(15),
    e_mail VARCHAR(100),
    e_add VARCHAR(255),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- 5. EMPLOYEE (Alternate uppercase spelling - for compatibility)
-- ============================================
CREATE TABLE IF NOT EXISTS EMPLOYEE (
    E_ID INT PRIMARY KEY AUTO_INCREMENT,
    E_FNAME VARCHAR(100) NOT NULL,
    E_LNAME VARCHAR(100),
    BDATE DATE,
    E_AGE INT,
    E_SEX VARCHAR(10),
    E_TYPE VARCHAR(50),
    E_JDATE DATE,
    E_SAL DECIMAL(10, 2),
    E_PHNO VARCHAR(15),
    E_MAIL VARCHAR(100),
    E_ADD VARCHAR(255),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- 6. SUPPLIERS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS suppliers (
    sup_id INT PRIMARY KEY AUTO_INCREMENT,
    sup_name VARCHAR(100) NOT NULL,
    sup_add VARCHAR(255),
    sup_phno VARCHAR(15),
    sup_mail VARCHAR(100),
    sup_status ENUM('active', 'inactive') DEFAULT 'active',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- 7. MEDICINES/INVENTORY TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS meds (
    med_id INT PRIMARY KEY AUTO_INCREMENT,
    med_name VARCHAR(150) NOT NULL,
    med_qty INT NOT NULL DEFAULT 0,
    category VARCHAR(50),
    med_price DECIMAL(10, 2) NOT NULL,
    location_rack VARCHAR(50),
    batch_number VARCHAR(50),
    expiry_date DATE,
    mfg_date DATE,
    supplier_id INT,
    med_status ENUM('in_stock', 'out_of_stock', 'discontinued') DEFAULT 'in_stock',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- 8. SALES TABLE (POS Transactions)
-- ============================================
CREATE TABLE IF NOT EXISTS sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    c_id INT,
    e_id INT,
    s_date DATE,
    s_time TIME,
    total_amt DECIMAL(15, 2),
    discount DECIMAL(10, 2) DEFAULT 0,
    payment_method VARCHAR(50) DEFAULT 'cash',
    payment_status ENUM('paid', 'pending') DEFAULT 'paid',
    notes TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (c_id) REFERENCES customer(c_id),
    FOREIGN KEY (e_id) REFERENCES employee(e_id)
);

-- ============================================
-- 9. SALES ITEMS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS sales_items (
    sale_id INT,
    med_id INT,
    sale_qty INT NOT NULL,
    tot_price DECIMAL(15, 2),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id) ON DELETE CASCADE,
    FOREIGN KEY (med_id) REFERENCES meds(med_id)
);

-- ============================================
-- 10. PURCHASES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS purchases (
    p_id INT PRIMARY KEY AUTO_INCREMENT,
    sup_id INT NOT NULL,
    p_date DATE NOT NULL,
    total_amount DECIMAL(15, 2),
    payment_status ENUM('pending', 'partial', 'paid') DEFAULT 'pending',
    notes TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (sup_id) REFERENCES suppliers(sup_id)
);

-- ============================================
-- 11. PURCHASE ITEMS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS purchase_items (
    p_id INT NOT NULL,
    med_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_cost DECIMAL(10, 2),
    total_cost DECIMAL(15, 2),
    FOREIGN KEY (p_id) REFERENCES purchases(p_id) ON DELETE CASCADE,
    FOREIGN KEY (med_id) REFERENCES meds(med_id)
);

-- ============================================
-- 12. STOCK MOVEMENTS TABLE (Tracking)
-- ============================================
CREATE TABLE IF NOT EXISTS stock_movements (
    movement_id INT PRIMARY KEY AUTO_INCREMENT,
    med_id INT NOT NULL,
    movement_type ENUM('in', 'out', 'adjustment', 'return') NOT NULL,
    quantity INT NOT NULL,
    reference_type VARCHAR(50),
    reference_id INT,
    reason TEXT,
    previous_quantity INT,
    new_quantity INT,
    created_by INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (med_id) REFERENCES meds(med_id)
);

-- ============================================
-- 13. EXPIRY TRACKING TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS expiry_tracking (
    expiry_id INT PRIMARY KEY AUTO_INCREMENT,
    med_id INT NOT NULL,
    batch_number VARCHAR(50),
    quantity INT,
    expiry_date DATE NOT NULL,
    warning_date DATE,
    status ENUM('active', 'expired', 'disposed') DEFAULT 'active',
    disposal_date DATE,
    disposal_notes TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (med_id) REFERENCES meds(med_id)
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

-- Admin indexes
CREATE INDEX idx_admin_username ON admin(a_username);
CREATE INDEX idx_admin_status ON admin(a_status);

-- Employee login indexes
CREATE INDEX idx_emplogin_username ON emplogin(e_username);
CREATE INDEX idx_emplogin_status ON emplogin(e_status);

-- Customer indexes
CREATE INDEX idx_customer_name ON customer(c_fname);
CREATE INDEX idx_customer_phone ON customer(c_phno);
CREATE INDEX idx_customer_email ON customer(c_mail);

-- Supplier indexes
CREATE INDEX idx_supplier_name ON suppliers(sup_name);
CREATE INDEX idx_supplier_email ON suppliers(sup_mail);

-- Medicine indexes
CREATE INDEX idx_medicine_name ON meds(med_name);
CREATE INDEX idx_medicine_batch ON meds(batch_number);
CREATE INDEX idx_medicine_expiry ON meds(expiry_date);
CREATE INDEX idx_medicine_status ON meds(med_status);

-- Sales indexes
CREATE INDEX idx_sale_date ON sales(s_date);
CREATE INDEX idx_sale_customer ON sales(c_id);
CREATE INDEX idx_sale_employee ON sales(e_id);
CREATE INDEX idx_sale_status ON sales(payment_status);

-- Stock movement indexes
CREATE INDEX idx_movement_date ON stock_movements(created_date);
CREATE INDEX idx_movement_medicine ON stock_movements(med_id);
CREATE INDEX idx_movement_type ON stock_movements(movement_type);

-- Expiry tracking indexes
CREATE INDEX idx_expiry_date ON expiry_tracking(expiry_date);
CREATE INDEX idx_expiry_status ON expiry_tracking(status);

-- ============================================
-- SAMPLE DATA FOR TESTING
-- ============================================

-- Insert sample admin user (Password: admin123 hashed with MD5)
INSERT INTO admin (a_username, a_password, a_email, a_status) VALUES 
('admin', MD5('admin123'), 'admin@pharma.com', 'active');

-- Insert sample pharmacy staff (Password: pharma123 hashed with MD5)
INSERT INTO emplogin (e_username, e_pass, e_email, e_status) VALUES 
('pharmacy1', MD5('pharma123'), 'pharmacy@pharma.com', 'active');

-- Insert sample employee (for pharmacy staff)
INSERT INTO employee (e_fname, e_lname, bdate, e_age, e_sex, e_type, e_jdate, e_sal, e_phno, e_mail, e_add) VALUES 
('John', 'Doe', '1990-05-15', 34, 'Male', 'Pharmacist', '2020-01-15', 30000, '9876543210', 'john@pharma.com', '123 Main St');

-- Insert sample suppliers
INSERT INTO suppliers (sup_name, sup_add, sup_phno, sup_mail, sup_status) VALUES 
('ABC Pharmaceuticals', '123 Business St, Mumbai', '9876543210', 'contact@abc.com', 'active'),
('XYZ Medical Supplies', '456 Trade Road, Delhi', '9123456789', 'info@xyz.com', 'active');

-- Insert sample medicines
INSERT INTO meds (med_name, med_qty, category, med_price, location_rack, batch_number, expiry_date, supplier_id, med_status) VALUES 
('Aspirin 500mg', 100, 'Pain Relief', 5.00, 'A1', 'BATCH001', '2026-12-31', 1, 'in_stock'),
('Amoxicillin 250mg', 50, 'Antibiotic', 3.00, 'B1', 'BATCH002', '2026-11-30', 2, 'in_stock'),
('Paracetamol 650mg', 200, 'Pain Relief', 2.50, 'A2', 'BATCH003', '2027-01-15', 1, 'in_stock');

-- Insert sample customers
INSERT INTO customer (c_fname, c_lname, c_age, c_sex, c_phno, c_mail) VALUES 
('Ram', 'Kumar', 45, 'Male', '9876543210', 'ram@email.com'),
('Priya', 'Singh', 38, 'Female', '9123456789', 'priya@email.com');

-- ============================================
-- END OF SCHEMA
-- ============================================
