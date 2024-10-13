# Cyclistic Bike-Share Case Study: Annual Members vs. Casual Riders in 2023

## Introduction:
This case study is the capstone project for the [Google Data Analytics Professional Certificate](https://www.coursera.org/professional-certificates/google-data-analytics?utm_medium=sem&utm_source=gg&utm_campaign=B2C_NAMER_google-data-analytics_google_FTCOF_professional-certificates_country-CA&campaignid=19667198857&adgroupid=148957582067&device=c&keyword=&matchtype=&network=g&devicemodel=&adposition=&creativeid=647783020241&hide_mobile_promo&gad_source=1&gclid=Cj0KCQjw05i4BhDiARIsAB_2wfAdX5_p7UxQI8jFpnPpoJkwYUETQ0pS4QoDSsdpuBJU-RxNBafM5L0aAqgAEALw_wcB) offered by Coursera. In this project, I will follow the data analysis process outlined in the course: **Ask**, **Prepare**, **Process**, **Analyze**, **Share**, and **Act**. I will use SQL and Tableau to analyze a publicly available dataset from a bike-share company called Cyclistic.

## Background:
I am a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve my recommendations, so they must be backed up with compelling data insights and professional data visualizations. 

## About the company:
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime. 

Cyclistic currently offers the following pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as **casual riders**. Customers who purchase annual memberships are **annual members**.

The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Thus, Cyclistic has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members.	

## Ask:
**Business task**: Design marketing strategies to convert casual riders into annual members. 

My job is to **analyze how annual members and casual riders use Cyclistic bikes differently**.

## Prepare:
**Data source**: 
I will use Cyclistic’s historical trip data to analyze and identify trends from January 2023 to December 2023, which I have downloaded onto my computer from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html)’s AWS server. The data has been made available by Motivate International Inc. under [this license](https://divvybikes.com/data-license-agreement). 

**Note**: Unfortunately GitHub does not support files larger than 100MB, so I was unable to include the datasets in this repository. 

**Data Organization**:
The trip data is stored in a CSV file, with a single file for each month. Each file contains 13 columns, as shown below: 
| Variable   | Data Type | Description | 
|-------------|-------------|--------------|
|ride_id | string | Unique ID assigned to each ride |
| rideable_type      | string| Type of bike used (classic, docked, electric)            | 
| started_at      | timestamp      | Date and time at the start of the trip            | 
| ended_at      | timestamp      | Date and time at the end of the trip            | 
| start_station_name      | string      | Name of the station that the ride started from            | 
| start_station_id      | string      | ID of the station that the ride started from            | 
| end_station_name      | string      | Name of the station that the ride ended from            | 
| end_station_id      | string      | ID of the station that the ride ended from            | 
| start_lat      | float      | Latitude of the starting station            | 
| start_lng      | float      | Longitude of the starting station            | 
| end_lat      | float      | Latitude of the ending station            | 
| end_lng      | float      | Longitude of the ending station            | 
| member_casual      | string      | Membership type of rider (member or casual)            | 

## Process:
The tools I will use are:
- **Google BigQuery**: Used for querying and processing the dataset.
- **SQL**: For performing data transformations and analysis.
- **Tableau**: For data visualization

As we will be working with very large amounts of data, we want to stay away from using spreadsheets. Thus, I decided to do this project in **BigQuery**, as suggested by Google. **BigQuery** is a data warehouse designed for handling large datasets and running very fast SQL queries. 

I started by creating a table for each month of data by uploading its corresponding CSV file to my BigQuery project studio. This was a bit tedious but it’s a critical part to set up and prepare the data for proper cleaning and analysis later on. 

Here I encountered my first problem - BigQuery only allows files <100MB to be uploaded.
Unfortunately, the datasets from May through October were all larger than 100MB. This was interesting to note early on as I already started to think there could be a correlation between warm weather and number of rides. 

I resolved this by writing a short python code called [split.py](https://github.com/kiankaas/bike-share-analysis/blob/main/split.py) that splits each file into two separate files.

**Data Combination**:
SQL Query: [Combining Tables](https://github.com/kiankaas/bike-share-analysis/blob/main/01-Combine_tables.sql) 
Once I uploaded and created a table for each of the files, I combined them into one big dataset using SQL. The dataset contains data regarding each ride in 2023, consisting of **5,719,877 records**. 

**Data Exploration**: 
SQL Query: [Data Exploration](https://github.com/kiankaas/bike-share-analysis/blob/main/02-data_exploration.sql)

Next, I familiarize myself with the dataset so I can uncover any errors, inconsistencies, outliers, or missing values. After running some queries, I observed the following:

1. All data types are correct and don’t need to be cleaned. 
2. There are **no duplicate rows** in the dataset.
3. All ride_id (primary key) values are 16 characters long. 
4. member_casual column has 2 unique values:

  ![Screen Shot 2024-10-11 at 5 56 43 PM](https://github.com/user-attachments/assets/2a62c941-e7b3-4270-8968-161246b7624a)

5. rideable_type column has 3 unique values: electric, classic, and docked bike

  ![Screen Shot 2024-10-12 at 3 13 18 PM](https://github.com/user-attachments/assets/fc30cfd3-5e7d-48d9-9445-7ffef3f12e23)

6. The table below shows the number of NULL values in each column:

  ![Screen Shot 2024-10-12 at 3 14 02 PM](https://github.com/user-attachments/assets/fbea6067-e482-469c-a366-21141f4579bc)

7. There are **1,388,170 rows** that contain at least one null entry.
8. **156,032 rows** contain outliers, which I determined by having a ride duration < 1 minute or > 24 hours long.

**Data Cleaning and Transformation**:
SQL Query: [Data Cleaning](https://github.com/kiankaas/bike-share-analysis/blob/main/03-data_cleaning.sql)

As **1,388,170 rows** contained at least one NULL value, simply deleting all these rows from the dataset would reduce our total available data by **~24%**, which could significantly affect our results. As the other columns contain valuable data that can be used for analysis, such as **rideable_type** and **member_casual**, I decided to keep these rows and treat the null entries as N/A rather than deleting them. 

To account for outliers I want to remove all trips with a duration of less than one minute and trips lasting more than 24 hours. Very short trips (under one minute) are likely due to user errors, such as unlocking and immediately relocking a bike, while trips over 24 hours likely involve operational activities, such as maintenance or relocation by Divvy. These outliers do not reflect typical user behavior and were removed to maintain the quality of the dataset. 

Using the **started_at** and **ended_at** columns, in YYYY-MM-DD HH:mm:ss UTC format, I created a new column named **ride_duration_minutes** to display the total duration of each ride in minutes. I will also create new columns **day_of_week**, **month**, and **hour** to help with analysis later on. As we create the new dataset, we can drop the **ride_id**, **start_station_name**, **start_station_id**, **end_station_name**, **end_station_id**, **start_lat**, **start_lng**, **end_lat** and **end_lng** columns as they serve no value to our analysis and keep the dataset cleaner. With these changes, a total of **269,711 rows** were deleted.

With these changes, our data is clean and ready to analyze. The final cleaned dataset has **5,450,166 rows** and **8 columns**.

## Analyze:
SQL Query: [Data Analysis](https://github.com/kiankaas/bike-share-analysis/blob/main/04-data_analysis.sql)

Analysis question: How do annual members and casual riders use Cyclistic bikes differently?  

### Total Rides in 2023:

![Screen Shot 2024-10-10 at 7 41 44 PM](https://github.com/user-attachments/assets/176cdcf0-9586-4217-8a3e-cb0afb80e191)

- Annual members made nearly twice as many rides in 2023 as casual riders did.
- Annual members made a total of 3,479,468 rides, accounting for 64% of the total rides.
- Casual riders made a total of 1,970,698 rides, accounting for 36% of the total rides.


### Types of Bikes:

![Screen Shot 2024-10-10 at 5 40 13 PM](https://github.com/user-attachments/assets/e9d4b5bf-425c-4a96-a2c7-3c65b77f8a49)

- Annual members have an equal preference towards electric and classic bikes.
- Casual riders slightly prefer electric bikes over classic bikes.
- Docked bikes were only used by casual riders.


### Total Rides per Month:

![Screen Shot 2024-10-10 at 5 52 23 PM](https://github.com/user-attachments/assets/0b66856f-fabc-4697-93b8-820e9cad1113)

- Both casual riders and annual members exhibit a similar seasonal trend, forming a bell curve over the year.
- Ride activity steadily rises through the spring and peaks in August, before dropping quickly as the colder months approach.


### Total Rides per Day of Week:

![Screen Shot 2024-10-10 at 5 56 51 PM](https://github.com/user-attachments/assets/267a682f-b852-42bf-af78-db8c892e3857)

- Casual riders and annual members exhibit nearly opposite trends in their usage patterns throughout the week.
- Annual members take more rides during weekdays, where casual riders take more trips during weekends. 


### Total Rides per Hour:

![Screen Shot 2024-10-10 at 5 59 36 PM](https://github.com/user-attachments/assets/89a5bef0-1b65-4634-9140-144991de165c)

- Annual members have distinct peaks during rush hours, with a significant increase at 8am and another at 5pm, reflecting commuting patterns.
- Casual riders show a relatively smooth rise in activity starting around 6am and peaking around 6pm, before declining.


### Average Rider Duration in Minutes per Member Type:

![Screen Shot 2024-10-10 at 6 03 41 PM](https://github.com/user-attachments/assets/fdab11d0-f856-4733-810e-a3bb1e438ce4)

- On average, casual riders take much longer rides than annual members, at nearly twice the average time.


### Average Ride Duration per Month:

![Screen Shot 2024-10-10 at 6 04 25 PM](https://github.com/user-attachments/assets/4beacab3-4cef-4414-8e5d-190d252ab04e)

- Annual members maintain a consistent average ride duration, hovering around 10-13 minutes throughout the year, and peaking in the summertime.
- Casual riders have longer average ride durations throughout the whole year, peaking in July steadily decreasing in the following months.
- This contrast in ride duration shows that casual riders tend to use bikes for leisurely and longer rides, while members use them for shorter, more practical trips.


### Average Ride Duration per Day of Week: 

![Screen Shot 2024-10-10 at 6 10 44 PM](https://github.com/user-attachments/assets/1fb1d145-1b6d-4b9c-98af-9c82b1d73a70)

- Both casual riders and annual members follow a similar trend, taking their longest trips on average on the weekends.

## Share:
Tableau Dashboard: [Cyclistic Bike-Share Case Study](https://public.tableau.com/app/profile/kian.kaas/viz/CyclisticBike-ShareCaseStudy_17283420976820/CyclisticDashboard)

![Screen Shot 2024-10-11 at 2 31 09 PM](https://github.com/user-attachments/assets/96f564d8-5704-424d-8b2c-f4332171f6fd)

**Similarities**:
- Both annual members and casual riders exhibit a similar seasonal trend, with ride activity rising through the spring, peaking in August, and declining in the colder months.
- Both groups take their longest rides on average during weekends, likely indicating more leisure or free time.
- Both annual members and casual riders make extensive use of electric and classic bikes.

**Differences**:
- Annual members account for 64% of all rides in 2023, taking significantly more trips than casual riders.
- Annual members split their usage evenly between electric and classic bikes, while casual riders favor electric bikes and are the only group to use docked bikes.
- Annual members are most active on weekdays, especially during rush hours at 8am and 5pm, reflecting a commuter pattern.
- Casual riders are more active on weekends, with a steady rise in activity that peaks around 6pm.
- Casual riders take longer rides, averaging nearly twice the duration of annual members.
- Annual members maintain a steady ride duration year-round, suggesting commuter-focused trips.
- Casual riders have much longer average ride times, especially during the summer, suggesting leisure-based trips.

## Act:

From my analysis, Cyclistic can design marketing strategies to convert casual riders to annual members. Here are my recommendations:

**Recommendations**:

**1. Offer New Memberships**
- Expand the pricing plans to offer monthly and seasonal passes. Offering seasonal passes, particularly for the peak riding months of spring and summer, could appeal to those who prefer biking during warmer weather. Additionally, a monthly pass option would allow riders to test out the benefits of membership before committing long-term, potentially leading to a smoother transition from casual to annual membership.

**2. Introduce a Loyalty Program**
- Implement a membership loyalty program that rewards casual riders for longer trips. Since casual riders tend to take longer rides, offering a points-based system where they can earn rewards or discounts toward an annual membership could incentivize them to convert.

**3. Weekend Promotions**
- Implement special promotions or discounts for weekend rides to cater to casual riders who are most active during this time. Consider offering a “Weekend Pass” that provides unlimited rides for a flat fee or discounted rates for rides taken on weekends. This could encourage casual riders to explore different bike routes, ultimately leading them to consider a full membership for convenience and savings during their leisure time. 

**4. Social Media Engagement**
- Utilize social media platforms to connect with a younger audience and build a community within Cyclistic. Share dynamic content featuring success stories, testimonials, and user-generated posts that highlight the joy of cycling. Encourage followers to share their biking adventures with a dedicated hashtag, and host online challenges or contests promoting weekend rides to engage casual riders and inspire them to join as members.

**5. Recommendation for Data Collection**
- To enhance future analyses and marketing strategies, Cyclistic should consider collecting additional demographic data, such as age and gender, from its users. This information would provide deeper insights into the preferences and behaviors of different rider segments, allowing Cyclistic to tailor its offerings more effectively. By understanding the demographics of both casual and annual riders, the company can identify trends, develop targeted marketing campaigns, and create customized membership options that cater to specific groups, ultimately fostering greater engagement and satisfaction among all riders.


