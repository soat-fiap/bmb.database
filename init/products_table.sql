create table IF NOT EXISTS Products(
    Id          char(36)   not null primary key,
    Name        varchar(100)  not null,
    Description varchar(200)  not null,
    Category    int           not null,
    Price       decimal(10,2)       not null,
    Images      varchar(1000) null
);