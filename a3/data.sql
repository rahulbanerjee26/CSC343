INSERT INTO DiversInfo VALUES
    ( 1 , 'Michael' , 'XYZ' , 30 , 'michael@dm.org' , 'NAUI'),
    ( 2 , 'Dwight' , 'Schrute' , 40 , 'dwight@dm.org' , 'CMAS'),
    ( 3 , 'Pam' , 'Beesly' , 20 , 'pam@dm.org' , 'PADI') ,
    ( 4 , 'Andy' , 'Samberg' , 23 , 'andy@dm.org' , 'NAUI'),
    ( 5 , 'Jim' , 'Halpert' , 40 , 'jim@dm.org' , 'PADI'),
    ( 6 , 'Joey' , 'Tribianni' , 30 , 'joey@dm.org' , 'NAUI'),
    ( 7 , 'Ross' , 'Geller' , 33 , 'ross@dm.org' , 'CMAS'),
    ( 8 , 'Chandler' , 'Bing' , 30 , 'chandler@dm.org' , 'NAUI'),
    ( 9 , 'Saminul' , 'Islam' , 45 , 'sam@dm.org' , 'PADI'),
    ( 10 , 'Jake' , 'Peralta' , 20 , 'jake@dm.org' , 'NAUI'),
    ( 11 , 'Charles' , 'Boyle' , 39 , 'charles@dm.org' , 'CMAS'),
    ( 12 , 'Barney' , 'Stinson' , 20 , 'barney@dm.org' , 'NAUI');

INSERT INTO Item VALUES
    (1 , 'tanks'),
    (2, 'weight belts'),
    (3 , 'snacks'),
    (4 , 'vests'),
    (5 , 'videos'),
    (6 , 'towels'),
    (7, 'showers'),
    (8 , 'mask'),
    (9 ,'regulator'),
    (10 , 'ns'),
    (11 , 'dive computer'),
    (12 , 'fins');

INSERT INTO DiveSiteInfo VALUES
    (1 , ' Bloody Bay Marine Park' , ' Little Cayman' , 10 ),
    (2 , ' Widow Maker’s Cave' , ' Montego Bay' , 20 ),
    (3 , ' Crystal Bay' , 'Crystal Bay' , 15 ),
    (4 , ' Batu Bolong' , 'Batu Bolong' , 15 ),
    (5 , 'ABC' , 'XYZ' , 20);

INSERT INTO DiveSiteItems VALUES
    (1 , 8 , 5),
    (1 , 12 , 10),
    (1 , 2 , 0),
    (1 , 3 ,0),
    (1 ,4 ,0),
    (1 ,5,0),
    (1 , 6, 10),
    (2 , 8 , 3),
    (2 , 12 ,5),
    (2 , 2 , 10),
    (2 , 3 ,20),
    (2 ,10 ,0),
    (2 ,5,0),
    (2 , 6, 10),
    (3 , 8 , 3),
    (3 , 12 ,5),
    (3 , 2 , 10),
    (3 , 3 ,20),
    (3 ,4 ,0),
    (3 ,5,0),
    (3 , 6, 10),
    (4 , 8 , 5),
    (4 , 12 , 10),
    (4 , 2 , 0),
    (4 , 3 ,0),
    (4 ,4 ,0),
    (4 ,5,0),
    (4 , 6, 10);

INSERT INTO SitesType VALUES
    (1 , 'cave'),
    (2 , 'open_water'),
    (2 , 'cave'),
    (3 , 'open_water'),
    (3,'cave'),
    (1 , 'deeper_30'),
    (4 , 'open_water'),
    (4,'cave'),
    (4 , 'deeper_30'),
    (5, 'open_water'),
    (5 , 'deeper_30');

INSERT INTO DiveSiteCapacity VALUES
    (1 , 'cave' , 'morn' ,30),
    (1 , 'cave' , 'noon' ,20),
    (1 , 'cave' , 'night' ,10),
    (1 , 'deeper_30' , 'morn' ,30),
    (1 , 'deeper_30' , 'noon' ,25),
    (1 , 'deeper_30' , 'night' ,10),
    (2 , 'open_water' , 'morn' , 40),
    (2 , 'open_water' , 'noon' , 30),
    (2 , 'open_water' , 'night' , 20),
    (2 , 'cave' , 'morn' , 40 ),
    (2 , 'cave' , 'noon' , 30),
    (2 , 'cave' , 'night' , 20),
    (3 , 'open_water' , 'morn', 50),
    (3 , 'open_water' , 'noon', 40),
    (3 , 'open_water' , 'night', 30),
    (3,'cave' , 'morn', 50),
    (3 , 'cave' , 'noon' , 40),
    (3, 'cave', 'night',30),
    (4 , 'cave' , 'morn' ,30),
    (4 , 'cave' , 'noon' ,20),
    (4 , 'cave' , 'night' ,10),
    (4 , 'deeper_30' , 'morn' ,30),
    (4 , 'deeper_30' , 'noon' ,25),
    (4 , 'deeper_30' , 'night' ,10),
    (4 , 'open_water' , 'morn', 50),
    (4 , 'open_water' , 'noon', 40),
    (4 , 'open_water' , 'night', 30);

INSERT INTO MonitorInfo VALUES 
    (1, 'Maria', 'Hill', 'mhill@shield.gov'), 
    (2, 'John', 'Smith', 'jsmith@gmail.com'), 
    (3, 'Ben', 'Parker', 'bparker@marvel.com'), 
    (4, 'Rahul', 'Bannerjee', 'rbannerjee@uoft.ca'), 
    (5, 'Mario', 'Kart', 'mkart@mario.com');

