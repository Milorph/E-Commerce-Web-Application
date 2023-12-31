
-- DROP TABLE Country, Courrier, Item_Detail, Location, Manager, Manufacturer, Product, Review, Transaction, User;
-- SELECT * FROM Transaction WHERE Trans_ID = 1;


CREATE TABLE Manager (
	  Manu_Manager_ID INT PRIMARY KEY NOT NULL,
	  Manu_Manager_FirstName VARCHAR(25) NOT NULL,
	  Manu_Manager_LastName VARCHAR(25) NOT NULL 
);

CREATE TABLE Manufacturer (
	  Manu_ID INT PRIMARY KEY NOT NULL,
	  Manu_Name VARCHAR(25) NOT NULL,
	  Manu_Type VARCHAR(25) NOT NULL, 
	  Manu_Manager_ID INT,
	  FOREIGN KEY (Manu_Manager_ID) REFERENCES Manager(Manu_Manager_ID)
);


CREATE TABLE Country (
	  Manu_CountryCode CHAR(5) PRIMARY KEY NOT NULL,
	  Manu_Country VARCHAR(50) NOT NULL
);

CREATE TABLE Location (
    Manu_ID INT,
    Manu_CountryCode CHAR(5), 
    Manu_State VARCHAR(25) NOT NULL, 
    Manu_ZIPcode VARCHAR(10) NOT NULL,
    Manu_Street VARCHAR(50) NOT NULL,
    PRIMARY KEY (Manu_ID, Manu_CountryCode),
    FOREIGN KEY (Manu_ID) REFERENCES Manufacturer(Manu_ID),
    FOREIGN KEY (Manu_CountryCode) REFERENCES Country(Manu_CountryCode)
);


CREATE TABLE Product (
  Product_ID INT PRIMARY KEY NOT NULL,
  Product_Name VARCHAR(50) NOT NULL,
  Product_Price DECIMAL(10,2) NOT NULL,
  Product_Category VARCHAR(50) NOT NULL,
  Product_Quantity INT NOT NULL,
  Manu_ID INT,
  Avg_Star_Rate DECIMAL(2,1) DEFAULT 0.0,
  Product_Image_Path VARCHAR(255),
  Product_Description varchar(1000),
  FOREIGN KEY (Manu_ID) REFERENCES Manufacturer(Manu_ID)
);


CREATE TABLE Courrier (
	  Courrier_Code INT PRIMARY KEY NOT NULL,
	  Courrier_Name VARCHAR(30) NOT NULL
);



CREATE TABLE User (
  User_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Profile_Name VARCHAR(30) , 
  email VARCHAR(60) NOT NULL UNIQUE, 
  password VARCHAR(50) NOT NULL,
  phone varchar(30),
  BankCard_Number VARCHAR(16) UNIQUE
);

CREATE TABLE Transaction (

	  Trans_ID INT PRIMARY KEY NOT NULL,
      User_ID INT,
	  Trans_Total_Price DECIMAL(10,2) NOT NULL DEFAULT 0,
	  Address_Country VARCHAR(30) NOT NULL, 
	  Address_State VARCHAR(30) NOT NULL,
	  Address_ZipCode VARCHAR(15) NOT NULL, 
	  Address_Street VARCHAR(50) NOT NULL,
	  Address_APT VARCHAR(30), 
	  Courrier_Code INT,
	  FOREIGN KEY (Courrier_Code) REFERENCES Courrier(Courrier_Code),
      FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);


CREATE TABLE Item_Detail (
  Trans_ID INT,
  Product_ID INT,
  Purchased_Quantity INT NOT NULL,
  Item_Total_Price DECIMAL(10,2) NOT NULL DEFAULT 0, 
  PRIMARY KEY (Trans_ID, Product_ID),
  FOREIGN KEY (Trans_ID) REFERENCES Transaction(Trans_ID),
  FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);


