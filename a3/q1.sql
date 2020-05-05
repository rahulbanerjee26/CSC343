/*
    ASSUMPTION
    -- It is not neccessary that a booking has been made for that site or that monitor
*/

DROP VIEW IF EXISTS MonitorType CASCADE;
CREATE VIEW MonitorType AS
    SELECT DISTINCT id , type_dive
    FROM MonitorPrice;
/*
    Monitor ID and the dive types they monitor
*/

DROP VIEW IF EXISTS SiteMonitorType CASCADE;
CREATE VIEW SiteMonitorType AS 
    SELECT site_id , monitor_id , type_dive 
    FROM Affiliation JOIN MonitorType 
    ON monitor_id = id;
/*
    Monitor ID, Type of dive they monitor and 
    the site they are affiliated with
*/

DROP VIEW IF EXISTS NumOfAffMons CASCADE;
CREATE VIEW NumOfAffMons AS 
    SELECT s.site_id , s.type_dive, count( DISTINCT monitor_id) 
    FROM SitesType s , SiteMonitorType sm 
    WHERE s.site_id = sm.site_id 
    AND s.type_dive = sm.type_dive 
    GROUP BY s.site_id , s.type_dive ;
/*
  Site ID , type of dive and number of monitors affiliated 
  with that site for that specific type
*/

SELECT type_dive , count( DISTINCT site_id)
    FROM NumOfAffmons WHERE
    count >= 1
    GROUP BY type_dive;

/*
    The type of dive and number of sites that allow it such that the 
    site has at least one affiliated monitor monitoring that type
*/