CREATE TABLE IF NOT EXISTS Customers
(
    Id    char(36)  not null
        primary key,
    Cpf   varchar(11) not null,
    Name  varchar(100) null,
    Email varchar(100) null
);