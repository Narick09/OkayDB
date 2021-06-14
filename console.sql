drop table if exists people cascade;
drop table if exists Personal_data cascade;
drop table if exists Telephone_book cascade;
drop table if exists Buyers cascade;
drop table if exists Owners cascade;
drop table if exists Agents cascade;
drop table if exists Object cascade;
drop table if exists Deal cascade;
--drop table if exists Object_parameters cascade;
drop table if exists Street_list cascade;
drop table if exists Buildings cascade;
----------------------------------------------------------------------------------------
------------------------------------tables----------------------------------------------
create table People(
    personId serial,--идентификатор
	surname	varchar(100) not null,--фамилия
	name	varchar(100),--имя
	patronymic	varchar(100),--отчество
	primary key (personId)
);

create table Personal_data(
    personId serial,--идентификатор
    pasport_number varchar(10) unique not null check (pasport_number between '3000000000' and '3999999999'),
    --номер паспорта
    foreign key (personId) references People(personId),
    primary key (personId)
);

create table Telephone_book(
    personId serial,
    telephone_number varchar(11) unique not null check (telephone_number between '80000000000' and '89999999999'),
    --телефонный номер
    foreign key (personId) references People(personId),
	primary key (personId)
);
create table Buyers
(
    buyerId            int,
    reliability_factor int check ( reliability_factor between 0 and 100),
    --индекс надежности покупателя - платежеспособность и т.п.(от 0 до 100)
    foreign key (buyerId) references People(personId),
	primary key (buyerId)
);

create table Owners
(
    ownerId int,
    personal_counter int,--число объектов продажи(сколько раз продавец обращался к агенству)
    foreign key (ownerId) references People(personId),
	primary key (ownerId)
);

create table Agents
(
    agentId int,
    work_stage int,--стаж работы
    foreign key (agentId) references People(personId),
	primary key (agentId)
);

create table Street_list(
    district varchar,--название района
    street varchar,--название улицы
    primary key (district,street)
);

create table Buildings(
    buildingId	serial,--идентификатор
    build_number int not null,--номер дома на улице
    district varchar,--район
    street	varchar not null,--улица
    floors_amount int,--число этажей
    repair_presence	bool,--наличие ремонта
    building_year date,--год постройки
    wall_material varchar,--материал стен--добавить чек-ограничения
    primary key (buildingId),
    foreign key (district, street) references Street_list(district, street)
);

create table Object(
    objectId serial,--идентификатор
    buildingId int,--идентификатор дома, в котором расположен этот объект
    agentId	int,--идентификатор агента, работающего с данным объектом
    ownerId	int unique,--идентификатор владельца данноого объекта
    obj_type varchar check (obj_type in ('Комната', 'Квартира')),--тип объекта
    price int,--цена
    floor_plan varchar check (floor_plan in ('Секционка', 'Улучшенной планировки', 'Коммунальная', 'Хрущевка', 'Студия', 'Типовая', 'Элитная', 'Сталинка', 'Ленинка', 'Брежневка')),
    --планировка
    living_area	int,--жил площадь
    total_area int,--вся площадь
    floor int,--этаж
    amonut_of_rooms	int,--число комнат
    object_num int,--номер объекта (в доме)
    furniture_presence bool,--наличие мебели
    repair_presence bool,--наличие ремонта
    additional_description varchar(10000),--доп информация
    primary key (objectId),
    foreign key (agentId) references Agents(agentId),
    foreign key (ownerId) references Owners(ownerId),
    foreign key (buildingId) references Buildings(buildingId)
);

