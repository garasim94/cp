insert into usr ( username, password, active)
values('Driver','12345678',true),
      ('Dispatcher','12345678',true),
      ('Driver2','12345678',true),
      ('Driver3','12345678',true),
      ('Driver4','12345678',true);
insert into user_role(user_id,roles)
values (2,'DRIVER'),(3,'DISPATCHER'),
       (4,'DRIVER'),
       (5,'DRIVER'),
       (6,'DRIVER');