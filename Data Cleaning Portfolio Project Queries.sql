/* Cleaning Data in SQL Queries*/

create database data_cleaning

Use data_cleaning

Select * 
from NashvilleHousing
-----------------------------------------------------------------------------------------------------------------
-- 1. Standardize Date Format

Select SaleDate, CONVERT(date, SaleDate) 
from NashvilleHousing

Update  NashvilleHousing
Set SaleDate = Convert(Date, SaleDate)

-- If it does not update properly then

Alter Table NashvilleHousing
Add SaleConvertedDate Date

Update NashvilleHousing
Set SaleConvertedDate = CONVERT(Date, SaleDate)

-----------------------------------------------------------------------------------------------------------------
-- 2. Populate Property Address Data

Select * 
From NashvilleHousing
Order By ParcelID

Select A.ParcelID,A.PropertyAddress, B.ParcelID, B.PropertyAddress, ISNULL(A.PropertyAddress, B.PropertyAddress)
From NashvilleHousing As A
Join NashvilleHousing As B
	On A.ParcelID = B.ParcelID and
	A.[UniqueID ] <> B.[UniqueID ]
Where A.PropertyAddress is Null

Update A
Set PropertyAddress = ISNULL(A.PropertyAddress, B.PropertyAddress)
From NashvilleHousing As A
Join NashvilleHousing As B
	On A.ParcelID = B.ParcelID and
	A.[UniqueID ] <> B.[UniqueID ]
Where A.PropertyAddress is Null

-----------------------------------------------------------------------------------------------------------------
-- 3. Breaking out Property Address Data and Owner Address Data into Individual Columns (Address, City, State)

	-- A. Property Address Data
Select PropertyAddress
From NashvilleHousing
Order by ParcelID

Select
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) As Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) -1, LEN(PropertyAddress)) As City
From NashvilleHousing

Alter Table NashvilleHousing
Add PropertySplitAddress Nvarchar (255)

Update NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1)

Alter Table NashvilleHousing
Add PropertyCityAddress Nvarchar (255)

Update NashvilleHousing
Set PropertyCityAddress = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) -1, LEN(PropertyAddress))

	-- B. Onwer Address Data

Select * 
from NashvilleHousing

Select OwnerAddress
from NashvilleHousing

Select 
PARSENAME(Replace(OwnerAddress, ',','.'),3),
PARSENAME(Replace(OwnerAddress, ',','.'),2),
PARSENAME(Replace(OwnerAddress, ',','.'),1)
from NashvilleHousing

Alter Table NashvilleHousing
Add OwnerSplitAddress nvarchar(255)

Update NashvilleHousing
Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',','.'),3)

Alter Table NashvilleHousing
Add OwnerCityAddress nvarchar(255)

Update NashvilleHousing
Set OwnerCityAddress = PARSENAME(Replace(OwnerAddress, ',','.'),2)


Alter Table NashvilleHousing
Add OwnerStateAddress nvarchar(255)

Update NashvilleHousing
Set OwnerStateAddress = PARSENAME(Replace(OwnerAddress, ',','.'),1)

Select *
From NashvilleHousing

-----------------------------------------------------------------------------------------------------------------
-- 4. Change Y and N to Yes and No in 'Sold as Vacant' Field

select * 
From NashvilleHousing

select Distinct(SoldAsVacant), Count(SoldAsVacant) As Count
From NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant,
Case When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
		End
From NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
		End

select Distinct(SoldAsVacant), Count(SoldAsVacant) As Count
From NashvilleHousing
Group by SoldAsVacant
Order by 2

-----------------------------------------------------------------------------------------------------------------
-- 5. Remove Duplicates

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
From NashvilleHousing
)
Select * 
from RowNumCTE
Where row_num > 1
Order By PropertyAddress

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
From NashvilleHousing
)
Delete
From RowNumCTE
Where row_num > 1

-----------------------------------------------------------------------------------------------------------------
-- 6. Delete Unused Columns

Select * 
From NashvilleHousing

Alter Table NashvilleHousing
Drop Column SaleDate, PropertyAddress, OwnerAddress, TaxDistrict

-----------------------------------------------------------------------------------------------------------------
-- 6. Renaming Column

Select * 
From NashvilleHousing

Exec sp_rename 'NashvilleHousing.SaleConvertedDate', 'SaleDate'
