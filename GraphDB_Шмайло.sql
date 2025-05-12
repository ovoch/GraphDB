USE master;
DROP DATABASE IF EXISTS GraphDB;
CREATE DATABASE GraphDB;
GO
USE GraphDB;
GO

-- Создание таблиц узлов
CREATE TABLE Rapper (
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(50) NOT NULL
) AS NODE;
GO

CREATE TABLE Studio (
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    country NVARCHAR(30) NOT NULL
) AS NODE;
GO

CREATE TABLE Track (
    id INT NOT NULL PRIMARY KEY,
    title NVARCHAR(50) NOT NULL
) AS NODE;
GO

-- Создание таблиц рёбер
CREATE TABLE Collabs AS EDGE;
CREATE TABLE SignedWith AS EDGE;
CREATE TABLE RecordedIn (
    recording_year INT
) AS EDGE;
CREATE TABLE Performs (
    release_year INT
) AS EDGE;
GO

-- Добавление ограничений рёбер
ALTER TABLE Collabs
ADD CONSTRAINT EC_Collabs CONNECTION (Rapper TO Rapper);
ALTER TABLE SignedWith
ADD CONSTRAINT EC_SignedWith CONNECTION (Rapper TO Studio);
ALTER TABLE RecordedIn
ADD CONSTRAINT EC_RecordedIn CONNECTION (Track TO Studio);
ALTER TABLE Performs
ADD CONSTRAINT EC_Performs CONNECTION (Rapper TO Track);
GO

-- Заполнение таблиц узлов
-- Rapper 
INSERT INTO Rapper (id, name)
VALUES 
    (1, N'Drake'),
    (2, N'Travis Scott'),
    (3, N'Kendrick Lamar'),
    (4, N'Eminem'),
    (5, N'XXXTentacion'),
    (6, N'Lil Uzi Vert'),
    (7, N'J. Cole'),
    (8, N'Post Malone'),
    (9, N'Lil Baby'),
    (10, N'PlayboiCarti');
GO

-- Studio 
INSERT INTO Studio (id, name, country)
VALUES 
    (1, N'Hit Factory', N'USA'),
    (2, N'Electric Lady', N'USA'),
    (3, N'Abbey Road', N'UK'),
    (4, N'Westlake', N'USA'),
    (5, N'Metropolis', N'UK'),
    (6, N'Record Plant', N'USA'),
    (7, N'Tree Sound', N'USA'),
    (8, N'Studio 54', N'USA'),
    (9, N'Chalice', N'USA'),
    (10, N'Air Studios', N'UK');
GO

-- Track 
INSERT INTO Track (id, title)
VALUES 
    (1, N'Gods Plan'),
    (2, N'Sicko Mode'),
    (3, N'HUMBLE.'),
    (4, N'Lose Yourself'),
    (5, N'Sad!'),
    (6, N'20 Min'),
    (7, N'Middle Child'),
    (8, N'Circles'),
    (9, N'Woah'),
    (10, N'Evil Jordan');
GO

-- Заполнение таблиц рёбер
-- Collabs 
INSERT INTO Collabs ($from_id, $to_id)
VALUES 
    ((SELECT $node_id FROM Rapper WHERE id = 1), (SELECT $node_id FROM Rapper WHERE id = 2)),
	((SELECT $node_id FROM Rapper WHERE id = 4), (SELECT $node_id FROM Rapper WHERE id = 3)),
	((SELECT $node_id FROM Rapper WHERE id = 6), (SELECT $node_id FROM Rapper WHERE id = 2)),
    ((SELECT $node_id FROM Rapper WHERE id = 1), (SELECT $node_id FROM Rapper WHERE id = 3)),
    ((SELECT $node_id FROM Rapper WHERE id = 2), (SELECT $node_id FROM Rapper WHERE id = 4)),
    ((SELECT $node_id FROM Rapper WHERE id = 3), (SELECT $node_id FROM Rapper WHERE id = 5)),
    ((SELECT $node_id FROM Rapper WHERE id = 4), (SELECT $node_id FROM Rapper WHERE id = 6)),
    ((SELECT $node_id FROM Rapper WHERE id = 5), (SELECT $node_id FROM Rapper WHERE id = 7)),
    ((SELECT $node_id FROM Rapper WHERE id = 6), (SELECT $node_id FROM Rapper WHERE id = 8)),
	((SELECT $node_id FROM Rapper WHERE id = 10), (SELECT $node_id FROM Rapper WHERE id = 4)),
	((SELECT $node_id FROM Rapper WHERE id = 2), (SELECT $node_id FROM Rapper WHERE id = 5)),
    ((SELECT $node_id FROM Rapper WHERE id = 7), (SELECT $node_id FROM Rapper WHERE id = 9)),
    ((SELECT $node_id FROM Rapper WHERE id = 8), (SELECT $node_id FROM Rapper WHERE id = 10)),
    ((SELECT $node_id FROM Rapper WHERE id = 9), (SELECT $node_id FROM Rapper WHERE id = 10));