-- DROP TABLE Country, Courrier, Item_Detail, Location, Manager, Manufacturer, Product, Review, Transaction, User;

CREATE TABLE Review (
	  Review_ID INT PRIMARY KEY NOT NULL,
	  Stars_Rate INT NOT NULL,
	  Product_ID INT NOT NULL,
	  User_ID INT NOT NULL,
	  FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
	  FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);

INSERT INTO Manager (Manu_Manager_ID, Manu_Manager_FirstName, Manu_Manager_LastName) VALUES
(1, 'John', 'Smith'),
(2, 'Sarah', 'Johnson'),
(3, 'David', 'Lee'),
(4, 'Emily', 'Wang'),
(5, 'Michael', 'Garcia'),
(6, 'Karen', 'Kim'),
(7, 'Robert', 'Brown'),
(8, 'Jennifer', 'Davis'),
(9, 'William', 'Miller'),
(10, 'Amy', 'Wilson');

INSERT INTO Manufacturer (Manu_ID, Manu_Name, Manu_Type, Manu_Manager_ID) VALUES
(1, 'Nike', 'Sportswear', 1),
(2, 'Adidas', 'Sportswear', 2),
(3, 'Samsung', 'Electronics', 3),
(4, 'Apple', 'Electronics', 4),
(5, 'Coca-Cola', 'Beverages', 5),
(6, 'PepsiCo', 'Beverages', 6),
(7, 'Nestle', 'Food', 7),
(8, 'Unilever', 'Consumer goods', 8),
(9, 'Procter & Gamble', 'Consumer goods', 9),
(10, 'Toyota', 'Automotive', 10);


INSERT INTO Country (Manu_CountryCode, Manu_Country) VALUES
('US', 'United States'),
('CN', 'China'),
('JP', 'Japan'),
('DE', 'Germany'),
('FR', 'France'),
('IT', 'Italy'),
('GB', 'United Kingdom'),
('BR', 'Brazil'),
('RU', 'Russia'),
('IN', 'India');

INSERT INTO Location (Manu_ID, Manu_CountryCode, Manu_State, Manu_ZIPcode, Manu_Street) VALUES
(1, 'US', 'Washington', '10001', 'Fifth Ave'),
(2, 'CN', 'GuongZhou', '80333', 'Leopoldstrasse'),
(3, 'JP', 'Kanto', '06351', 'Samsung-ro'),
(4, 'DE', 'Berlin', '90210', 'Rodeo Dr'),
(5, 'FR', 'Paris', '30313', 'Martin Luther King Jr Dr SW'),
(6, 'IT', 'Milan', '10022', 'Park Ave'),
(7, 'GB', 'England', '1800', 'Avenue Nestle'),
(8, 'BR', 'Bahia', '3012', 'Weena'),
(9, 'RU', 'Amur', '105-0014', 'Roppongi'),
(10, 'IN', 'Goa', '471-8571', 'Toyota-cho');


DELIMITER $$
CREATE TRIGGER update_product_quantity
AFTER INSERT ON Item_Detail
FOR EACH ROW
BEGIN
    UPDATE Product
    SET Product_Quantity = Product_Quantity - NEW.Purchased_Quantity
    WHERE Product_ID = NEW.Product_ID;
END $$
DELIMITER ;

