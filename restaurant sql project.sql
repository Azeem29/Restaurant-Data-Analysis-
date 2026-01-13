--SELECT * FROM public."Project1"
--votes Analysis
---Highest votes with respect to Restaurant 
SELECT  "Restaurant Name","Votes"
FROM public."Project1"
ORDER BY "Votes" DESC
LIMIT 1;

--LOWEST VOTES 
SELECT  "Restaurant Name","Votes"
FROM public."Project1"
where "Votes"=0
group by "Votes","Restaurant Name"
ORDER BY "Votes" ASC;

---- Analyzing the correlation between number 
----FINDING TOP 3 CUISINES IN DATA SET
Select*from public."Project1";

Select count(*) as "Cuisines_count", "Cuisines" from 
public."Project1"  group by "Cuisines" order by count(*) DESC limit 3;
--So the top 3 most famous Cuisines are New Delhi, Gurgaon, Noida

--- Percentage of Restaurant that are serving this cuisines....
WITH cuisine_list AS (
    SELECT
        "Restaurant ID",
        TRIM(cuisine) AS cuisine
    FROM public."Project1",
    unnest(string_to_array("Cuisines", ',')) AS cuisine
),
total_restaurants AS (
    SELECT COUNT(DISTINCT "Restaurant ID") AS total FROM public."Project1"
)
SELECT
    cuisine,
    COUNT(DISTINCT "Restaurant ID") AS restaurant_count,
    ROUND(
        100.0 * COUNT(DISTINCT "Restaurant ID") / (SELECT total FROM total_restaurants),
        2
    ) AS percentage_of_restaurants
FROM cuisine_list
GROUP BY cuisine
ORDER BY restaurant_count DESC
LIMIT 3;  -- Top 3 cuisines

--City Analysis
---SELECT * FROM public."Project1"

--SELECT "Cuisines", "Restaurant Name", Sum(COUNT(*)) AS "highest_Restaurant"
--FROM public."Project1"
--GROUP BY "Cuisines", "Restaurant Name"
--ORDER BY COUNT(*) DESC
--LIMIT 50

SELECT "Cuisines", COUNT(*) AS restaurant_count
FROM public."Project1"
GROUP BY "Cuisines"
ORDER BY restaurant_count DESC
LIMIT 1;

--- New Delhi has highest number of Restaurant 

Select avg("Agregate rating"),"Cuisines" from public."Project1" group by "Cuisines";
---SELECT * FROM public."Project1"
Select avg("Agregate rating"),"Cuisines" from public."Project1" group by "Cuisines"
order by avg("Agregate rating") DESC limit 1 ;
---Inner City has highest Ratings of 4.9
--SELECT * FROM public."Project1"


--SELECT * FROM public."Project1"

----Online Delivery Analysis////////

SELECT
  COUNT(*) AS total_restaurants,
  COUNT(*) FILTER (WHERE "Has online delivery" = 'Yes') AS online_delivery_restaurants
FROM public."Project1";

--comparing average ratings of restaurant , with respect to delivery
--online or offline
Select avg("Agregate rating"),"Has online delivery" from public."Project1" group by "Has online delivery"
 having lower("Has online delivery") in ('yes','no');

----##RESTAURANT RATING ANALYSIS
Select avg("Votes") as avg_votes,"Restaurant Name" from public."Project1" group by "Restaurant Name" order by avg_votes  DESC;

-----these are the average votes received by each restaurants

----Cuisines Combination
SELECT * FROM public."Project1";

select "Cuisines","Agregate rating" from public."Project1" where "Agregate rating"> 4.5;
---these are certain cuisines which have highest ratings
SELECT * FROM public."Project1";
DELETE FROM public."Project1"
WHERE "Rating text" = 'Not rated';
SELECT * FROM public."Project1";

---Analyzing reveiw of restaurant
Select "Restaurant Name", "Rating text" from public."Project1" where "Rating text" in ('Excellent','Average');
---So here are some restaurants whose ratings are average and one whose rating is Excellent.
--SELECT CORR("Votes", "Aggregate rating") AS correlation
--FROM public."Project1"
--WHERE "Votes" IS NOT NULL AND "Aggregate rating" IS NOT NULL
  --AND "Votes" > 0 AND "Aggregate rating" > 0;
SELECT * FROM public."Project1";
