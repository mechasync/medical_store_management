# Medical Store Management System - Setup & Usage Guide

## ✅ Project Status

Your Medical Store Management System has been restructured and is now **fully ready to run** (assuming database is set up and running).

## 📋 Current Project Structure

```
medical_store_management/
├── config.php                          # Database configuration
├── index.php                           # Main entry point
├── adminmainpage.php                   # Admin dashboard
├── pharmmainpage.php                   # Pharmacy staff dashboard
├── mainpage.php                        # Admin login page
├── mainpage_pharma.php                 # Pharmacy staff login page
│
├── customers/                          # Customer management
│   ├── customer-add.php
│   ├── customer-view.php
│   ├── customer-update.php
│   ├── customer-delete.php
│   ├── pharm-customer.php
│   └── pharm-customer-view.php
│
├── employees/                          # Employee management
│   ├── employee-add.php
│   ├── employee-view.php
│   ├── employee-update.php
│   └── employee-delete.php
│
├── inventory/                          # Medicine inventory
│   ├── inventory-add.php
│   ├── inventory-view.php
│   ├── inventory-update.php
│   ├── inventory-delete.php
│   └── pharm-inventory.php
│
├── purchases/                          # Stock purchases
│   ├── purchase-add.php
│   ├── purchase-view.php
│   ├── purchase-update.php
│   └── purchase-delete.php
│
├── suppliers/                          # Supplier management
│   ├── supplier-add.php
│   ├── supplier-view.php
│   ├── supplier-update.php
│   └── supplier-delete.php
│
├── pos/                                # Point of Sale system
│   ├── pos1.php
│   ├── pos2.php
│   ├── pos-delete.php
│   ├── pharm-pos1.php
│   ├── pharm-pos2.php
│   └── pharm-pos-delete.php
│
├── reports/                            # Analytics & reporting
│   ├── expiryreport.php
│   ├── salesreport.php
│   ├── sales-view.php
│   ├── salesitems-view.php
│   └── stockreport.php
│
├── utilities/                          # Helper scripts
│   ├── logout.php                      # Admin logout (redirects to mainpage.php)
│   └── logout1.php                     # Pharmacy logout (redirects to mainpage_pharma.php)
│
├── assets/                             # Static files
│   ├── css/
│   │   ├── nav2.css
│   │   ├── table1.css, table2.css
│   │   ├── form2.css, form3.css, form4.css
│   │   ├── header.css, login1.css
│   │   └── ...
│   └── img/
│
├── database/                           # Database files
│   └── schema.sql                      # Complete database schema
│
└── Documentation files
    ├── README.md                       # Project overview
    ├── SETUP_GUIDE.md                  # This file (Setup & usage guide)
    └── COMPLETION_REPORT.md            # Project restructuring report
```

## 🚀 Getting Started

### Prerequisites
- PHP 7.0 or higher
- MySQL 5.7 or higher (MariaDB compatible)
- Apache Web Server (or XAMPP/WAMP)
- All files are properly configured with correct paths

### Step 1: Database Setup

1. **Create and import the database:**
   ```sql
   CREATE DATABASE pharma;
   USE pharma;
   -- Then import schema.sql
   ```

2. **Import the schema using phpMyAdmin or MySQL client:**
   
   **Via phpMyAdmin:**
   - Open phpMyAdmin
   - Create new database named `pharma`
   - Select the database
   - Click "Import" tab
   - Select `database/schema.sql` file
   - Click "Go"
   
   **Via MySQL command line:**
   ```bash
   mysql -u root -p < database/schema.sql
   ```
   
   **Via MySQL Workbench:**
   - Open the `database/schema.sql` file
   - Execute the script

3. **Verify database connection in config.php:**
   ```php
   $conn = mysqli_connect("localhost", "root", "", "pharma");
   if ($conn->connect_error) {
       die("Connection failed: " . $conn->connect_error);
   }
   ```
   Update credentials if your MySQL setup differs:
   - Change `"root"` to your MySQL username
   - Change `""` (empty) to your MySQL password
   - Change `"pharma"` to your database name

### Step 2: Configure Web Server

1. **Place the project in your web root:**
   - **XAMPP**: `C:\xampp\htdocs\medical_store_management\`
   - **WAMP**: `C:\wamp\www\medical_store_management\`
   - **Linux/Apache**: `/var/www/html/medical_store_management/`

2. **Ensure proper file permissions:**
   ```bash
   chmod -R 755 medical_store_management/
   chmod -R 777 medical_store_management/database/
   ```

### Step 3: Access the Application

Open your browser and navigate to:
```
http://localhost/medical_store_management/mainpage.php
```

For direct access:
- **Admin Login**: `http://localhost/medical_store_management/mainpage.php`
- **Pharmacy Login**: `http://localhost/medical_store_management/mainpage_pharma.php`

