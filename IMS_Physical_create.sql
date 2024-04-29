-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-04-28 03:58:14.05

-- tables
-- Table: Customer
CREATE TABLE Customer (
    customerID int  NOT NULL COMMENT 'unique ID',
    customerName varchar(100)  NOT NULL COMMENT 'name of customer',
    customerAddress varchar(200)  NOT NULL COMMENT 'address of customer (denormalized for simplicity)',
    CONSTRAINT Customer_pk PRIMARY KEY (customerID)
);

-- Table: Delivery
CREATE TABLE Delivery (
    deliveryID int  NOT NULL COMMENT 'unique ID',
    saleDate int  NOT NULL COMMENT 'date of sale to customer',
    Customer_customerID int  NOT NULL COMMENT 'unique ID',
    CONSTRAINT Delivery_pk PRIMARY KEY (deliveryID)
);

-- Table: Delivery_Detail
CREATE TABLE Delivery_Detail (
    deliveryDetailID int  NOT NULL COMMENT 'unique ID',
    deliveryQuantity int  NOT NULL COMMENT 'number of products delivered',
    estimatedDate date  NOT NULL COMMENT 'estimated arrival date',
    arrivalDate date  NOT NULL COMMENT 'actual arrival date',
    Delivery_deliveryID int  NOT NULL COMMENT 'unique ID',
    Product_productID int  NOT NULL COMMENT 'unique product ID number',
    Warehouse_sourceWarehouseID int  NOT NULL COMMENT 'unique ID',
    Warehouse_destinationWarehouseID int  NOT NULL,
    CONSTRAINT Delivery_Detail_pk PRIMARY KEY (deliveryDetailID)
) COMMENT 'detailed view of delivery';

-- Table: Inventory
CREATE TABLE Inventory (
    inventoryID int  NOT NULL COMMENT 'unique ID',
    quantityAvailable int  NOT NULL COMMENT 'quantity on-hand',
    minStockQuantity int  NOT NULL COMMENT 'minimum number of units required to ensure no shortages at warehouse',
    maxStockQuantity int  NOT NULL COMMENT 'maximum number of units required to ensure no shortages at warehouse',
    reorderPoint int  NOT NULL COMMENT 'when the number of product units reaches this point, a purchase order must be generated.',
    Warehouse_sourceWarehouseID int  NOT NULL COMMENT 'unique ID',
    Warehouse_destinationWarehouseID int  NOT NULL,
    Product_productID int  NOT NULL COMMENT 'unique product ID number',
    CONSTRAINT Inventory_pk PRIMARY KEY (inventoryID)
) COMMENT 'relational entity between product and warehouse';

-- Table: Location
CREATE TABLE Location (
    locationID int  NOT NULL COMMENT 'unique location ID',
    locationName varchar(100)  NOT NULL COMMENT 'name of location',
    locationAddress varchar(200)  NOT NULL COMMENT 'full address of location (denormalized for simplicity)',
    CONSTRAINT Location_pk PRIMARY KEY (locationID)
) COMMENT 'inventory locations';

-- Table: Order
CREATE TABLE `Order` (
    orderID int  NOT NULL COMMENT 'unique ID',
    orderDate date  NOT NULL COMMENT 'date of order',
    Provider_providerID int  NOT NULL COMMENT 'unique ID',
    CONSTRAINT Order_pk PRIMARY KEY (orderID)
);

-- Table: Order_Detail
CREATE TABLE Order_Detail (
    orderDetailID int  NOT NULL COMMENT 'unique ID',
    orderQuantity int  NOT NULL COMMENT 'number of products in order',
    estimatedDate date  NOT NULL COMMENT 'estimated arrival date',
    arrivalDate date  NOT NULL COMMENT 'actual arrival date',
    Order_orderID int  NOT NULL COMMENT 'unique ID',
    Product_productID int  NOT NULL COMMENT 'unique product ID number',
    Warehouse_sourceWarehouseID int  NOT NULL COMMENT 'unique ID',
    Warehouse_destinationWarehouseID int  NOT NULL,
    CONSTRAINT Order_Detail_pk PRIMARY KEY (orderDetailID)
) COMMENT 'detailed view of an order';

-- Table: Product
CREATE TABLE Product (
    productID int  NOT NULL COMMENT 'unique product ID number',
    productSKU varchar(100)  NOT NULL COMMENT 'internal product code (stock keeping unit)',
    productUPC varchar(100)  NOT NULL COMMENT 'external product code (universal product code)',
    productName varchar(100)  NOT NULL COMMENT 'product name',
    productDescription varchar(1000)  NOT NULL COMMENT 'detailed product description',
    productCategory varchar(100)  NOT NULL COMMENT 'product category (denormalized for simplicity)',
    reorderQuantity int  NOT NULL COMMENT 'for units not available for single unit order',
    CONSTRAINT Product_pk PRIMARY KEY (productID)
) COMMENT 'standard product attributes';

-- Table: Provider
CREATE TABLE Provider (
    providerID int  NOT NULL COMMENT 'unique ID',
    providerName varchar(100)  NOT NULL COMMENT 'name of provider',
    providerAddress varchar(200)  NOT NULL COMMENT 'address of provider (denormalized for simplicity)',
    CONSTRAINT Provider_pk PRIMARY KEY (providerID)
) COMMENT 'provider of products';

