drop table if exists people cascade;
drop table if exists Personal_data cascade;
drop table if exists Telephone_book cascade;
drop table if exists Buyers cascade;
drop table if exists Owners cascade;
drop table if exists Agents cascade;
drop table if exists Object cascade;
drop table if exists Deal cascade;
drop table if exists Object_parameters cascade;
drop table if exists Street_list cascade;
drop table if exists Buildings cascade;

create table People(
    personId serial,
	surname	varchar(100) not null,
	name	varchar(100),
	patronymic	varchar(100),
	primary key (personId)
);

create table Personal_data(
    personId serial,
    pasport_number varchar(11) unique not null,--need to check pattern
    foreign key (personId) references People(personId),
    primary key (personId)
);

create table Telephone_book(
    personId serial,
    telephone_number varchar(15) unique not null,--need to check pattern
    foreign key (personId) references People(personId),
	primary key (personId)
);
create table Buyers
(
    buyerId            int,
    reliability_factor int,
    foreign key (buyerId) references People(personId),
	primary key (buyerId)
);

create table Owners
(
    ownerId int,
    foreign key (ownerId) references People(personId),
	primary key (ownerId)
);

create table Agents
(
    agentId int,
    work_stage int,
    foreign key (agentId) references People(personId),
	primary key (agentId)
);

create table Street_list(
    district varchar,
    street varchar,
    amount_selling_objects int,
    amount_buildings int,
    primary key (district,street)
);

create table Buildings(
    buildingId	serial,
    --objectId int,
    district varchar,
    street	varchar,
    floors_amount int,
    repair_presence	bool,
    building_year date,
    wall_material varchar,
    primary key (buildingId),
    --foreign key (objectId) references Object(objectId),
    foreign key (district, street) references Street_list(district, street)
);

create table Object(
    objectId serial,
    agentId	int,
    ownerId	int unique,
    buildingId int not null,
    primary key (objectId),
    foreign key (agentId) references Agents(agentId),
    foreign key (ownerId) references Owners(ownerId),
    foreign key (buildingId) references Buildings(buildingId)
);

create table Deal(
    dealId int,
    agentId	int,
    objectId int,
    buyerId int,
    deal_type varchar check (deal_type in('Usual', 'Alternative')),--it can be null
    primary key (dealId),
    foreign key (agentId) references Agents(agentId),
    foreign key (objectId) references Object(objectId),
    foreign key (buyerId) references Buyers(buyerId)
);

create table Object_parameters(
    objectId int,
    obj_type varchar check (obj_type in ('Комната', 'Квартира')),
    price int,
    floor_plan varchar check (floor_plan in ('Секционка', 'Улучшенной планировки', 'Коммунальная', 'Хрущевка', 'Студия', 'Типовая', 'Элитная', 'Сталинка', 'Ленинка', 'Брежневка')),
    living_area	int,
    total_area int,
    floor int,
    amonut_of_rooms	int,
    object_num int,
    furniture_presence bool,
    repair_presence bool,
    additional_description varchar(10000),
    primary key(objectId),
    foreign key (objectId) references Object(objectId)
);

--People
-- Personal_data
--Telephone_book
-- Buyers
-- Owners
--Agents
--Object
-- Deal
-- Object_parameters
--Street_list
--Buildings
insert into People(surname, name, patronymic)
values('Elon','Musk', 'Vitalievich'),
                          ('Vitaliy','Ninja', 'Olegovich'),
                          ('Unanua','Kitaitsy', 'Idutnapole'),
                          ('Natasha','Rostova', 'Evgenievna'),
                          ('Poruchick','Rjevskiy', 'Sergeyevich'),
                          ('Александров','Максим', 'Святославович'),
                          ('Алексеева','Ксения', 'Максимовна'),
                          ('Алешина','Ирина', 'Фёдоровна'),
                          ('Сергей','Пухов', 'Михайлович'),
                          ('Воронов','Максим', 'Львович'),
                          ('Окабэ','Рейнтару', 'Аркадьевич'),
                          ('Герасимова','Ева', 'Максимовна'),
                          ('Кагами','Шинья', null),
                          ('Тсунамори','Акане', null),
                          ('Замураев','Виктор', 'Генадьевич'),
                          ('Сидорова','Кристина', 'Ивановна'),
                          ('Сайго','Джоджи', null),
                          ('Юдин','Алексей', 'Даниилович');

