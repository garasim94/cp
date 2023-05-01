INSERT INTO trip (departure_date, arrival_date, departure_time, arrival_time, start_point, end_point, route_number,status,user_id)
VALUES
('2023-05-01', '2023-05-01', '08:00:00', '10:00:00', 'Start point 1', 'End point 1', '1','UNREAD',2),
('2023-05-02', '2023-05-02', '10:00:00', '12:00:00', 'Start point 2', 'End point 2', '2','ACCEPT',2),
('2023-05-03', '2023-05-03', '12:00:00', '14:00:00', 'Start point 3', 'End point 3', '3','UNREAD',2),
('2023-05-04', '2023-05-04', '14:00:00', '16:00:00', 'Start point 4', 'End point 4', '4','DENIED',2),
('2023-05-05', '2023-05-05', '16:00:00', '18:00:00', 'Start point 5', 'End point 5', '5','DENIED',2),
('2023-05-06', '2023-05-06', '18:00:00', '20:00:00', 'Start point 6', 'End point 6', '6','UNREAD',2),
('2023-05-07', '2023-05-07', '20:00:00', '22:00:00', 'Start point 7', 'End point 7', '7','ACCEPT',2),
('2023-05-08', '2023-05-08', '22:00:00', '00:00:00', 'Start point 8', 'End point 8', '8','ACCEPT',2),
('2023-05-09', '2023-05-09', '00:00:00', '02:00:00', 'Start point 9', 'End point 9', '9','ACCEPT',2),
('2023-05-10', '2023-05-10', '02:00:00', '04:00:00', 'Start point 10', 'End point 10', '10','DENIED',2);
INSERT INTO train_trip (train_id, trip_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 4),
    (2, 5),
    (2, 6),
    (3, 7),
    (3, 8),
    (3, 9),
    (4, 10);