create table Deal(
    dealId int,--идентификатор сделки
    agentId	int,--идентификатор агента, проводящего сделку
    objectId int,--идентификатор объекта сделки
    buyerId int,--идентификатор покупателя
    deal_type varchar not null check (deal_type in('Обычная', 'Альтернативная')),--тип сделки
    --альтернативная значит с последующей покупкой
    primary key (dealId),
    foreign key (agentId) references Agents(agentId),
    foreign key (objectId) references Object(objectId),
    foreign key (buyerId) references Buyers(buyerId)
);
/*
create table Object_parameters(
    objectId int,--идентификатор
    obj_type varchar check (obj_type in ('Комната', 'Квартира')),--тип объекта
    price int,--цена
    floor_plan varchar check (floor_plan in ('Секционка', 'Улучшенной планировки', 'Коммунальная', 'Хрущевка', 'Студия', 'Типовая', 'Элитная', 'Сталинка', 'Ленинка', 'Брежневка')),
    --планировка
    living_area	int,--жил площадь
    total_area int,--вся площадь
    floor int,--этаж
    amonut_of_rooms	int,--число комнат
    object_num int,--номер объекта (в доме)
    furniture_presence bool,--наличие мебели
    repair_presence bool,--наличие ремонта
    additional_description varchar(10000),--доп информация
    primary key(objectId),
    foreign key (objectId) references Object(objectId)
);
*/
----------------------------------------------------------------------------------------
-----------------------------------some inserts-----------------------------------------
/*
insert into People(surname, name, patronymic)
values('Elon','Musk', 'Vitalievich'),
                          ('Vitaliy','Ninja', 'Olegovich'),
                          ('Unanua','Kitaitsy', 'Idutnapole'),
                          ('Natasha','Rostova', 'Evgenievna'),
                          ('Poruchick','Rjevskiy', 'Sergeyevich'),
                          ('Alexandrov','Maxim', 'Svyatoslavovich'),
                          ('Alekseeva','Kseniya', 'Maximovna'),
                          ('Alyoshina','Irina', 'Fyodorovna'),
                          ('Sergey','Puhov', 'Mihailovich'),
                          ('Voronov','Maxim', 'Lvovich'),
                          ('Okabe','Reintaro', 'Arkadievich'),
                          ('Gerasimova','Eva', 'Maximovna'),
                          ('Kogami','Shinya', null),
                          ('Tsunamori','Akane', null),
                          ('Zamuraev','Viktor', 'Gennadievich'),
                          ('Sidorova','Kristina', 'Ivanovna'),
                          ('Sayga','Joji', null),
                          ('Yudin','Alaxey', 'Daniilovich');
*/
insert into People(surname, name, patronymic)
values('Илон','Маск', 'Витальевич'),
                          ('Виталий','Ниндзя', 'Олегович'),
                          ('Уняня','Китайцы', 'Идутнаполе'),
                          ('Наташа','Ростова', 'Евгеньевна'),
                          ('Поручик','Ржевский', 'Сергеевич'),
                          ('Александров','Масим', 'Святославович'),
                          ('Алексеева','Ксения', 'Максимовна'),
                          ('Алёшина','Ирина', 'Федоровна'),
                          ('Сергей','Пухов', 'Михайлович'),
                          ('Воронов','Максим', 'Львович'),
                          ('Окабэ','Рейнтаро', 'Аркадиевич'),
                          ('Герасимова','Ева', 'Максимовна'),
                          ('Когами','Шинья', null),
                          ('Тсунамори','Акане', null),
                          ('Замураев','Виктор', 'Геннадьевич'),
                          ('Сидорова','Кристина', 'Ивановна'),
                          ('Сайго','Джоджи', null),
                          ('Юдин','Алексей', 'Даниилович');

select * from people;
insert into Personal_data (pasport_number) values ('3714123456'),
                                 ('3714123451'),
                                 ('3714123452'),
('3714123453'),
('3714123454'),
('3714123455'),
('3714123457'),
('3714123458'),
('3714123459'),
('3714123450'),
('3714923456'),
('3714823456'),
('3714723456'),
('3714623456'),
('3714523456'),
('3714423456'),
('3714323456'),
('3714223456');

/*
-- insert into Telephone_book (telephone_number) values ('8-963-277-33-74'),
--                                  ('8-800-555-35-35'),
--                                  ('8-800-555-35-34'),
-- ('8-800-555-35-33'),
-- ('8-800-555-35-32'),
-- ('8-800-555-35-31'),
-- ('8-800-555-35-30'),
-- ('8-800-555-35-39'),
-- ('8-800-555-35-38'),
-- ('8-800-555-35-37'),
-- ('8-800-555-35-36'),
-- ('8-800-555-35-50'),
-- ('8-800-555-35-51'),
-- ('8-800-555-35-52'),
-- ('8-800-555-35-53'),
-- ('8-800-555-35-54'),
-- ('8-800-555-35-55'),
-- ('8-800-555-35-56');
*/

insert into Telephone_book (telephone_number) values ('89632773374'),
('88005553535'),('88005553534'),('88005553533'),('88005553532'),
('88005553531'),('88005553530'),('88005553539'),('88005553538'),
('88005553537'),('88005553536'),('88005553550'),('88005553551'),
('88005553552'),('88005553553'),('88005553554'),('88005553555'),
('88005553556');
select * from Telephone_book;

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

