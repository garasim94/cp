create sequence hibernate_sequence start 1 increment 1;
create table train (
                       id BIGSERIAL not null,
                       train_name varchar(255),
                       train_number varchar(255),
                       primary key (id));
create table train_trip (
                            id BIGSERIAL not null,
                            train_id int8,
                            trip_id int8,
                            primary key (id));
create table trip (
                      id BIGSERIAL not null,
                      arrival_date date,
                      arrival_time time,
                      departure_date date,
                      departure_time time,
                      end_point varchar(255),
                      route_number varchar(255),
                      start_point varchar(255),
                      user_id int8,
                      primary key (id));
create table trip (
                      id BIGSERIAL not null,
                      arrival_date date,
                      arrival_time time,
                      departure_date date,
                      departure_time time,
                      end_point varchar(255),
                      route_number varchar(255),
                      start_point varchar(255),
                      status varchar(255),
                      user_id int8,
                      primary key (id));
create table user_role (
                           user_id BIGSERIAL not null,
                           roles varchar(255));
create table usr (
                     id BIGSERIAL not null,
                     active boolean not null,
                     password varchar(255),
                     username varchar(255),
                     primary key (id));
alter table if exists train_trip
    add constraint train_fk
    foreign key (train_id) references train;
alter table if exists train_trip
    add constraint trip_fk
    foreign key (trip_id) references trip;
alter table if exists trip
    add constraint user_trip_user_fk
    foreign key (user_id) references usr;
alter table if exists user_role
    add constraint user_role_user_fk
    foreign key (user_id) references usr;

create table issue (
                       id BIGSERIAL not null,
                       message varchar(255),
                       status varchar(255),
                       train_id int8,
                       trip_id int8,
                       user_id int8,
                       primary key (id));
create table train (
                       id BIGSERIAL not null,
                       train_name varchar(255),
                       train_number varchar(255),
                       primary key (id));
create table train_trip (
                            id BIGSERIAL not null,
                            train_id int8,
                            trip_id int8,
                            primary key (id));
create table trip (
                      id BIGSERIAL not null,
                      arrival_date date, arrival_time time,
                      departure_date date,
                      departure_time time,
                      end_point varchar(255),
                      route_number varchar(255),
                      start_point varchar(255),
                      status varchar(255),
                      user_id int8,
                      primary key (id));
create table user_role (
                           user_id int8 not null,
                           roles varchar(255));
create table usr (
                     id BIGSERIAL not null,
                     active boolean not null,
                     password varchar(255),
                     username varchar(255),
                     primary key (id));
alter table if exists issue
    add constraint train_fk
    foreign key (train_id) references train;
alter table if exists issue
    add constraint trip_fk
    foreign key (trip_id) references trip;
alter table if exists issue
    add constraint user_fk
    foreign key (user_id) references usr;
alter table if exists train_trip
    add constraint train_fk
    foreign key (train_id) references train;
alter table if exists train_trip
    add constraint trip_fk
    foreign key (trip_id) references trip;
alter table if exists trip
    add constraint user_trip_user_fk
    foreign key (user_id) references usr;
alter table if exists user_role
    add constraint user_role_user_fk
    foreign key (user_id) references usr;
