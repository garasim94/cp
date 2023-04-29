insert into usr (id, username, password, active)
values(2,'Driver','1994',true),
      (3,'Dispatcher','1994',true),
      (4,'Driver2','1994',true),
      (5,'Driver3','1994',true),
      (6,'Driver4','1994',true);
insert into user_role(user_id,roles)
values (2,'DRIVER'),(3,'DISPATCHER'),
       (4,'DRIVER'),
       (5,'DRIVER'),
       (6,'DRIVER');