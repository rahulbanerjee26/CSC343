/*
    ASSUMPTION
    --  We need to find the monitor whose average rating is higher 
        than average ratings of the each site they are affiliated with
*/

DROP VIEW IF EXISTS AverageRatingsMonitor CASCADE;
CREATE VIEW AverageRatingsMonitor AS 
    SELECT monitor_id , avg(ratings)  
    FROM MonitorRatings 
    GROUP BY monitor_id;
/*
    The Monitor ID and the average rating of that specific monitor
*/

DROP VIEW IF EXISTS AverageRatingsSite CASCADE;
CREATE VIEW AverageRatingsSite AS 
    SELECT site_id , avg(ratings)  
    FROM SiteRatings 
    GROUP BY Site_id;
/*
    The Site ID and the average rating of that specific site
*/

DROP VIEW IF EXISTS RatingComparison CASCADE;
CREATE VIEW RatingComparison AS 
    SELECT m.monitor_id , m.avg AS m_avg , 
    s.site_id , s.avg AS s_avg 
    FROM AverageRatingsMonitor m , 
    AverageRatingsSite s , Affiliation a 
    WHERE a.monitor_id = m.monitor_id 
    AND a.site_id = s.site_id 
    ORDER BY m.monitor_id;
/*
    The monitor ID, average rating of the monitor , 
    site that monitor is affiliated with, average rating of that site
*/

DROP VIEW IF EXISTS RequiredMonitor CASCADE;
CREATE VIEW RequiredMonitor AS 
    SELECT DISTINCT r1.monitor_id 
    FROM RatingComparison r1 
    WHERE r1.m_avg > 
    ALL
    ( SELECT s_avg FROM 
            RatingComparison r2 
            WHERE r1.monitor_id = r2.monitor_id
    );

/*
    Monitor ID of all monitors such that 
    the monitor's average rating is higher than average rating 
    of each site they are affiliated to
*/

DROP VIEW IF EXISTS MonPrice CASCADE;
CREATE VIEW MonPrice AS 
    SELECT monitor_id , avg(price) 
    FROM RequiredMonitor r , MonitorPrice m 
    WHERE r.monitor_id = m.id 
    GROUP BY r.monitor_id;
/*
    The Required Monitor ID and their average FEE 
*/

SELECT monitor_id , avg 
    AS price , email 
    FROM MonPrice m1 JOIN MonitorInfo m2 
    ON m1.monitor_id = m2.id;

/*
    The Required Monitor ID , average price of the monitor and the monitor's email
*/