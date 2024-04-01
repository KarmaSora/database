-- DROP FUNCTION IF EXISTS order_status;
-- DELIMITER ;;
-- CREATE FUNCTION order_status(
--     date_of_order TIMESTAMP,
--     date_of_last_update TIMESTAMP, -- date of update
--     date_of_delete TIMESTAMP, -- date of deletion
--     date_of_activated TIMESTAMP, -- date of activation / beställed
--     date_of_sent TIMESTAMP  -- date of sent / skickad
--     )
-- RETURNS VARCHAR(100)
-- DETERMINISTIC
-- BEGIN
--     IF date_of_delete > date_of_sent AND date_of_delete > date_of_last_update AND date_of_delete > date_of_activated AND date_of_delete > date_of_order THEN
--         RETURN "Deleted";
--     ELSEIF date_of_sent > date_of_last_update AND date_of_sent > date_of_activated AND date_of_sent > date_of_order THEN
--         RETURN "Sent";
--     ELSEIF date_of_activated > date_of_order THEN
--         RETURN "Ordered";
--     ELSEIF date_of_last_update > date_of_order THEN
--         RETURN "Updated";
--     ELSE
--         RETURN "Created";
--     END IF;
-- END;;

-- DELIMITER ;






DROP FUNCTION IF EXISTS order_status;
DELIMITER ;;
CREATE FUNCTION order_status(
    date_of_order TIMESTAMP,
    date_of_last_update TIMESTAMP, 
    date_of_delete TIMESTAMP, 
    date_of_activated TIMESTAMP, 
    date_of_sent TIMESTAMP  
    )
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE latest_date TIMESTAMP;
    
    -- Find the latest non-NULL date among the provided timestamps
    SET latest_date = GREATEST(
        COALESCE(date_of_order, '0000-00-00'), 
        COALESCE(date_of_last_update, '0000-00-00'), 
        COALESCE(date_of_delete, '0000-00-00'), 
        COALESCE(date_of_activated, '0000-00-00'), 
        COALESCE(date_of_sent, '0000-00-00')
    );
    
    -- Determine the status based on the latest date
    IF date_of_delete = latest_date THEN
        RETURN "Deleted";
    ELSEIF date_of_sent = latest_date THEN
        RETURN "Sent";
    ELSEIF date_of_activated = latest_date THEN
        RETURN "Ordered";
    ELSEIF date_of_last_update = latest_date THEN
        RETURN "Updated";
    ELSE
        RETURN "Created";
    END IF;
END;;
DELIMITER ;