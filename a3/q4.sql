
/*
    ASSUMPTION
    -- Dive Site has Flat Fee per person irrespective of time and type of dive
    -- Monitor Fee is per group and not per person
*/

DROP VIEW IF EXISTS ItemsPrice CASCADE;
CREATE VIEW ItemsPrice AS  
    SELECT af.booking_id , af.item_id, ds.price , b.site_id
    FROM BookingInfo b , AdditionalFees af , DiveSiteItems ds 
    WHERE af.booking_id = b.id AND b.site_id = ds.site_id 
    AND af.item_id = ds.item_id;
/*
    The booking ID , The Items in that booking ,the cost of that item and the site ID of booking
*/

DROP VIEW IF EXISTS ExtraFees CASCADE;
CREATE VIEW ExtraFees AS 
    SELECT booking_id , site_id, sum(price) AS extras 
    FROM ItemsPrice 
    GROUP BY booking_id , site_id;

/*
    The booking ID, site ID of booking and total cost of items per person.
*/

DROP VIEW IF EXISTS NumPpl CASCADE;
CREATE VIEW NumPpl AS 
    SELECT book_id , count(member_id) + 1 AS num_ppl  -- Group Info doesn't include the lead diver
    FROM GroupInfo 
    GROUP BY book_id;
/*
    The booking ID and the total number of divers in that booking
*/

DROP VIEW IF EXISTS A1 CASCADE;
CREATE VIEW A1 AS 
    SELECT np.book_id , ip.site_id ,np.num_ppl , ip.extras , dsi.fees 
    FROM DiveSiteInfo dsi , NumPpl np , ExtraFees ip 
    WHERE np.book_id = ip.booking_id AND ip.site_id = dsi.id;
/*
    The booking ID , site ID of booking , number of ppl in the booking , 
    extra fee per person and dive site fee per person
*/

DROP VIEW IF EXISTS MonitorFees CASCADE;
CREATE VIEW MonitorFees AS 
    SELECT b.id , price FROM BookingInfo b , MonitorPrice m 
    WHERE b.monitor_id = m.id AND 
    b.d_type = m.type_dive AND b.time = m.time_dive;
/*
    The booking ID and the fees charge by the monitor of the booking
*/

DROP VIEW IF EXISTS TotalCost CASCADE;
CREATE VIEW TotalCost AS 
    SELECT a.book_id , a.site_id , 
    num_ppl * ( extras + fees) + price AS total 
    FROM A1 a , MonitorFees mf 
    WHERE mf.id= a.book_id; 
/*
    The booking ID, Site ID of the booking and total Cost of the Booking
*/

SELECT id , min(total) AS lowest , 
    max(total) AS highest , 
    avg(total) AS average 
    FROM TotalCost RIGHT JOIN DiveSiteInfo 
    ON TotalCost.site_id = DiveSiteInfo.id 
    GROUP BY id 
    ORDER BY id; 
/*
    The Site ID, lowest cost, highest cost and average cost for each site.
*/
