/* Cleaning Data in SQL Queries*/

create database data_cleaning

Use data_cleaning

-- Checking out the table
Select 
	* 
From 
	Housing

--1. Checking out the number of columns and rows in table

SELECT 
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Housing') AS NumberOfColumns,
    (SELECT SUM(row_count) FROM sys.dm_db_partition_stats WHERE object_id = OBJECT_ID('Housing')) AS NumberOfRows;

	/* The output shows that there are 19 columns and 56477 rows in the table.*/


-- 2. Standardize Date Format

-- There is information on date in the SaleDate column. It needs to be standardized

Select 
	SaleDate, 
	CONVERT(date, SaleDate)  As date_formatted
From 
	Housing

	-- Creating a new column 'SaleConvertedDate' 

Alter Table Housing
Add SaleDate_Formatted Date

	-- Updating the 'SaleConvertedDate' column
Update Housing
Set SaleDate_Formatted = CONVERT(Date, SaleDate)


-- 3. Addressing Null values in the 'PropertyAddress' Column

-- Checking
Select 
	ParcelID, 
	PropertyAddress 
From 
	Housing
Order By 
	1

/* By scrolling through the out put it is oserved that there are Null values in the 'PropertyAddress'.
	Furthermore each parcel of land has its own unique ParcelID.
	If a parcel is bought is sold or bought it address will remain the same.*/ 

-- For filling the null values we will use Self Join 

Select 
	Tab_A.ParcelID,
	Tab_A.PropertyAddress, 
	Tab_B.ParcelID, 
	Tab_B.PropertyAddress, 
	ISNULL(Tab_A.PropertyAddress, Tab_B.PropertyAddress) As property_address
From 
	Housing As Tab_A
Join 
	Housing As Tab_B
	On 
		Tab_A.ParcelID = Tab_B.ParcelID 
		and Tab_A.[UniqueID ] <> Tab_B.[UniqueID ]
Where 
	Tab_A.PropertyAddress is Null

-- For updating the 'PropertyAddress' column in the table

Update Tab_A
Set 
	PropertyAddress = ISNULL(Tab_A.PropertyAddress, Tabe_B.PropertyAddress)
From 
	Housing As Tab_A
Join 
	Housing As Tabe_B
	On 
		Tab_A.ParcelID = Tabe_B.ParcelID and
		Tab_A.[UniqueID ] <> Tabe_B.[UniqueID ]
Where 
	Tab_A.PropertyAddress is Null

	-- Checking if there are any remaining null values in the 'Property_Address' column
select 
	ParcelID, 
	PropertyAddress
From
	Housing
Where 
	PropertyAddress is null

/* The output shows that there are no null values.*/


-- 4. Splitting Property Address Data and Owner Address Data into Individual Columns (Address, City, State)

	-- A. Property Address Data

	-- Checking the 'PropertyAddress' column
Select 
	PropertyAddress
From 
	Housing
Order By 
	ParcelID

/* The output shows that we should split the column by comma, the information to the left of the comma is about the 
address while to the right of the comma is information about City*/

-- Splitting the column by comma
Select
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) As Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) As City
From 
	Housing
Order By 
	ParcelID

-- Creating a new column for information on property address in the table
Alter Table 
	Housing
Add 
	PropertyStreetAddress Nvarchar (255)

-- Populating the column
Update 
	Housing
Set 
	PropertyStreetAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1)


-- Creating a new column for information on property city in the table

Alter Table 
	Housing
Add 
	PropertyCity Nvarchar (255)

-- Populating the column
Update Housing
Set PropertyCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress))


-- Checking

select 
	PropertyAddress, PropertyStreetAddress, PropertyCity 
From
	Housing

	-- B. Onwer Address Data

	-- Checking the 'OwnerAddress' column
Select 
	OwnerAddress
From 
	Housing
Order By 
	ParcelID

/* The output shows that there are two commas, before the first comma we have information on the Street Address,
after the first comma (in the middle) we have information on the City, and after the second comma there is infromation
on the state*/

-- Splitting the column by commas

Select 
PARSENAME(Replace(OwnerAddress, ',','.'),3) As Owner_Street_Address,
PARSENAME(Replace(OwnerAddress, ',','.'),2) As Owner_City_Address,
PARSENAME(Replace(OwnerAddress, ',','.'),1) As Owner_State_Address
From 
	Housing

