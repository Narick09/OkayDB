drop table if exists people;
drop table if exists Personal_data;
drop table if exists Telephone_book;
drop table if exists Buyers;
drop table if exists Owners;
drop table if exists Agents;
drop table if exists Object;
drop table if exists Deal;
drop table if exists Object_parameters;
drop table if exists Street_list;
drop table if exists Buildings;

create table People(
    personId serial,
	surname	varchar(100),
	name	varchar(100),
	patronymic	varchar(100),
	primary key (personId)
);

create table Personal_data(
    personId int,
    pasport_number varchar(11) unique not null,--need to check pattern
    foreign key (personId) references People(personId),
    primary key (personId)
);

create table Telephone_book(
    personId int,
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

create table Object(
    objectId int,
    agentId	int,
    ownerId	int,
    primary key (objectId),
    foreign key (agentId) references Agents(agentId),
    foreign key (ownerId) references Owners(ownerId)
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
    floor_plan varchar check (obj_type in ('Секционка', 'Улучшенной планировки', 'Коммунальная, Хрущевка', 'Студия', 'Типовая', 'Элитная', 'Сталинка', 'Ленинка', 'Брежневка')),
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

create table Street_list(
    district varchar,
    street varchar,
    amount_selling_objects int,
    amount_buildings int,
    primary key (district,street)
);

create table Buildings(
    buildingId	int,
    objectId int,
    district varchar,
    street	varchar,
    floors_amount int,
    repair_presence	bool,
    building_year date,
    wall_material varchar,
    primary key (buildingId),
    foreign key (objectId) references Object(objectId),
    foreign key (district, street) references Street_list(district, street)
);

