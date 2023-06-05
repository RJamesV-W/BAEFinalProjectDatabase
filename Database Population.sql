LOAD DATA INFILE '/path/to/citizen.csv'
INTO TABLE CITIZEN
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(	citizenId, 
	forenames, 
    surname, 
    address, 
    dateOfBirth, 
    placeOfBirth, 
    sex);

LOAD DATA INFILE '/path/to/vehicles.csv'
INTO TABLE CITIZEN
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(   vehicleRegistrationNo,
    make,
    model,
    colour);

LOAD DATA INFILE '/path/to/anprcamera.csv'
INTO TABLE CITIZEN
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(   anprId,
    streetName,
    latitude,
    longitude);

LOAD DATA INFILE '/path/to/epos.csv'
INTO TABLE CITIZEN
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(citizenId, forenames, surname, address, dateOfBirth, placeOfBirth, sex);

LOAD DATA INFILE '/path/to/atmpoint.csv'
INTO TABLE CITIZEN
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(citizenId, forenames, surname, address, dateOfBirth, placeOfBirth, sex);