-- Creating a new column for owner's street address

Alter Table 
	Housing
Add 
	OwnerStreetAddress Nvarchar(255)

-- Populating the column

Update 
	Housing
Set 
	OwnerStreetAddress = PARSENAME(Replace(OwnerAddress, ',','.'),3)

-- Creating a new column for owner's city address

Alter Table 
	Housing
Add 
	OwnerCity Nvarchar(255)

-- Populating the column

Update 
	Housing
Set 
	OwnerCity = PARSENAME(Replace(OwnerAddress, ',','.'),2)

-- Creating a new column for owner's state address

Alter Table 
	Housing
Add 
	OwnerState Nvarchar(255)

-- Populating the column

Update 
	Housing
Set 
	OwnerState = PARSENAME(Replace(OwnerAddress, ',','.'),1)

-- Checking

Select
	OwnerAddress,
	OwnerStreetAddress,
	OwnerCity,
	OwnerState
From 
	Housing


-- 5. Cleaning the 'SoldAsVacant' column

-- Checking
select 
	Distinct(SoldAsVacant), 
	Count(SoldAsVacant) As Count
From 
	Housing
Group By 
	SoldAsVacant
Order By 
	2

/* In the out put there is Yes and No and then Y and N.*/ 

-- Replacing Y with Yes and N with No

Select 
	SoldAsVacant,
	Case When 
		SoldAsVacant = 'Y' Then 'Yes'
		When 
			SoldAsVacant = 'N' Then 'No'
		Else 
			SoldAsVacant
		End as sold_or_vacant
From 
	Housing
Where
	SoldAsVacant = 'Y'
	or SoldAsVacant = 'N'

-- Updating the SoldAsVacant column

Update Housing
Set 
	SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
		When 
			SoldAsVacant = 'N' Then 'No'
		Else
			SoldAsVacant
		End

-- Checking

select 
	Distinct(SoldAsVacant), 
	Count(SoldAsVacant) As Count
From 
	Housing
Group By 
	SoldAsVacant
Order By 
	2 desc

-- 6. Checking the table for Duplicates

With RowNumCTE AS (
Select *,
		ROW_NUMBER() Over(
		Partition By ParcelID,
							PropertyAddress,
							SaleDate, 
							SalePrice,
							LegalReference
							Order By
									UniqueID
									) As row_num
From Housing
)
Select * 
From RowNumCTE
Where row_num > 1
Order By PropertyAddress

-- There are 104 duplicates in the table

-- Deleting the duplicates

With RowNumCTE As (
Select *,
		ROW_NUMBER() Over(
		Partition By ParcelID,
							PropertyAddress,
							SaleDate, 
							SalePrice,
							LegalReference
							Order By
									UniqueID
									) As row_num
From 
	Housing
)
Delete
From
	RowNumCTE
Where 
	row_num > 1


-- 7. Checking the OwnerName column

Select 
	OwnerName
From
	Housing
where
	OwnerName is not null

/* The output shows that some of the properties are owned by single individual, and in some cases they are co-owned*/ 

-- Checking the co-owned properties.*/

select
	OwnerName
From 
	Housing
Where OwnerName like '%&%'

-- 'Yes' for Co-owned properties and 'No' for properties owned by a single individual 

Select 
	OwnerName,
	Case When 
		OwnerName like '%&%' Then 'Yes'
		When 
			OwnerName not like '%&%' Then 'No'
		Else 
			OwnerName
		End as CoOwned
From 
	Housing
Where OwnerName is not null

-- Creating a new column

Alter Table Housing
Add CoOwned Nvarchar(255)

-- Populating the new column and assigning Yes to Co-owned, and No to properties owned by a single owner.

Update Housing
Set 
	CoOwned = Case When 
		OwnerName like '%&%' Then 'Yes'
		When 
			OwnerName not like '%&%' Then 'No'
		Else 
			OwnerName
		End 
	From 
		Housing

-- Checking

Select
	OwnerName,
	CoOwned
From 
	Housing
Where OwnerName is not null


-- 8. Deleting Unused Columns

-- Checking for columns that we do not need
Select * 
From Housing

-- Deleting the columns
Alter Table Housing
Drop Column PropertyAddress, SaleDate, OwnerAddress, TaxDistrict
