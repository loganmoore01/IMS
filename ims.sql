-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2024 at 11:50 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ims`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customerID` int(11) NOT NULL COMMENT 'unique ID',
  `customerName` varchar(100) NOT NULL COMMENT 'name of customer',
  `customerAddress` varchar(200) NOT NULL COMMENT 'address of customer (denormalized for simplicity)',
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `postalCode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerID`, `customerName`, `customerAddress`, `city`, `state`, `postalCode`) VALUES
(1, 'Customer 1', '123 Main St', 'City 1', 'State 1', 12345),
(2, 'Customer 2', '456 Elm St', 'City 2', 'State 2', 23456),
(3, 'Customer 3', '789 Oak St', 'City 3', 'State 3', 34567),
(4, 'Customer 4', '101 Pine St', 'City 4', 'State 4', 45678),
(5, 'Customer 5', '202 Maple St', 'City 5', 'State 5', 56789),
(6, 'Customer 6', '303 Cedar St', 'City 6', 'State 6', 67890),
(7, 'Customer 7', '404 Walnut St', 'City 7', 'State 7', 78901),
(8, 'Customer 8', '505 Birch St', 'City 8', 'State 8', 89012),
(9, 'Customer 9', '606 Pine St', 'City 9', 'State 9', 90123),
(10, 'Customer 10', '707 Elm St', 'City 10', 'State 10', 12345);

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `deliveryID` int(11) NOT NULL COMMENT 'unique ID',
  `saleDate` int(11) NOT NULL COMMENT 'date of sale to customer',
  `Order_orderID` int(11) NOT NULL,
  `Customer_customerID` int(11) NOT NULL COMMENT 'unique ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` (`deliveryID`, `saleDate`, `Order_orderID`, `Customer_customerID`) VALUES
(1, 2024, 1, 1),
(2, 2024, 2, 2),
(3, 2024, 3, 3),
(4, 2024, 4, 4),
(5, 2024, 5, 5),
(6, 2024, 6, 6),
(7, 2024, 7, 7),
(8, 2024, 8, 8),
(9, 2024, 9, 9),
(10, 2024, 10, 10);

-- --------------------------------------------------------

--
-- Table structure for table `delivery_detail`
--

