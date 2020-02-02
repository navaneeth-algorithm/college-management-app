
/*
--BACKUP DATABASE with file path in command prompt
--mysqldump -u root -p  CollegeManagement > CollegeManagement-$(date +%F).sql
For More:
https://www.linode.com/docs/databases/mysql/use-mysqldump-to-back-up-mysql-or-mariadb/
*/

CREATE TABLE Country
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL
);


CREATE TABLE UserTypes
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   ActiveStatus INT
);


CREATE TABLE Sems
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   ActiveStatus INT
);

CREATE TABLE Day
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   ActiveStatus INT
);


CREATE TABLE Months
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   ActiveStatus INT
);

CREATE TABLE MarkTypes
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   AllocatedTotalMarks INT,
   ActiveStatus INT
);

CREATE TABLE Designations
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   ActiveStatus INT
);

CREATE TABLE Subjects
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   ActiveStatus INT
);



CREATE TABLE Departments
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   ActiveStatus INT
);

CREATE TABLE AllowedExtensions
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL
);


CREATE TABLE NoticeTypes
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   ActiveStatus INT
);


CREATE TABLE NotesTypes
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   ActiveStatus INT
);


CREATE TABLE MessageTypes
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   ActiveStatus INT
);


/*
DEPENDENT TABLES
*/

CREATE TABLE States
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   CountryId INT,
   FOREIGN KEY(CountryId) REFERENCES Country(Id)
);

CREATE TABLE HolidayLists
(
   Id INT PRIMARY KEY,
   HolidayDate VARCHAR(255) NOT NULL,
   DaysId INT,
   FOREIGN KEY(DaysId) REFERENCES Day(Id),
   MonthId INT,
   FOREIGN KEY(MonthId) REFERENCES Months(Id),
   HolidayReason VARCHAR(255),
   ActiveStatus INT
);

CREATE TABLE Districts
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   StateId INT,
   FOREIGN KEY(StateId) REFERENCES States(Id)
);


CREATE TABLE PinCodes
(
   Id INT PRIMARY KEY,
   PinCodeNumber VARCHAR(255) NOT NULL,
   DistrictId INT,
   FOREIGN KEY(DistrictId) REFERENCES Districts(Id),
   StateId INT,
   FOREIGN KEY(StateId) REFERENCES States(Id)
);

CREATE TABLE Addresses
(
   Id INT PRIMARY KEY,
   Address1 VARCHAR(255),
   Address2 VARCHAR(255),
   Address3 VARCHAR(255),
   DistrictId INT,
   FOREIGN KEY(DistrictId) REFERENCES Districts(Id),
   StateId INT,
   FOREIGN KEY(StateId) REFERENCES States(Id),
   CountryId INT,
   FOREIGN KEY(CountryId) REFERENCES Country(Id)
);

CREATE TABLE Colleges
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   Email VARCHAR(255) UNIQUE,
   WebsiteLink VARCHAR(255),
   ContactNumber VARCHAR(255),
   CollegeTimings VARCHAR(255),
   About TEXT,
   AddressId INT,
   FOREIGN KEY(AddressId) REFERENCES Addresses(Id),
   ActiveStatus INT
);

CREATE TABLE Users
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL,
   Email VARCHAR(255) UNIQUE,
   UserTypeId INT,
   FOREIGN KEY(UserTypeId) REFERENCES UserTypes(Id),
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id),
   ContactNumber VARCHAR(255),
   AddressId INT,
   FOREIGN KEY(AddressId) REFERENCES Addresses(Id),
   ActiveStatus INT
);

CREATE TABLE SubjectSemDepartmentMap
(
   Id INT PRIMARY KEY,
   SubjectId INT,
   FOREIGN KEY(SubjectId) REFERENCES Subjects(Id),
   SemId INT,
   FOREIGN KEY(SemId) REFERENCES Sems(Id),
   DepartmentId INT,
   FOREIGN KEY(DepartmentId) REFERENCES Departments(Id)
);


CREATE TABLE Students
(
   Id INT PRIMARY KEY,
   UserId INT,
   FOREIGN KEY(UserId) REFERENCES Users(Id),
   StudentCollegeId VARCHAR(255) UNIQUE NOT NULL,
   SemId INT,
   FOREIGN KEY(SemId) REFERENCES Sems(Id),
   DepartmentId INT,
   FOREIGN KEY(DepartmentId) REFERENCES Departments(Id)
);

CREATE TABLE Faculties
(
   Id INT PRIMARY KEY,
   UserId INT,
   FOREIGN KEY(UserId) REFERENCES Users(Id),
   FacultyCollegeId VARCHAR(255) UNIQUE NOT NULL,
   DesignationId INT,
   FOREIGN KEY(DesignationId) REFERENCES Designations(Id),
   DepartmentId INT,
   FOREIGN KEY(DepartmentId) REFERENCES Departments(Id)
);

CREATE TABLE FacultiesSubjectMap
(
   Id INT PRIMARY KEY,
   FacultyId INT,
   FOREIGN KEY(FacultyId) REFERENCES Faculties(Id),
   SubjectId INT,
   FOREIGN KEY(SubjectId) REFERENCES Subjects(Id)
);

