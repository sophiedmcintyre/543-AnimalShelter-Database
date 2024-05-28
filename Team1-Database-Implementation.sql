/* McKenzie Marshall, Christina Sheets, Katrina Lujan, Sophie McIntyre */
/* Team 1 Database Implementation */
/* LIS 543 */

/* Creates database for an Animal Shelter */
CREATE DATABASE Team1_AnimalShelterDB
GO

USE Team1_AnimalShelterDB

CREATE TABLE dbo.Branch
	(BranchID int NOT NULL
		CONSTRAINT PK_Branch
		PRIMARY KEY,
	 BranchName varchar(50) NOT NULL,
	 BranchAddress varchar(50) NOT NULL,
	 BranchCity varchar(50) NOT NULL,
	 BranchState varchar(50) CHECK (BranchState = 'WA'), /* CHECK Constraint where the state has to be Washington */
	 BranchZip smallint NOT NULL,
	 BranchCapacity int NOT NULL);

CREATE TABLE dbo.ResidentAnimal
	(ResidentAnimalId int NOT NULL
		CONSTRAINT PK_ResidentAnimal
		PRIMARY KEY,
	 BranchID int NOT NULL
		CONSTRAINT FK_Animal_Branch
		FOREIGN KEY
		REFERENCES dbo.Branch(BranchID),
	 AdoptionStatus varchar(50) NOT NULL,
	 Species varchar(50) NOT NULL,
	 DateofBirth date NULL,
	 Sex varchar(50) NOT NULL,
	 Weight tinyint NOT NULL,
	 SpayedNeutered varchar(30) NOT NULL);

CREATE TABLE dbo.CandidateOwner
	(CandidateOwnerId int NOT NULL
		CONSTRAINT PK_CandidateOwnerId
		PRIMARY KEY,
	 CandidateFName varchar(50) NOT NULL,
	 CandidateLName varchar(50) NOT NULL,
	 CandidateAddress varchar(50) NOT NULL,
	 CandidateCity varchar(50) NOT NULL,
	 CandidateState varchar(50) CHECK (CandidateState = 'WA'), /* CHECK Constraint where the state has to be Washington */
	 CandidateZip smallint NOT NULL,
	 CandidateAddedDate date NOT NULL);

CREATE TABLE dbo.Adoption
	(AdoptionId int NOT NULL
		CONSTRAINT PK_Adoption
		PRIMARY KEY,
	 ResidentAnimalId int NOT NULL
		CONSTRAINT FK_Adoption_Animal
		FOREIGN KEY
		REFERENCES dbo.ResidentAnimal(ResidentAnimalId),
	CandidateOwnerId int NOT NULL
		CONSTRAINT FK_Adoption_CandidateOwner
		FOREIGN KEY
		REFERENCES dbo.CandidateOwner(CandidateOwnerID),
	AdoptionDate date NOT NULL,
	AdoptionStatus varchar(50) Not NULL);

CREATE TABLE dbo.FosterHome
	(FosterHomeId int NOT NULL
		CONSTRAINT PK_FosterHome
		PRIMARY KEY,
	 FosterFName varchar(50) NOT NULL,
	 FosterLName varchar(50) NOT NULL,
	 FosterAddress varchar(50) NOT NULL,
	 FosterCity varchar(50) NOT NULL,
	 FosterState varchar(50) CHECK (FosterState = 'WA'), /* CHECK Constraint where the state has to be Washington */
	 FosterZip smallint NOT NULL,
	 FosterHomeAddedDate date NOT NULL);

CREATE TABLE dbo.Veterinarian
	(VetId int NOT NULL
		CONSTRAINT PK_VetId
		PRIMARY KEY,
	 VetAddress varchar(50) NOT NULL,
	 VetCity varchar(50) NOT NULL,
	 VetState varchar(50) CHECK (VetState = 'WA'), /* CHECK Constraint where the state has to be Washington */
	 VetZip smallint NOT NULL,
	 VetPracticeName varchar(50) NOT NULL,
	 VetDateAdded date NOT NULL);

CREATE TABLE dbo.Specialty
	(SpecialtyId int NOT NULL
		CONSTRAINT PK_Specialty
		PRIMARY KEY,
	 SpecialtyDesc varchar(1000));

