-- Populate Product table
INSERT INTO product (productID, productSKU, productUPC, productName, productDescription, productCategory, reorderQuantity)
VALUES
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

-- Populate Location table
INSERT INTO location (locationID, locationName, locationAddress, city, state, postalCode)
VALUES
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

-- Populate Warehouse table
INSERT INTO warehouse (sourceWarehouseID, destinationWarehouseID, warehouseName, Location_locationID)
VALUES
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

-- Populate Inventory table
INSERT INTO inventory (inventoryID, quantityAvailable, minStockQuantity, maxStockQuantity, reorderPoint, Warehouse_sourceWarehouseID, Warehouse_destinationWarehouseID, Product_productID)
VALUES
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

-- Populate Provider table
INSERT INTO provider (providerID, providerName, providerAddress, city, state, postalCode)
VALUES
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

-- Populate Order table
INSERT INTO ordertable (orderID, orderDate, Provider_providerID)
VALUES
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

-- Populate OrderDetail table
INSERT INTO order_detail (orderDetailID, orderQuantity, estimatedDate, arrivalDate, Order_orderID, Product_productID, Warehouse_sourceWarehouseID, Warehouse_destinationWarehouseID)
VALUES
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

-- Populate Customer table
INSERT INTO customer (customerID, customerName, customerAddress, city, state, postalCode)
VALUES
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

-- Populate Delivery table
INSERT INTO delivery (deliveryID, Order_orderID, Customer_customerID, saleDate)
VALUES
    (1, 1, 1, '2024-04-15'),
    (2, 2, 2, '2024-04-16'),
    (3, 3, 3, '2024-04-17'),
    (4, 4, 4, '2024-04-18'),
    (5, 5, 5, '2024-04-19'),
    (6, 6, 6, '2024-04-20'),
    (7, 7, 7, '2024-04-21'),
    (8, 8, 8, '2024-04-22'),
    (9, 9, 9, '2024-04-23'),
    (10, 10, 10, '2024-04-24');

-- Populate DeliveryDetail table
INSERT INTO delivery_detail (deliveryDetailID, deliveryQuantity, estimatedDate, arrivalDate, Delivery_deliveryID, Product_productID, Warehouse_sourceWarehouseID, Warehouse_destinationWarehouseID)
VALUES
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

-- Populate Transfer table
INSERT INTO transfer (transferID, transferQuantity, sendDate, receiveDate, Product_productID, Warehouse_sourceWarehouseID, Warehouse_destinationWarehouseID)
VALUES
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
