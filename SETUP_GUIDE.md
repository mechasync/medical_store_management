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
├── mainpage.php                        # User login/selection page
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
│   ├── logout.php
│   └── logout1.php
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
│
└── pharma_schema.sql                   # Database schema
```

## 🚀 Getting Started

### Prerequisites
- PHP 7.0 or higher
- MySQL 5.7 or higher
- Apache Web Server (or similar)
- All files are properly configured with correct paths

### Step 1: Database Setup

1. **Create the database:**
   ```sql
   CREATE DATABASE pharma;
   USE pharma;
   ```

2. **Import the schema:**
   - Open your database client (phpMyAdmin, MySQL Workbench, etc.)
   - Run the SQL file: `pharma_schema.sql`
   
   Or use command line:
   ```bash
   mysql -u root -p < pharma_schema.sql
   ```

3. **Verify database connection in config.php:**
   ```php
   $conn = mysqli_connect("localhost", "root", "", "pharma");
   ```
   Update credentials if needed.

### Step 2: Configure Web Server

1. Place the project in your web root:
   - **Apache**: `/var/www/html/medical_store_management/`
   - **XAMPP/WAMP**: `htdocs/medical_store_management/`

2. Ensure file permissions are correct:
   ```bash
   chmod -R 755 medical_store_management/
   ```

### Step 3: Access the Application

Open your browser and navigate to:
```
http://localhost/medical_store_management/
```

Or directly to:
```
http://localhost/medical_store_management/mainpage.php
```

## 🔐 Login Information

### Default Credentials (from database schema)

**Admin Account:**
- Username: `admin`
- Password: `admin123`
- Access: `http://localhost/medical_store_management/adminmainpage.php`

**Pharmacy Staff Account:**
- Username: `pharmacy1`
- Password: `pharma123`
- Access: `http://localhost/medical_store_management/pharmmainpage.php`

> ⚠️ **Security Note**: These are default credentials for testing. Change them in production!

## 📁 What's Fixed

✅ All file paths updated for new directory structure  
✅ All CSS/asset references corrected (`../assets/...`)  
✅ All navigation links updated to use subdirectory paths  
✅ All includes/requires pointing to correct config.php location  
✅ All header redirects working properly  
✅ Project structure matches README documentation  

## 🛠️ Key Features Available

### Admin Dashboard
- **Inventory Management** - Add, view, update, delete medicines
- **Customer Management** - Manage customer database
- **Employee Management** - Track employees
- **Supplier Management** - Supplier information
- **Purchase Management** - Stock orders
- **POS System** - Process sales
- **Reporting** - Sales, stock, expiry reports

### Pharmacy Staff Dashboard
- **Inventory Viewing** - Check available medicines
- **Customer Management** - Add/view customers
- **POS System** - Process sales transactions
- **Logout** - Secure session termination

## 📊 Database Tables

The system includes the following tables:
- `users` - User authentication and roles
- `customers` - Customer information
- `suppliers` - Supplier details
- `medicines` - Inventory items
- `employees` - Employee records
- `purchases` & `purchase_items` - Stock orders
- `sales` & `sales_items` - Sales transactions
- `stock_movements` - Inventory tracking
- `expiry_tracking` - Expiry management
- `audit_log` - System activity logs

## ⚠️ Common Issues & Fixes

### Issue: "Headers already sent" error
- **Cause**: Output before header() calls
- **Fix**: Ensure no echo/output before `header()` statements

### Issue: Database connection failed
- **Cause**: Database not running or wrong credentials
- **Fix**: Check `config.php` settings, verify MySQL is running

### Issue: Blank page or 404 errors
- **Cause**: Incorrect file paths
- **Fix**: Verify all paths in navigation links are correct (they should be now!)

### Issue: CSS not loading
- **Cause**: Asset path issues
- **Fix**: Check that asset files exist in `assets/` directory

## 🔄 Workflow

1. Start the application → `mainpage.php`
2. Login with your credentials
3. Dashboard loads based on user role
4. Navigate using sidebar menu
5. All links use correct paths within directory structure
6. File operations (add/edit/delete) work within their directories
7. Logout redirects properly

## 📝 Notes

- All PHP files now use **relative paths** consistently
- Config file includes work from any directory (uses `../config.php` pattern)
- Assets are accessed correctly from all locations
- Navigation maintains a consistent sidebar structure
- Database queries will execute assuming the database is set up

## 🆘 Support

If you encounter any issues:

1. **Check file paths**: Navigate to file locations to verify they exist
2. **Database errors**: Review `config.php` and database connection
3. **Navigation issues**: Clear browser cache and reload
4. **Permission errors**: Check file and directory permissions

## 🎯 Next Steps

1. ✅ Database setup (using `pharma_schema.sql`)
2. ✅ Web server configuration
3. ✅ Access the application
4. ✅ Login with test credentials
5. 🔄 Customize as needed for your use case

---

**Status**: ✅ Ready to Deploy (Database setup required)  
**Last Updated**: May 29, 2026  
**Version**: 1.0
