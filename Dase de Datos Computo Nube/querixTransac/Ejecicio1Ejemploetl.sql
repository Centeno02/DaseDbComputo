CREATE DATABASE ejemploetl
use ejemploetl




create table productos(
productosId int not null identity (1,1),
nombreprodcuto nvarchar (40) not null,
precio money not null,
stock smallint not null,
import as 
(precio * stock),
categoria nvarchar (15) not null,
constraint pk_producto
primary key (productosId))

alter table productos
add Categoria nvarchar (15) not null 

select * from productos

select * from NORTHWND.dbo.Categories

select * from NORTHWND.dbo.Products




-- permite vixualizar las carracteristas de las tablas
select * from sys.tables

Insert into ejemploetl.dbo.productos
select p.ProductName, p .UnitPrice, p.UnitsInStock
,c.CategoryName from NORTHWND.dbo.Products as p
inner join NORTHWND.dbo.Categories as c
on c.CategoryID = p.CategoryID