INSERT INTO Affiliation VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (1, 2),
    (3, 2),
    (2, 3),
    (3,3),
    (2,2),
    (1 , 5),
    (1,4),
    (2,5),
    (4,5),
    (4,4),
    (4,2);

INSERT INTO MonitorPrice VALUES
    (1, 'cave', 'night', 25),
    (2, 'cave', 'night', 25),
    (3, 'cave', 'night', 25),
    (4, 'cave', 'night', 25),
    (1, 'open_water', 'morn', 10),
    (2, 'open_water', 'morn', 10),
    (3, 'open_water', 'morn', 10),
    (4, 'open_water', 'morn', 10),
    (1, 'open_water', 'noon', 15),
    (1, 'cave', 'morn', 30),
    (2, 'cave', 'morn', 15),
    (3, 'cave', 'morn', 20),
    (1 , 'deeper_30' , 'morn',10),
    (2 , 'deeper_30' , 'morn',10),
    (3 , 'deeper_30' , 'morn',10),
    (4 , 'deeper_30' , 'morn',10),
    (1 , 'deeper_30' , 'noon',10),
    (2 , 'deeper_30' , 'noon',10),
    (3 , 'deeper_30' , 'noon',10),
    (4 , 'deeper_30' , 'noon',10),
    (5, 'open_water', 'noon', 15),
    (5, 'cave', 'morn', 30),
    (5, 'cave', 'noon', 10),
    (5, 'cave', 'night', 20),
    (5 , 'deeper_30' , 'morn',10);

INSERT INTO MonitorCapacity VALUES
    (1, 'open_water', 10),
    (1, 'cave', 5),
    (1, 'deeper_30', 5),
    (2, 'cave', 15),
    (3, 'open_water', 15),
    (3, 'cave', 5),
    (3, 'deeper_30', 5);

INSERT INTO CreditCardInfo VALUES
    ( 1 , 2 , 22334455566 , 345),
    (2 , 1 , 1124422455333 , 467),
    (3 , 4 , 111112222333 , 490);

INSERT INTO BookingInfo VALUES
    (1 , 1 , 1 , 1 , 'cave' , 'morn' ,'10/2/2020' , 1),
    (2 , 2 , 2 , 5 , 'open_water' , 'morn' ,'11/2/2020' , 2),
    (3 , 2 , 1 , 1 , 'cave' , 'morn' ,'6/2/2020' , 3),
    (4 , 4 , 1 , 7 , 'cave' , 'night' ,'4/2/2020' , 1),
    (5 , 4 , 5 , 1 , 'open_water' , 'noon' ,'4/2/2020' , 1),
    (6 , 4 , 4 , 5 , 'deeper_30' , 'night' ,'4/2/2020' , 1),
    (7 , 4 , 2 , 3 , 'deeper_30' , 'morn' ,'4/2/2020' , 1);

INSERT INTO GroupInfo VALUES 
    (1 , 2),
    (1 ,3),
    (1 ,4),
    (1 ,5 ),
    (1 , 6),
    (2 , 6),
    (2 ,3),
    (2 ,10),
    (2 ,9 ),
    (2 , 12),
    (3 , 7),
    (3 ,3),
    (3 ,4),
    (3 ,5 ),
    (3 , 6),
    (4 , 6),
    (4 ,3),
    (4 ,10),
    (4 ,9 ),
    (4 , 12),
    (5 , 6),
    (5 ,3),
    (5 ,10),
    (5 ,9 ),
    (5 , 12),
    (5 ,2),
    (5 ,5),
    (5 ,7 ),
    (5 , 11),
    (6 , 6),
    (6 ,3),
    (6 ,10),
    (6 ,9 ),
    (6 , 12),
    (7 , 6),
    (7 ,3),
    (7 ,10),
    (7 ,9 ),
    (7 , 12),
    (7 ,2),
    (7 ,5),
    (7 ,7 );

INSERT INTO AdditionalFees VALUES
    (1 , 8),
    (1 , 12),
    (1 , 2),
    (1 , 3),
    (1 ,4),
    (2 , 8 ),
    (2 , 12 ),
    (2 , 2 ),
    (2 , 3 ),
    (3 , 10),
    (3,5),
    (3,6),
    (4 , 8),
    (4 , 12),
    (4 , 2),
    (4 , 3),
    (4 ,4),
    (4 ,5),
    (4 , 6),
    (6 ,4),
    (6 ,5),
    (6 , 6),
    (5 , 8),
    (5 , 12),
    (5 , 2),
    (5 , 3),
    (7 , 8),
    (7 , 12),
    (7 , 2),
    (7 , 3),
    (7 ,4),
    (7 ,5),
    (7 , 6);

INSERT INTO SiteRatings VALUES
    (1 , 2 , 5),
    (1 ,3 , 2),
    (1 ,4 , 0 ),
    (1 ,5, 4 ),
    (1 , 6 , 3 ),
    (2 , 6 , 4),
    (2 ,3 , 4),
    (2 ,10 , 4),
    (2 ,9 , 3),
    (2 , 12 , 3),
    (4 , 6 , 3),
    (4 ,3 , 2),
    (4 ,10 ,3 ),
    (4 ,9 ,2 ),
    (4 , 12 , 3);

INSERT INTO MonitorRatings VALUES
    (1,1,5),
    (2,5,4),
    (1 , 7 , 3),
    (1,1, 2),
    (5 , 1 ,4),
    (4 , 5 , 2),
    (2 ,3 ,2);















    




    
    


