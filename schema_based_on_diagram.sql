CREATE TABLE patients (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(250),
	date_of_birth DATE,
	PRIMARY KEY(id)
);

CREATE TABLE invoices (
	id INT GENERATED ALWAYS AS IDENTITY,
	total_amount REAL,
	generated_at TIMESTAMP,
	payed_at TIMESTAMP,
	medical_history_id INT,
	PRIMARY KEY(id),
	CONSTRAINT fk_medicals
		FOREIGN KEY(medical_history_id)
			REFERENCES medical_histories(id)
);

CREATE TABLE medical_histories (
	id INT GENERATED ALWAYS AS IDENTITY,
	admitted_at TIMESTAMP,
	patient_id INT,
	status VARCHAR(50),
	PRIMARY KEY(id),
	CONSTRAINT fk_patient
		FOREIGN KEY(patient_id)
			REFERENCES patients(id)
);

CREATE TABLE invoice_items (
	id INT GENERATED ALWAYS AS IDENTITY,
	unit_price REAL,
	quantity INT,
	total_price REAL,
	invoice_id INT,
	treatment_id INT,
	PRIMARY KEY(id),
	CONSTRAINT fk_invoice
		FOREIGN KEY(invoice_id)
			REFERENCES invoices(id),
	CONSTRAINT fk_treatments
		FOREIGN KEY(treatment_id)
			REFERENCES treatments(id)
);

CREATE TABLE diagnosis (
	id INT GENERATED ALWAYS AS IDENTITY,
	treatment_id INT,
	medical_histories_id INT,
	CONSTRAINT fk_treatment
		FOREIGN KEY(treatment_id)
			REFERENCES invoice_items(id),
	CONSTRAINT fk_medical_histories
		FOREIGN KEY(medical_histories_id)
			REFERENCES medical_histories(id)
);

CREATE TABLE treatments (
	id INT GENERATED ALWAYS AS IDENTITY,
	invoice_items_id INT,
	medical_histories_id INT,
	type VARCHAR(50),
	name VARCHAR(250),
	PRIMARY KEY(id)
);