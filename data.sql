/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon', 'Feb 3, 2020', 0, true, 10.23 );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Gabumon', 'November 15, 2018', 2, true, 8 );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Pikachu', 'January 17, 2021', 1, false, 15.04 );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Devimon', 'May 12, 2017', 5, true, 11 );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Charmander', 'February 8, 2020', 0, false, -11 );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Plantmon', 'November 15, 2022', 2, true, -5.7 );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Squirtle', 'April 2, 1993', 3, false, -12.13 );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Angemon', 'June 12, 2005', 1, true, -45 );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Boarmon', 'June 7, 2005', 7, true, 20.4 );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Blossom', 'October 13, 1998', 3, true, 17 );

/*Insert the following data into the owners table*/
INSERT INTO owners(full_name, age)
VALUES('Sam Smith', 34),('Jennifer Orwell', 19),
('Bob', 45),('Melody Pond', 77),('Dean Winchester', 14),
('Jodie Whittaker', 38);

/*Insert the following data into the species table*/
INSERT INTO species(name) 
VALUES('Pokemon'),('Digimon');

/*If the name ends in "mon" it will be Digimon*/
UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

/*All other animals are Pokemon*/
UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;

/*Modify your inserted animals to include owner information (owner_id)*/
UPDATE animals
SET owner_id = 1
WHERE name LIKE 'Agumon';

UPDATE animals
SET owner_id = 2
WHERE name LIKE 'Pikachu' OR name LIKE 'Gabumon';

UPDATE animals
SET owner_id = 3
WHERE name LIKE 'Plantmon' OR name LIKE 'Devimon';

UPDATE animals
SET owner_id = 4
WHERE name LIKE 'Charmander' OR name LIKE 'Squirtle' OR name LIKE 'Blossom';

UPDATE animals
SET owner_id = 5
WHERE name LIKE 'Angemon' OR name LIkE 'Boarmon';