insert into Street_list VALUES ('Первомайский', 'Шмидта'),
                               ('Кировский', 'Бронная'),
                               ('Ленинский', 'Степная');

insert into Buildings (build_number, district, street, floors_amount, repair_presence, building_year, wall_material) values
(35, 'Первомайский', 'Шмидта',5, true, '02-02-2000', 'Кирпич'),
(14, 'Кировский', 'Бронная', 5, true, '02-02-2013', 'Кирпич'),
(18, 'Ленинский', 'Степная', 5, true, '02-02-2015', 'Кирпич');

insert into Object (agentId,ownerId, buildingId,  obj_type, price,
                    floor_plan, living_area, total_area, floor,
                    amonut_of_rooms, object_num, furniture_presence, repair_presence, additional_description)
VALUES (6, 1, 1, 'Комната', 900, 'Коммунальная', 15, 25, 3, 1, 324, true, true, null),
                                             (8,2, 1, 'Квартира', 3500, 'Улучшенной планировки', 47, 54, 9, 3, 34, false, true, null),
                                             (8,3,2, 'Квартира', 2900, 'Сталинка',  25, 40, 3, 2, 313, true, true, null),
                                             (9,4,3, 'Квартира', 2500, 'Секционка', 35, 45, 4, 2, 424, true, true, null),
                                             (10, 5,3, 'Квартира', 2350, 'Студия', 30, 40, 1, 3, 122, true, true, null);
----------------------------------------------------------------------------------------
-----------------------------------functions--------------------------------------------
-----------------------------------boolean----------------------------------------------
/*
drop function if exists isExist_street(street varchar);
create or replace function isExist_street(street varchar) returns bool as
    $$
        BEGIN
            if street in (select Street_list.street from Street_list) then
                return true;
            else
                return false;
            end if;
        end;
    $$ Language plpgsql;

drop function if exists isExist_district(district varchar);
create or replace function isExist_district(district varchar) returns bool as
    $$
        BEGIN
            if district in (select Street_list.district from Street_list) then
                return true;
            else
                return false;
            end if;
        end;
    $$ Language plpgsql;
--drop function isExist_address(district varchar, street varchar, build_num int);

drop function if exists isExist_address( district varchar,street varchar, build_num int);
create or replace function isExist_address( district varchar,street varchar, build_num int) returns bool as
    $$
        BEGIN
            if (street, district) in (select Street_list.street,Street_list.district from Street_list) and
                build_num in (select build_number from Buildings) then
                return true;
            else
                return false;
            end if;
        end;
    $$ Language plpgsql;
*/
select * from Object where objectId not in (select Deal.objectId from Deal);
-----------------------------------changing--------------------------------------------

drop function if exists add_buyer(Surname_ varchar, Name_ varchar, Patronymic_ varchar, reliability_factor_ int);
create or replace function add_buyer(Surname_ varchar, Name_ varchar, Patronymic_ varchar, reliability_factor_ int)
returns void as
    $$
        BEGIN
            insert into people (surname, name, patronymic) values (Surname_, Name_, Patronymic_);
            insert into buyers (buyerId, reliability_factor) values ((select max(personId) from people group by personId), reliability_factor_);
        end;
    $$ LANGUAGE plpgsql;

drop function if exists add_owner(Surname_ varchar, Name_ varchar, Patronymic_ varchar);
create or replace function add_owner(Surname_ varchar, Name_ varchar, Patronymic_ varchar, personal_counter_ int)
returns void as
    $$
        BEGIN
            insert into people (surname, name, patronymic) values (Surname_, Name_, Patronymic_);
            insert into owners(ownerId, personal_counter) values ((select max(personId) from people group by personId), personal_counter_);
        end;
    $$ LANGUAGE plpgsql;

drop function if exists add_agent(Surname_ varchar, Name_ varchar, Patronymic_ varchar, work_stage_ int);
create or replace function add_agent(Surname_ varchar, Name_ varchar, Patronymic_ varchar, work_stage_ int)
returns varchar as
    $$
    declare
    id int;
    max_id int;
        BEGIN
            id = 0;
            max_id = 0;
            id = (select personId from people where Surname_ = surname and Name_= Name and  Patronymic_ = Patronymic);
            if (id != 0) then
                if(id in (select agentId from agents)) then
                    update Agents set work_stage=work_stage_ where agentId=id;
                    return 'Агент уже в БД. Данные изменены';
                else
                    insert into Agents (agentId, work_stage) values (id, work_stage_);
                end if;
            else
                insert into People values (max_id, Surname_, Name_, Patronymic_);
                max_id = (select max(personId) from people group by personId limit 1);
                insert into Agents (agentId, work_stage) values (max_id, work_stage_);
            end if;
            return 'Агент добавлен';
        end
    $$ LANGUAGE plpgsql;

