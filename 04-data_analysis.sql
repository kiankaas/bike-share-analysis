-- Total Rides per Member Type
SELECT member_casual, COUNT(*) as Total_Rides, 
FROM `cyclistic-case-study-424722.2023_trip_data.2023_clean_data`
GROUP BY member_casual
ORDER BY member_casual;

-- Total Rides per Bike Type
SELECT member_casual, rideable_type, COUNT(*) as Total_Rides, 
FROM `cyclistic-case-study-424722.2023_trip_data.2023_clean_data`
GROUP BY member_casual, rideable_type
ORDER BY member_casual;

-- Total Rides per Bike Type
SELECT member_casual, rideable_type, COUNT(*) as Total_Rides, 
FROM `cyclistic-case-study-424722.2023_trip_data.2023_clean_data`
GROUP BY member_casual, rideable_type
ORDER BY member_casual;

-- Total Rides per Month
SELECT member_casual, month, COUNT(*) as Total_Rides, 
FROM `cyclistic-case-study-424722.2023_trip_data.2023_clean_data`
GROUP BY member_casual, month
ORDER BY member_casual;

-- Total Rides per Day of Week
SELECT member_casual, day_of_week, COUNT(*) as Total_Rides, 
FROM `cyclistic-case-study-424722.2023_trip_data.2023_clean_data`
GROUP BY member_casual, day_of_week
ORDER BY member_casual;

-- Total Rides per Hour
SELECT member_casual, hour, COUNT(*) as Total_Rides, 
FROM `cyclistic-case-study-424722.2023_trip_data.2023_clean_data`
GROUP BY member_casual, hour
ORDER BY member_casual;

-- Average Ride Duration per Member Type
SELECT member_casual, AVG(ride_duration_minutes) as avg_ride_duration
FROM `cyclistic-case-study-424722.2023_trip_data.2023_clean_data`
GROUP BY member_casual;

-- Average Ride Duration per Month
SELECT member_casual, month, AVG(ride_duration_minutes) as avg_ride_duration
FROM `cyclistic-case-study-424722.2023_trip_data.2023_clean_data`
GROUP BY member_casual, month
ORDER BY member_casual;

-- Average Ride Duration per Day of Week
SELECT member_casual, day_of_week, AVG(ride_duration_minutes) as avg_ride_duration
FROM `cyclistic-case-study-424722.2023_trip_data.2023_clean_data`
GROUP BY member_casual, day_of_week
ORDER BY member_casual;