GO

-- SignedWith 
INSERT INTO SignedWith ($from_id, $to_id)
VALUES 
    ((SELECT $node_id FROM Rapper WHERE id = 1), (SELECT $node_id FROM Studio WHERE id = 1)),
    ((SELECT $node_id FROM Rapper WHERE id = 2), (SELECT $node_id FROM Studio WHERE id = 2)),
    ((SELECT $node_id FROM Rapper WHERE id = 3), (SELECT $node_id FROM Studio WHERE id = 3)),
    ((SELECT $node_id FROM Rapper WHERE id = 4), (SELECT $node_id FROM Studio WHERE id = 4)),
    ((SELECT $node_id FROM Rapper WHERE id = 5), (SELECT $node_id FROM Studio WHERE id = 5)),
    ((SELECT $node_id FROM Rapper WHERE id = 6), (SELECT $node_id FROM Studio WHERE id = 6)),
    ((SELECT $node_id FROM Rapper WHERE id = 7), (SELECT $node_id FROM Studio WHERE id = 7)),
    ((SELECT $node_id FROM Rapper WHERE id = 8), (SELECT $node_id FROM Studio WHERE id = 8)),
    ((SELECT $node_id FROM Rapper WHERE id = 9), (SELECT $node_id FROM Studio WHERE id = 9)),
    ((SELECT $node_id FROM Rapper WHERE id = 10), (SELECT $node_id FROM Studio WHERE id = 10));
GO

-- RecordedIn
INSERT INTO RecordedIn ($from_id, $to_id, recording_year)
VALUES 
    ((SELECT $node_id FROM Track WHERE id = 1), (SELECT $node_id FROM Studio WHERE id = 1), 2018),
    ((SELECT $node_id FROM Track WHERE id = 2), (SELECT $node_id FROM Studio WHERE id = 1), 2018),
    ((SELECT $node_id FROM Track WHERE id = 3), (SELECT $node_id FROM Studio WHERE id = 2), 2017),
    ((SELECT $node_id FROM Track WHERE id = 4), (SELECT $node_id FROM Studio WHERE id = 2), 2017),
    ((SELECT $node_id FROM Track WHERE id = 5), (SELECT $node_id FROM Studio WHERE id = 3), 2020),
    ((SELECT $node_id FROM Track WHERE id = 6), (SELECT $node_id FROM Studio WHERE id = 4), 2021),
    ((SELECT $node_id FROM Track WHERE id = 7), (SELECT $node_id FROM Studio WHERE id = 5), 2019),
    ((SELECT $node_id FROM Track WHERE id = 8), (SELECT $node_id FROM Studio WHERE id = 6), 2019),
    ((SELECT $node_id FROM Track WHERE id = 9), (SELECT $node_id FROM Studio WHERE id = 7), 2020),
    ((SELECT $node_id FROM Track WHERE id = 10), (SELECT $node_id FROM Studio WHERE id = 8), 2011),
    ((SELECT $node_id FROM Track WHERE id = 1), (SELECT $node_id FROM Studio WHERE id = 9), 2018),
    ((SELECT $node_id FROM Track WHERE id = 2), (SELECT $node_id FROM Studio WHERE id = 10), 2018);
GO

