# check for duplicate rows
SELECT DISTINCT COUNT(ride_id)
FROM `cyclistic-case-study-424722.2023_trip_data.2023_raw_data`;
-- no duplicate rows, ride_id is the primary key 

# check for inconsistencies in ride_id
SELECT LENGTH(ride_id) as id_length, COUNT(*)
FROM `cyclistic-case-study-424722.2023_trip_data.2023_raw_data`
GROUP BY id_length;
-- no errors, all 16 characters long

# check for errors in member_casual
SELECT COUNT(*), member_casual
FROM `cyclistic-case-study-424722.2023_trip_data.2023_raw_data`
GROUP BY member_casual;
-- no errors, only casual riders or members

# check for errors in rideable_type
SELECT COUNT(*), rideable_type
FROM `cyclistic-case-study-424722.2023_trip_data.2023_raw_data`
GROUP BY rideable_type;
-- no errors, only 3 different bike types

# find the number of NULL values in each column
SELECT 
  COUNT(*)-COUNT(ride_id) As ride_id, 
  COUNT(*)-COUNT(rideable_type) As rideable_type,
  COUNT(*)-COUNT(started_at) As started_at,
  COUNT(*)-COUNT(ended_at) As ended_at,
  COUNT(*)-COUNT(start_station_name) As start_station_name,
  COUNT(*)-COUNT(start_station_id) As start_station_id, 
  COUNT(*)-COUNT(end_station_name) As end_station_name,
  COUNT(*)-COUNT(end_station_id) As end_station_id,
  COUNT(*)-COUNT(start_lat) As start_lat,
  COUNT(*)-COUNT(start_lng) As start_lng,
  COUNT(*)-COUNT(end_lat) As end_lat,
  COUNT(*)-COUNT(end_lng) As end_lng,
  COUNT(*)-COUNT(member_casual) As member_casual,
FROM `cyclistic-case-study-424722.2023_trip_data.2023_raw_data`;

# find the number of rows that contain at least one NULL value
SELECT COUNT(*)
FROM `cyclistic-case-study-424722.2023_trip_data.2023_raw_data`

WHERE ride_id is NULL
  OR rideable_type is NULL
  OR started_at is NULL
  OR ended_at is NULL
  OR start_station_name is NULL
  OR start_station_id is NULL
  OR end_station_name is NULL
  OR end_station_id is NULL
  OR start_lat is NULL
  OR start_lng is NULL
  OR end_lat is NULL
  OR end_lng is NULL
  OR member_casual is NULL;

# Check for outliers, classified as rides < 1 minute, or > 24 hours
SELECT COUNT(*) as outliers
FROM `cyclistic-case-study-424722.2023_trip_data.2023_raw_data`
WHERE 
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) < 1 OR
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) > 1440 
