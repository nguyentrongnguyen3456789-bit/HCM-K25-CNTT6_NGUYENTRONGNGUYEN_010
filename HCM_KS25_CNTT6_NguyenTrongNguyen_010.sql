CREATE DATABASE hackathon_sql;
USE hackathon_sql;

CREATE TABLE Movies(
	movie_id VARCHAR(5) PRIMARY KEY NOT NULL,
	title VARCHAR(100) UNIQUE,
    duration INT NOT NULL,
    category VARCHAR(50) NOT NULL
);

CREATE TABLE Showtimes(
	show_id VARCHAR(5) PRIMARY KEY,
    FOREIGN KEY(movie_id) REFERENCES Movies(movie_id),
	movie_id VARCHAR(5) NOT NULL,
	room_name VARCHAR(50) NOT NULL,
    start_time DATETIME NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Customers(
	customer_id VARCHAR(5) NOT NULL,
	full_name VARCHAR(100),
	email VARCHAR(100) UNIQUE,
	phone VARCHAR(15) UNIQUE
);

CREATE TABLE Tickets(
	ticket_id INT PRIMARY KEY AUTO_INCREMENT,
	show_id VARCHAR(5),
    FOREIGN KEY(show_id) REFERENCES Showtimes(show_id),
	customer_id VARCHAR(5),
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
    seat_number VARCHAR(10),
    status VARCHAR(20) NOT NULL
);

INSERT INTO Movies VALUES
('M01','Avartar 2',190,'hành động'),
('M02','Joke',120,'tâm lý'),
('M03','Toty Story 4',100,'hoạt hình'),
('M04','Interstellar',169,'khoa học');

INSERT INTO Showtimes VALUES
('S01','M01','Cinema 01','2025-10-01 19:00:00',120000.00),
('S02','M02','Cinema 02','2025-10-01 20:00:00',90000.00),
('S03','M03','Cinema 03','2025-10-02 9:00:00',80000.00),
('S04','M04','Cinema 04','2025-10-02 14:00:00',150000.00);

INSERT INTO Customers VALUES
('C01','Nguyễn Văn AN','an.nv@gmal.com',0911111111),
('C02','Nguyễn Thị Mai','mai.nt@gmal.com',0922222222),
('C03','Trần Quang Hải','hai.tp@gmal.com',0933333333);

INSERT INTO Tickets VALUES
(1,'SO1','C01','A01','Booked'),
(2,'SO2','C02','B05','Booked'),
(3,'SO1','C03','A02','Cancelled'),
(4,'SO4','C01','C10','Booked'),
(5,'SO3','C02','D01','Booked');

UPDATE Showtimes
SET ticket_price = ticket_price * 1.1
WHERE Showtimes = 'S01';

UPDATE Customers 
SET phone = '0988888888'
WHERE Customers = 'Nguyễn Văn AN';

DELETE FROM Tickets
WHERE status = 'Cancelled';

SELECT *
FROM Movies
WHERE duration > 120;

SELECT *
FROM Customer
WHERE full_name ='mai';



SELECT *
FROM Showtimes
ORDER BY start_time DESC
LIMIT 3;

SELECT title, duration
FROM Movies
LIMIT 2 OFFSET 1;

SELECT ticket_id,full_name,title,seat_number
FROM Tickets tic
JOIN Customer cus ON cus.customer_id = tic.customer_id
JOIN Showtimes s ON s.show_id = tic.show_id
JOIN  Movies mo ON mo.movies_id = s.movies_id
WHERE status = 'Booked';






