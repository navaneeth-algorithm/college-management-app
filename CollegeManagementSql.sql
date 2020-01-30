--create Database college Management
CREATE DATABASE CollegeManagement;

--drop Database collegeManagement
/*
DROP DATABASE CollegeManagement;

*/
--BACKUP DATABASE with file path in command prompt
/*
For More:
https://www.linode.com/docs/databases/mysql/use-mysqldump-to-back-up-mysql-or-mariadb/
*/
--mysqldump -u root -p  CollegeManagement > CollegeManagement-$(date +%F).sql





/*
create table using other TABLE

CREATE TABLE new_table_name AS
    SELECT Column1,Column2...
    FROM existing_table_name
    WHERE .....;

*/

--drop Table Country
/*
Drop Entire Table

DROP TABLE Country;

*/

--Truncate Table Country
/*
Truncate use to delete Data inside table

TRUNCATE TABLE Country;
*/


/*

INDEPENDENT TABLES

*/

--create Table Country
CREATE TABLE Country (
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);


--Table User Type
CREATE TABLE UserTypes(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ActiveStatus INT,
);

--Table Sem
CREATE TABLE Sems(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ActiveStatus INT
);

--Table Days
CREATE TABLE Day(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ActiveStatus INT
);

--Table Months
CREATE TABLE Months(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ActiveStatus INT
);

--Table Marks
CREATE TABLE MarkTypes(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    AllocatedTotalMarks INT,
    ActiveStatus INT
);

CREATE TABLE Designations(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ActiveStatus INT
);

CREATE TABLE Subjects(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ActiveStatus INT
);



CREATE TABLE Departments(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ActiveStatus INT
);

CREATE TABLE AllowedExtensions(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);


CREATE TABLE NoticeTypes(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ActiveStatus INT
);


CREATE TABLE NotesTypes(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ActiveStatus INT
);


CREATE TABLE MessageTypes(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ActiveStatus INT
);


/*
DEPENDENT TABLES
*/

CREATE TABLE States(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    CountryId INT FOREIGN KEY REFERENCES Country(Id)
);

CREATE TABLE HolidayLists(
    Id INT PRIMARY KEY,
    HolidayDate VARCHAR(255) NOT NULL,
    DaysId INT FOREIGN KEY REFERENCES Day(Id),
    MonthId INT FOREIGN KEY REFERENCES Months(Id),
    HolidayReason VARCHAR(255),
    ActiveStatus INT
);

CREATE TABLE Districts(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    StateId INT FOREIGN KEY REFERENCES States(Id)
);


CREATE TABLE PinCodes(
    Id INT PRIMARY KEY,
    PinCodeNumber VARCHAR(255) NOT NULL,
    DistrictId INT FOREIGN KEY REFERENCES Districts(Id),
    StateId INT FOREIGN KEY REFERENCES States(Id) 
);

CREATE TABLE Addresses(
    Id INT PRIMARY KEY,
    Address1 VARCHAR(255),
    Address2 VARCHAR(255),
    Address3 VARCHAR(255),
    DistrictId INT FOREIGN KEY REFERENCES Districts(Id),
    StateId INT FOREIGN KEY REFERENCES States(Id),
    CountryId INT FOREIGN KEY REFERENCES Country(Id)
);

CREATE TABLE Colleges(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    WebsiteLink VARCHAR(255), 
    ContactNumber VARCHAR(255),
    CollegeTimings VARCHAR(255),
    About TEXT,
    AddressId INT FOREIGN KEY REFERENCES Addresses(Id),
    ActiveStatus INT
);

CREATE TABLE Users(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    UserTypeId INT FOREIGN KEY REFERENCES UserTypes(Id),
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id),
    ContactNumber VARCHAR(255),
    AddressId INT FOREIGN KEY REFERENCES Addresses(Id),
    ActiveStatus INT
);

CREATE TABLE SubjectSemDepartmentMap(
    Id INT PRIMARY KEY,
    SubjectId INT FOREIGN KEY REFERENCES Subjects(Id),
    SemId INT FOREIGN KEY REFERENCES Sems(Id),
    DepartmentId INT FOREIGN KEY REFERENCES Departments(Id)
);


CREATE TABLE Students(
    Id INT PRIMARY KEY,
    UserId INT FOREIGN KEY REFERENCES Users(Id),
    StudentCollegeId VARCHAR(255) UNIQUE NOT NULL,
    SemId INT FOREIGN KEY REFERENCES Sems(Id),
    DepartmentId INT FOREIGN KEY REFERENCES Departments(Id)
);

CREATE TABLE Faculties(
    Id INT PRIMARY KEY,
    UserId INT FOREIGN KEY REFERENCES Users(Id),
    FacultyCollegeId VARCHAR(255) UNIQUE NOT NULL,
    DesignationId INT FOREIGN KEY REFERENCES Designations(Id),
    DepartmentId INT FOREIGN KEY REFERENCES Departments(Id),
);