CREATE TABLE `delivery_detail` (
  `deliveryDetailID` int(11) NOT NULL COMMENT 'unique ID',
  `deliveryQuantity` int(11) NOT NULL COMMENT 'number of products delivered',
  `estimatedDate` date NOT NULL COMMENT 'estimated arrival date',
  `arrivalDate` date NOT NULL COMMENT 'actual arrival date',
  `Delivery_deliveryID` int(11) NOT NULL COMMENT 'unique ID',
  `Product_productID` int(11) NOT NULL COMMENT 'unique product ID number',
  `Warehouse_sourceWarehouseID` int(11) NOT NULL COMMENT 'unique ID',
  `Warehouse_destinationWarehouseID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='detailed view of delivery';

--
-- Dumping data for table `delivery_detail`
--

INSERT INTO `delivery_detail` (`deliveryDetailID`, `deliveryQuantity`, `estimatedDate`, `arrivalDate`, `Delivery_deliveryID`, `Product_productID`, `Warehouse_sourceWarehouseID`, `Warehouse_destinationWarehouseID`) VALUES
(1, 5, '2024-04-15', '2024-04-20', 1, 1, 1, 2),
(2, 10, '2024-04-16', '2024-04-21', 1, 2, 2, 3),
(3, 8, '2024-04-17', '2024-04-22', 2, 3, 3, 4),
(4, 12, '2024-04-18', '2024-04-23', 2, 4, 4, 5),
(5, 15, '2024-04-19', '2024-04-24', 3, 5, 5, 6),
(6, 20, '2024-04-20', '2024-04-25', 3, 6, 6, 7),
(7, 18, '2024-04-21', '2024-04-26', 4, 7, 7, 8),
(8, 22, '2024-04-22', '2024-04-27', 4, 8, 8, 9),
(9, 25, '2024-04-23', '2024-04-28', 5, 9, 9, 10),
(10, 30, '2024-04-24', '2024-04-29', 5, 10, 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventoryID` int(11) NOT NULL COMMENT 'unique ID',
  `quantityAvailable` int(11) NOT NULL COMMENT 'quantity on-hand',
  `minStockQuantity` int(11) NOT NULL COMMENT 'minimum number of units required to ensure no shortages at warehouse',
  `maxStockQuantity` int(11) NOT NULL COMMENT 'maximum number of units required to ensure no shortages at warehouse',
  `reorderPoint` int(11) NOT NULL COMMENT 'when the number of product units reaches this point, a purchase order must be generated.',
  `Warehouse_sourceWarehouseID` int(11) NOT NULL COMMENT 'unique ID',
  `Warehouse_destinationWarehouseID` int(11) NOT NULL,
  `Product_productID` int(11) NOT NULL COMMENT 'unique product ID number'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='relational entity between product and warehouse';

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventoryID`, `quantityAvailable`, `minStockQuantity`, `maxStockQuantity`, `reorderPoint`, `Warehouse_sourceWarehouseID`, `Warehouse_destinationWarehouseID`, `Product_productID`) VALUES
(1, 100, 20, 100, 10, 1, 2, 1),
(2, 150, 30, 150, 15, 2, 3, 2),
(3, 200, 40, 200, 20, 3, 4, 3),
(4, 120, 25, 120, 12, 4, 5, 4),
(5, 180, 35, 180, 18, 5, 6, 5),
(6, 250, 50, 250, 25, 6, 7, 6),
(7, 300, 60, 300, 30, 7, 8, 7),
(8, 170, 45, 170, 17, 8, 9, 8),
(9, 220, 55, 220, 22, 9, 10, 9),
(10, 280, 70, 280, 28, 10, 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `locationID` int(11) NOT NULL COMMENT 'unique location ID',
  `locationName` varchar(100) NOT NULL COMMENT 'name of location',
  `locationAddress` varchar(200) NOT NULL COMMENT 'full address of location (denormalized for simplicity)',
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `postalCode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='inventory locations';

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`locationID`, `locationName`, `locationAddress`, `city`, `state`, `postalCode`) VALUES
(1, 'Location 1', '123 Main St', 'City 1', 'State 1', 12345),
(2, 'Location 2', '456 Elm St', 'City 2', 'State 2', 23456),
(3, 'Location 3', '789 Oak St', 'City 3', 'State 3', 34567),
(4, 'Location 4', '101 Pine St', 'City 4', 'State 4', 45678),
(5, 'Location 5', '202 Maple St', 'City 5', 'State 5', 56789),
(6, 'Location 6', '303 Cedar St', 'City 6', 'State 6', 67890),
(7, 'Location 7', '404 Walnut St', 'City 7', 'State 7', 78901),
(8, 'Location 8', '505 Birch St', 'City 8', 'State 8', 89012),
(9, 'Location 9', '606 Pine St', 'City 9', 'State 9', 90123),
(10, 'Location 10', '707 Elm St', 'City 10', 'State 10', 12345);

-- --------------------------------------------------------

--
-- Table structure for table `ordertable`
--