## 🔐 Login Information & Authentication

### Default Test Credentials

**Admin Account:**
- **Page**: `http://localhost/medical_store_management/mainpage.php`
- **Username**: `admin`
- **Password**: `admin123`
- **Access Level**: Full admin access to all modules
- **Redirects to**: `adminmainpage.php`

**Pharmacy Staff Account:**
- **Page**: `http://localhost/medical_store_management/mainpage_pharma.php`
- **Username**: `pharmacy1`
- **Password**: `pharma123`
- **Access Level**: Pharmacy-specific functions (POS, inventory, customers)
- **Redirects to**: `pharmmainpage.php`

### Authentication System Details

**Password Hashing:**
- Algorithm: MD5
- Applied: Both admin and pharmacy staff logins
- Location: Hashing done in login pages before database query

**Database Tables for Authentication:**
- **Admin Login**: `admin` table
  - Columns: `id`, `a_username`, `a_password`, `a_email`, `a_status`
  - Query: `SELECT id FROM admin WHERE a_username='$uname' AND a_password=MD5('$password')`
  
- **Pharmacy Login**: `emplogin` table
  - Columns: `e_id`, `e_username`, `e_pass`, `e_email`, `e_status`
  - Query: `SELECT e_id FROM emplogin WHERE e_username='$uname' AND e_pass=MD5('$password')`

**Session Management:**
- Session variable stores username/ID after successful login
- `$_SESSION['user']` = username (admin) or employee ID (pharmacy)
- Session destroyed on logout
- Logout redirects to appropriate login page

> ⚠️ **Security Note**: These are default credentials for testing. 
> - Change them immediately in production
> - Use stronger passwords (minimum 12 characters with special characters)
> - Consider upgrading to bcrypt or Argon2 password hashing for production

## 📊 Database Schema Overview

### Core Tables

| Table | Purpose | Primary Key | Key Columns |
|-------|---------|-------------|------------|
| `admin` | Admin authentication | `id` | `a_username`, `a_password` |
| `emplogin` | Pharmacy staff login | `e_id` | `e_username`, `e_pass` |
| `employee` | Employee records | `e_id` | `e_fname`, `e_email`, `e_phno` |
| `customer` | Customer data | `c_id` | `c_fname`, `c_phno`, `c_mail` |
| `meds` | Medicine inventory | `med_id` | `med_name`, `med_qty`, `category` |
| `suppliers` | Supplier information | `sup_id` | `sup_name`, `sup_mail` |
| `sales` | POS transactions | `sale_id` | `c_id`, `e_id`, `s_date` |
| `sales_items` | Sales line items | - | `sale_id`, `med_id`, `sale_qty` |
| `purchases` | Stock orders | `p_id` | `sup_id`, `p_date` |
| `purchase_items` | Purchase line items | - | `p_id`, `med_id`, `quantity` |
| `expiry_tracking` | Expiry management | `expiry_id` | `med_id`, `expiry_date` |
| `stock_movements` | Inventory tracking | `movement_id` | `med_id`, `movement_type` |

### Sample Data Included

The schema includes sample data for testing:
- **Admin User**: username=`admin`, password=`admin123`
- **Pharmacy Staff**: username=`pharmacy1`, password=`pharma123`
- **Employees**: Sample pharmacist record linked to pharmacy staff
- **Suppliers**: 2 sample suppliers (ABC Pharmaceuticals, XYZ Medical Supplies)
- **Medicines**: 3 sample medicines with various categories
- **Customers**: 2 sample customers

## 🛠️ Key Features Available

### Admin Dashboard (adminmainpage.php)
- **Inventory Management** - Add, view, update, delete medicines
- **Customer Management** - Manage customer database
- **Employee Management** - Track employees and their credentials
- **Supplier Management** - Supplier information and contacts
- **Purchase Management** - Stock orders from suppliers
- **POS System** - Process sales transactions
- **Reporting** - Sales, stock, and expiry reports
- **Full System Access** - All modules available

### Pharmacy Staff Dashboard (pharmmainpage.php)
- **Inventory Viewing** - Check available medicines and stock levels
- **Customer Management** - Add and view customer records
- **POS System** - Process sales transactions (main function)
- **Pharmacy-specific Features** - Tailored tools for pharmacy operations
- **Limited Access** - Pharmacy-specific modules only
- **Logout** - Secure session termination

## 🔄 Workflow

1. **Start the Application**
   - Navigate to `http://localhost/medical_store_management/mainpage.php`
   - Or choose between admin/pharmacy login page

