
Select*
From [portfolio project].dbo.NashvilleHousing


----STANDARDIZING THE DATE FORMAT

Select SaleDate, CONVERT(Date, SaleDate)
From [portfolio project].dbo.NashvilleHousing



ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)


Select SalesDateConverted, CONVERT(Date, SaleDate)
From [portfolio project].dbo.NashvilleHousing


-----Populate Property Address data
Select PropertyAddress
From [portfolio project].dbo.NashvilleHousing

Select *
From [portfolio project].dbo.NashvilleHousing
Where PropertyAddress is null

Select *
From [portfolio project].dbo.NashvilleHousing
Order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, Isnull(a.PropertyAddress, b.PropertyAddress)
From [portfolio project].dbo.NashvilleHousing a
Join [portfolio project].dbo.NashvilleHousing b
   on a.ParcelID = b.ParcelID
   AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
Set PropertyAddress = Isnull(a.PropertyAddress, b.PropertyAddress)
From [portfolio project].dbo.NashvilleHousing a
Join [portfolio project].dbo.NashvilleHousing b
   on a.ParcelID = b.ParcelID
   AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null



------Breaking out Address Columns (Address, city, state)
Select PropertyAddress
From [portfolio project].dbo.NashvilleHousing
--Order by ParcelID

Select
Substring(PropertyAddress, 1, Charindex(', ', PropertyAddress)-1) as Address,
Substring(PropertyAddress, Charindex(', ', PropertyAddress)+ 1, Len(PropertyAddress)) as Address
From [portfolio project].dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
Add PropertySplitAddress Varchar(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = Substring(PropertyAddress, 1, Charindex(', ', PropertyAddress)-1)


ALTER TABLE NashvilleHousing
Add PropertySplitCity Varchar(255);

UPDATE NashvilleHousing
SET PropertySplitCity = Substring(PropertyAddress, Charindex(', ', PropertyAddress)+ 1, Len(PropertyAddress)) 


Select*
From [portfolio project].dbo.NashvilleHousing





Select OwnerAddress
From [portfolio project].dbo.NashvilleHousing

Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
From [portfolio project].dbo.NashvilleHousing



ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Varchar(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Varchar(255);

UPDATE NashvilleHousing
SET OwnerSplitCity =  PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Varchar(255);

UPDATE NashvilleHousing
SET OwnerSplitState =  PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

Select*
From [portfolio project].dbo.NashvilleHousing


------------------------------------------
----CONVERT Y AND N TO YES AND NO
Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From [portfolio project].dbo.NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
,CASE When SoldAsVacant = 'Y' THEN 'Yes'
       When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From [portfolio project].dbo.NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
       When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END


	   --------- Remove DuplicatE
 WITH RowNumCTE AS(
Select*,
Row_number() over(
PARTITION BY ParcelID,
             PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 ORDER BY
			   UniqueID
			   ) row_num
From [portfolio project].dbo.NashvilleHousing
--order by ParcelID
)
Select*
From  RowNumCTE 
Where row_num > 1
--Order by PropertyAddress

-------Delete row aand columns
SELECT*
FROM [portfolio project].dbo.NashvilleHousing

ALTER TABLE  [portfolio project].dbo.NashvilleHousing
DROP COLUMN OwnerAddress, PropertyAddress, SaleDate