CREATE TABLE TimeTableTypes
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255) NOT NULL
);

CREATE TABLE TimeTables
(
   Id INT PRIMARY KEY,
   Description TEXT,
   DayId INT,
   FOREIGN KEY(DayId) REFERENCES Day(Id),
   SemId INT,
   FOREIGN KEY(SemId) REFERENCES Sems(Id),
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id),
   DepartmentId INT,
   FOREIGN KEY(DepartmentId) REFERENCES Departments(Id),
   StartTime VARCHAR(255),
   EndTime VARCHAR(255),
   TimeTableTypeId INT,
   FOREIGN KEY(TimeTableTypeId) REFERENCES TimeTableTypes(Id)
);

CREATE TABLE TimeTableFacultiesMap
(
   Id INT PRIMARY KEY,
   TimeTableId INT,
   FOREIGN KEY(TimeTableId) REFERENCES TimeTables(Id),
   FacultySubjectMapId INT,
   FOREIGN KEY(FacultySubjectMapId) REFERENCES FacultiesSubjectMap(Id),
   TimeTableDate VARCHAR(255),
   TimeTableTime VARCHAR(255)
);


CREATE TABLE Attendence
(
   Id INT PRIMARY KEY,
   UserId INT,
   FOREIGN KEY(UserId) REFERENCES Users(Id),
   TimeTableId INT,
   FOREIGN KEY(TimeTableId) REFERENCES TimeTables(Id),
   AttendenceDate VARCHAR(255),
   PresentAbsenceFlag INT DEFAULT 1,
   TimeTableFacultyMapId INT,
   FOREIGN KEY(TimeTableFacultyMapId) REFERENCES TimeTableFacultiesMap(Id),
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE SubjectMarks
(
   Id INT PRIMARY KEY,
   FacultySubjectMapId INT,
   FOREIGN KEY(FacultySubjectMapId) REFERENCES FacultiesSubjectMap(Id),
   MarkTypeId INT,
   FOREIGN KEY(MarkTypeId) REFERENCES MarkTypes(Id),
   StudentId INT,
   FOREIGN KEY(StudentId) REFERENCES Students(Id),
   MarkSecured INT,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE NotesAllowedExtensionsMap
(
   Id INT PRIMARY KEY,
   NoteTypeId INT,
   FOREIGN KEY(NoteTypeId) REFERENCES NotesTypes(Id),
   AllowedExtensionId INT,
   FOREIGN KEY(AllowedExtensionId) REFERENCES AllowedExtensions(Id)
);

CREATE TABLE Notes
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255),
   Description VARCHAR(255),
   Links VARCHAR(255),
   SubjectSemDepartmentId INT,
   FOREIGN KEY(SubjectSemDepartmentId) REFERENCES SubjectSemDepartmentMap(Id),
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id),
   ActiveStatus INT
);

CREATE TABLE NoticeVisibilites
(
   Id INT PRIMARY KEY,
   Name VARCHAR(255)
);

CREATE TABLE Notices
(
   Id INT PRIMARY KEY,
   HEAD VARCHAR(255) NOT NULL,
   Description VARCHAR(255) NOT NULL,
   NoticeTypeId INT,
   FOREIGN KEY(NoticeTypeId) REFERENCES NoticeTypes(Id),
   NoticeDate VARCHAR(255) NOT NULL,
   NoticeTime VARCHAR(255) NOT NULL,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id),
   ActiveStatus INT
);

CREATE TABLE Messages
(
   Id INT PRIMARY KEY,
   MessageDescription TEXT,
   MessageFromUserId INT,
   FOREIGN KEY(MessageFromUserId) REFERENCES Users(Id),
   MessageToUserId INT,
   FOREIGN KEY(MessageToUserId) REFERENCES Users(Id),
   MessageDate VARCHAR(255) NOT NULL,
   MessageTime VARCHAR(255),
   MessageTypeId INT,
   FOREIGN KEY(MessageTypeId) REFERENCES MessageTypes(Id),
   ActiveStatus INT
);


/*
College Mapping Table
*/

CREATE TABLE UserTypesCollegeMap
(
   Id INT PRIMARY KEY,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE DesignationsCollegeMap
(
   Id INT PRIMARY KEY,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE SemsCollegeMap
(
   Id INT PRIMARY KEY,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE DepartmentsCollegeMap
(
   Id INT PRIMARY KEY,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE SubjectsCollegeMap
(
   Id INT PRIMARY KEY,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE SubjectSemDepartmentCollegeMap
(
   Id INT PRIMARY KEY,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE HolidayListsCollegeMap
(
   Id INT PRIMARY KEY,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE MarkTypesCollegeMap
(
   Id INT PRIMARY KEY,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE AllowedExtensionsCollegeMap
(
   Id INT PRIMARY KEY,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE NotesTypesCollegeMap
(
   Id INT PRIMARY KEY,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE NoticeTypesCollegeMap
(
   Id INT PRIMARY KEY,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);

CREATE TABLE MessageTypesCollegeMap
(
   Id INT PRIMARY KEY,
   CollegeId INT,
   FOREIGN KEY(CollegeId) REFERENCES Colleges(Id)
);
