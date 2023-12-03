DROP SCHEMA IF EXISTS workwear_schema CASCADE;

CREATE SCHEMA IF NOT EXISTS workwear_schema AUTHORIZATION smkhnv;
COMMENT ON SCHEMA workwear_schema IS 'Схема данных для спецодежды на отдельно взятом заводе';

SET search_path TO workwear_schema, public;

DROP TABLE IF EXISTS Workwear CASCADE;
DROP TABLE IF EXISTS Workshops CASCADE;
DROP TABLE IF EXISTS Workers CASCADE;
DROP TABLE IF EXISTS Obtaining CASCADE;
DROP TABLE IF EXISTS Positions CASCADE;
DROP TABLE IF EXISTS Workwear_Type CASCADE;

CREATE TABLE IF NOT EXISTS Workwear (
	workwear_id serial NOT NULL,
	workwear_type_id integer NOT NULL,
	workwear_cost DECIMAL NOT NULL,
	CONSTRAINT Workwear_pk PRIMARY KEY (workwear_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE Workwear IS 'Спецодежда';
COMMENT ON COLUMN Workwear.workwear_id IS 'Идентификатор спецодежды';
COMMENT ON COLUMN Workwear.workwear_type_id IS 'Идентификатор типа спецодежды';
COMMENT ON COLUMN Workwear.workwear_cost IS 'Стоимость спецодежды';


CREATE TABLE IF NOT EXISTS Workshops (
	workshop_id serial NOT NULL,
	workshop_name VARCHAR(255) NOT NULL UNIQUE,
	workshop_boss_id integer NOT NULL UNIQUE,
	CONSTRAINT Workshops_pk PRIMARY KEY (workshop_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE Workshops IS 'Цеха';
COMMENT ON COLUMN Workshops.workshop_id IS 'Идентификатор цеха';
COMMENT ON COLUMN Workshops.workshop_name IS 'Название цеха';
COMMENT ON COLUMN Workshops.workshop_boss_id IS 'Идентификатор начальника цеха';


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
COMMENT ON TABLE Workers IS 'Работники';
COMMENT ON COLUMN Workers.worker_id IS 'Идентификатор работника';
COMMENT ON COLUMN Workers.worker_name IS 'ФИО работника';
COMMENT ON COLUMN Workers.worker_position_id IS 'Идентификатор должности';
COMMENT ON COLUMN Workers.workwear_discount IS 'Скидка на спецодежду';
COMMENT ON COLUMN Workers.workshop_id IS 'Номер цеха';


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
COMMENT ON TABLE Obtaining IS 'Получение';
COMMENT ON COLUMN Obtaining.obtaining_id IS 'Идентификатор получения';
COMMENT ON COLUMN Obtaining.workwear_id IS 'Идентификатор спецодежды';
COMMENT ON COLUMN Obtaining.worker_id IS 'Идентификатор работника';
COMMENT ON COLUMN Obtaining.workwear_number IS 'Количество спецодежды';
COMMENT ON COLUMN Obtaining.obtaining_date_start IS 'Дата получения';
COMMENT ON COLUMN Obtaining.obtaining_date_end IS 'Дата окончания';
COMMENT ON COLUMN Obtaining.obtaining_sign IS 'Подпись';


CREATE TABLE IF NOT EXISTS Positions (
	position_id serial NOT NULL,
	position VARCHAR(255) NOT NULL,
	CONSTRAINT Positions_pk PRIMARY KEY (position_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE Positions IS 'Должности';
COMMENT ON COLUMN Positions.position_id IS 'Идентификатор должности';
COMMENT ON COLUMN Positions.position IS 'Должность';


CREATE TABLE IF NOT EXISTS Workwear_Type (
	workwear_type_id serial NOT NULL,
	workwear_type VARCHAR(255) NOT NULL,
	CONSTRAINT Workwear_Type_pk PRIMARY KEY (workwear_type_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE Workwear_Type IS 'Тип спецодежды';
COMMENT ON COLUMN Workwear_Type.workwear_type_id IS 'Идентификатор типа спецодежды';
COMMENT ON COLUMN Workwear_Type.workwear_type IS 'Тип спецодежды';


ALTER TABLE Workshops 
	ADD CONSTRAINT Workshops_fk_workers FOREIGN KEY (workshop_boss_id) 
	REFERENCES Workers(worker_id)
	DEFERRABLE INITIALLY DEFERRED
	ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Workers 
	ADD CONSTRAINT Workers_fk_positions FOREIGN KEY (worker_position_id) 
	REFERENCES Positions(position_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE Workers 
	ADD CONSTRAINT Workers_fk_workshops FOREIGN KEY (workshop_id) 
	REFERENCES Workshops(workshop_id)
	DEFERRABLE INITIALLY DEFERRED
	ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE Obtaining 
	ADD CONSTRAINT Obtaining_fk_workwear FOREIGN KEY (workwear_id) 
	REFERENCES Workwear(workwear_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE Obtaining 
	ADD CONSTRAINT Obtaining_fk_workers FOREIGN KEY (worker_id) 
	REFERENCES Workers(worker_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;

INSERT INTO Workwear_Type VALUES (1, 'Халат рабочий');
INSERT INTO Workwear_Type VALUES (2, 'Ботинки противоударные');
INSERT INTO Workwear_Type VALUES (3, 'Каска противоударная');
INSERT INTO Workwear_Type VALUES (4, 'Жилет светоотражающий');
INSERT INTO Workwear_Type VALUES (5, 'Перчатки армированные');

INSERT INTO Workwear VALUES (1, 1, 100);
INSERT INTO Workwear VALUES (2, 1, 100);
INSERT INTO Workwear VALUES (3, 2, 200);
INSERT INTO Workwear VALUES (4, 2, 250);
INSERT INTO Workwear VALUES (5, 3, 300);
INSERT INTO Workwear VALUES (6, 4, 300);
INSERT INTO Workwear VALUES (7, 4, 300);
INSERT INTO Workwear VALUES (8, 4, 350);

INSERT INTO Positions VALUES (1, 'Начальник цеха');
INSERT INTO Positions VALUES (2, 'Кабанчик');
INSERT INTO Positions VALUES (3, 'Заместитель начальника цеха');
INSERT INTO Positions VALUES (4, 'Старший мастер');
INSERT INTO Positions VALUES (5, 'Младший мастер');

INSERT INTO Workers VALUES (1, 'Алексеева Виктория Александровна', 1, 0.1, 1);
INSERT INTO Workers VALUES (2, 'Шумейко Святослав Евгеньевич', 1, 0.5, 2);
INSERT INTO Workers VALUES (3, 'Носков Павел Эдуардович', 1, 0.3, 3);
INSERT INTO Workers VALUES (4, 'Мазуров Леонид Алексеевич', 1, 0.9, 4);
INSERT INTO Workers VALUES (5, 'Смехнёв Иван Юрьевич', 1, 0.99, 5);
INSERT INTO Workers VALUES (6, 'Брянцев Всеволод Александрович', 1, 0.5, 6);
INSERT INTO Workers VALUES (7, 'Недобежкин Павел Владимирович', 2, 0.1, 5);
INSERT INTO Workers VALUES (8, 'Айбайльдульчевов Ибрагим Махмудович', 3, 0.5, 1);
INSERT INTO Workers VALUES (9, 'Яшин Ян Янович', 4, 0.4, 6);
INSERT INTO Workers VALUES (10, 'Простинин Азамат Алмазович', 2, 0.3, 2);

INSERT INTO Obtaining VALUES (1, 1, 2, 2, '2023-01-01', '2023-12-31', 'ШСЕ');
INSERT INTO Obtaining VALUES (2, 1, 3, 1, '2022-05-26', '2024-01-01', 'НПЭ');
INSERT INTO Obtaining VALUES (3, 2, 4, 2, '2022-06-17', '2025-06-17', 'МЛА');
INSERT INTO Obtaining VALUES (4, 2, 5, 3, '2020-11-11', '2024-11-11', 'СИЮ');
INSERT INTO Obtaining VALUES (5, 3, 6, 1, '2023-06-01', '2026-06-01', 'БВА');
INSERT INTO Obtaining VALUES (6, 4, 8, 2, '2022-01-30', '2030-01-01', 'АИМ');
INSERT INTO Obtaining VALUES (7, 4, 9, 1, '2022-02-22', '2030-01-01', 'ЯЯЯ');
INSERT INTO Obtaining VALUES (8, 4, 10, 1, '2022-03-02', '2030-01-02', 'ПАА');

INSERT INTO Workshops VALUES (1, 'Столярный цех', 1);
INSERT INTO Workshops VALUES (2, 'Красильный цех', 2);
INSERT INTO Workshops VALUES (3, 'Сборочный цех', 3);
INSERT INTO Workshops VALUES (4, 'Обивочный цех', 4);
INSERT INTO Workshops VALUES (5, 'ГБЖ цех', 5);
INSERT INTO Workshops VALUES (6, 'Ремонтный цех', 6);