CREATE TABLE `ordertable` (
  `orderID` int(11) NOT NULL COMMENT 'unique ID',
  `orderDate` date NOT NULL COMMENT 'date of order',
  `Provider_providerID` int(11) NOT NULL COMMENT 'unique ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ordertable`
--

INSERT INTO `ordertable` (`orderID`, `orderDate`, `Provider_providerID`) VALUES
(1, '2024-04-01', 1),
(2, '2024-04-02', 2),
(3, '2024-04-03', 3),
(4, '2024-04-04', 4),
(5, '2024-04-05', 5),
(6, '2024-04-06', 6),
(7, '2024-04-07', 7),
(8, '2024-04-08', 8),
(9, '2024-04-09', 9),
(10, '2024-04-10', 10);

-- --------------------------------------------------------

--
-- Table structure for table `order_detail`
--

CREATE TABLE `order_detail` (
  `orderDetailID` int(11) NOT NULL COMMENT 'unique ID',
  `orderQuantity` int(11) NOT NULL COMMENT 'number of products in order',
  `estimatedDate` date NOT NULL COMMENT 'estimated arrival date',
  `arrivalDate` date NOT NULL COMMENT 'actual arrival date',
  `Order_orderID` int(11) NOT NULL COMMENT 'unique ID',
  `Product_productID` int(11) NOT NULL COMMENT 'unique product ID number',
  `Warehouse_sourceWarehouseID` int(11) NOT NULL COMMENT 'unique ID',
  `Warehouse_destinationWarehouseID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='detailed view of an order';

--
-- Dumping data for table `order_detail`
--

INSERT INTO `order_detail` (`orderDetailID`, `orderQuantity`, `estimatedDate`, `arrivalDate`, `Order_orderID`, `Product_productID`, `Warehouse_sourceWarehouseID`, `Warehouse_destinationWarehouseID`) VALUES
(1, 5, '2024-04-10', '2024-04-15', 1, 1, 1, 2),
(2, 10, '2024-04-11', '2024-04-16', 2, 2, 2, 3),
(3, 8, '2024-04-12', '2024-04-17', 3, 3, 3, 4),
(4, 12, '2024-04-13', '2024-04-18', 4, 4, 4, 5),
(5, 15, '2024-04-14', '2024-04-19', 5, 5, 5, 6),
(6, 20, '2024-04-15', '2024-04-20', 6, 6, 6, 7),
(7, 18, '2024-04-16', '2024-04-21', 7, 7, 7, 8),
(8, 22, '2024-04-17', '2024-04-22', 8, 8, 8, 9),
(9, 25, '2024-04-18', '2024-04-23', 9, 9, 9, 10),
(10, 30, '2024-04-19', '2024-04-24', 10, 10, 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `productID` int(11) NOT NULL COMMENT 'unique product ID number',
  `productSKU` varchar(100) NOT NULL COMMENT 'internal product code (stock keeping unit)',
  `productUPC` varchar(100) NOT NULL COMMENT 'external product code (universal product code)',
  `productName` varchar(100) NOT NULL COMMENT 'product name',
  `productDescription` varchar(1000) NOT NULL COMMENT 'detailed product description',
  `productCategory` varchar(100) NOT NULL COMMENT 'product category (denormalized for simplicity)',
  `reorderQuantity` int(11) NOT NULL COMMENT 'for units not available for single unit order'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='standard product attributes';

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productID`, `productSKU`, `productUPC`, `productName`, `productDescription`, `productCategory`, `reorderQuantity`) VALUES
(1, 'SKU001', 'UPC001', 'Product 1', 'Description 1', 'Category A', 10),
(2, 'SKU002', 'UPC002', 'Product 2', 'Description 2', 'Category B', 20),
(3, 'SKU003', 'UPC003', 'Product 3', 'Description 3', 'Category A', 15),
(4, 'SKU004', 'UPC004', 'Product 4', 'Description 4', 'Category C', 30),
(5, 'SKU005', 'UPC005', 'Product 5', 'Description 5', 'Category B', 25),
(6, 'SKU006', 'UPC006', 'Product 6', 'Description 6', 'Category A', 12),
(7, 'SKU007', 'UPC007', 'Product 7', 'Description 7', 'Category C', 28),
(8, 'SKU008', 'UPC008', 'Product 8', 'Description 8', 'Category A', 18),
(9, 'SKU009', 'UPC009', 'Product 9', 'Description 9', 'Category B', 22),
(10, 'SKU010', 'UPC010', 'Product 10', 'Description 10', 'Category C', 35);

-- --------------------------------------------------------

--
-- Table structure for table `provider`
--

CREATE TABLE `provider` (
  `providerID` int(11) NOT NULL COMMENT 'unique ID',
  `providerName` varchar(100) NOT NULL COMMENT 'name of provider',
  `providerAddress` varchar(200) NOT NULL COMMENT 'address of provider (denormalized for simplicity)',
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `postalCode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='provider of products';

--
-- Dumping data for table `provider`
--

INSERT INTO `provider` (`providerID`, `providerName`, `providerAddress`, `city`, `state`, `postalCode`) VALUES
(1, 'Provider 1', '123 Oak St', 'City 1', 'State 1', 12345),
(2, 'Provider 2', '456 Maple St', 'City 2', 'State 2', 23456),
(3, 'Provider 3', '789 Elm St', 'City 3', 'State 3', 34567),
(4, 'Provider 4', '101 Pine St', 'City 4', 'State 4', 45678),
(5, 'Provider 5', '202 Walnut St', 'City 5', 'State 5', 56789),
(6, 'Provider 6', '303 Cedar St', 'City 6', 'State 6', 67890),
(7, 'Provider 7', '404 Birch St', 'City 7', 'State 7', 78901),
(8, 'Provider 8', '505 Oak St', 'City 8', 'State 8', 89012),
(9, 'Provider 9', '606 Maple St', 'City 9', 'State 9', 90123),
(10, 'Provider 10', '707 Elm St', 'City 10', 'State 10', 12345);

-- --------------------------------------------------------

--
-- Table structure for table `transfer`
--

CREATE TABLE `transfer` (
  `transferID` int(11) NOT NULL COMMENT 'unique ID',
  `transferQuantity` int(11) NOT NULL COMMENT 'number of products transferred',
  `sendDate` date NOT NULL COMMENT 'date products were sent out',
  `receiveDate` date NOT NULL COMMENT 'date products were received',
  `Product_productID` int(11) NOT NULL COMMENT 'unique product ID number',
  `Warehouse_sourceWarehouseID` int(11) NOT NULL COMMENT 'unique ID',
  `Warehouse_destinationWarehouseID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='warehouse transfer entity.';

--
-- Dumping data for table `transfer`
--

INSERT INTO `transfer` (`transferID`, `transferQuantity`, `sendDate`, `receiveDate`, `Product_productID`, `Warehouse_sourceWarehouseID`, `Warehouse_destinationWarehouseID`) VALUES
(1, 5, '2024-04-15', '2024-04-20', 1, 1, 2),
(2, 10, '2024-04-16', '2024-04-21', 2, 2, 3),
(3, 8, '2024-04-17', '2024-04-22', 3, 3, 4),
(4, 12, '2024-04-18', '2024-04-23', 4, 4, 5),
(5, 15, '2024-04-19', '2024-04-24', 5, 5, 6),
(6, 20, '2024-04-20', '2024-04-25', 6, 6, 7),
(7, 18, '2024-04-21', '2024-04-26', 7, 7, 8),
(8, 22, '2024-04-22', '2024-04-27', 8, 8, 9),
(9, 25, '2024-04-23', '2024-04-28', 9, 9, 10),
(10, 30, '2024-04-24', '2024-04-29', 10, 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `warehouse`
--

CREATE TABLE `warehouse` (
  `sourceWarehouseID` int(11) NOT NULL COMMENT 'unique ID',
  `destinationWarehouseID` int(11) NOT NULL,
  `warehouseName` varchar(100) NOT NULL COMMENT 'name of warehouse',
  `Location_locationID` int(11) NOT NULL COMMENT 'unique location ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='physical storage area within a ''''Location"';

--
-- Dumping data for table `warehouse`
--

INSERT INTO `warehouse` (`sourceWarehouseID`, `destinationWarehouseID`, `warehouseName`, `Location_locationID`) VALUES
(1, 1, 'Warehouse 1', 1),
(2, 2, 'Warehouse 2', 2),
(3, 3, 'Warehouse 3', 3),
(4, 4, 'Warehouse 4', 4),
(5, 5, 'Warehouse 5', 5),
(6, 6, 'Warehouse 6', 6),
(7, 7, 'Warehouse 7', 7),
(8, 8, 'Warehouse 8', 8),
(9, 9, 'Warehouse 9', 9),
(10, 10, 'Warehouse 10', 10);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerID`),
  ADD UNIQUE KEY `customerAddress` (`customerAddress`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`deliveryID`),
  ADD UNIQUE KEY `Order_orderID` (`Order_orderID`),
  ADD KEY `Delivery_Customer` (`Customer_customerID`);

--
-- Indexes for table `delivery_detail`
--
ALTER TABLE `delivery_detail`
  ADD PRIMARY KEY (`deliveryDetailID`),
  ADD KEY `DeliveryDetail_Delivery` (`Delivery_deliveryID`),
  ADD KEY `DeliveryDetail_Product` (`Product_productID`),
  ADD KEY `DeliveryDetail_Warehouse` (`Warehouse_sourceWarehouseID`,`Warehouse_destinationWarehouseID`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventoryID`),
  ADD UNIQUE KEY `Warehouse_sourceWarehouseID` (`Warehouse_sourceWarehouseID`,`Warehouse_destinationWarehouseID`,`Product_productID`),
  ADD KEY `Product_productID` (`Product_productID`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`locationID`),
  ADD UNIQUE KEY `locationAddress` (`locationAddress`);

--
-- Indexes for table `ordertable`
--
ALTER TABLE `ordertable`
  ADD PRIMARY KEY (`orderID`),
  ADD KEY `Order_Provider` (`Provider_providerID`);

--
-- Indexes for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`orderDetailID`),
  ADD KEY `OrderDetail_Order` (`Order_orderID`),
  ADD KEY `OrderDetail_Product` (`Product_productID`),
  ADD KEY `OrderDetail_Warehouse` (`Warehouse_sourceWarehouseID`,`Warehouse_destinationWarehouseID`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`productID`);

--
-- Indexes for table `provider`
--
ALTER TABLE `provider`
  ADD PRIMARY KEY (`providerID`),
  ADD UNIQUE KEY `providerAddress` (`providerAddress`);

--
-- Indexes for table `transfer`
--
ALTER TABLE `transfer`
  ADD PRIMARY KEY (`transferID`),
  ADD KEY `Transfer_Product` (`Product_productID`),
  ADD KEY `Transfer_sourceWarehouse` (`Warehouse_sourceWarehouseID`,`Warehouse_destinationWarehouseID`);

--
-- Indexes for table `warehouse`
--
ALTER TABLE `warehouse`
  ADD PRIMARY KEY (`sourceWarehouseID`,`destinationWarehouseID`),
  ADD UNIQUE KEY `Location_locationID` (`Location_locationID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `Delivery_Customer` FOREIGN KEY (`Customer_customerID`) REFERENCES `customer` (`customerID`);

--
-- Constraints for table `delivery_detail`
--
ALTER TABLE `delivery_detail`
  ADD CONSTRAINT `DeliveryDetail_Delivery` FOREIGN KEY (`Delivery_deliveryID`) REFERENCES `delivery` (`deliveryID`),
  ADD CONSTRAINT `DeliveryDetail_Product` FOREIGN KEY (`Product_productID`) REFERENCES `product` (`productID`),
  ADD CONSTRAINT `DeliveryDetail_Warehouse` FOREIGN KEY (`Warehouse_sourceWarehouseID`,`Warehouse_destinationWarehouseID`) REFERENCES `warehouse` (`sourceWarehouseID`, `destinationWarehouseID`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `Inventory_Product` FOREIGN KEY (`Product_productID`) REFERENCES `product` (`productID`),
  ADD CONSTRAINT `Inventory_Warehouse` FOREIGN KEY (`Warehouse_sourceWarehouseID`,`Warehouse_destinationWarehouseID`) REFERENCES `warehouse` (`sourceWarehouseID`, `destinationWarehouseID`);

--
-- Constraints for table `ordertable`
--
ALTER TABLE `ordertable`
  ADD CONSTRAINT `Order_Provider` FOREIGN KEY (`Provider_providerID`) REFERENCES `provider` (`providerID`);

--
-- Constraints for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `OrderDetail_Order` FOREIGN KEY (`Order_orderID`) REFERENCES `ordertable` (`orderID`),
  ADD CONSTRAINT `OrderDetail_Product` FOREIGN KEY (`Product_productID`) REFERENCES `product` (`productID`),
  ADD CONSTRAINT `OrderDetail_Warehouse` FOREIGN KEY (`Warehouse_sourceWarehouseID`,`Warehouse_destinationWarehouseID`) REFERENCES `warehouse` (`sourceWarehouseID`, `destinationWarehouseID`);

--
-- Constraints for table `transfer`
--
ALTER TABLE `transfer`
  ADD CONSTRAINT `Transfer_Product` FOREIGN KEY (`Product_productID`) REFERENCES `product` (`productID`),
  ADD CONSTRAINT `Transfer_destinationWarehouse` FOREIGN KEY (`Warehouse_sourceWarehouseID`,`Warehouse_destinationWarehouseID`) REFERENCES `warehouse` (`sourceWarehouseID`, `destinationWarehouseID`),
  ADD CONSTRAINT `Transfer_sourceWarehouse` FOREIGN KEY (`Warehouse_sourceWarehouseID`,`Warehouse_destinationWarehouseID`) REFERENCES `warehouse` (`sourceWarehouseID`, `destinationWarehouseID`);

--
-- Constraints for table `warehouse`
--
ALTER TABLE `warehouse`
  ADD CONSTRAINT `Warehouse_Location` FOREIGN KEY (`Location_locationID`) REFERENCES `location` (`locationID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
