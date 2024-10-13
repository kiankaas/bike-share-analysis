-- Add columns ride_duration, day_of_week, hour, month and season onto 2023_all_data
-- Remove rows with ride_duration < 1 minute OR > 24 hours

--NOTE: BigQuery is designed around the concept of immutable data structures and 
-- does not support the ALTER TABLE operation, thus I will have to create a new table
-- in order to add/remove columns to existing tables

CREATE TABLE `cyclistic-case-study-424722.2023_trip_data.2023_clean_data` AS
SELECT
  rideable_type, started_at, ended_at,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_duration_minutes,
  CASE EXTRACT(DAYOFWEEK FROM started_at) 
    WHEN 1 THEN 'SUN'
    WHEN 2 THEN 'MON'
    WHEN 3 THEN 'TUES'
    WHEN 4 THEN 'WED'
    WHEN 5 THEN 'THURS'
    WHEN 6 THEN 'FRI'
    WHEN 7 THEN 'SAT'    
  END AS day_of_week,
  CASE EXTRACT(HOUR FROM started_at) 
    WHEN 0 THEN '12 AM'
    WHEN 1 THEN '1 AM'
    WHEN 2 THEN '2 AM'
    WHEN 3 THEN '3 AM'
    WHEN 4 THEN '4 AM'
    WHEN 5 THEN '5 AM'
    WHEN 6 THEN '6 AM'
    WHEN 7 THEN '7 AM'
    WHEN 8 THEN '8 AM'
    WHEN 9 THEN '9 AM'
    WHEN 10 THEN '10 AM'
    WHEN 11 THEN '11 AM'
    WHEN 12 THEN '12 PM'
    WHEN 13 THEN '1 PM'
    WHEN 14 THEN '2 PM'
    WHEN 15 THEN '3 PM'
    WHEN 16 THEN '4 PM'
    WHEN 17 THEN '5 PM'
    WHEN 18 THEN '6 PM'
    WHEN 19 THEN '7 PM'
    WHEN 20 THEN '8 PM'
    WHEN 21 THEN '9 PM'
    WHEN 22 THEN '10 PM'
    WHEN 23 THEN '11 PM'
  END AS hour,
  CASE EXTRACT(MONTH FROM started_at) 
    WHEN 1 THEN 'JAN'
    WHEN 2 THEN 'FEB'
    WHEN 3 THEN 'MAR'
    WHEN 4 THEN 'APR'
    WHEN 5 THEN 'MAY'
    WHEN 6 THEN 'JUN'
    WHEN 7 THEN 'JUL'
    WHEN 8 THEN 'AUG'
    WHEN 9 THEN 'SEP'
    WHEN 10 THEN 'OCT'
    WHEN 11 THEN 'NOV'
    WHEN 12 THEN 'DEC'
  END AS month,
  member_casual

FROM `cyclistic-case-study-424722.2023_trip_data.2023_raw_data` 

WHERE 
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) > 1 AND
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) < 1440 