drop function if exists add_object(Surname_ varchar, Name_ varchar, Patronymic_ varchar, work_stage_ int);
create or replace function add_object(Surname_ varchar, Name_ varchar, Patronymic_ varchar, work_stage_ int)
returns void as
    $$
        BEGIN
            insert into People (surname, name, patronymic) values (Surname_, Name_, Patronymic_);
            insert into Agents (agentId, work_stage) values ((select max(personId) from people group by personId), work_stage_);
        end;
    $$ LANGUAGE plpgsql;



-----------------------------------selects---------------------------------------------
drop function if exists select_owners_objects(Owner_Surname_ varchar, Owner_Name_ varchar, Owner_Patronymic_ varchar);
create or replace function select_owners_objects(Owner_Surname_ varchar, Owner_Name_ varchar, Owner_Patronymic_ varchar)
returns setof Object AS $$
    declare
        id int;
    BEGIN
    select personId from owners, people where surname=Owner_Surname_
                                   and name = Owner_Name_
                                   and patronymic = Owner_Patronymic_
                                   and people.personId=Owners.ownerId
                                       into id;
    return query
        select * from Object where Object.ownerId = id;
    end;
    $$ LANGUAGE plpgsql;

drop function if exists select_agents_objects(Agent_Surname_ varchar, Agent_Name_ varchar, Agent_Patronymic_ varchar);
create or replace function select_agents_objects(Agent_Surname_ varchar, Agent_Name_ varchar, Agent_Patronymic_ varchar)
returns setof Object AS $$
    declare
        id int;
    BEGIN
    select personId from Agents, people where surname = Agent_Surname_
                                   and name = Agent_Name_
                                   and patronymic = Agent_Patronymic_
                                   and people.personId=Agents.agentId
                                       into id;
    return query
        select * from Object where Object.agentId = id;
    end;
    $$ LANGUAGE plpgsql;
     -- ('Юдин','Алексей', 'Даниилович');
drop function if exists select_client_id(Client_Surname_ varchar, Client_Name_ varchar, Client_Patronymic_ varchar);
create or replace function select_client_id(Client_Surname_ varchar, Client_Name_ varchar, Client_Patronymic_ varchar)
returns int AS $$
    declare
        id int;
    BEGIN
    id = (select personId from Buyers, people where surname = Client_Surname_
                                   and name = Client_Name_
                                   and patronymic = Client_Patronymic_
                                   and people.personId=Buyers.buyerId);
                                    --into id;
    return id;
    end;
    $$ LANGUAGE plpgsql;

drop function if exists select_client_telephone(Client_Surname_ varchar, Client_Name_ varchar, Client_Patronymic_ varchar);
create or replace function select_client_telephone(Client_Surname_ varchar, Client_Name_ varchar, Client_Patronymic_ varchar)
returns setof Telephone_book AS $$
    BEGIN
    return query
        select * from telephone_book
        where personId = select_client_id(Client_Surname_, Client_Name_, Client_Patronymic_);
    end;
    $$ LANGUAGE plpgsql;

drop function if exists select_client_personal_data(Client_Surname_ varchar, Client_Name_ varchar, Client_Patronymic_ varchar);
create or replace function select_client_personal_data(Client_Surname_ varchar, Client_Name_ varchar, Client_Patronymic_ varchar)
returns setof Personal_data AS $$
    BEGIN
    return query
        select * from Personal_data
        where personId = select_client_id(Client_Surname_, Client_Name_, Client_Patronymic_);
    end;
    $$ LANGUAGE plpgsql;

drop function if exists select_client_name_by_telephone(Client_Telephone varchar);
create or replace function select_client_name_by_telephone(Client_Telephone varchar)
returns setof people AS $$
    BEGIN
    return query
        select People.personId, People.surname, People.name, People.patronymic
        from people, Buyers, telephone_book
        where buyerId = (select buyerId from buyers, telephone_book
        where Telephone_book.personId = buyers.buyerId
            and telephone_number = Client_Telephone);
    end;
    $$ LANGUAGE plpgsql;
