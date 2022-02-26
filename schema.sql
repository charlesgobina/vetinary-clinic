/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(250),
	date_of_birth DATE,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg REAL
);

ALTER TABLE animals
ADD species VARCHAR(250)

/*owners table*/
CREATE TABLE owners (
	id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(250),
	age INT,
	PRIMARY KEY(id)
);

/*species table*/
CREATE TABLE species (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(250),
	PRIMARY KEY(id)
);

/*Alter animal table*/
ALTER TABLE animals
ADD PRIMARY KEY(id);

ALTER TABLE animals
DROP species;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD CONSTRAINT fk_species
	FOREIGN KEY(species_id)
		REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owners
	FOREIGN KEY(owner_id)
		REFERENCES owners(id);

/*Vets table*/
CREATE TABLE vets (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(250),
	age INT,
	date_of_graduation DATE,
	PRIMARY KEY(id)
);

/*Specialisation table*/
CREATE TABLE specializations (
	id INT GENERATED ALWAYS AS IDENTITY,
	vets_id INT,
	species_id iNT,
	CONSTRAINT fk_vets
		FOREIGN KEY(vets_id)
			REFERENCES vets(id),
	CONSTRAINT fk_species
		FOREIGN KEY(species_id)
			REFERENCES species(id),
	PRIMARY KEY(id)
);

/*Visits*/
CREATE TABLE visits (
	id INT GENERATED ALWAYS AS IDENTITY,
	animals_id INT,
	vets_id iNT,
	visit_date DATE,
	CONSTRAINT fk_animals
		FOREIGN KEY(animals_id)
			REFERENCES animals(id),
	CONSTRAINT fk_vets
		FOREIGN KEY(vets_id)
			REFERENCES vets(id),
	PRIMARY KEY(id)
);
