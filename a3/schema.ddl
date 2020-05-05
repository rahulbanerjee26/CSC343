DROP SCHEMA IF EXISTS wetworldschema CASCADE; 
CREATE SCHEMA wetworldschema; 
SET SEARCH_PATH TO wetworldschema;


/*
    CONSTRAINTS ENFORCED
    
    -- Age of the diver must be greater than 16
    -- certification type must be one of NAUI , CMAS , PADI
    -- dive_type must be one of open water , cave , deepe than 30 metres
    -- time must be morning , evening , noon
    -- ratings are between 0 and 5
    -- Monitor is actually affiliated with site when booking
    -- The dive site actually suports the dive type, when booking

*/

/*
    CONSTRAINTS NOT ENFORCED

    -- The Capacity Constraint
        To avoid redundancies, the site capacity ( based on dive type and time)
        and monitor capacites are stored in tables. Since we need assert and trigger for
        cross table references and we are not allowed to use it for this assignment, we ignored
        the constraint.

    -- No more than 2 dives in  24 hour time constraint
        Since check( ) does not support self join, the constraint that no diver can dive more than
        twice in 24 hours was ignored.
*/

/*
    ASSUMPTIONS
    
    -- Monitor's price depends only on time of day and dive type, not on the dive site
    -- User Inputs Age while booking
    -- Dive Site has Flat Fee per person irrespective of time and type of dive
    -- Monitor Fee is per group and not per person
*/


/* 
    ----------------------- DOMAINS -------------------------------
*/


-- Type of Certifications --
CREATE DOMAIN certification_type AS varchar(4)
    NOT NULL
    CONSTRAINT typeOfCertification
    CHECK (value in ('NAUI','CMAS', 'PADI')); 

-- Age Constraint --
CREATE DOMAIN age_range AS INT
    NOT NULL
    constraint ageRange
    check (value>=16);

-- Dive Types --
CREATE DOMAIN dive_type AS varchar(15)
    NOT NULL
    CONSTRAINT typeOfDives
    CHECK (value in ('open_water','cave', 'deeper_30')); 

-- Time --
CREATE DOMAIN times AS varchar(5)
    NOT NULL
    CONSTRAINT typeOfTimes
    CHECK (value in ('morn', 'noon', 'night')); 

/*
----------------------------- TABLES ------------------------------
*/

-- Diver's Information --
CREATE TABLE DiversInfo(
  -- Diver's id --   
  id int NOT NULL PRIMARY KEY,
  -- The first name of the passenger.
  firstname varchar(50) NOT NULL,
  -- The surname of the passenger.
  surname varchar(50) NOT NULL,
  -- The age of the diver, must be more 16 --
  age age_range NOT NULL,
  -- The email of the passenger --
  email varchar(30) NOT NULL,
  -- Certification --
  certification certification_type NOT NULL
);

-- Items like fins, masks etc --
CREATE TABLE Item(
    id int NOT NULL PRIMARY KEY,
    name_item varchar(25) NOT NULL
);

-- Dive Site's Information --
CREATE TABLE DiveSiteInfo(
    -- Dive Site's id --
    id int NOT NULL PRIMARY KEY,
    -- name of the divesite --
    ds_name varchar(50) NOT NULL,
    -- location of the divesite --
    location varchar(50) NOT NULL,
    -- fees --
    fees int NOT NULL
);

-- Dive Site Additional and free accessories, for free set price to 0--
CREATE TABLE DiveSiteItems(
    -- Site id --
    site_id int NOT NULL REFERENCES DiveSiteInfo,
    -- ITEM ID --
    item_id int NOT NULL REFERENCES Item,
    -- price, 0 if free --
    price int NOT NULL,
    -- super key --
    PRIMARY KEY (site_id, item_id)
);

-- Dive sites and dive types supported --
CREATE TABLE SitesType(
    -- Site id --
    site_id int NOT NULL REFERENCES DiveSiteInfo,
    -- type of dive --
    type_dive dive_type NOT NULL,
    PRIMARY KEY (site_id , type_dive)
);

-- Credit Card Info
CREATE TABLE CreditCardInfo(
    -- id --
    id int NOT NULL PRIMARY KEY,
    -- diver's id --
    d_id int NOT NULL REFERENCES DiversInfo,
    -- card number --
    num bigint NOT NULL,
    -- card pass --
    pass int NOT NULL
);

