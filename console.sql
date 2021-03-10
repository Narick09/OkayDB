CREATE TABLE Persons
(
    "Pasport data" int PRIMARY KEY,
    Surname varchar(60) not null,
    Name varchar(60) not null,
    Login varchar(60) UNIQUE,
    Email varchar(60) UNIQUE,
    Department varchar(60) check (department in ('администрация', 'бухгалтерия', 'производство', 'поддержка пользователей')),
    city varchar(20)
);

CREATE TABLE Project
(
    Name varchar(100) primary key,
    Description text,
    "Start project date" date not null,
    "Ending project date" date
);

CREATE TABLE Task
(
    taskID int PRIMARY KEY,
    "project ownership" varchar,
    Name varchar(100),
    Priority int,
    Description text,
    Status varchar(12) check (status in ( 'Новая', 'Переоткрыта', 'Выполняется', 'Закрыта' )),
    "Required time" int,
    "spent time" int,
    "Ending task date" date,
    "starting task date" date,
    Executing varchar,
    Creator varchar,
    FOREIGN KEY ("project ownership") REFERENCES project (Name),
    FOREIGN KEY (executing) REFERENCES Persons (login),
    FOREIGN KEY (Creator) REFERENCES Persons (login)
);

--------------------------------------------------------------------------------
INSERT INTO Persons VALUES ('1','Касаткин','Артем','ArtyomKas01','ArtyomKas01@mail.ru','администрация',null);
INSERT INTO Persons VALUES ('2','Петрова','София','SofiaPet','SofiaPet@mail.ru','бухгалтерия',null);
INSERT INTO Persons VALUES ('3','Дроздов','Федор','Drozd200','Drozd200@mail.ru','бухгалтерия','Москва');
INSERT INTO Persons VALUES ('4','Иванова','Василина','Ivas9','Ivas9@mail.ru','бухгалтерия',null);
INSERT INTO Persons VALUES ('5','Беркут','Алексей','bercal','bercal@mail.ru','производство','Владивосток');
INSERT INTO Persons VALUES ('6','Белова','Вера','Belochka','Belochka@mail.ru','администрация','Москва');
INSERT INTO Persons VALUES ('7','Макенрой','Алексей','makentoshAl','makentoshAl@mail.ru','производство','Новосибирск');

INSERT INTO Project VALUES ('РТК',NULL,'2016-01-31',NULL);
INSERT INTO Project VALUES ('СС.Коннект',NULL,'2015-02-23','2016-12-31');
INSERT INTO Project VALUES ('Демо-Сибирь',NULL,'2015-05-11','2015-01-31');
INSERT INTO Project VALUES ('МВД-Онлайн',NULL,'2015-05-22','2016-01-31');
INSERT INTO Project VALUES ('Поддержка',NULL,'2016-06-07',NULL);

insert into Task (taskID, "project ownership",Name,Priority, Status, "Ending task date", Creator) VALUES
(1, 'РТК', 'Create DB', 1, 'Выполняется', '2021-03-11', 'ArtyomKas01'),
(2, 'МВД-Онлайн', 'Watch DB', 55, 'Переоткрыта', '2021-03-11', 'Belochka'),
(3, 'Демо-Сибирь', 'Do Something', 15, 'Выполняется', '2021-03-11', 'bercal'),
(4, 'Поддержка', 'Create host-server', 12, 'Новая', '2021-03-11', 'makentoshAl');

update Task set priority=100 where name='Create DB';
update Task set Executing='Drozd200' where name='Create DB';
update Task set Executing='makentoshAl' where name='Do Something';
update Task set Executing='Drozd200' where name='Create host-server';
update Task set Executing='bercal' where name='Read man(documentation)';
update Task set Executing='SofiaPet' where name='Watch DB' and "project ownership"='СС.Коннект';
--update Task set Creator='bercal' where name='Do Something';
insert into Task (taskID, "project ownership",Name,Priority, Status, "Ending task date", Creator) VALUES
(6, 'СС.Коннект', 'Read man(documentation)', 51, 'Новая', '2021-03-11', 'ArtyomKas01'),
(5, 'СС.Коннект', 'Watch DB', 0, 'Закрыта', '2021-03-11', 'Ivas9');

insert into Task (taskID, "project ownership",Name,Priority, Status, "Ending task date", Creator, executing) VALUES
(7, 'Демо-Сибирь', 'Write the article', 5, 'Новая', '2016-01-01', 'SofiaPet' ,'ArtyomKas01'),
(8, 'Поддержка', 'Call to ArtyomKas01', 2, 'Переоткрыта', '2016-01-01', 'Ivas9', 'ArtyomKas01'),
(9, 'Демо-Сибирь', 'Build home', 57, 'Новая', '2016-01-02', 'SofiaPet', 'ArtyomKas01'),
(10, 'Поддержка', 'Call to ArtyomKas01', 2, 'Переоткрыта', '2016-01-01', 'Ivas9', 'ArtyomKas01');
update task set "starting task date"='2016-01-01' where ("Ending task date" between '2016-01-01' AND '2016-01-03');
update task set name='Call to mariaDB' where taskid=10;
update task set name='reload system' where taskid=8;
update task set name='Build home' where taskid=9;
insert into Task (taskID, "project ownership",Name,Priority, Status, "Ending task date", Creator, executing) VALUES
(11, 'СС.Коннект', 'Calculate discriminant', 5, 'Новая', '2016-01-01', 'ArtyomKas01' ,'SofiaPet'),
(12, 'Поддержка', 'Solve problem', 2, 'Переоткрыта', '2016-01-01', 'Ivas9', 'SofiaPet');
insert into Task (taskID, "project ownership",Name,Priority, Status, "Ending task date", Creator) VALUES
(13, 'СС.Коннект', 'Remake product', 13, 'Новая', '2021-03-11', 'ArtyomKas01'),
(14, 'СС.Коннект', 'Show presentation', 0, 'Закрыта', '2021-03-11', 'Ivas9');
-----------------------------------------------------------------------------------
--3a
SELECT * from Task;
SELECT Task.* from Task;
--3b
select Surname, Name, Department from persons;
--3c
select login, Email from persons;
--3d
select name, Priority from Task where Priority>50;
--3e
select persons.Surname,persons.name, task.Name from persons,task where Persons.login=task.Executing;
--3f
select executing from task
union
select Creator from task;
--3k
select name, Executing, Creator from task where Creator!='SofiaPet' and Executing in ('Ivas9', 'bercal', 'Drozd200');
--4
select name, Executing, "starting task date" from task where Executing='ArtyomKas01' and ("starting task date" between '2016-01-01' AND '2016-01-03');
--5
select name,Creator from task where Executing='SofiaPet' and Creator in (select Login from persons where Department in ('администрация', 'бухгалтерия', 'производство'));
--6.2
select name, Executing from task where Executing is null;
--6.3
update task set executing='SofiaPet' where executing is null;
select name, Executing from task where Executing='SofiaPet';
--update task set executing=null where taskID in (5,13,14);

--7
drop table if EXISTS Task2;
create table task2 as select * from Task;
select * from task2;
--8
select * from persons where
                            name not like '%а'
                        and Surname not like '%а'
                        and login like 'b%'
                        and login like '%r%';