select * from people;
insert into Personal_data (pasport_number) values ('3714 123456'),
                                 ('3714 123451'),
                                 ('3714 123452'),
('3714 123453'),
('3714 123454'),
('3714 123455'),
('3714 123457'),
('3714 123458'),
('3714 123459'),
('3714 123450'),
('3714 923456'),
('3714 823456'),
('3714 723456'),
('3714 623456'),
('3714 523456'),
('3714 423456'),
('3714 323456'),
('3714 223456');

insert into Telephone_book (telephone_number) values ('8-963-277-33-74'),
                                 ('8-800-555-35-35'),
                                 ('8-800-555-35-34'),
('8-800-555-35-33'),
('8-800-555-35-32'),
('8-800-555-35-31'),
('8-800-555-35-30'),
('8-800-555-35-39'),
('8-800-555-35-38'),
('8-800-555-35-37'),
('8-800-555-35-36'),
('8-800-555-35-50'),
('8-800-555-35-51'),
('8-800-555-35-52'),
('8-800-555-35-53'),
('8-800-555-35-54'),
('8-800-555-35-55'),
('8-800-555-35-56');

insert into Owners(ownerId) VALUES (1),(2),(3),(4),(5);
insert into Agents(agentId, work_stage) values (6,1),
                                               (7,2),
                                               (8,3),
                                               (9,4),
                                               (10,5),
                                               (11,6),
                                               (12,6),
                                               (13,7),
                                               (14,3);
insert into Buyers(buyerId, reliability_factor) values (15,1),
                                                       (16,1),
                                                       (17,1),
                                                       (18,1);

insert into Street_list VALUES ('Первомайский', 'Шмидта', 2, 167),
                               ('Кировский', 'Бронная', 1, 167),
                               ('Ленинский', 'Степная', 2, 167);

insert into Buildings (district, street, floors_amount, repair_presence, building_year, wall_material) values
('Первомайский', 'Шмидта', 5, true, '02-02-2000', 'Кирпич'),
('Кировский', 'Бронная', 5, true, '02-02-2013', 'Кирпич'),
('Ленинский', 'Степная', 5, true, '02-02-2015', 'Кирпич');


insert into Object (agentId, ownerId,buildingId) VALUES (6, 1, 1),
                                             (8,2, 1),
                                             (8,3,2),
                                             (9,4,3),
                                             (10, 5,3);

insert into Object_parameters values (1, 'Комната', 900, 'Коммунальная', 15, 25, 3, 1, 324, true, true, null),
                                     (2, 'Квартира', 3500, 'Улучшенной планировки', 54, 47, 9, 3, 34, false, true, null),
                                     (3, 'Квартира', 2900, 'Сталинка',  25, 40, 3, 2, 313, true, true, null),
                                     (4, 'Квартира', 2500, 'Секционка', 35, 45, 4, 2, 424, true, true, null),
                                     (5, 'Квартира', 2350, 'Студия', 30, 40, 1, 3, 122, true, true, null);

select * from people;
select * from  Personal_data;
select * from  Telephone_book;
select personId, surname from Buyers, People where buyerId=People.personId;
select personId, surname from Owners, People where ownerId=People.personId;
select personId, surname from Agents, People where Agents.agentId=People.personId;
select * from  Object;
select * from Deal;
select * from  Object_parameters;
select * from Street_list;
select * from  Buildings;