-- Monitor's Information --
CREATE TABLE MonitorInfo(
  -- Monitors's id --   
  id int NOT NULL PRIMARY KEY,
  -- The first name of the monitor.
  firstname varchar(50) NOT NULL,
  -- The surname of the monitor.
  surname varchar(50) NOT NULL,
  -- email --
  email varchar(100) NOT NULL
);

-- Monitor's charges --
CREATE TABLE MonitorPrice(
    -- Monitor's id --
    id int NOT NULL REFERENCES MonitorInfo, 
    -- type of dive --
    type_dive dive_type NOT NULL,
    -- time of dive --
    time_dive times NOT NULL,
    -- monitor's fees --
    price int NOT NULL,
    -- super key --
    PRIMARY KEY (id , type_dive ,time_dive )
);

CREATE TABLE MonitorCapacity(
    -- Monitor's id --
    id int NOT NULL REFERENCES MonitorInfo, 
    -- type of dive --
    type_dive dive_type NOT NULL,
    -- monitor's capacity --
    capacity int NOT NULL,
    -- super key --
    PRIMARY KEY (id, type_dive)
);

-- Monitor and Dive Site Affiliation --
CREATE TABLE Affiliation(
    -- DIVE SITE ID --
    site_id int NOT NULL REFERENCES DiveSiteInfo,
    -- Affiliated Monitor Id --
    monitor_id int NOT NULL REFERENCES MonitorInfo,
    -- Super Key --
    PRIMARY KEY (site_id , monitor_id)
);

-- Dive Site's Capacity --
CREATE TABLE DiveSiteCapacity(
    -- Dive Site Id --
    id int NOT NULL REFERENCES DiveSiteInfo,
    -- type of dive --,
    type_dive dive_type NOT NULL,
    -- time of dive --
    time times NOT NULL,
    -- capacity of the site --
    capacity int NOT NULL,
    -- super key--
    PRIMARY KEY (id , type_dive, time)
);

-- Booking Info --
CREATE TABLE BookingInfo(
    -- Booking id --
    id int NOT NULL PRIMARY KEY,
    -- dive site id --
    site_id int NOT NULL REFERENCES DiveSiteInfo,
    -- monitor id --
    monitor_id  int NOT NULL REFERENCES MonitorInfo,
    -- lead diver's id --
    leader_id int NOT NULL REFERENCES DiversInfo,
    -- dive type --
    d_type dive_type NOT NULL,
    -- time of dive --
    time times NOT NULL,
    -- date --
    dive_date date NOT NULL, 
    -- credit card uses --
    card_id int NOT NULL REFERENCES CreditCardInfo,
    -- check if monitor is affiliated to the site --
    FOREIGN KEY (site_id , monitor_id) REFERENCES Affiliation(site_id , monitor_id),
    -- check if the site supports the dive_type --
    FOREIGN KEY( site_id , d_type ) REFERENCES SitesType(site_id , type_dive)
);

-- Group Info --
CREATE TABLE GroupInfo(
    -- booking id --,
    book_id int NOT NULL REFERENCES BookingInfo,
    -- group member's id --
    member_id int NOT NULL REFERENCES DiversInfo,
    PRIMARY KEY ( book_id , member_id )
);

CREATE TABLE AdditionalFees(
    -- booking id --
    booking_id int NOT NULL,
    -- item for that booking --
    item_id int NOT NULL REFERENCES Item ,
    -- super key --
    PRIMARY KEY (booking_id , item_id)
);

CREATE TABLE SiteRatings(
    -- booking site --
    site_id int NOT NULL REFERENCES DiveSiteInfo,
    -- diver's id --
    diver_id int NOT NULL REFERENCES DiversInfo,
    -- ratings between 0 and 5 --
    ratings int NOT NULL,
    CHECK(ratings >= 0 and ratings <=5),
    -- super key --
    PRIMARY KEY ( site_id, diver_id , ratings)
);

CREATE TABLE MonitorRatings(
    -- booking site --
    monitor_id int NOT NULL REFERENCES MonitorInfo,
    -- diver's id --
    diver_id int NOT NULL REFERENCES DiversInfo,
    -- ratings between 0 and 5 --
    ratings int NOT NULL,
    CHECK(ratings >= 0 and ratings <=5),
    -- super key --
    PRIMARY KEY ( monitor_id, diver_id, ratings)
);
