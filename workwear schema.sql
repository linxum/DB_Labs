DROP SCHEMA IF EXISTS movie_theather CASCADE;

CREATE SCHEMA IF NOT EXISTS movie_theather AUTHORIZATION smekhnev_ii;

COMMENT ON SCHEMA movie_theather IS 'Кинотеатр';
ALTER ROLE smekhnev_ii IN DATABASE smekhnev_ii_db SET search_path TO movie_theather, public;
GRANT ALL ON SCHEMA movie_theather TO smekhnev_ii;

DROP TABLE IF EXISTS movie CASCADE;
DROP TABLE IF EXISTS box_office CASCADE;
DROP TABLE IF EXISTS cinema_hall CASCADE;
DROP TABLE IF EXISTS session CASCADE;
DROP TABLE IF EXISTS tickets CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS directors CASCADE;

CREATE TABLE IF NOT EXISTS movie (
	movie_id serial NOT NULL,
	movie_name_rus VARCHAR(255) NOT NULL,
	movie_name_eng VARCHAR(255) NOT NULL,
	movie_year DATE NOT NULL,
	movie_director_id integer NOT NULL,
	movie_slogan VARCHAR(255) NOT NULL,
	movie_duration TIME NOT NULL,
	CONSTRAINT movie_pk PRIMARY KEY (movie_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE movie IS 'Фильм';
COMMENT ON COLUMN movie.movie_id IS 'Номер фильма';
COMMENT ON COLUMN movie.movie_name_rus IS 'Название фильма на русском';
COMMENT ON COLUMN movie.movie_name_eng IS 'Название фильма на английском';
COMMENT ON COLUMN movie.movie_year IS 'Год выхода фильма';
COMMENT ON COLUMN movie.movie_director_id IS 'Режиссер фильма';
COMMENT ON COLUMN movie.movie_slogan IS 'Слоган фильма';
COMMENT ON COLUMN movie.movie_duration IS 'Продолжительность фильма';

CREATE TABLE IF NOT EXISTS box_office (
	office_id serial NOT NULL,
	office_start_time TIME NOT NULL,
	office_end_time TIME NOT NULL,
	office_employee_id integer NOT NULL,
	CONSTRAINT box_office_pk PRIMARY KEY (office_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE box_office IS 'Касса';
COMMENT ON COLUMN box_office.office_id IS 'Номер кассы';
COMMENT ON COLUMN box_office.office_start_time IS 'Время начала работы кассы';
COMMENT ON COLUMN box_office.office_end_time IS 'Время конца работы кассы';
COMMENT ON COLUMN box_office.office_employee_id IS 'Номер работника кассы';

CREATE TABLE IF NOT EXISTS cinema_hall (
	hall_id serial NOT NULL,
	hall_capacity integer NOT NULL,
	hall_size_screen integer NOT NULL,
	hall_size_hall integer NOT NULL,
	CONSTRAINT cinema_hall_pk PRIMARY KEY (hall_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE cinema_hall IS 'Кинозал';
COMMENT ON COLUMN cinema_hall.hall_id IS 'Номер кинозала';
COMMENT ON COLUMN cinema_hall.hall_capacity IS 'Вместимость кинозала';
COMMENT ON COLUMN cinema_hall.hall_size_screen IS 'Размер экрана кинозала';
COMMENT ON COLUMN cinema_hall.hall_size_hall IS 'Размер кинозала';

CREATE TABLE IF NOT EXISTS session (
	session_id serial NOT NULL,
	session_start_date TIMESTAMP NOT NULL,
	session_end_date TIMESTAMP NOT NULL,
	session_movie_id integer NOT NULL,
	session_hall_id integer NOT NULL,
	CONSTRAINT session_pk PRIMARY KEY (session_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE session IS 'Сеанс';
COMMENT ON COLUMN session.session_id IS 'Номер сеанса';
COMMENT ON COLUMN session.session_start_date IS 'Время начала сеанса';
COMMENT ON COLUMN session.session_end_date IS 'Время окончания сеанса';
COMMENT ON COLUMN session.session_movie_id IS 'Название фильма сеанса';
COMMENT ON COLUMN session.session_hall_id IS 'Номер кинозала сеанса';



CREATE TABLE IF NOT EXISTS tickets (
	ticket_id serial NOT NULL,
	ticket_session_id integer NOT NULL,
	ticket_cost integer NOT NULL,
	ticket_seat_id integer NOT NULL,
	ticket_office_id integer NOT NULL,
	CONSTRAINT tickets_pk PRIMARY KEY (ticket_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE tickets IS 'Билет';
COMMENT ON COLUMN tickets.ticket_id IS 'Номер билета';
COMMENT ON COLUMN tickets.ticket_session_id IS 'Номер сеанса билета';
COMMENT ON COLUMN tickets.ticket_cost IS 'Цена билета';
COMMENT ON COLUMN tickets.ticket_seat_id IS 'Номер места билета';
COMMENT ON COLUMN tickets.ticket_office_id IS 'Номер кассы билета';

CREATE TABLE IF NOT EXISTS employees (
	employee_id serial NOT NULL,
	employee_first_name VARCHAR(255) NOT NULL,
	employee_last_name VARCHAR(255) NOT NULL,
	employee_birthday DATE NOT NULL,
	employee_email VARCHAR(255) NOT NULL,
	CONSTRAINT employees_pk PRIMARY KEY (employee_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE employees IS 'Работники';
COMMENT ON COLUMN employees.employee_id IS 'Номер работника';
COMMENT ON COLUMN employees.employee_first_name IS 'Имя работника';
COMMENT ON COLUMN employees.employee_last_name IS 'Фамилия работника';
COMMENT ON COLUMN employees.employee_birthday IS 'День рождения работника';
COMMENT ON COLUMN employees.employee_email IS 'Электронная почта работника';

CREATE TABLE IF NOT EXISTS directors (
	director_id integer NOT NULL,
	director_name VARCHAR(255) NOT NULL,
	CONSTRAINT directors_pk PRIMARY KEY (director_id)
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE directors IS 'Режисеры';
COMMENT ON COLUMN directors.director_id IS 'Режисер';
COMMENT ON COLUMN directors.director_name IS 'Имя режисера';

ALTER TABLE movie 
	ADD CONSTRAINT movie_fk_director_id FOREIGN KEY (movie_director_id) 
	REFERENCES directors(director_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE box_office 
	ADD CONSTRAINT box_office_fk_employee FOREIGN KEY (office_employee_id) 
	REFERENCES employees(employee_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE session 
	ADD CONSTRAINT session_fk_movie_id FOREIGN KEY (session_movie_id) 
	REFERENCES movie(movie_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;
 
ALTER TABLE session 
	ADD CONSTRAINT session_fk_hall_id FOREIGN KEY (session_hall_id) 
	REFERENCES cinema_hall(hall_id)
	ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE tickets 
	ADD CONSTRAINT tickets_fk_session_id FOREIGN KEY (ticket_session_id) 
	REFERENCES session(session_id)
	ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE tickets 
	ADD CONSTRAINT tickets_fk_box_office_id FOREIGN KEY (ticket_office_id) 
	REFERENCES box_office(office_id)
	ON UPDATE CASCADE ON DELETE SET NULL;

INSERT INTO directors VALUES (1, 'Тайко Вайтити');
INSERT INTO directors VALUES (2, 'Роб Минкофф, Роджер Аллерс');
INSERT INTO directors VALUES (3, 'Джоэл Шумахер');
INSERT INTO directors VALUES (4, 'Фрэнк Дарабонт');
INSERT INTO directors VALUES (5, 'Илья Найшуллер');

INSERT INTO movie VALUES (1, 'Кролик ДжоДжо', 'Jojo Rabbit', '2019-11-19', 1, 'An anti-hate satire', '01:48:00');
INSERT INTO movie VALUES (2, 'Король Лев', 'The Lion King', '1995-01-20', 2, 'The Circle of Life', '01:28:00');
INSERT INTO movie VALUES (3, 'Бэтмен и Робин', 'Batman and Robin', '1997-06-20', 3, '-', '02:05:00');
INSERT INTO movie VALUES (4, 'Побег из Шоушенка', 'The Shawshank Redemption', '1994-09-10', 4, 'Страх - это кандалы. Надежда - это свобода', '02:22:00');
INSERT INTO movie VALUES (5, 'Хардкор', 'Hardcore', '2015-09-12', 5, 'First they made him dangerous. Then they made him mad', '01:36:00');

INSERT INTO employees VALUES (1, 'Иван', 'Иванов', '1995-03-17', 'i_ivanov@yandex.ru');
INSERT INTO employees VALUES (2, 'Михаил', 'Михайлов', '1970-10-04', 'mm@mail.ru');
INSERT INTO employees VALUES (3, 'Петр', 'Петров', '1989-12-25', 'petrov@gmail.com');
INSERT INTO employees VALUES (4, 'Павел', 'Пешков', '2003-07-10', 'pasha_p@yandex.kz');
INSERT INTO employees VALUES (5, 'Виктория', 'Алексеева', '1975-05-01', 'vika_alex@gmail.com');

INSERT INTO cinema_hall VALUES (2, 150, 200, 1000);
INSERT INTO cinema_hall VALUES (1, 100, 150, 800);
INSERT INTO cinema_hall VALUES (3, 150, 200, 1000);
INSERT INTO cinema_hall VALUES (4, 30, 100, 200);

INSERT INTO session VALUES (1, '2024-01-01 18:30:00', '2024-01-01 20:18:00', 2, 3);
INSERT INTO session VALUES (2, '2024-01-02 15:30:00', '2024-01-02 17:18:00', 2, 1);
INSERT INTO session VALUES (3, '2024-01-07 23:00:00', '2024-01-02 01:05:00', 3, 4);
INSERT INTO session VALUES (4, '2024-01-10 22:00:00', '2024-01-11 00:05:00', 3, 4);
INSERT INTO session VALUES (5, '2024-01-15 17:45:00', '2024-01-15 20:07:00', 4, 2);
INSERT INTO session VALUES (6, '2024-01-17 17:30:00', '2024-01-17 19:52:00', 4, 3);
INSERT INTO session VALUES (7, '2024-02-01 00:00:00', '2024-02-01 01:36:00', 5, 4);

INSERT INTO box_office VALUES (1, '00:00:00', '08:00:00', 3);
INSERT INTO box_office VALUES (2, '04:00:00', '12:00:00', 5);
INSERT INTO box_office VALUES (3, '08:00:00', '16:00:00', 1);
INSERT INTO box_office VALUES (4, '12:00:00', '20:00:00', 4);
INSERT INTO box_office VALUES (5, '16:00:00', '00:00:00', 2);

INSERT INTO tickets VALUES (1, 1, 350, 44, 4);
INSERT INTO tickets VALUES (2, 1, 350, 45, 4);
INSERT INTO tickets VALUES (3, 1, 350, 46, 4);
INSERT INTO tickets VALUES (4, 2, 320, 94, 3);
INSERT INTO tickets VALUES (5, 2, 320, 96, 3);
INSERT INTO tickets VALUES (6, 3, 300, 10, 5);
INSERT INTO tickets VALUES (7, 3, 300, 11, 5);
INSERT INTO tickets VALUES (8, 3, 300, 12, 5);
INSERT INTO tickets VALUES (9, 4, 320, 55, 4);

CREATE VIEW movie_sessions_view AS
SELECT
    s.session_id,
    m.movie_name_rus AS movie_name,
    m.movie_year AS movie_year,
    s.session_start_date,
    s.session_end_date,
    h.hall_id
FROM
    session s
JOIN
    movie m ON s.session_movie_id = m.movie_id
JOIN
    cinema_hall h ON s.session_hall_id = h.hall_id;

CREATE VIEW ticket_sales_view AS
SELECT
    t.ticket_id,
    m.movie_name_rus AS movie_name,
    s.session_start_date,
    t.ticket_cost,
    t.ticket_seat_id,
    b.office_id,
    e.employee_first_name || ' ' || e.employee_last_name AS employee_name
FROM
    tickets t
JOIN
    session s ON t.ticket_session_id = s.session_id
JOIN
    movie m ON s.session_movie_id = m.movie_id
LEFT JOIN
    box_office b ON t.ticket_office_id = b.office_id
LEFT JOIN
    employees e ON b.office_employee_id = e.employee_id;

CREATE VIEW employee_schedule_view AS
SELECT
    e.employee_id,
    e.employee_first_name,
    e.employee_last_name,
    e.employee_birthday,
    e.employee_email,
    b.office_id,
    b.office_start_time,
    b.office_end_time
FROM
    employees e
JOIN
    box_office b ON e.employee_id = b.office_employee_id;

CREATE SEQUENCE ticket_id_sequence
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE OR REPLACE FUNCTION getRandomSession() RETURNS TABLE (
    sessions_id integer,
    halls_capacity integer
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.session_id AS sessions_id,
        h.hall_capacity AS halls_capacity
    FROM 
        session s
    JOIN 
        cinema_hall h ON s.session_hall_id = h.hall_id
    ORDER BY 
        RANDOM()
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getRandomOffice() RETURNS TABLE (
	box_office_id integer
) AS $$
BEGIN
	RETURN QUERY
	SELECT 
		office_id as box_office_id
	FROM box_office
	ORDER BY RANDOM()
	LIMIT 1;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE generateTicket(num_ticket INTEGER) AS $$
DECLARE
	t_ticket_id integer;
	t_session_id integer;
	t_ticket_cost integer;
	t_seat_id integer;
	t_box_office_id integer;
	t_hall_capacity integer;
BEGIN
	FOR t_ticket_id IN 1..num_ticket LOOP
		SELECT sessions_id, halls_capacity INTO t_session_id, t_hall_capacity FROM getRandomSession();
		SELECT box_office_id INTO t_box_office_id FROM getRandomOffice();

		t_ticket_cost := floor(random() * 1000) + 100;
		t_seat_id := floor(random() * t_hall_capacity) + 1;

		INSERT INTO tickets VALUES (nextval('ticket_id_sequence'), t_session_id, t_ticket_cost, t_seat_id, t_box_office_id);
	END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE TABLE IF NOT EXISTS Ticket_Audit (
    audit_id SERIAL PRIMARY KEY,
    ticket_id INTEGER,
    action VARCHAR(10) NOT NULL,
    audit_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_data JSONB,
    new_data JSONB
);

CREATE OR REPLACE FUNCTION ticket_audit()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO Ticket_Audit (ticket_id, action, new_data)
        VALUES (NEW.ticket_id, 'INSERT', ROW_TO_JSON(NEW)::JSONB);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO Ticket_Audit (ticket_id, action, old_data, new_data)
        VALUES (NEW.ticket_id, 'UPDATE', ROW_TO_JSON(OLD)::JSONB, ROW_TO_JSON(NEW)::JSONB);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO Ticket_Audit (ticket_id, action, old_data)
        VALUES (OLD.ticket_id, 'DELETE', ROW_TO_JSON(OLD)::JSONB);
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER Ticket_audit_trigger
AFTER INSERT OR UPDATE OR DELETE
ON tickets
FOR EACH ROW
EXECUTE FUNCTION ticket_audit();

REVOKE ALL PRIVILEGES ON DATABASE smekhnev_ii_db FROM hr_movie_theather;
REVOKE ALL PRIVILEGES ON SCHEMA movie_theather FROM hr_movie_theather;
REVOKE ALL PRIVILEGES ON TABLE box_office, employees FROM hr_movie_theather;
REVOKE ALL PRIVILEGES ON DATABASE smekhnev_ii_db FROM cashier_movie_thather;
REVOKE ALL PRIVILEGES ON SCHEMA movie_theather FROM cashier_movie_thather;
REVOKE ALL PRIVILEGES ON TABLE box_office, employees FROM cashier_movie_thather;
DROP USER IF EXISTS cashier_movie_thather;
DROP ROLE IF EXISTS hr_movie_theather;

REVOKE ALL PRIVILEGES ON DATABASE smekhnev_ii_db FROM admin_movie_theather;
REVOKE ALL PRIVILEGES ON SCHEMA movie_theather FROM admin_movie_theather;
REVOKE ALL PRIVILEGES ON TABLE movie, cinema_hall, session, tickets, directors FROM admin_movie_theather;
REVOKE ALL PRIVILEGES ON DATABASE smekhnev_ii_db FROM admin1_movie_theather;
REVOKE ALL PRIVILEGES ON SCHEMA movie_theather FROM admin1_movie_theather;
REVOKE ALL PRIVILEGES ON TABLE movie, cinema_hall, session, tickets, directors FROM admin1_movie_theather;
DROP USER IF EXISTS admin1_movie_theather;
DROP ROLE IF EXISTS admin_movie_theather;

CREATE ROLE hr_movie_theather;
GRANT CONNECT ON DATABASE smekhnev_ii_db TO hr_movie_theather;
GRANT USAGE ON SCHEMA movie_theather TO hr_movie_theather;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE box_office TO hr_movie_theather;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE employees TO hr_movie_theather;

CREATE ROLE admin_movie_theather;
GRANT CONNECT ON DATABASE smekhnev_ii_db TO hr_movie_theather;
GRANT USAGE ON SCHEMA movie_theather TO hr_movie_theather;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE movie TO hr_movie_theather;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE cinema_hall TO hr_movie_theather;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE session TO hr_movie_theather;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE tickets TO hr_movie_theather;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE directors TO hr_movie_theather;

CREATE USER cashier_movie_thather WITH PASSWORD 'cashier';
GRANT hr_movie_theather TO cashier_movie_thather;
GRANT CONNECT ON DATABASE smekhnev_ii_db TO cashier_movie_thather;
ALTER ROLE cashier_movie_thather IN DATABASE smekhnev_ii_db SET search_path TO movie_theather, public;

CREATE USER admin1_movie_theather WITH PASSWORD 'admin1';
GRANT admin_movie_theather TO admin1_movie_theather;
GRANT CONNECT ON DATABASE smekhnev_ii_db TO admin1_movie_theather;
ALTER ROLE admin1_movie_theather IN DATABASE smekhnev_ii_db SET search_path TO movie_theather, public;
