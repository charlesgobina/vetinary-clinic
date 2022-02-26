/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * 
FROM animals
WHERE name LIKE '%mon';


-- List the name of all animals born between 2016 and 2019.
SELECT name 
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';


-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name 
FROM animals
WHERE (neutered IS true) AND (escape_attempts < 3); 


-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth 
FROM animals
WHERE (name LIKE 'Agumon') OR (name LIKE 'Pikachu'); 


-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts 
FROM animals
WHERE weight_kg > 10.5;


-- Find all animals that are neutered.
SELECT * 
FROM animals
WHERE neutered IS true;


-- Find all animals not named Gabumon.
SELECT * 
FROM animals
WHERE name NOT LIKE 'Gabumon';


-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * 
FROM animals
WHERE weight_kg >= 10.4 AND weight_kg <= 17.3; 


-- Inside a transaction update the animals table by setting the 
-- species column to unspecified. Verify that change was made. 
-- Then roll back the change and verify that species columns
--  went back to the state before transaction.
BEGIN; -- start transaction
UPDATE animals
SET species = 'unspecified'; -- make change
SELECT species from animals; -- verify that change was done
ROLLBACK;
SELECT species from animals; -- verify that change was undone


-- Update the animals table by setting the species column to 
-- digimon for all animals that have a name ending in mon.
BEGIN; -- start transaction
UPDATE animals
SET species = 'digmon' -- make change
WHERE name LIKE '%mon';
SELECT species from animals; -- verify that change was done


-- Update the animals table by setting the species column to
-- pokemon for all animals that don't have species already set.
BEGIN; -- start transaction
UPDATE animals
SET species = 'pokemon' -- make change
WHERE species IS NULL
SELECT species from animals; -- verify that change was done
COMMIT;
SELECT species from animals; -- verify that change remains


-- Now, take a deep breath and... Inside a transaction delete
-- all records in the animals table, then roll back the transaction.
BEGIN; -- start transaction
DELETE FROM animals -- make change(deletion)
SELECT * from animals; -- verify that change was done
ROLLBACK;
SELECT * from animals; -- verify that change was undone

-- Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals
WHERE date_of_birth > 'January 1, 2022';


-- Create a savepoint for the transaction.
SAVEPOINT birth_day_after_jan_1


-- Update all animals' weight to be their weight multiplied by -1.
BEGIN;
UPDATE animals
SET weight_kg = weight_kg * -1


-- Rollback to the savepoint
ROLLBACK TO SAVEPOINT birth_day_after_jan_1
SELECT * from animals; -- verify that changes were restored to savepoint



-- Update all animals' weights that are negative 
-- to be their weight multiplied by -1.
BEGIN;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
SELECT * from animals; -- verify that change was done
COMMIT;
SELECT * from animals; -- verify that changes remain after commit


-- How many animals are there?
SELECT COUNT(*) 
FROM animals;


-- How many animals have never tried to escape?
SELECT COUNT(*) 
FROM animals
WHERE escape_attempts = 0;


-- What is the average weight of animals?
SELECT AVG(weight_kg) 
FROM animals


-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) 
FROM animals
GROUP BY neutered;


-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) 
FROM animals
GROUP BY species;


-- What is the average number of escape attempts per 
-- animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) 
FROM animals
WHERE date_of_birth BETWEEN 'January 1, 1990' AND 'December 31, 2000'
GROUP BY species;

/*What animals belong to Melody Pond?*/
SELECT animals.name, owners.full_name
FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name LIKE 'Melody Pond';

/*Animals that are pokemon*/
SELECT animals.name, species.name AS species_name
FROM animals
JOIN species ON species.id = animals.species_id
WHERE species.name LIKE 'Pokemon';

/*Owners and their aniamls*/
SELECT animals.name, owners.full_name AS owner_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id

/*Number of animals per specie*/
SELECT species.name, COUNT(animals.name) AS animal_per_specie 
FROM animals
JOIN species ON species.id = animals.species_id
GROUP BY species.name

/*List all Digimon owned by Jennifer Orwell*/
SELECT animals.* FROM animals
LEFT JOIN owners ON animals.owner_id = owners.id
LEFT JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell'
AND species.name = 'Digimon';

/*List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT animals.name, owners.full_name
FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name LIKE 'Dean Winchester'
AND animals.escape_attempts = 0;

/*Who owns the most animals?*/
SELECT owners.full_name, COUNT(animals.name) AS total_animals
FROM animals
RIGHT JOIN owners ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY total_animals DESC LIMIT 1;