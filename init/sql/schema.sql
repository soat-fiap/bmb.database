use techchallengedb;

CREATE TABLE IF NOT EXISTS Customers
(
    Id    char(36)  not null
        primary key,
    Cpf   varchar(11) not null,
    Name  varchar(100) null,
    Email varchar(100) null
);


CREATE TABLE IF NOT EXISTS Products
(
    Id          char(36)      not null comment 'product id'
        primary key,
    Name        varchar(100)  not null,
    Description varchar(200)  not null,
    Category    int           not null,
    Price       decimal(10,2)       not null,
    Images      varchar(1000) null
);


CREATE TABLE IF NOT EXISTS Orders
(
    Id         char(36)   not null
        primary key,
    CustomerId char(36)   null,
    PaymentId  char(36)   null,
    Status     int        not null,
    Created    datetime   null,
    Updated    datetime   null,
    TrackingCode       varchar(7) null,
    foreign key (CustomerId) references Customers(Id)
);


CREATE TABLE IF NOT EXISTS OrderItems
(
    OrderId     char(36)     not null,
    ProductId   char(36)     not null,
    ProductName varchar(200) not null,
    UnitPrice   decimal      not null,
    Quantity    int          not null,
    foreign key (OrderId) references Orders(Id),
    foreign key (ProductId) references Products(Id)
);

CREATE TABLE IF NOT EXISTS Payments
(
    Id         char(36)   not null,
    OrderId    char(36)   not null,
    Status     int        not null,
    Created    datetime   null,
    Updated    datetime   null,
    PaymentType int       not null,
    ExternalReference     varchar(36) not null,
    Amount     decimal(10,2) not null,
    PRIMARY KEY (Id, OrderId),
    foreign key (OrderId) references Orders(Id)
);

erDiagram
    Customers {
        char(36) Id
        varchar(11) Cpf
        varchar(100) Name
        varchar(100) Email
    }
    
    Products {
        char(36) Id
        varchar(100) Name
        varchar(200) Description
        int Category
        decimal(10) Price
        varchar(1000) Images
    }
    
    Orders {
        char(36) Id
        char(36) CustomerId
        char(36) PaymentId
        int Status
        datetime Created
        datetime Updated
        varchar(7) TrackingCode
    }
    
    OrderItems {
        char(36) OrderId
        char(36) ProductId
        varchar(200) ProductName
        decimal UnitPrice
        int Quantity
    }
    
    Payments {
        char(36) Id
        char(36) OrderId
        int Status
        datetime Created
        datetime Updated
        int PaymentType
        varchar(36) ExternalReference
        decimal(10) Amount
    }
    
    Customers ||--o{ Orders : "has"
    Orders ||--|{ OrderItems : "contains"
    Products ||--o{ OrderItems : "included in"
    Orders ||--o| Payments : "paid with"