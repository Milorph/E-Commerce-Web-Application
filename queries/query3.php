<?php



	// Set up database connection variables
	$servername = "localhost";
	$username = "root";
	$password = "";
	$dbname = "test";

	// Create connection
	$conn = mysqli_connect($servername, $username, $password, $dbname);
	// Check connection
	if (!$conn) {
		die("Connection failed: " . mysqli_connect_error());
	}


	$sql = "SELECT * FROM (
			SELECT * FROM Product ORDER BY Product_ID DESC LIMIT 5
			) AS subquery ORDER BY Product_Price

			";
			
	$result = mysqli_query($conn, $sql);
?>

<!DOCTYPE html>
<html>
<head>
	<title>Latest cheapest products</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="container">
		<h1>Latest cheapest products</h1>
		<a href="../home.php">Back to Home</a>
		<table>
			<tr>
				<th>Product_ID</th>
				<th>Product_Name</th>
				<th>Product_Price</th>
				<th>Product_Category</th>
				<th>Product_Quantity</th>
				<th>Manu_ID</th>
				<th>Avg_Star_Rate</th>
			</tr>
			<?php while($row = mysqli_fetch_assoc($result)) { ?>
			<tr>
				<td><?php echo $row["Product_ID"]; ?></td>
				<td><?php echo $row["Product_Name"]; ?></td>
				<td><?php echo $row["Product_Price"]; ?></td>
				<td><?php echo $row["Product_Category"]; ?></td>
				<td><?php echo $row["Product_Quantity"]; ?></td>
				<td><?php echo $row["Manu_ID"]; ?></td>
				<td><?php echo $row["Avg_Star_Rate"]; ?></td>
			</tr>
			<?php } ?>
      <?php 
    // Free result set
    mysqli_free_result($result);
    mysqli_close($conn);
    ?>
		</table>
	</div>
</body>
</html>