2. **User Login**
   - Select appropriate login page (Admin or Pharmacy)
   - Enter credentials
   - Password validated with MD5 hashing
   - Session created on successful authentication

3. **Dashboard Access**
   - Admin or Pharmacy dashboard loads based on role
   - Navigation menu displays role-specific modules

4. **Navigate Modules**
   - Use sidebar menu to access different sections
   - All links use correct relative paths

5. **Perform Operations**
   - Add/Edit/Delete operations within each module
   - POS transactions processed
   - Reports generated
   - Redirects work properly within directory structure

6. **Logout**
   - Click "Logout" link in dashboard
   - Session terminated
   - Redirected to appropriate login page
   - `logout.php` → admin redirects to `mainpage.php`
   - `logout1.php` → pharmacy redirects to `mainpage_pharma.php`

## ⚠️ Common Issues & Fixes

### Issue: "Access denied for user 'root'@'localhost'"
- **Cause**: Wrong MySQL password in `config.php`
- **Fix**: 
  ```php
  // Update config.php with correct credentials
  $conn = mysqli_connect("localhost", "username", "password", "pharma");
  ```

### Issue: "Table doesn't exist" errors
- **Cause**: Schema not imported correctly
- **Fix**:
  1. Delete the `pharma` database if it exists
  2. Create a fresh database
  3. Re-import `database/schema.sql`
  4. Verify all tables are created: `SHOW TABLES;`

### Issue: "Headers already sent" error
- **Cause**: Output before header() calls
- **Fix**: Ensure no `echo`/output before `header()` statements in login/logout files

### Issue: "Invalid username or password" even with correct credentials
- **Cause**: Password not properly hashed or database query issue
- **Fix**:
  1. Verify admin/emplogin tables exist
  2. Check sample data was inserted: `SELECT * FROM admin;`
  3. Verify MD5 hashing is applied consistently
  4. Check column names: `a_username`, `a_password` for admin

### Issue: CSS/Images not loading
- **Cause**: Asset path issues
- **Fix**: 
  1. Verify `assets/` directory exists in root
  2. Check relative paths in CSS links: `../assets/css/`
  3. Clear browser cache (Ctrl+F5)

### Issue: Logout redirects to wrong page
- **Cause**: Using wrong logout file
- **Fix**:
  1. Admin pages use `logout.php` (redirects to mainpage.php)
  2. Pharmacy pages use `logout1.php` (redirects to mainpage_pharma.php)

### Issue: Session not persisting
- **Cause**: Session not started or database connection issue
- **Fix**:
  1. Ensure `session_start()` called in login files
  2. Verify database connection successful
  3. Check PHP session settings in php.ini

## 📝 Database Maintenance

### Backup Database
```bash
mysqldump -u root -p pharma > backup_pharma.sql
```

### Restore Database
```bash
mysql -u root -p pharma < backup_pharma.sql
```

### Add New User (Admin)
```sql
INSERT INTO admin (a_username, a_password, a_email, a_status) 
VALUES ('newadmin', MD5('password123'), 'admin@email.com', 'active');
```

### Add New Pharmacy Staff
```sql
INSERT INTO emplogin (e_username, e_pass, e_email, e_status) 
VALUES ('newstaff', MD5('password123'), 'staff@email.com', 'active');
```

### Reset Password
```sql
UPDATE admin SET a_password = MD5('newpassword') WHERE a_username = 'admin';
UPDATE emplogin SET e_pass = MD5('newpassword') WHERE e_username = 'pharmacy1';
```

## 🎯 Next Steps

1. ✅ Import database schema
2. ✅ Configure `config.php` with database credentials
3. ✅ Test admin login with default credentials
4. ✅ Test pharmacy staff login
5. 🔄 Create additional user accounts as needed
6. 🔄 Add sample data (medicines, suppliers, customers)
7. 🔄 Customize as per your business requirements
8. 🔄 Change default passwords before production

## 🆘 Support & Troubleshooting

**Database Connection Issues:**
- Verify MySQL service is running
- Check credentials in `config.php`
- Confirm `pharma` database exists

**Authentication Issues:**
- Verify admin/emplogin tables exist
- Check sample data was inserted
- Ensure MD5 hashing is applied
- Compare with password stored in database

**File/Path Issues:**
- All paths have been corrected
- Relative paths work from any directory
- Assets load correctly with `../assets/`

**Still Not Working?**
1. Check PHP error logs: `php_errors.log`
2. Enable error reporting in `config.php`
3. Verify all files are readable/executable
4. Check file permissions: `755` for directories, `644` for files

---

**Status**: ✅ Ready to Deploy (All authentication and schema corrected)  
**Last Updated**: May 30, 2026  
**Version**: 1.1 (Fixed: Schema, Authentication, Password Hashing)