-- Inserting into Product table
INSERT INTO Product (Product_ID, Product_Name, Product_Price, Product_Category, Product_Quantity, Manu_ID, Product_Description)
VALUES (1, 'Red T-shirt', 20.99, 'Clothing', 100, 1, "Elevate your casual style with this vibrant Red T-shirt. Made from high-quality materials, this comfortable and stylish piece is a must-have in any wardrobe. The classic design and flattering fit make it suitable for various occasions, whether you're out for a relaxed day with friends or want to add a pop of color to your outfit. Don't miss out on the opportunity to enhance your collection with this versatile Red T-shirt."),
       (2, 'Blue Jeans', 49.99, 'Clothing', 50, 2, "Discover the perfect blend of style and comfort with our Blue Jeans. Crafted from premium denim, these jeans offer a timeless and fashionable look that pairs well with any top. The sturdy construction ensures durability, while the classic blue shade adds a touch of sophistication to your attire. Whether you're going for a casual or slightly dressed-up look, these Blue Jeans are an essential addition to your closet."),
       (3, 'Black Sneakers', 99.00, 'Footwear', 25, 1, "Step up your footwear game with these sleek Black Sneakers. Designed for both comfort and style, these sneakers are perfect for daily wear or casual outings. The black color and modern design make them a versatile choice that complements various outfits. With a focus on quality and aesthetics, these sneakers are sure to become your go-to option for achieving a trendy and relaxed look."),
       (4, 'Silver Watch', 199.99, 'Accessories', 10, 3, "Make a statement of elegance and refinement with our Silver Watch. This exquisite accessory boasts a luxurious silver-tone finish that adds a touch of sophistication to your wrist. Designed for both men and women, this timepiece combines style and functionality seamlessly. With precise timekeeping and a comfortable fit, it's the perfect blend of aesthetics and practicality, making it an ideal choice for any occasion."),
       (5, 'Green Hat', 15.00, 'Accessories', 75, 2, "Add a pop of color to your ensemble with our Green Hat. This stylish accessory not only protects you from the sun but also elevates your fashion game. The vibrant green hue adds a playful touch, and the versatile design complements a wide range of outfits. Whether you're heading out for a day of fun or simply want to express your unique style, this Green Hat is a fantastic choice."),
       (6, 'White Towel Set', 39.99, 'Home & Living', 30, 4, "Indulge in the softness and luxury of our White Towel Set. Designed to provide comfort and absorbency, this set is a perfect addition to your bathroom essentials. The pristine white color adds a touch of elegance to your space, and the high-quality materials ensure these towels remain soft and plush wash after wash. Elevate your daily routine with the indulgence of our White Towel Set."),
       (7, 'Brown Leather Belt', 29.99, 'Accessories', 60, 2, "Complete your outfit with the timeless charm of our Brown Leather Belt. Crafted from genuine leather, this belt offers durability and style in equal measure. The rich brown color complements a variety of clothing choices, making it a versatile accessory for any wardrobe. Whether you're dressing up or going for a more casual look, this Brown Leather Belt is the perfect finishing touch."),
       (8, 'Pink Dress', 79.99, 'Clothing', 20, 1, "Embrace femininity and grace with our Pink Dress. This stunning piece features a flattering design that accentuates your figure while providing utmost comfort. The soft pink hue adds a touch of romance, making it suitable for various occasions, from date nights to special events. With its impeccable craftsmanship and elegant appeal, this Pink Dress is sure to turn heads wherever you go."),
       (9, 'Silver Necklace', 149.99, 'Accessories', 15, 3, "Adorn yourself with the exquisite beauty of our Silver Necklace. Crafted with precision, this accessory exudes elegance and sophistication. The shimmering silver pendant hangs delicately from a high-quality chain, adding a touch of luxury to your look. Whether it's a gift for a loved one or a personal indulgence, this Silver Necklace is a timeless piece that enhances any ensemble."),
       (10, 'Blue Backpack', 89.00, 'Bags & Luggage', 40, 4, "Stay organized and stylish on the go with our Blue Backpack. This versatile accessory combines functionality and fashion, offering ample storage space for your belongings while making a statement with its bold blue color. Whether you're headed to school, work, or a weekend adventure, this Blue Backpack is designed to meet your needs and reflect your personal style. Please check back for pricing and availability.");