CREATE TABLE FacultiesSubjectMap(
    Id INT PRIMARY KEY,
    FacultyId INT FOREIGN KEY REFERENCES Faculties(Id),
    SubjectId INT FOREIGN KEY REFERENCES Subjects(Id)
);

CREATE TABLE TimeTableTypes(
    Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL, 
);

CREATE TABLE TimeTables(
    Id INT PRIMARY KEY,
    Description TEXT,
    DayId INT FOREIGN KEY REFERENCES Day(Id),
    SemId INT FOREIGN KEY REFERENCES Sems(Id),
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id),
    DepartmentId INT FOREIGN KEY REFERENCES Departments(Id),
    StartTime VARCHAR(255),
    EndTime VARCHAR(255),
    TimeTableTypeId INT FOREIGN KEY REFERENCES TimeTableTypes(Id),
);

CREATE TABLE TimeTableFacultiesMap(
    Id INT PRIMARY KEY,
    TimeTableId INT FOREIGN KEY REFERENCES TimeTables(Id),
    FacultySubjectMapId INT FOREIGN KEY REFERENCES FacultiesSubjectMap(Id),
    TimeTableDate VARCHAR(255),
    TimeTableTime VARCHAR(255),
);


CREATE TABLE Attendence(
    Id INT PRIMARY KEY,
    UserId INT FOREIGN KEY REFERENCES Users(Id),
    TimeTableId INT FOREIGN KEY REFERENCES TimeTables(Id),
    AttendenceDate VARCHAR(255),
    PresentAbsenceFlag INT DEFAULT 1,
    TimeTableFacultyMapId INT FOREIGN KEY REFERENCES TimeTableFacultiesMap(Id),
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id),    
);

CREATE TABLE SubjectMarks(
    Id INT PRIMARY KEY,
    FacultySubjectMapId INT FOREIGN KEY REFERENCES FacultiesSubjectMap(Id),
    MarkTypeId INT FOREIGN KEY REFERENCES MarksType(Id),
    StudentId INT FOREIGN KEY REFERENCES Students(Id),
    MarkSecured INT,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);

CREATE TABLE NotesAllowedExtensionsMap(
    Id INT PRIMARY KEY,
    NoteTypeId INT FOREIGN KEY REFERENCES NotesType(Id),
    AllowedExtensionId INT FOREIGN KEY REFERENCES AllowedExtensions(Id) 
);

CREATE TABLE Notes(
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
    Description VARCHAR(255),
    Links VARCHAR(255),
    SubjectSemDepartmentId INT FOREIGN KEY REFERENCES SubjectSemDepartmentMap(Id),
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id),
    ActiveStatus INT
);

CREATE TABLE NoticeVisibilites(
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
);

CREATE TABLE Notices(
    Id INT PRIMARY KEY,
    HEAD VARCHAR(255) NOT NULL,
    Description VARCHAR(255) NOT NULL,
    NoticeTypeId INT FOREIGN KEY REFERENCES NoticeTypes(Id),
    NoticeDate VARCHAR(255) NOT NULL,
    NoticeTime VARCHAR(255) NOT NULL,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id),
    ActiveStatus INT
);

CREATE TABLE MessageTypes(
    Id INT PRIMARY KEY,
    Name VARCHAR(255),
);

CREATE TABLE Messages(
    Id INT PRIMARY KEY,
    MessageDescription TEXT,
    MessageFromUserId INT FOREIGN KEY REFERENCES Users(Id),
    MessageToUserId INT FOREIGN KEY REFERENCES Users(Id),
    MessageDate VARCHAR(255) NOT NULL,
    MessageTime VARCHAR(255),
    MessageTypeId INT FOREIGN KEY REFERENCES MessageTypes(Id),
    ActiveStatus INT
);


/*
College Mapping Table
*/

CREATE TABLE UserTypesCollegeMap(
    Id INT PRIMARY KEY,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);

CREATE TABLE DesignationsCollegeMap(
    Id INT PRIMARY KEY,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);

CREATE TABLE SemsCollegeMap(
    Id INT PRIMARY KEY,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);

CREATE TABLE DepartmentsCollegeMap(
    Id INT PRIMARY KEY,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);

CREATE TABLE SubjectsCollegeMap(
    Id INT PRIMARY KEY,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);

CREATE TABLE SubjectSemDepartmentCollegeMap(
    Id INT PRIMARY KEY,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);

CREATE TABLE HolidayListsCollegeMap(
    Id INT PRIMARY KEY,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);

CREATE TABLE MarkTypesCollegeMap(
    Id INT PRIMARY KEY,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);

CREATE TABLE AllowedExtensionsCollegeMap(
    Id INT PRIMARY KEY,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);

CREATE TABLE NotesTypesCollegeMap(
    Id INT PRIMARY KEY,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);

CREATE TABLE NoticeTypesCollegeMap(
    Id INT PRIMARY KEY,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);

CREATE TABLE MessageTypesCollegeMap(
    Id INT PRIMARY KEY,
    CollegeId INT FOREIGN KEY REFERENCES Colleges(Id)
);