<!DOCTYPE html>
<html>

<head>
	<title>Item Details</title>
	<link rel="stylesheet" href="styles.css">
</head>

<body>
	<div class="container">
		<h1>Item Details</h1>
        <a href="../home.php">Back to Home</a>
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


        $sql = "SELECT * FROM Item_Detail";
        $result = mysqli_query($conn, $sql);
        if (mysqli_num_rows($result) > 0) {
            // output data of each row
            echo "<table>
                    <tr>
                        <th>Transaction ID</th>
                        <th>Product ID</th>
                        <th>Purchased Quantity</th>
                        <th>Item Total Price</th>
                    </tr>";
            while($row = mysqli_fetch_assoc($result)) {
                echo "<tr>
                        <td>" . $row["Trans_ID"]. "</td>
                        <td>" . $row["Product_ID"]. "</td>
                        <td>" . $row["Purchased_Quantity"] . "</td>
                        <td>" . $row["Item_Total_Price"] . "</td>
                    </tr>";
            }
            echo "</table>";
        } else {
            echo "0 results";
        }

        // Free result set
        mysqli_close($conn);

        ?>


	</div>
</body>

</html>

