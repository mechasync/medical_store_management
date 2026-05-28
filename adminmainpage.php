<!DOCTYPE html>
<html>

<head>
	<link rel="stylesheet" type="text/css" href="assets/css/nav2.css">
	<title>
		Admin Dashboard
	</title>
</head>

<body>

	<div class="sidenav">
		<h2 style="font-family:Arial; color:white; text-align:center;"> Medical Store Management System </h2>
		<p style="margin-top:-20px;color:white;line-height:1;font-size:12px;text-align:center">Developed by, Harsh</p>
		<a href="adminmainpage.php">Dashboard</a>
		<button class="dropdown-btn">Inventory
			<i class="down"></i>
		</button>
		<div class="dropdown-container">
			<a href="inventory/inventory-add.php">Add New Medicine</a>
			<a href="inventory/inventory-view.php">Manage Inventory</a>
		</div>
		<button class="dropdown-btn">Suppliers
			<i class="down"></i>
		</button>
		<div class="dropdown-container">
			<a href="suppliers/supplier-add.php">Add New Supplier</a>
			<a href="suppliers/supplier-view.php">Manage Suppliers</a>
		</div>
		<button class="dropdown-btn">Stock Purchase
			<i class="down"></i>
		</button>
		<div class="dropdown-container">
			<a href="purchases/purchase-add.php">Add New Purchase</a>
			<a href="purchases/purchase-view.php">Manage Purchases</a>
		</div>
		<button class="dropdown-btn">Employees
			<i class="down"></i>
		</button>
		<div class="dropdown-container">
			<a href="employees/employee-add.php">Add New Employee</a>
			<a href="employees/employee-view.php">Manage Employees</a>
		</div>
		<button class="dropdown-btn">Customers
			<i class="down"></i>
		</button>
		<div class="dropdown-container">
			<a href="customers/customer-add.php">Add New Customer</a>
			<a href="customers/customer-view.php">Manage Customers</a>
		</div>
		<a href="reports/sales-view.php">View Sales Invoice Details</a>
		<a href="reports/salesitems-view.php">View Sold Products Details</a>
		<a href="pos/pos1.php">Add New Sale</a>
		<button class="dropdown-btn">Reports
			<i class="down"></i>
		</button>
		<div class="dropdown-container">
			<a href="reports/stockreport.php">Medicines - Low Stock</a>
			<a href="reports/expiryreport.php">Medicines - Soon to Expire</a>
			<a href="reports/salesreport.php">Transactions Reports</a>
		</div>
	</div>

	<div class="topnav">
		<a href="utilities/logout.php">Logout(Logged in as Admin)</a>
	</div>

	<center>
		<div class="head">
			<h2> ADMIN DASHBOARD </h2>
		</div>
	</center>

	<a href="pos/pos1.php" title="Add New Sale">
		<img src="assets/img/carticon1.png" style="padding:8px;margin-left:450px;margin-top:40px;width:200px;height:200px;border:2px solid black;" alt="Add New Sale">
	</a>

	<a href="inventory/inventory-view.php" title="View Inventory">
		<img src="assets/img/inventory.png" style="padding:8px;margin-left:100px;margin-top:40px;width:200px;height:200px;border:2px solid black;" alt="Inventory">
	</a>

	<a href="employees/employee-view.php" title="View Employees">
		<img src="assets/img/emp.png" style="padding:8px;margin-left:100px;margin-top:40px;width:200px;height:200px;border:2px solid black;" alt="Employees List">
	</a>
	<br>
	<a href="reports/salesreport.php" title="View Transactions">
		<img src="assets/img/moneyicon.png" style="padding:8px;margin-left:550px;margin-top:40px;width:200px;height:200px;border:2px solid black;" alt="Transactions List">
	</a>

	<a href="reports/stockreport.php" title="Low Stock Alert">
		<img src="assets/img/alert.png" style="padding:8px;margin-left:100px;margin-top:40px;width:200px;height:200px;border:2px solid black;" alt="Low Stock Report">
	</a>


</body>

<script>
	var dropdown = document.getElementsByClassName("dropdown-btn");
	var i;

	for (i = 0; i < dropdown.length; i++) {
		dropdown[i].addEventListener("click", function() {
			this.classList.toggle("active");
			var dropdownContent = this.nextElementSibling;
			if (dropdownContent.style.display === "block") {
				dropdownContent.style.display = "none";
			} else {
				dropdownContent.style.display = "block";
			}
		});
	}
</script>



</html>
