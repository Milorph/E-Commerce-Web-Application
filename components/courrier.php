<!DOCTYPE html>
<html>

<head>
	<title>Courrier Info</title>
	<link rel="stylesheet" href="styles.css">
</head>

<body>
	<div class="container">
		<h1>Courrier Info</h1>
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

        // Run SQL query to fetch data from the database
        $sql = "SELECT * FROM Courrier";
        $result = mysqli_query($conn, $sql);

        // Output data as an HTML table with CSS styles
        if (mysqli_num_rows($result) > 0) {
            echo "<table>";
            echo "<tr ><th>Courrier Code</th><th>Courrier Name</th></tr>";
            while($row = mysqli_fetch_assoc($result)) {
                echo "<tr><td>" . $row["Courrier_Code"]. "</td><td>" . $row["Courrier_Name"] . "</td></tr>";
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