-- Table: Transfer
CREATE TABLE Transfer (
    transferID int  NOT NULL COMMENT 'unique ID',
    transferQuantity int  NOT NULL COMMENT 'number of products transferred',
    sendDate date  NOT NULL COMMENT 'date products were sent out',
    receiveDate date  NOT NULL COMMENT 'date products were received',
    Product_productID int  NOT NULL COMMENT 'unique product ID number',
    Warehouse_sourceWarehouseID int  NOT NULL COMMENT 'unique ID',
    Warehouse_destinationWarehouseID int  NOT NULL,
    CONSTRAINT Transfer_pk PRIMARY KEY (transferID)
) COMMENT 'warehouse transfer entity.';

-- Table: Warehouse
CREATE TABLE Warehouse (
    sourceWarehouseID int  NOT NULL COMMENT 'unique ID',
    destinationWarehouseID int  NOT NULL,
    warehouseName varchar(100)  NOT NULL COMMENT 'name of warehouse',
    Location_locationID int  NOT NULL COMMENT 'unique location ID',
    CONSTRAINT Warehouse_pk PRIMARY KEY (sourceWarehouseID,destinationWarehouseID)
) COMMENT 'physical storage area within a ''''Location"';

-- foreign keys
-- Reference: DeliveryDetail_Delivery (table: Delivery_Detail)
ALTER TABLE Delivery_Detail ADD CONSTRAINT DeliveryDetail_Delivery FOREIGN KEY DeliveryDetail_Delivery (Delivery_deliveryID)
    REFERENCES Delivery (deliveryID);

-- Reference: DeliveryDetail_Product (table: Delivery_Detail)
ALTER TABLE Delivery_Detail ADD CONSTRAINT DeliveryDetail_Product FOREIGN KEY DeliveryDetail_Product (Product_productID)
    REFERENCES Product (productID);

-- Reference: DeliveryDetail_Warehouse (table: Delivery_Detail)
ALTER TABLE Delivery_Detail ADD CONSTRAINT DeliveryDetail_Warehouse FOREIGN KEY DeliveryDetail_Warehouse (Warehouse_sourceWarehouseID,Warehouse_destinationWarehouseID)
    REFERENCES Warehouse (sourceWarehouseID,destinationWarehouseID);

-- Reference: Delivery_Customer (table: Delivery)
ALTER TABLE Delivery ADD CONSTRAINT Delivery_Customer FOREIGN KEY Delivery_Customer (Customer_customerID)
    REFERENCES Customer (customerID);

-- Reference: Inventory_Product (table: Inventory)
ALTER TABLE Inventory ADD CONSTRAINT Inventory_Product FOREIGN KEY Inventory_Product (Product_productID)
    REFERENCES Product (productID);

-- Reference: Inventory_Warehouse (table: Inventory)
ALTER TABLE Inventory ADD CONSTRAINT Inventory_Warehouse FOREIGN KEY Inventory_Warehouse (Warehouse_sourceWarehouseID,Warehouse_destinationWarehouseID)
    REFERENCES Warehouse (sourceWarehouseID,destinationWarehouseID);

-- Reference: OrderDetail_Order (table: Order_Detail)
ALTER TABLE Order_Detail ADD CONSTRAINT OrderDetail_Order FOREIGN KEY OrderDetail_Order (Order_orderID)
    REFERENCES `Order` (orderID);

-- Reference: OrderDetail_Product (table: Order_Detail)
ALTER TABLE Order_Detail ADD CONSTRAINT OrderDetail_Product FOREIGN KEY OrderDetail_Product (Product_productID)
    REFERENCES Product (productID);

-- Reference: OrderDetail_Warehouse (table: Order_Detail)
ALTER TABLE Order_Detail ADD CONSTRAINT OrderDetail_Warehouse FOREIGN KEY OrderDetail_Warehouse (Warehouse_sourceWarehouseID,Warehouse_destinationWarehouseID)
    REFERENCES Warehouse (sourceWarehouseID,destinationWarehouseID);

-- Reference: Order_Provider (table: Order)
ALTER TABLE `Order` ADD CONSTRAINT Order_Provider FOREIGN KEY Order_Provider (Provider_providerID)
    REFERENCES Provider (providerID);

-- Reference: Transfer_Product (table: Transfer)
ALTER TABLE Transfer ADD CONSTRAINT Transfer_Product FOREIGN KEY Transfer_Product (Product_productID)
    REFERENCES Product (productID);

-- Reference: Transfer_destinationWarehouse (table: Transfer)
ALTER TABLE Transfer ADD CONSTRAINT Transfer_destinationWarehouse FOREIGN KEY Transfer_destinationWarehouse (Warehouse_sourceWarehouseID,Warehouse_destinationWarehouseID)
    REFERENCES Warehouse (sourceWarehouseID,destinationWarehouseID);

-- Reference: Transfer_sourceWarehouse (table: Transfer)
ALTER TABLE Transfer ADD CONSTRAINT Transfer_sourceWarehouse FOREIGN KEY Transfer_sourceWarehouse (Warehouse_sourceWarehouseID,Warehouse_destinationWarehouseID)
    REFERENCES Warehouse (sourceWarehouseID,destinationWarehouseID);

-- Reference: Warehouse_Location (table: Warehouse)
ALTER TABLE Warehouse ADD CONSTRAINT Warehouse_Location FOREIGN KEY Warehouse_Location (Location_locationID)
    REFERENCES Location (locationID);

-- End of file.