-- Performs 
INSERT INTO Performs ($from_id, $to_id, release_year)
VALUES 
    ((SELECT $node_id FROM Rapper WHERE id = 1), (SELECT $node_id FROM Track WHERE id = 1), 2018),
    ((SELECT $node_id FROM Rapper WHERE id = 2), (SELECT $node_id FROM Track WHERE id = 1), 2018),
    ((SELECT $node_id FROM Rapper WHERE id = 3), (SELECT $node_id FROM Track WHERE id = 1), 2018),
    ((SELECT $node_id FROM Rapper WHERE id = 2), (SELECT $node_id FROM Track WHERE id = 2), 2018),
    ((SELECT $node_id FROM Rapper WHERE id = 4), (SELECT $node_id FROM Track WHERE id = 2), 2018),
	((SELECT $node_id FROM Rapper WHERE id = 4), (SELECT $node_id FROM Track WHERE id = 7), 2019),
    ((SELECT $node_id FROM Rapper WHERE id = 3), (SELECT $node_id FROM Track WHERE id = 3), 2017),
    ((SELECT $node_id FROM Rapper WHERE id = 4), (SELECT $node_id FROM Track WHERE id = 4), 2017),
    ((SELECT $node_id FROM Rapper WHERE id = 5), (SELECT $node_id FROM Track WHERE id = 4), 2017),
    ((SELECT $node_id FROM Rapper WHERE id = 5), (SELECT $node_id FROM Track WHERE id = 5), 2020),
    ((SELECT $node_id FROM Rapper WHERE id = 6), (SELECT $node_id FROM Track WHERE id = 6), 2021),
    ((SELECT $node_id FROM Rapper WHERE id = 7), (SELECT $node_id FROM Track WHERE id = 7), 2019),
    ((SELECT $node_id FROM Rapper WHERE id = 8), (SELECT $node_id FROM Track WHERE id = 8), 2019),
    ((SELECT $node_id FROM Rapper WHERE id = 9), (SELECT $node_id FROM Track WHERE id = 9), 2020),
    ((SELECT $node_id FROM Rapper WHERE id = 10), (SELECT $node_id FROM Track WHERE id = 10), 2011),
    ((SELECT $node_id FROM Rapper WHERE id = 6), (SELECT $node_id FROM Track WHERE id = 5), 2020);
GO

-- Запросы с MATCH
-- 1. Кто сотрудничал с Drake?
SELECT Rapper1.name, Rapper2.name AS collaborator_name
FROM Rapper AS Rapper1, Collabs, Rapper AS Rapper2
WHERE MATCH(Rapper1-(Collabs)->Rapper2)
AND Rapper1.name = N'Drake';
GO

-- 2. Кто сотрудничал с коллабораторами Drake?
SELECT Rapper1.name + N' сотрудничает с ' + Rapper2.name AS Level1, 
       Rapper2.name + N' сотрудничает с ' + Rapper3.name AS Level2
FROM Rapper AS Rapper1, Collabs AS collab1, Rapper AS Rapper2, Collabs AS collab2, Rapper AS Rapper3
WHERE MATCH(Rapper1-(collab1)->Rapper2-(collab2)->Rapper3)
AND Rapper1.name = N'Drake';
GO

-- 3. Какие треки исполняют коллабораторы Drake?
SELECT Rapper2.name AS rapper, Track.title AS track, Performs.release_year
FROM Rapper AS Rapper1, Rapper AS Rapper2, Performs, Collabs, Track
WHERE MATCH(Rapper1-(Collabs)->Rapper2-(Performs)->Track)
AND Rapper1.name = N'Drake';
GO

-- 4. Какие треки записаны в студиях, где работают коллабораторы Drake?
SELECT Rapper2.name AS rapper, Track.title AS track, Studio.name AS studio, RecordedIn.recording_year
FROM Rapper AS Rapper1, Rapper AS Rapper2, SignedWith, Studio, RecordedIn, Track, Collabs
WHERE MATCH(Rapper1-(Collabs)->Rapper2-(SignedWith)->Studio<-(RecordedIn)-Track)
AND Rapper1.name = N'Drake';
GO

-- 5. Какие рэперы исполняют треки, записанные в их студии?
SELECT Rapper.name AS rapper, Track.title AS track, Performs.release_year, Studio.name AS studio
FROM Rapper, Performs, Track, SignedWith, Studio, RecordedIn
WHERE MATCH(Rapper-(Performs)->Track-(RecordedIn)->Studio AND Rapper-(SignedWith)->Studio);
GO

-- Запросы с SHORTEST_PATH
-- 1. Максимальная сеть коллабораций для Drake (шаблон +)
SELECT Rapper1.name AS RapperName, 
       STRING_AGG(Rapper2.name, '->') WITHIN GROUP (GRAPH PATH) AS Collaborators
FROM Rapper AS Rapper1, Collabs FOR PATH AS co, Rapper FOR PATH AS Rapper2
WHERE MATCH(SHORTEST_PATH(Rapper1(-(co)->Rapper2)+))
AND Rapper1.name = N'Drake';
GO

-- 2. С кем Drake может сотрудничать, обойдя сеть коллабораций не более чем на 3 шага (шаблон {1,3})
SELECT Rapper1.name AS RapperName, 
       STRING_AGG(Rapper2.name, '->') WITHIN GROUP (GRAPH PATH) AS Collaborators
FROM Rapper AS Rapper1, Collabs FOR PATH AS co, Rapper FOR PATH AS Rapper2
WHERE MATCH(SHORTEST_PATH(Rapper1(-(co)->Rapper2){1,3}))
AND Rapper1.name = N'Drake';
GO