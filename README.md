"# Medical Store Management System

A comprehensive web-based management system for medical stores and pharmacies, designed to streamline operations including inventory management, sales, customer relations, and reporting.

> 🚀 **NEW & READY**: Project has been completely restructured and organized. All paths are corrected and working!  
> 📖 **Start Here**: Read [SETUP_GUIDE.md](SETUP_GUIDE.md) for quick start instructions  
> ✅ **View Status**: Check [COMPLETION_REPORT.md](COMPLETION_REPORT.md) for detailed restructuring details

## 🎯 Features

### Core Functionality
- **Customer Management** - Add, view, update, and delete customer records
- **Employee Management** - Manage employee information and access
- **Inventory Management** - Track stock, manage expiry dates, and stock levels
- **Point of Sale (POS)** - Process sales transactions efficiently
- **Purchase Management** - Handle supplier purchases and stock orders
- **Pharmacy Features** - Specialized pharmacy-specific tools and workflows
- **Reporting Dashboard** - Generate comprehensive reports including:
  - Sales reports
  - Stock reports
  - Expiry reports
  - Sales items tracking

### Admin Features
- User authentication and authorization
- Role-based access (Admin, Pharmacy Staff)
- Employee oversight
- Supplier management
- Financial tracking

## 📁 Project Structure

```
medical_store_management/
├── config.php                 # Database and application configuration
├── adminmainpage.php          # Admin dashboard
├── pharmmainpage.php          # Pharmacy staff dashboard
├── mainpage.php               # General main page
│
├── Customer Management/
│   ├── customer-add.php       # Add new customers
│   ├── customer-view.php      # View customer details
│   ├── customer-update.php    # Update customer information
│   └── customer-delete.php    # Delete customer records
│
├── Employee Management/
│   ├── employee-add.php
│   ├── employee-view.php
│   ├── employee-update.php
│   └── employee-delete.php
│
├── Inventory Management/
│   ├── inventory-add.php
│   ├── inventory-view.php
│   ├── inventory-update.php
│   └── inventory-delete.php
│
├── Purchase Management/
│   ├── purchase-add.php
│   ├── purchase-view.php
│   ├── purchase-update.php
│   └── purchase-delete.php
│
├── Supplier Management/
│   ├── supplier-add.php
│   ├── supplier-view.php
│   ├── supplier-update.php
│   └── supplier-delete.php
│
├── POS System/
│   ├── pos1.php               # Main POS interface
│   ├── pos2.php               # Secondary POS module
│   ├── pos-delete.php         # Delete transactions
│   ├── pharm-pos1.php         # Pharmacy POS interface
│   ├── pharm-pos2.php
│   └── pharm-pos-delete.php
│
├── Reporting/
│   ├── expiryreport.php       # Track expired items
│   ├── salesreport.php        # Sales performance analysis
│   ├── salesitems-view.php    # Detailed sales items
│   └── stockreport.php        # Stock level reports
│
├── assets/
│   ├── css/                   # Stylesheets
│   │   ├── form2.css, form3.css, form4.css
│   │   ├── header.css, nav2.css
│   │   ├── login1.css, table1.css, table2.css
│   └── img/                   # Images and media
│
└── Utilities/
    ├── logout.php, logout1.php
    └── pharm-customer-view.php, pharm-customer.php, pharm-inventory.php
```

## 🛠️ Technology Stack

- **Backend**: PHP
- **Database**: MySQL
- **Frontend**: HTML5, CSS3, JavaScript
- **UI Components**: Custom CSS styling

## ⚙️ Installation & Setup

### Prerequisites
- PHP 7.0 or higher
- MySQL/MariaDB
- Apache Web Server (or equivalent)

### Steps

1. **Clone or download the project**
   ```bash
   git clone <repository-url>
   cd medical_store_management
   ```

2. **Configure Database**
   - Update `config.php` with your database credentials
   ```php
   define('DB_HOST', 'localhost');
   define('DB_USER', 'your_db_user');
   define('DB_PASS', 'your_db_password');
   define('DB_NAME', 'medical_store_db');
   ```

3. **Set up the database**
   - Create MySQL database
   - Import database schema (if available)

4. **Deploy to Web Server**
   - Place project files in your web root directory (e.g., `/var/www/html/`)
   - Ensure proper file permissions

5. **Access the Application**
   - Navigate to `http://localhost/medical_store_management/` (or your configured URL)

## 🚀 Usage

### For Administrators
1. Log in using admin credentials
2. Access `adminmainpage.php`
3. Manage customers, employees, suppliers, and inventory
4. View comprehensive reports and analytics

### For Pharmacy Staff
1. Log in using pharmacy credentials
2. Access `pharmmainpage.php`
3. Process sales through POS system
4. Manage pharmacy inventory
5. View pharmacy-specific reports

## 📊 Key Modules

| Module | Purpose |
|--------|---------|
| Customer | Maintain customer database and contact info |
| Employee | Manage staff records and credentials |
| Inventory | Track products, quantities, expiry dates |
| POS | Handle sales transactions |
| Purchase | Order stock from suppliers |
| Supplier | Maintain supplier information |
| Reports | Generate sales, stock, and expiry reports |

## 🔐 Security Features

- **User Authentication** - MD5 hashed passwords for secure login
  - Admin login: `mainpage.php` (uses `admin` table)
  - Pharmacy staff login: `mainpage_pharma.php` (uses `emplogin` table)
- **Role-based Access Control** - Different access levels for admin vs pharmacy staff
- **Session Management** - Secure session handling with automatic logout
- **Password Hashing** - All passwords hashed with MD5 before storage in database
- **Database Configuration Isolation** - Database credentials stored in `config.php`

## 🔑 Default Login Credentials (Testing Only)

| Role | Login Page | Username | Password |
|------|-----------|----------|----------|
| **Admin** | `mainpage.php` | `admin` | `admin123` |
| **Pharmacy Staff** | `mainpage_pharma.php` | `pharmacy1` | `pharma123` |

⚠️ **Important**: Change all default passwords immediately in production environments!

## 📝 Notes

- Ensure `config.php` is properly configured before running the application
- Database credentials should be stored securely
- Regular backups are recommended
- Check file permissions for proper functionality

## 🤝 Support

For issues, questions, or contributions, please contact the development team.

## 📄 License

[Add your license information here]" 