-- Inserting into Courrier table
INSERT INTO Courrier (Courrier_Code, Courrier_Name)
VALUES (1, 'UPS'),
       (2, 'FedEx'),
       (3, 'USPS'),
       (4, 'DHL'),
       (5, 'Amazon Logistics'),
       (6, 'OnTrac'),
       (7, 'Purolator'),
       (8, 'Canada Post'),
       (9, 'Royal Mail'),
       (10, 'DPD');
       
       
DELIMITER $$      
CREATE TRIGGER update_transaction_total_price
AFTER INSERT ON Item_Detail
FOR EACH ROW
BEGIN
    UPDATE Transaction
    SET Trans_Total_Price = (
        SELECT SUM(Item_Total_Price)
        FROM Item_Detail
        WHERE Trans_ID = NEW.Trans_ID
    )
    WHERE Trans_ID = NEW.Trans_ID;
END $$

DELIMITER ;

-- Inserting into the User table

INSERT INTO User (User_ID, Profile_Name, email, password, BankCard_Number)
VALUES (1, 'John Smith', 'jsmith123@gmail.com', 'password123', '1234567890123456'),
	   (2, 'Jane Doe', 'jdoe456@gmail.com', 'abc123', '9876543210987654'),
	   (3, 'Michael Johnson', 'mjohnson789@gmail.com', 'qwerty', '1111222233334444'),
	   (4, 'Emily Rodriguez', 'erodriguez321@gmail.com','p@ssw0rd', '5555666677778888'),
	   (5, 'William Lee', 'wlee777@gmail.com',  'letmein', '4444555566667777'),
	   (6, 'Sophia Hernandez', 'shernandez456@gmail.com', 'secret', '8888999911112222'),
	   (7, 'David Kim',  'dkim890@gmail.com','password123', '7777888899990000'),
	   (8, 'Sarah Thompson', 'sthompson234@gmail.com', 'abcdef', '2222333344445555'),
	   (9, 'Jacob Nguyen',  'jnguyen567@gmail.com','123456', '6666777788889999'),
	   (10, 'Olivia Garcia', 'ogarcia789@gmail.com', 'password', '3333444455556666');

-- Inserting into Transaction table
INSERT INTO Transaction (Trans_ID, User_ID, Address_Country, Address_State, Address_ZipCode, Address_Street, Address_APT, Courrier_Code)
VALUES
(1, 1, 'US', 'New York', '10001', 'Fifth Ave', 'Apt 2B', 1),
(2, 2, 'DE', 'Bavaria', '80333', 'Leopoldstrasse', NULL, 2),
(3, 3, 'KR', 'Seoul', '06351', 'Samsung-ro', NULL, 3),
(4, 4, 'US', 'California', '90210', 'Rodeo Dr', 'Suite 301', 4),
(5, 5, 'US', 'Georgia', '30313', 'Martin Luther King Jr Dr SW', NULL, 5),
(6, 6, 'US', 'New York', '10022', 'Park Ave', 'Floor 15', 6),
(7, 7, 'CH', 'Vevey', '1800', 'Avenue Nestle', '3rd Floor', 7),
(8, 8, 'NL', 'Rotterdam', '3012', 'Weena', 'Unit 2B', 8),
(9, 9, 'JP', 'Tokyo', '105-0014', 'Roppongi', 'Apartment 101', 9),
(10, 10, 'JP', 'Aichi', '471-8571', 'Toyota-cho', NULL, 10);


DELIMITER $$
CREATE TRIGGER item_detail_trigger
BEFORE INSERT ON Item_Detail
FOR EACH ROW
BEGIN
	SET NEW.Item_Total_Price = (
	SELECT Product_Price * NEW.Purchased_Quantity
	FROM Product
	WHERE Product_ID = NEW.Product_ID
);
END$$
DELIMITER ;

-- Inserting into Item_Detail table
INSERT INTO Item_Detail (Trans_ID, Product_ID, Purchased_Quantity)
VALUES (1, 1, 2),
       (1, 2, 1),
       (3, 3, 2),
       (4, 4, 1),
       (5, 5, 1),
       (6, 6, 1),
       (7, 7, 3),
       (8, 8, 1),
       (9, 9, 1),
       (10, 10, 2);
       
       
