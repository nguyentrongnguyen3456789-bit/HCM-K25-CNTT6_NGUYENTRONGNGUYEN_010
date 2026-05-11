CREATE DATABASE hackathon_sql;
USE hackathon_sql;

-- Bảng Movies
CREATE TABLE Movies(
    movie_id VARCHAR(5) PRIMARY KEY NOT NULL,
    title VARCHAR(100) UNIQUE,
    duration INT NOT NULL,
    category VARCHAR(50) NOT NULL
);

-- Bảng Showtimes
CREATE TABLE Showtimes(
    show_id VARCHAR(5) PRIMARY KEY,
    movie_id VARCHAR(5) NOT NULL,
    room_name VARCHAR(50) NOT NULL,
    start_time DATETIME NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY(movie_id) REFERENCES Movies(movie_id)
);

-- Bảng Customers
CREATE TABLE Customers(
    customer_id VARCHAR(5) PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) UNIQUE
);

-- Bảng Tickets
CREATE TABLE Tickets(
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    show_id VARCHAR(5),
    customer_id VARCHAR(5),
    seat_number VARCHAR(10) UNIQUE,
    status VARCHAR(20) NOT NULL,

    FOREIGN KEY(show_id) REFERENCES Showtimes(show_id),
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

-- INSERT Movies
INSERT INTO Movies VALUES
('M01','Avatar 2',190,'Hành động'),
('M02','Joker',120,'Tâm lý'),
('M03','Toy Story 4',100,'Hoạt hình'),
('M04','Interstellar',169,'Khoa học');

-- INSERT Showtimes
INSERT INTO Showtimes VALUES
('S01','M01','Cinema 01','2025-10-01 19:00:00',120000.00),
('S02','M02','Cinema 02','2025-10-01 20:00:00',90000.00),
('S03','M03','Cinema 03','2025-10-02 09:00:00',80000.00),
('S04','M04','Cinema 04','2025-10-02 14:00:00',150000.00);

-- INSERT Customers
INSERT INTO Customers VALUES
('C01','Nguyễn Văn An','an.nv@gmail.com','0911111111'),
('C02','Nguyễn Thị Mai','mai.nt@gmail.com','0922222222'),
('C03','Trần Quang Hải','hai.tp@gmail.com','0933333333');

-- INSERT Tickets
INSERT INTO Tickets(ticket_id,show_id,customer_id,seat_number,status) VALUES
(1,'S01','C01','A01','Booked'),
(2,'S02','C02','B05','Booked'),
(3,'S01','C03','A02','Cancelled'),
(4,'S04','C01','C10','Booked'),
(5,'S03','C02','D01','Booked');



-- 3. tăng giá vé lên 10%
UPDATE Showtimes
SET ticket_price = ticket_price * 1.1
WHERE show_id = 'S01';



-- 4. cập nhật số điện thoại khách hàng
UPDATE Customers 
SET phone = '0988888888'
WHERE full_name = 'Nguyễn Văn An';



-- 5. xóa tất cả các vé có trạng thái Cancelled
DELETE FROM Tickets
WHERE status = 'Cancelled';



-- 6. liệt kê danh sách phim có thời lượng trên 120 phút
SELECT *
FROM Movies
WHERE duration > 120;



-- 7. lấy thông tin khách hàng có tên chứa từ "Mai"
SELECT *
FROM Customers
WHERE full_name LIKE '%Mai%';



-- 8. hiển thị danh sách các suất chiếu giảm dần theo thời gian
SELECT show_id, room_name, start_time
FROM Showtimes
ORDER BY start_time DESC;



-- 9. lấy 3 suất chiếu có giá vé cao nhất
SELECT *
FROM Showtimes
ORDER BY ticket_price DESC
LIMIT 3;



-- 10. bỏ qua phim đầu tiên và lấy 2 phim tiếp theo
SELECT title, duration
FROM Movies
LIMIT 2 OFFSET 1;



-- 11. hiển thị danh sách vé có trạng thái Booked
SELECT 
    tic.ticket_id,
    cus.full_name,
    mo.title,
    tic.seat_number
FROM Tickets tic
JOIN Customers cus 
    ON cus.customer_id = tic.customer_id
JOIN Showtimes s 
    ON s.show_id = tic.show_id
JOIN Movies mo 
    ON mo.movie_id = s.movie_id
WHERE tic.status = 'Booked';
