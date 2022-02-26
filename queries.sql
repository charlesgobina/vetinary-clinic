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

/*Who was the last animal seen by William Tatcher*/
SELECT animals.name, visits.visit_date
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name LIKE 'Vet William Tatcher'
ORDER BY visit_date DESC 
LIMIT 1;

/*How many different animals did Stephanie Mendez see*/
SELECT animals.name, COUNT(animals.name)
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name LIKE 'Vet Stephanie Mendez'
GROUP BY animals.name

/*List all vets and their specialties, including vets with no specialties*/
SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations Spec ON Spec.vets_id = vets.id
LEFT JOIN species ON species.id = Spec.species_id

/*List all animals that visited Stephanie Mendez between April 1st and August 30th*/
SELECT animals.name, visits.visit_date
FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name LIKE 'Vet Stephanie Mendez' AND
(visit_date BETWEEN 'April 1, 2020' AND 'August 30, 2020');

/*What animal has the most visits to vets*/
SELECT animals.name, COUNT(visits.visit_date) AS number_of_visits
FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vets_id
GROUP BY animals.name
ORDER BY number_of_visits DESC
LIMIT 1;

/*Who was Maisy Smith's first visit*/
SELECT animals.name, visits.visit_date
FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name LIKE 'Vet Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

/*Most recent visit*/
SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date
FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vets_id
ORDER BY visits.visit_date DESC
LIMIT 1;

/*How many visits were with a vet that did not specialize in that animal's species*/
SELECT vets.name, COUNT(visits.id)
FROM visits
JOIN vets ON visits.vets_id = vets.id
JOIN animals ON visits.animals_id = animals.id
WHERE vets.id = 2
GROUP BY vets.name

/*What specialty should Maisy Smith consider getting*/
SELECT species.name, COUNT(visits.id)
FROM visits
JOIN vets ON visits.vets_id = vets.id
JOIN animals ON visits.animals_id = animals.id
JOIN species ON species.id = animals.species_id
WHERE vets.id = 2
GROUP BY species.name