DELIMITER $$
CREATE TRIGGER review_insert_trigger
AFTER INSERT ON Review
FOR EACH ROW
BEGIN
	UPDATE Product
	SET Avg_Star_Rate = (
	SELECT AVG(Stars_Rate)
	FROM Review
	WHERE Product_ID = NEW.Product_ID
	)
  WHERE Product_ID = NEW.Product_ID;
END$$
DELIMITER ;      

-- Inserting into the Review table

INSERT INTO Review (Review_ID, Stars_Rate, Product_ID, User_ID)
VALUES (1, 4, 1, 1),
	   (2, 5, 3, 2),
	   (3, 3, 3, 3),
	   (4, 4, 4, 4),
	   (5, 5, 5, 5),
	   (6, 2, 6, 6),
	   (7, 3, 7, 7),
	   (8, 5, 8, 8),
	   (9, 3, 9, 9),
	   (10, 5, 10, 10),
     (11, 1, 2, 10);
       
-- Queries involving inner join on two or more tables  

-- This query joins two tables - Product and Manufacturer - on their common column Manu_ID. 
-- The result of the join is a table that includes the Product_ID, Product_Name, Product_Price and Manu_Name columns.

SELECT Product.Product_ID, Product.Product_Name, Product.Product_Price, Manufacturer.Manu_Name
FROM Product
INNER JOIN Manufacturer ON Product.Manu_ID = Manufacturer.Manu_ID;


-- Queries involving aggregate functions, such as SUM, COUNT, AVG etc.

-- This query calculates the total price of all transactions in the "Transaction" table and returns it as a single value in the result table. 

SELECT SUM(Trans_Total_Price) AS Total_Price
FROM Transaction;

-- Queries involving subqueries  

-- This query calculates the average price of products sold in each country where the manufacturers are located.

SELECT Manu_CountryCode, AVG(Product_Price) AS Average_Price 
FROM (
  SELECT m.Manu_ID, l.Manu_CountryCode, SUM(Purchased_Quantity) AS Total_Sales 
  FROM Item_Detail i
  INNER JOIN Product p ON i.Product_ID = p.Product_ID
  INNER JOIN Manufacturer m ON p.Manu_ID = m.Manu_ID 
  INNER JOIN Location l ON m.Manu_ID = l.Manu_ID 
  GROUP BY m.Manu_ID, l.Manu_CountryCode 
) AS Sales 
INNER JOIN Product p ON Sales.Manu_ID = p.Manu_ID 
GROUP BY Manu_CountryCode;

-- Queries involving GROUP BY and HAVING clause  

-- This query retrieves the manufacturer IDs, names, and the total number of products they have produced, 
-- but only for manufacturers who have produced more than two products.

SELECT Manufacturer.Manu_ID, Manufacturer.Manu_Name, COUNT(*) AS Total_Products
FROM Manufacturer
INNER JOIN Product ON Manufacturer.Manu_ID = Product.Manu_ID
GROUP BY Manufacturer.Manu_ID
HAVING COUNT(*) > 2;

-- Queries involving left outer join or right outer join of two tables  

-- This query would return all rows from the Review table and matching rows from the Product table. 
-- If there are products with no reviews, those rows would still be returned with NULL values in the columns from the Review table.

SELECT Product.Product_ID, Product.Product_Name, Review.Review_ID, Review.Stars_Rate
FROM Review
RIGHT OUTER JOIN Product ON Product.Product_ID = Review.Product_ID;

SELECT 
    Manu_Name, 
    (SELECT COUNT(DISTINCT Product_ID) 
     FROM Product 
     WHERE Manu_ID = Manufacturer.Manu_ID) AS Total_Products
FROM Manufacturer;

