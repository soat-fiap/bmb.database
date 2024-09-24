use techchallengedb;

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