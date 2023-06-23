/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Date]
      ,[ Medication Revenue ]
      ,[  Lab Cost ]
      ,[ Consultation Revenue ]
      ,[Doctor Type]
      ,[Financial Class]
      ,[Patient Type]
      ,[Entry Time]
      ,[Post-Consultation Time]
      ,[Completion Time]
      ,[Patient ID]
  FROM [Portfolio].[dbo].[Hospital data]



 ----------Seeing the data in full
  SELECT *
  FROM Portfolio.dbo.[Hospital data]


 --------- Standardizing the date
  SELECT Date, CONVERT(DATE, Date)
  FROM Portfolio.dbo.[Hospital data]



 ALTER TABLE Portfolio.dbo.[Hospital data]
 ADD HospitalDateConverted DATE;

 UPDATE Portfolio.dbo.[Hospital data]
 SET HospitalDateConverted = CONVERT(DATE, Date)


  --------------Retrive the record where the consultation revenue greater than 20
SELECT *
FROM Portfolio.dbo.[Hospital data]
WHERE [ Consultation Revenue ] > 20
  


  ---------Standarize the entry time
  SELECT CONVERT(TIME, [Entry Time])
  FROM Portfolio.dbo.[Hospital data]

  ALTER TABLE Portfolio.dbo.[Hospital data]
  ADD EntryTimeConverted TIME;

  UPDATE Portfolio.dbo.[Hospital data]
  SET EntryTimeConverted = CONVERT(TIME, [Entry Time])

  --------------Retrive the record where the entry time is between 9am AND 12pm
  SELECT *
  FROM Portfolio.dbo.[Hospital data]
  WHERE EntryTimeConverted BETWEEN '09:00:00.0000000' AND '12:00:00.0000000'
  
  --------------Standardize the completion time
  FROM Portfolio.dbo.[Hospital data]

  ALTER TABLE Portfolio.dbo.[Hospital data]
  ADD CompletionTimeConverted TIME;

  UPDATE Portfolio.dbo.[Hospital data]
  SET CompletionTimeConverted = CONVERT(TIME, [Completion Time])

  --------------Retrive the record where the patient type is 'OUTPATIENT' and the completion time is 9am
  SELECT *
  FROM Portfolio.dbo.[Hospital data]
  WHERE CompletionTimeConverted = '09:00:00.0000000' AND [Patient Type]  = 'OUTPATIENT'


  --------------Retrive the record wherethe doctor type is 'ANCHOR' and the financial class is INSURANCE
  SELECT *
  FROM Portfolio.dbo.[Hospital data]
  WHERE [Doctor Type] = 'ANCHOR' AND [Financial Class] = 'INSURANCE'


  --------------Retrive the record where the medication revenue is greater than 500
  SELECT *
  FROM Portfolio.dbo.[Hospital data]
  WHERE [ Medication Revenue ] > 500

