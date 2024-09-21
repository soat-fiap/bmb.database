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