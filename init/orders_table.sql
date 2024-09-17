create table IF NOT EXISTS Orders
(
    Id         char(36)   not null,
    CustomerId char(36)   null,
    PaymentId  char(36)   null,
    Status     int        not null,
    Created    datetime   null,
    Updated    datetime   null,
    TrackingCode       varchar(7) null
);