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

/*Inserting data to vets*/
INSERT INTO vets(name, age, date_of_graduation) 
VALUES('Vet William Tatcher', 45, 'April 23, 2000'),
('Vet Maisy Smith', 26, 'January 17, 2019'),
('Vet Stephanie Mendez', 64, 'May 4, 1981'),
('Vet Jack Harkness', 38, 'June 8, 2008');

/*Insert into specialisation*/
INSERT INTO specializations(vets_id, species_id) 
VALUES
(
	(
		SELECT id 
		FROM vets
		WHERE name LIKE 'Vet William Tatcher'
	),
	(
		SELECT id 
		FROM species
		WHERE name LIKE 'Pokemon'
	)
),
(
	(
		SELECT id 
		FROM vets
		WHERE name LIKE 'Vet Stephanie Mendez'
	),
	(
		SELECT id 
		FROM species
		WHERE name LIKE 'Pokemon'
	)
),
(
	(
		SELECT id 
		FROM vets
		WHERE name LIKE 'Vet Stephanie Mendez'
	),
	(
		SELECT id 
		FROM species
		WHERE name LIKE 'Digimon'
	)
),
(
	(
		SELECT id 
		FROM vets
		WHERE name LIKE 'Vet Jack Harkness'
	),
	(
		SELECT id 
		FROM species
		WHERE name LIKE 'Digimon'
	)
);

/*Insert into visits*/
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES 
(
    (SELECT id FROM animals WHERE name LIKE 'Agumon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet William Tatcher'),
    ('May 24, 2020')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Agumon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Stephanie Mendez'),
    ('Jul 22, 2020')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Gabumon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Jack Harkness'),
    ('Feb 2, 2021')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Pikachu'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Maisy Smith'),
    ('Jan 5, 2020')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Pikachu'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Maisy Smith'),
    ('March 8, 2020')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Pikachu'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Maisy Smith'),
    ('May 14, 2020')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Devimon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Stephanie Mendez'),
    ('May 4, 2021')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Charmander'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Jack Harkness'),
    ('Feb 24, 2021')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Plantmon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Maisy Smith'),
    ('Dec 21, 2019')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Plantmon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet William Tatcher'),
    ('Aug 10, 2020')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Plantmon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Maisy Smith'),
    ('Apr 7, 2021')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Squirtle'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Stephanie Mendez'),
    ('Sep 29, 2019')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Angemon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Jack Harkness'),
    ('Oct 3, 2020')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Angemon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Jack Harkness'),
    ('Nov 4, 2020')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Boarmon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Maisy Smith'),
    ('Jan 24, 2019')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Boarmon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Maisy Smith'),
    ('May 15, 2019')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Boarmon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Maisy Smith'),
    ('Feb 27, 2020')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Boarmon'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Maisy Smith'),
    ('Aug 3, 2020')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Blossom'),
    (SELECT id FROM vets WHERE name LIKE 'Vet Stephanie Mendez'),
    ('May 24, 2020')
),
(
    (SELECT id FROM animals WHERE name LIKE 'Blossom'),
    (SELECT id FROM vets WHERE name LIKE 'Vet William Tatcher'),
    ('Jan 11, 2021')
);

INSERT INTO owners (full_name, email) 
SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

INSERT INTO visits (animals_id, vets_id, visit_date) 
SELECT * FROM (SELECT id FROM animals) animal_ids, 
(SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;