CREATE TABLE dbo.VetSpecialty
	(VetId int NOT NULL
		REFERENCES dbo.Veterinarian(VetId),
	 SpecialtyId int NOT NULL
		REFERENCES dbo.Specialty(SpecialtyId));

CREATE TABLE dbo.Medication
	(MedicationId int NOT NULL
		CONSTRAINT PK_Medication
		PRIMARY KEY,
	 MedicationName varchar(50) NOT NULL);

CREATE TABLE dbo.ResidentMedication
	(ResidentMedicationId int NOT NULL
		CONSTRAINT PK_ResidentMedication
		PRIMARY KEY,
	 MedicationId int NOT NULL
		CONSTRAINT FK_ResidentMed_Medication
		FOREIGN KEY
		REFERENCES dbo.Medication(MedicationId),
	 ResidentAnimalId int NOT NULL
		CONSTRAINT FK_ResidentMed_Animal
		FOREIGN KEY
		REFERENCES dbo.ResidentAnimal(ResidentAnimalId),
	 VetId int NOT NULL
		CONSTRAINT FK_ResidentMed_Vet
		FOREIGN KEY
		REFERENCES dbo.Veterinarian(VetId),
	 MedicationDosage tinyint NOT NULL,
	 MedicationDosageUnits varchar(10) NOT NULL,
	 MedDateStarted date NOT NULL,
	 MedicationActive varchar(20) NOT NULL);

CREATE TABLE dbo.SurrenderingEntity
	(SurrenderingEntityId int NOT NULL
		CONSTRAINT PK_SurrenderingEntity
		PRIMARY KEY,
	 SurrenderingEntityType varchar(50) NOT NULL,
	 DateAdded date NOT NULL);

CREATE TABLE dbo.Surrender
	(SurrenderID int NOT NULL
		CONSTRAINT PK_SurrenderId
		PRIMARY KEY,
	 ResidentAnimalId int NOT NULL
		CONSTRAINT FK_Surrender_Animal
		REFERENCES dbo.ResidentAnimal(ResidentAnimalId),
	 SurrenderingEntityId int NOT NULL
		CONSTRAINT FK_Surrender_SurrenderingEntity
		REFERENCES dbo.SurrenderingEntity(SurrenderingEntityId),
	 SurrenderDate date NOT NULL);

CREATE TABLE dbo.FosterCare
	(FosterCareId int NOT NULL
		CONSTRAINT PK_FosterCare
		PRIMARY KEY,
	 ResidentAnimalId int NOT NULL
		CONSTRAINT FK_FosterCare_Animal
		FOREIGN KEY
		REFERENCES dbo.ResidentAnimal(ResidentAnimalID),
	 FosterHomeId int NOT NULL
		CONSTRAINT FK_FosterCare_FosterHome
		FOREIGN KEY
		REFERENCES dbo.FosterHome(FosterHomeId),
	 FosterCareDate date NOT NULL,
	 ActivePlacement varchar(500) NOT NULL);

CREATE TABLE dbo.AgeClassification
	(AgeClassificationId int NOT NULL
		CONSTRAINT PK_AgeClassification
		PRIMARY KEY,
	 AgeClassificationLabel varchar(50) NOT NULL,
	 AgeClassificationDesc varchar(1000) NOT NULL);

CREATE TABLE dbo.SizeClassification
	(SizeClassificationId int NOT NULL
		CONSTRAINT PK_SizeClassification
		PRIMARY KEY,
	 SizeClassificationLabel varchar(50) NOT NULL,
	 SizeClassificationDesc varchar(1000) NOT NULL);

CREATE TABLE dbo.AdoptionConstraints
	(AdoptionConstraintsId int NOT NULL
		CONSTRAINT PK_AdoptionConstraints
		PRIMARY KEY,
	 AgeClassificationId int NOT NULL
		CONSTRAINT FK_AdoptionConstraints_Age
		FOREIGN KEY
		REFERENCES dbo.AgeClassification(AgeClassificationId),
	 SizeClassificationId int NOT NULL
		CONSTRAINT FK_AdoptionConstraints_Size
		FOREIGN KEY
		REFERENCES dbo.SizeClassification(SizeClassificationId),
	 ChildFriendly varchar(10) NULL,
	 CatFriendly varchar(10) NULL,
	 DogFriendly varchar(10) NULL,
	 HouseTrained varchar(10) NULL,
	 SpecialNeeds varchar(50) NULL);

