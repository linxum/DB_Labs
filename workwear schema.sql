CREATE TABLE IF NOT EXISTS Workwear (
	workwear_id serial NOT NULL,
	workwear_type_id integer NOT NULL,
	workwear_cost DECIMAL NOT NULL,
	CONSTRAINT Workwear_pk PRIMARY KEY (workwear_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE Workwear IS "Спецодежда"
COMMENT ON COLUMN Workwear.workwear_id IS "Идентификатор спецодежды"
COMMENT ON COLUMN Workwear.workwear_type_id IS "Идентификатор типа спецодежды"
COMMENT ON COLUMN Workwear.workwear_cost IS "Стоимость спецодежды"


CREATE TABLE IF NOT EXISTS Workshops (
	workshop_id serial NOT NULL,
	workshop_name VARCHAR(255) NOT NULL UNIQUE,
	workshop_boss_id integer NOT NULL UNIQUE,
	CONSTRAINT Workshops_pk PRIMARY KEY (workshop_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE Workshops IS "Цеха"
COMMENT ON COLUMN Workshops.workshop_id IS "Идентификатор цеха"
COMMENT ON COLUMN Workshops.workshop_name IS "Название цеха"
COMMENT ON COLUMN Workshops.workshop_boss_id IS "Идентификатор начальника цеха"


CREATE TABLE IF NOT EXISTS Workers (
	worker_id serial NOT NULL,
	worker_name VARCHAR(255) NOT NULL,
	worker_position_id integer NOT NULL,
	workwear_discount DECIMAL,
	workshop_id integer NOT NULL,
	CONSTRAINT Workers_pk PRIMARY KEY (worker_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE Workers IS "Работники"
COMMENT ON COLUMN Workers.worker_id IS "Идентификатор работника"
COMMENT ON COLUMN Workers.worker_name IS "ФИО работника"
COMMENT ON COLUMN Workers.worker_position_id IS "Идентификатор должности"
COMMENT ON COLUMN Workers.workwear_discount IS "Скидка на спецодежду"
COMMENT ON COLUMN Workers.workshop_id IS "Номер цеха"


CREATE TABLE IF NOT EXISTS Obtaining (
	obtaining_id integer NOT NULL,
	workwear_id integer NOT NULL,
	worker_id integer NOT NULL,
	workwear_number integer NOT NULL,
	obtaining_date_start DATE NOT NULL,
	obtaining_date_end DATE NOT NULL,
	obtaining_sign VARCHAR(255) NOT NULL,
	CONSTRAINT Obtaining_pk PRIMARY KEY (obtaining_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE Obtaining IS "Получение"
COMMENT ON COLUMN Obtaining.obtaining_id IS "Идентификатор получения"
COMMENT ON COLUMN Obtaining.workwear_id IS "Идентификатор спецодежды"
COMMENT ON COLUMN Obtaining.worker_id IS "Идентификатор работника"
COMMENT ON COLUMN Obtaining.workwear_number IS "Количество спецодежды"
COMMENT ON COLUMN Obtaining.obtaining_date_start IS "Дата получения"
COMMENT ON COLUMN Obtaining.obtaining_date_end IS "Дата окончания"
COMMENT ON COLUMN Obtaining.obtaining_sign IS "Подпись"


CREATE TABLE IF NOT EXISTS Positions (
	position_id serial NOT NULL,
	position VARCHAR(255) NOT NULL,
	CONSTRAINT Positions_pk PRIMARY KEY (position_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE Positions IS "Должности"
COMMENT ON COLUMN Positions.position_id IS "Идентификатор должности"
COMMENT ON COLUMN Positions.position IS "Должности"



CREATE TABLE IF NOT EXISTS Workwear_Type (
	workwear_type_id serial NOT NULL,
	workwear_type VARCHAR(255) NOT NULL,
	CONSTRAINT Workwear_Type_pk PRIMARY KEY (workwear_type_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE Workwear_Type IS "Тип спецодежды"
COMMENT ON COLUMN Workwear_Type.workwear_type_id IS "Идентификатор типа спецодежды"
COMMENT ON COLUMN Workwear_Type.workwear_type IS "Тип спецодежды"



ALTER TABLE Workwear 
	ADD CONSTRAINT Workwear_fk_workwear_type FOREIGN KEY (workwear_type_id) 
	REFERENCES Workwear_Type(workwear_type_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE Workshops 
	ADD CONSTRAINT Workshops_fk_workers FOREIGN KEY (workshop_boss_id) 
	REFERENCES Workers(worker_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Workers 
	ADD CONSTRAINT Workers_fk_positions FOREIGN KEY (worker_position_id) 
	REFERENCES Positions(position_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE Workers 
	ADD CONSTRAINT Workers_fk_workshops FOREIGN KEY (workshop_id) 
	REFERENCES Workshops(workshop_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Obtaining 
	ADD CONSTRAINT Obtaining_fk_workwear FOREIGN KEY (workwear_id) 
	REFERENCES Workwear(workwear_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE Obtaining 
	ADD CONSTRAINT Obtaining_fk_workers FOREIGN KEY (worker_id) 
	REFERENCES Workers(worker_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;