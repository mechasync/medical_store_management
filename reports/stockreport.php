<!DOCTYPE html>
<html>

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="../assets/css/nav2.css">
	<link rel="stylesheet" type="text/css" href="../assets/css/table1.css">
	<title>
		Reports
	</title>
</head>

<body>

	<div class="sidenav">
		<h2 style="font-family:Arial; color:white; text-align:center;"> Medical Store Management System </h2>
		<p style="margin-top:-20px;color:white;line-height:1;font-size:12px;text-align:center">Developed by, Harsh</p>
		<a href="../adminmainpage.php">Dashboard</a>
		<button class="dropdown-btn">Inventory
			<i class="down"></i>
		</button>
		<div class="dropdown-container">
			<a href="../inventory/inventory-add.php">Add New Medicine</a>
			<a href="../inventory/inventory-view.php">Manage Inventory</a>
		</div>
		<button class="dropdown-btn">Suppliers
			<i class="down"></i>
		</button>
		<div class="dropdown-container">
			<a href="../suppliers/supplier-add.php">Add New Supplier</a>
			<a href="../suppliers/supplier-view.php">Manage Suppliers</a>
		</div>
		<button class="dropdown-btn">Stock Purchase
			<i class="down"></i>
		</button>
		<div class="dropdown-container">
			<a href="../purchases/purchase-add.php">Add New Purchase</a>
			<a href="../purchases/purchase-view.php">Manage Purchases</a>
		</div>
		<button class="dropdown-btn">Employees
			<i class="down"></i>
		</button>
		<div class="dropdown-container">
			<a href="../employees/employee-add.php">Add New Employee</a>
			<a href="../employees/employee-view.php">Manage Employees</a>
		</div>
		<button class="dropdown-btn">Customers
			<i class="down"></i>
		</button>
		<div class="dropdown-container">
			<a href="../customers/customer-add.php">Add New Customer</a>
			<a href="../customers/customer-view.php">Manage Customers</a>
		</div>
		<a href="../reports/sales-view.php">View Sales Invoice Details</a>
		<a href="../reports/salesitems-view.php">View Sold Products Details</a>
		<a href="../pos/pos1.php">Add New Sale</a>
		<button class="dropdown-btn">Reports
			<i class="down"></i>
		</button>
		<div class="dropdown-container">
			<a href="../reports/stockreport.php">Medicines - Low Stock</a>
			<a href="../reports/expiryreport.php">Medicines - Soon to Expire</a>
			<a href="../reports/salesreport.php">Transactions Reports</a>
		</div>
	</div>

	<div class="topnav">
		<a href="../utilities/logout.php">Logout</a>
	</div>

	<center>
		<div class="head">
			<h2> MEDICINES LOW ON STOCK(LESS THAN 50)</h2>
		</div>
	</center>

	<table align="right" id="table1" style="margin-right:100px;">
		<tr>
			<th>Medicine ID</th>
			<th>Medicine Name</th>
			<th>Quantity Available</th>
			<th>Category</th>
			<th>Price</th>
		</tr>

		<?php

		include "../config.php";
		$result = mysqli_query($conn, "CALL `STOCK`();");
		if ($result->num_rows > 0) {

			while ($row = $result->fetch_assoc()) {

				echo "<tr>";
				echo "<td>" . $row["med_id"] . "</td>";
				echo "<td>" . $row["med_name"] . "</td>";
				echo "<td style='color:red;'>" . $row["med_qty"] . "</td>";
				echo "<td>" . $row["category"] . "</td>";
				echo "<td>" . $row["med_price"] . "</td>";
				echo "</tr>";
			}
			echo "</table>";
		}

		$conn->close();
		?>

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
