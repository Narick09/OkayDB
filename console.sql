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
    --repair_presence	bool,--наличие ремонта
    --building_year int check (building_year between 1950 and 2021),--год постройки
    --wall_material varchar,--материал стен--добавить чек-ограничения
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
    area	int,--жил площадь
    floor int,--этаж
    amonut_of_rooms	int,--число комнат
    object_num int,--номер объекта (в доме)
    additional_description varchar(10000),--доп информация
    primary key (objectId),
    foreign key (agentId) references Agents(agentId),
    foreign key (ownerId) references Owners(ownerId) on delete cascade,
    foreign key (buildingId) references Buildings(buildingId)
);

create table Deal(
    dealId serial,--идентификатор сделки
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

insert into Buildings (build_number, district, street, floors_amount) values
(35, 'Первомайский', 'Шмидта',5),
(14, 'Кировский', 'Бронная', 5),
(18, 'Ленинский', 'Степная', 5);

insert into Object (agentId,ownerId, buildingId,  obj_type, price,
                     area, floor,
                    amonut_of_rooms, object_num, additional_description)
VALUES (6, 1, 1, 'Комната', 900, 15, 3, 1, 324, null),
                                             (8,2, 1, 'Квартира', 3500,  47,  9, 3, 34, null),
                                             (8,3,2, 'Квартира', 2900,   25,  3, 2, 313, null),
                                             (9,4,3, 'Квартира', 2500, 35,  4, 2, 424, null),
                                             (10, 5,3, 'Квартира', 2350,  40, 1, 3, 122, null);
----------------------------------------------------------------------------------------
-----------------------------------functions--------------------------------------------
-----------------------------------getters----------------------------------------------
/*drop function if exists getID_people(Surname_ varchar, Name_ varchar, Patronymic_ varchar);
create or replace function getID_people(Surname_ varchar, Name_ varchar, Patronymic_ varchar)
returns int as
    $$
    declare
    id int;
        BEGIN
            id = 0;
            id = (select personId from people where Surname_ = surname and Name_= Name and  Patronymic_ = Patronymic);
            return id;
        end
    $$ LANGUAGE plpgsql;*/
-----------------------------------adding--------------------------------------------
drop function if exists add_people(Surname_ varchar, Name_ varchar, Patronymic_ varchar, telephone_number_ varchar, passport_data_ varchar);
create or replace function add_people(Surname_ varchar, Name_ varchar, Patronymic_ varchar,  telephone_number_ varchar, passport_data_ varchar)
returns int as
    $$
    declare
    id int;
        BEGIN
            id = 0;
            id = (select personId from people where Surname_ = surname and Name_= Name and  Patronymic_ = Patronymic);
            if (id != 0) then
                if (passport_data_ is not null) then
                    update Personal_data set pasport_number=passport_data_ where personId=id;
                end if;
                if (telephone_number_ is not null) then
                    update Telephone_book set telephone_number=telephone_number_ where personId=id;
                end if;
            else
                insert into People (surname, name, patronymic) values (Surname_, Name_, Patronymic_);
                id = (select personId from people where
                Surname_=Surname and Name_ = Name and Patronymic_=Patronymic);
                insert into Personal_data values (id, passport_data_);
                insert into telephone_book values (id, telephone_number_);
            end if;
            return id;
        end
    $$ LANGUAGE plpgsql;

drop function if exists add_buyer(Surname_ varchar, Name_ varchar, Patronymic_ varchar, telephone_number_ varchar, passport_data_ varchar,reliability_factor_ int);
create or replace function add_buyer(Surname_ varchar, Name_ varchar, Patronymic_ varchar, telephone_number_ varchar, passport_data_ varchar, reliability_factor_ int)
returns varchar as
    $$
    declare
    id int;
    buyer_id int;
        BEGIN
            id = add_people(Surname_,Name_, Patronymic_, telephone_number_, passport_data_);
            buyer_id = 0;
            buyer_id = (select buyerid from buyers where buyerid = id);
            if (buyer_id != 0) then
                update buyers set reliability_factor=reliability_factor_ where buyerId=id;
                return 'Клиент уже в БД. Данные изменены';
            else
                insert into buyers (buyerId, reliability_factor) values (id, reliability_factor_);
            end if;
            return 'Клиент добавлен';
        end
    $$ LANGUAGE plpgsql;

drop function if exists add_owner(Surname_ varchar, Name_ varchar, Patronymic_ varchar, telephone_number_ varchar, passport_data_ varchar);
create or replace function add_owner(Surname_ varchar, Name_ varchar, Patronymic_ varchar, telephone_number_ varchar, passport_data_ varchar)
returns varchar as
    $$
    declare
    id int;
    owner_id int;
        BEGIN
            id = add_people(Surname_,Name_, Patronymic_, telephone_number_, passport_data_);
            owner_id = 0;
            owner_id = (select ownerId from owners where ownerId = id);
            if (owner_id != 0) then
                update owners set personal_counter = personal_counter + 1 where ownerId = id;
                return 'Владелец уже в БД. Данные изменены';
            else
                insert into owners (ownerId, personal_counter) values (id, 1);
            end if;
            return 'Владелец добавлен';
        end
    $$ LANGUAGE plpgsql;

drop function if exists add_agent(Surname_ varchar, Name_ varchar, Patronymic_ varchar, telephone_number_ varchar, passport_data_ varchar, work_stage_ int);
create or replace function add_agent(Surname_ varchar, Name_ varchar, Patronymic_ varchar, telephone_number_ varchar, passport_data_ varchar, work_stage_ int)
returns varchar as
    $$
    declare
    id int;
    agent_id int;
        BEGIN
            id = add_people(Surname_,Name_, Patronymic_, telephone_number_, passport_data_);
            agent_id = 0;
            agent_id = (select agentId from agents where agentId = id);
            if (agent_id != 0) then
                update Agents set work_stage=work_stage_ where agentId=id;
                return 'Агент уже в БД. Данные изменены';
            else
                insert into Agents (agentId, work_stage) values (id, work_stage_);
            end if;
            return 'Агент добавлен';
        end
    $$ LANGUAGE plpgsql;
--select max(personId) from people group by personId;-- limit 1;

-------------------------------------------------------------objects--
drop function if exists add_address(district_ varchar, street_ varchar);
create or replace function add_address(district_ varchar, street_ varchar)
returns void as
    $$
        BEGIN
            if (select street from street_list where district_=district and street_=street) is null then
                insert into street_list (district, street) values (district_, street_);
            end if;
        end;
    $$ LANGUAGE plpgsql;

drop function if exists add_building(district_ varchar, street_ varchar, build_num_ int, floors_amount_ int);
create or replace function add_building(district_ varchar, street_ varchar, build_num_ int, floors_amount_ int)
returns int as
    $$
    declare
    id int;
        BEGIN
             execute add_address(district_, street_);
             id = 0;
             id = (select buildingId from Buildings where district_=district and street_=street
                                                    and build_num_ = build_number);
             if (id != 0) then
                    update Buildings set build_number = build_num_, district = district_ , street=street_,
                                          floors_amount=floors_amount_
                    where id = buildingId;
             else
                  insert into Buildings (build_number, district , street, floors_amount)
                        values (build_num_, district_ ,street_, floors_amount_);
             end if;
            return id;
            end;
    $$ LANGUAGE plpgsql;

drop function if exists add_object(district_ varchar, street_ varchar, build_num_ int,
floors_amount_ int, ownerId_ int, agentId_ int, obj_type_ varchar, price_ int, area_ int,
floor_ int, amonut_of_rooms_ int,  object_num_ int, additional_description_ varchar
);
create or replace function add_object(district_ varchar, street_ varchar, build_num_ int,
floors_amount_ int, ownerId_ int, agentId_ int, obj_type_ varchar, price_ int, area_ int,
floor_ int, amonut_of_rooms_ int,  object_num_ int, additional_description_ varchar
)
returns varchar as
    $$
    declare
        build_id int;
        BEGIN
            build_id = add_building(district_, street_, build_num_,floors_amount_);
             if object_num_ in (select object_num from object where buildingId = build_id) then
                 return 'Объект уже существует';
             else
                 insert into object (buildingId, agentId, ownerId, obj_type, price, area,
                                     floor, amonut_of_rooms, object_num, additional_description)
                 values (build_id, agentId_, ownerId_, obj_type_, price_,  area_,
                                     floor_, amonut_of_rooms_, object_num_, additional_description_);
             end if;
            --getID_people
        return 'Объект добавлен';
        end;
    $$ LANGUAGE plpgsql;

drop function if exists add_deal(objectId_ int, clientId int, deal_type_ varchar);
create or replace function add_deal(objectId_ int, clientId_ int, deal_type_ varchar)
returns varchar as
    $$
        BEGIN
            insert into deal (agentId, objectId, buyerId, deal_type)
            values ((select Agents.agentID from Agents, object where Agents.agentId = object.agentId and object.objectId = objectId_),
                    objectId_, clientId_, deal_type_);
        return 'Сделка добавлена';--. Id: ' + (select dealId from deal where objectId = objectId_);
        end
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

-----------------------------------deleting---------------------------------------------
drop function if exists delete_agent(People_Surname_ varchar, People_Name_ varchar, People_Patronymic_ varchar);
create or replace function delete_agent(People_Surname_ varchar, People_Name_ varchar, People_Patronymic_ varchar)
returns varchar AS $$
    BEGIN
        delete from agents where agentId =
                                 (select personId from people
                                 where people.surname = People_Surname_
                                   and people.name = People_Name_
                                   and people.patronymic = People_Patronymic_);
        return 'Человек вычеркнут из списка сотрудников';
    end;
    $$ LANGUAGE plpgsql;

drop function if exists delete_owner(People_Surname_ varchar, People_Name_ varchar, People_Patronymic_ varchar);
create or replace function delete_owner(People_Surname_ varchar, People_Name_ varchar, People_Patronymic_ varchar)
returns varchar AS $$
    BEGIN
        delete from owners where ownerId =
                                 (select personId from people
                                 where people.surname = People_Surname_
                                   and people.name = People_Name_
                                   and people.patronymic = People_Patronymic_);
        return 'Человек вычеркнут из списка владельцев';
    end;
    $$ LANGUAGE plpgsql;

drop function if exists delete_client(People_Surname_ varchar, People_Name_ varchar, People_Patronymic_ varchar);
create or replace function delete_client(People_Surname_ varchar, People_Name_ varchar, People_Patronymic_ varchar)
returns varchar AS $$
    BEGIN
        delete from buyers where buyerId =
                                 (select personId from people
                                 where people.surname = People_Surname_
                                   and people.name = People_Name_
                                   and people.patronymic = People_Patronymic_);
        return 'Человек вычеркнут из списка клиентов';
    end;
    $$ LANGUAGE plpgsql;

drop function if exists delete_person(People_Surname_ varchar, People_Name_ varchar, People_Patronymic_ varchar);
create or replace function delete_person(People_Surname_ varchar, People_Name_ varchar, People_Patronymic_ varchar)
returns varchar AS $$
    declare
    id int;
    BEGIN
    	id = (select personId from people where People_Surname_ = surname and People_Name_ = name and People_Patronymic_ = patronymic);
        delete from personal_data where personId = id;
    	delete from telephone_book where personId = id;
        delete from people where surname = People_Surname_ and name = People_Name_ and patronymic = People_Patronymic_;
        return 'Человек удален из базы данных';
    end;
    $$ LANGUAGE plpgsql;

