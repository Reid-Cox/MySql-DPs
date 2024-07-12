
CREATE TABLE Sheep (
    SheepID int not null PRIMARY KEY,
    Sheep_name varchar(255),
    Sex varchar(255) check (Sex ='male' or Sex='female') not null,
    Father_ID int,
	Mother_ID int,
    Date_of_Birth date not null,
    Dead Boolean,
    Dead_Date date,
    Sold Boolean,
    Sold_Amount int,
    Sold_Date date
); 

CREATE TABLE Goats (
    GoatID int not null PRIMARY KEY,
    Goat_name varchar(255),
    Sex varchar(255) check (Sex ='male' or Sex='female')not null,
    Father_ID int,
	Mother_ID int,
    Date_of_Birth date not null,
    Dead Boolean,
    Dead_Date date,
    Sold Boolean,
    Sold_Amount int,
    Sold_Date date
); 

CREATE TABLE Medicine (
	ID int auto_increment primary key not NULL,
    Medicine_Name varchar(255),
    Amount_in_ML int not null,
    Date_of_admin datetime,
    Animal_ID int not null
);

CREATE TABLE Hillair_Farms (
	H_Year Year primary key  ,
    Number_of_Goats int,
    Number_of_Sheep int 
);

UPDATE Hillair_Farms
set Number_of_Goats = (select count(GoatID) from Goats 
where (H_Year >= YEAR(Date_of_Birth))
)
;
UPDATE Hillair_Farms
set Number_of_Sheep = (select count(SheepID) from Sheep 
where (H_Year >= YEAR(Date_of_Birth))
)
;

delimiter $$
create trigger update_Goat_Count after insert on Goats
for each row
begin
UPDATE Hillair_Farms
set Number_of_Goats = (select count(GoatID) from Goats 
where (H_Year >= YEAR(Date_of_Birth))
)
;
end;
delimiter;

delimiter $$
create trigger update_Sheep_Count after insert on Sheep
for each row
begin
UPDATE Hillair_Farms
set Number_of_Sheep = (select count(SheepID) from Sheep 
where (H_Year >= YEAR(Date_of_Birth))
)
;
end;
delimiter;

CREATE VIEW Goat_Fathers AS
SELECT  GoatID, Goat_name  
FROM Goats
WHERE Sex = 'male' and GoatID = Father_ID ; 

sheep_fathersCREATE VIEW Sheep_Fathers AS
SELECT  SheepID, Sheep_name  
FROM sheep
WHERE Sex = 'male' and SheepID = Father_ID ; 



CREATE VIEW Goat_Mothers AS
SELECT  GoatID, Goat_name  
FROM Goats
WHERE Sex = 'female' and GoatID = Mother_ID ; 

CREATE VIEW Sheep_Mothers AS
SELECT  SheepID, Sheep_name  
FROM sheep
WHERE Sex = 'female' and SheepID = Mother_ID ; 