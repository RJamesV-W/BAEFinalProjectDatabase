LOAD DATA INFILE '/path/to/citizen.csv'
INTO TABLE CITIZEN
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(citizenId, forename, surname, homeAddress, dateOfBirth, placeOfBirth);

