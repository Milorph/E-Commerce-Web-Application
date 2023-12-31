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


$sql = "SELECT Manufacturer.Manu_ID, Manufacturer.Manu_Name, COUNT(*) AS Total_Products
    FROM Manufacturer
    INNER JOIN Product ON Manufacturer.Manu_ID = Product.Manu_ID
    GROUP BY Manufacturer.Manu_ID
    HAVING COUNT(*) > 2;";
$result = mysqli_query($conn, $sql);
?>

<!DOCTYPE html>
<html>
<head>
	<title>Manufacturer</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="container">
		<h1>Manufacturer</h1>
		<a href="../home.php">Back to Home</a>
		<table>
			<tr>
				<th>Manu_ID</th>
				<th>Manu_Name</th>
				<th>Total Products</th>
			</tr>
			<?php while($row = mysqli_fetch_assoc($result)) { ?>
			<tr>
				<td><?php echo $row["Manu_ID"]; ?></td>
				<td><?php echo $row["Manu_Name"]; ?></td>
				<td><?php echo $row["Total_Products"]; ?></td>
			</tr>
			<?php } ?>
		</table>
	</div>
</body>
</html>

<?php 
// Free result set
mysqli_free_result($result);
mysqli_close($conn);
?>