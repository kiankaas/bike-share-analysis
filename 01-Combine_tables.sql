# Combine all the data tables from each month into one big dataset for the year of 2023
CREATE TABLE IF NOT EXISTS `cyclistic-case-study-424722.2023_trip_data.2023_all_data` AS (
  
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Jan_2023`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Feb_2023`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Mar_2023`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Apr_2023`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.May_2023_p1`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.May_2023_p2`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Jun_2023_p1`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Jun_2023_p2`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Jul_2023_p1`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Jul_2023_p2`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Aug_2023_p1`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Aug_2023_p2`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Sep_2023_p1`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Sep_2023_p2`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Oct_2023_p1`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Oct_2023_p2`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Nov_2023`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-424722.2023_trip_data.Dec_2023`

);


# The total number of rows in our dataset is 5,719,877
SELECT COUNT(*)
FROM `cyclistic-case-study-424722.2023_trip_data.2023_all_data`;