CREATE TABLE dbo.CandidateOwnerAdoptionConstraint
	(CandidateOwnerId int NOT NULL
		REFERENCES dbo.CandidateOwner(CandidateOwnerId),
	 AdoptionConstraintId int NOT NULL
		REFERENCES dbo.AdoptionConstraints(AdoptionConstraintsId));

CREATE TABLE dbo.ResidentAnimalAdoptionConstraint
	(ResidentAnimalId int NOT NULL
		REFERENCES dbo.ResidentAnimal(ResidentAnimalId),
	 AdoptionConstraintId int NOT NULL
		REFERENCES dbo.AdoptionConstraints(AdoptionConstraintsId));

CREATE TABLE dbo.Volunteer
	(VolunteerId int NOT NULL
		CONSTRAINT PK_Volunteer
		PRIMARY KEY,
	 BranchID int NOT NULL
		CONSTRAINT FK_Volunteer_BranchID
		FOREIGN KEY
		REFERENCES dbo.Branch(BranchID),
	 VolunteerFName varchar(50) NOT NULL,
	 VolunteerLName varchar(50) NOT NULL,
	 VolunteerDOB date NOT NULL,
	 VolunteerAddress varchar(50) NOT NULL,
	 VolunteerCity varchar(50) NOT NULL,
	 VolunteerState varchar(50) CHECK (VolunteerState = 'WA'), /* CHECK Constraint where the state has to be Washington */
	 VolunteerZip smallint NOT NULL);

CREATE TABLE dbo.Staff
	(StaffId int NOT NULL
		CONSTRAINT PK_Staff
		PRIMARY KEY,
	 BranchID int NOT NULL
		CONSTRAINT FK_Staff_BranchID
		FOREIGN KEY
		REFERENCES dbo.Branch(BranchID),
	 StaffFName varchar(50) NOT NULL,
	 StaffLName varchar(50) NOT NULL,
	 StaffTitle varchar(50) NOT NULL,
	 StaffDOB date NOT NULL,
	 StaffAddress varchar(50) NOT NULL,
	 StaffCity varchar(50) NOT NULL,
	 StaffState varchar(50) CHECK (StaffState = 'WA'), /* CHECK Constraint where the state has to be Washington */
	 StaffZip smallint NOT NULL,
	 StaffHireDate date NOT NULL);

CREATE TABLE dbo.FosterHomeAdoptionConstraint
	(FosterHomeId int NOT NULL
		REFERENCES dbo.FosterHome(FosterHomeId),
	 AdoptionConstraintId int NOT NULL
		REFERENCES dbo.AdoptionConstraints(AdoptionConstraintsId));

/*Data imported using Data Import Wizard. See .csv files.*/
/* Creates Views */

CREATE VIEW [Daily Medications] AS
SELECT
ResidentAnimal.ResidentAnimalId
,Medication.MedicationName
,ResidentMedication.MedicationDosage
,ResidentMedication.MedicationDosageUnits
FROM ResidentMedication
LEFT JOIN ResidentAnimal
ON ResidentMedication.ResidentAnimalId = ResidentAnimal.ResidentAnimalId
LEFT JOIN Medication
ON Medication.MedicationId = ResidentMedication.MedicationId
WHERE
ResidentMedication.MedicationActive = 'Yes'
and ResidentAnimal.AdoptionStatus = 'Needs Home';


CREATE VIEW [Branch Capacity] AS
SELECT
Branch.BranchID
,Branch.BranchName
,Branch.BranchCapacity as "BranchCapacityLimit"
,COUNT(DISTINCT ResidentAnimal.ResidentAnimalId) AS "CurrentCapacity"
FROM Branch
LEFT JOIN ResidentAnimal
ON Branch.BranchID = ResidentAnimal.BranchID
WHERE
ResidentAnimal.AdoptionStatus = 'Needs Home'
GROUP BY Branch.BranchID, Branch.BranchName, Branch.BranchCapacity;
