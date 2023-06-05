-- Create database
-- DROP DATABASE IF EXISTS DataSet; -- This will drop the database if needed. Only use during production, don't use in deployment.
CREATE DATABASE IF NOT EXISTS DataSet;
USE DataSet;

-- Primary Tables
-- Citizen
CREATE TABLE IF NOT EXISTS CITIZEN (
    citizenId VARCHAR(255) NOT NULL,
    forenames VARCHAR(255),
    surname VARCHAR(255),
    address VARCHAR(255),
    dateOfBirth DATE,
    placeOfBirth VARCHAR(255),
    sex VARCHAR(255),
    PRIMARY KEY (forenames, surname, address, dateOfBirth)
);

-- Vehicles
CREATE TABLE IF NOT EXISTS VEHICLES (
    vehicleRegistrationNo VARCHAR(255) NOT NULL,
    make VARCHAR(255),
    model VARCHAR(255),
    colour VARCHAR(255),
    PRIMARY KEY (vehicleRegistrationNo)
);

-- ANPR Camera
CREATE TABLE IF NOT EXISTS ANPR_CAMERA (
    anprId VARCHAR(255) NOT NULL,
    streetName VARCHAR(255),
    latitude DECIMAL(16, 13),
    longitude DECIMAL(17, 13),
    PRIMARY KEY (anprId)
);

-- EPOS Terminals
CREATE TABLE IF NOT EXISTS EPOS_TERMINALS (
    id VARCHAR(255) NOT NULL,
    vendor VARCHAR(255),
    streetName VARCHAR(255),
    postcode VARCHAR(255),
    latitude DECIMAL(16, 13),
    longitude DECIMAL(17, 13),
    PRIMARY KEY (id)
);

-- ATM Point
CREATE TABLE IF NOT EXISTS ATM_POINT (
    atmId VARCHAR(255) NOT NULL,
    operator VARCHAR(255),
    streetName VARCHAR(255),
    postcode VARCHAR(255),
    latitude DECIMAL(16, 13),
    longitude DECIMAL(17, 13),
    PRIMARY KEY (atmId)
);

-- Tables for Vehicle Information
-- Vehicle Registration
CREATE TABLE IF NOT EXISTS VEHICLE_REGISTRATIONS (
    registrationId VARCHAR(255) NOT NULL,
    registrationDate DATE,
    vehicleRegistrationNo VARCHAR(255),
    make VARCHAR(255),
    model VARCHAR(255),
    colour VARCHAR(255),
    forenames VARCHAR(255),
    surname VARCHAR(255),
    address VARCHAR(255),
    dateOfBirth DATE,
    driverLicenseID VARCHAR(255),
    PRIMARY KEY (registrationId),
    FOREIGN KEY (forenames, surname, address, dateOfBirth) REFERENCES CITIZEN(forenames, surname, address, dateOfBirth),
    FOREIGN KEY (vehicleRegistrationNo) REFERENCES VEHICLES(vehicleRegistrationNo)
);

-- ANPR Observations
CREATE TABLE IF NOT EXISTS ANPR_OBSERVATIONS (
    ANPRPointId VARCHAR(255) NOT NULL,
    event_time DATETIME(3) NOT NULL,
    vehicleRegistrationNo VARCHAR(255),
    FOREIGN KEY (vehicleRegistrationNo) REFERENCES VEHICLES(vehicleRegistrationNo),
    FOREIGN KEY (ANPRPointId) REFERENCES ANPR_CAMERA(anprId)
);

-- Tables for Mobile Call Records
-- Subscriber Records
CREATE TABLE IF NOT EXISTS SUBSCRIBER_RECORDS (
    forenames VARCHAR(255),
    surname VARCHAR(255),
    dateOfBirth DATE,
    address VARCHAR(255),
    phoneNumber VARCHAR(255),
    network VARCHAR(255),
    PRIMARY KEY (phoneNumber),
    FOREIGN KEY (forenames, surname, address, dateOfBirth) REFERENCES CITIZEN(forenames, surname, address, dateOfBirth)
);

-- Cell Towers
CREATE TABLE IF NOT EXISTS CELL_TOWERS (
    cellTowerId VARCHAR(255) NOT NULL,
    operator VARCHAR(255),
    tower_type VARCHAR(255),
    latitude DECIMAL(16, 13),
    longitude DECIMAL(17, 13),
    PRIMARY KEY (cellTowerId)
);

-- Mobile Calls Records
CREATE TABLE IF NOT EXISTS MOBILE_CALL_RECORDS (
    event_time DATETIME(3) NOT NULL,
    callerMSISDN VARCHAR(255),
    callCellTowerId VARCHAR(255),
    receiverMSISDN VARCHAR(255),
    receiverTowerId VARCHAR(255),
    FOREIGN KEY (receiverMSISDN) REFERENCES SUBSCRIBER_RECORDS(phoneNumber),
    FOREIGN KEY (callCellTowerId) REFERENCES CELL_TOWERS(cellTowerId)
);

-- Tables for Financial Transactions
-- Bank Account Holders
CREATE TABLE IF NOT EXISTS BANK_ACCOUNT_HOLDERS (
    bankAccountId VARCHAR(255) NOT NULL,
    accountNumber VARCHAR(255),
    bank VARCHAR(255),
    forenames VARCHAR(255),
    surname VARCHAR(255),
    dateOfBirth DATE,
    address VARCHAR(255),
    PRIMARY KEY (bankAccountId, accountNumber),
    FOREIGN KEY (forenames, surname, address, dateOfBirth) REFERENCES CITIZEN(forenames, surname, address, dateOfBirth)
);

-- Bank Cards
CREATE TABLE IF NOT EXISTS BANK_CARDS (
    bankcardId VARCHAR(255) NOT NULL,
    cardNumber VARCHAR(255),
    sortCode VARCHAR(255),
    bankAccountId VARCHAR(255),
    accountNumber VARCHAR(255),
    bank VARCHAR(255),
    PRIMARY KEY (cardNumber),
    FOREIGN KEY (bankAccountId, accountNumber) REFERENCES BANK_ACCOUNT_HOLDERS(bankAccountId, accountNumber)
);

-- ATM Transactions
CREATE TABLE IF NOT EXISTS ATM_TRANSACTIONS (
    event_time DATETIME(3) NOT NULL,
    atmId VARCHAR(255),
    bankCardNumber VARCHAR(255),
    transaction_type VARCHAR(255),
    amount DECIMAL(10, 2),
    FOREIGN KEY (atmId) REFERENCES ATM_POINT(atmId),
    FOREIGN KEY (bankCardNumber) REFERENCES BANK_CARDS(cardNumber)
);

-- EPOS Transactions
CREATE TABLE IF NOT EXISTS EPOS_TRANSACTIONS (
    event_time DATETIME(3) NOT NULL,
    eposId VARCHAR(255),
    bankCardNumber VARCHAR(255),
    payeeAccount VARCHAR(255),
    amount DECIMAL(10, 2),
    PRIMARY KEY (eposId),
    FOREIGN KEY (bankCardNumber) REFERENCES BANK_CARDS(cardNumber),
    FOREIGN KEY (payeeAccount) REFERENCES BANK_ACCOUNT_HOLDERS(bankAccountId),
    FOREIGN KEY (eposId) REFERENCES EPOS_TERMINALS(id)
);


