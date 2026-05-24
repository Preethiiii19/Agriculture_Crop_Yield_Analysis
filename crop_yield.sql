create database crops;
use crops;

create table crop_yield (
    Crop VARCHAR(100),
    Crop_Year INT,
    Season VARCHAR(50),
    State VARCHAR(100),
    `Area(ha)` INT,
    `Production(MT)` BIGINT,
    `Annual_Rainfall(mm)` DOUBLE,
    `Fertilizer(Kg)` DOUBLE,
    `Pesticide(Kg)` DOUBLE,
    `Yield(MT/ha)` DOUBLE
);
select * from crop_yield;
update crop_yield 
set Season = trim(Season);

-- ==============================
-- 1. Data Exploration
-- ==============================

-- Total Records
select count(*) as Total_Records from crop_yield;
-- INSIGHT: Total of 19689 records are present

-- Dataset Overview
select 
count(distinct Crop) as Total_Crops,
count(distinct State) as Total_States,
count(distinct Season) as Total_Seasons,
min(Crop_Year) as Start_Year,
max(Crop_Year) as End_Year
from crop_yield;
-- INSIGHT: Total_Crops = 55, Total_States = 30,
-- Total_Seasons = 6, Start_Year = 1997, End_Year = 2020

-- Records per Season
select Season,count(*) as Total_Records from crop_yield
group by Season
order by Total_Records desc;
-- INSIGHT: Kharif season has the highest number of crop records 
-- indicating it is the most actively cultivated season in India

-- ==============================
-- 2. Crop Analysis
-- ==============================

-- Top 10 Crops by Total Production
select Crop,round(sum(`Production(MT)`), 2) as Total_Production
from crop_yield
group by Crop
order by Total_Production desc
limit 10;
-- INSIGHT: Coconut leads total production making it 
-- India's highest yielding crop by output volume

--  Top 10 Crops by Average Yield
select Crop,round(avg(`yield(mt/ha)`), 2) as Avg_Yield
from crop_yield
group by Crop
order by Avg_Yield desc
limit 10;
-- INSIGHT: Coconut has highest average yield 8652 MT/ha
-- making it the most productive crop per hectare

-- Top 10 Crops by Cultivation Area
select Crop,round(sum(`area(ha)`),2) as Total_Area
from crop_yield
group by Crop
order by Total_Area desc
limit 10;
-- INSIGHT: Rice covers largest cultivation area of 991858075 ha
-- making it most widely grown crop

-- Crops with Zero Production
select Crop,State,Crop_Year,Season from crop_yield
where `Production(MT)`=0
order by Crop_Year;
-- INSIGHT: 112 records show zero production
-- indicating crop failures across states and years

-- Yield Comparision Of All Crops
select Crop,
    round(avg(`yield(mt/ha)`), 2) as Avg_Yield,
    round(max(`yield(mt/ha)`), 2) as Max_Yield,
    round(min(`yield(mt/ha)`), 2) as Min_Yield
from crop_yield
group by Crop
order by Avg_Yield desc;
-- INSIGHT: Coconut shows highest max yield 21105 MT/ha

-- ==============================
-- 3. Statewise Analysis
-- ==============================

-- Top 10 States by Total Production
select State,round(sum(`production(mt)`), 2) as Total_Production
from crop_yield
group by State
order by Total_Production desc
limit 10;
-- INSIGHT: Kerala leads with highest total production of 129,700,649,853 units
-- making it India's most productive state

-- Top 10 States by Average Yield
select State,round(avg(`yield(mt/ha)`), 2) as Avg_Yield
from crop_yield
group by State
order by Avg_Yield desc
limit 10;
-- INSIGHT: Goa achieves highest avg yield of 354.78 MT/ha 
-- indicating most efficient farming practices

-- Total Crops Grown per State
select State,count(distinct Crop) as Total_Crops
from crop_yield
group by State
order by Total_Crops desc;
-- INSIGHT: Andhra Pradesh grows most diverse range of 46
-- crops showing highest agricultural diversity

-- State wise Area Under Cultivation
select State,round(sum(`area(ha)`), 2) as Total_Area
from crop_yield
group by State
order by Total_Area desc
limit 10;
-- INSIGHT: Uttar Pradesh has largest cultivated area of
-- 542.6 Million hectares showing maximum land usage

-- Bottom 5 States by Yield
select State,round(avg(`yield(mt/ha)`), 2) as Avg_Yield
from crop_yield
group by State
order by Avg_Yield asc
limit 5;
-- INSIGHT: Sikkim has lowest avg yield of 1.23 MT/ha
-- indicating need for improved farming techniques

-- ==============================
-- 4. Season wise Analysis
-- ==============================

-- Total Production by Season
select Season,round(sum(`production(mt)`),2) as Total_Production
from crop_yield
group by season
order by Total_production desc;
-- INSIGHT: Whole year cultivation records the highest 
-- total production dominating India's crop output

-- Average Yield by Season
select Season,round(avg(`yield(mt/ha)`), 2) as Avg_Yield
from crop_yield
group by Season
order by Avg_Yield desc;
-- INSIGHT: Whole Year cultivation shows highest avg yield of 413 MT/ha

--  Number of Crops per Season
select Season,count(distinct crop) as Total_Crops
from crop_yield
group by Season
order by Total_Crops desc;
-- INSIGHT: Kharif season grows most variety of
-- 53 crops showing highest crop diversity

-- Season wise Area Cultivated
select Season,round(sum(`area(ha)`), 2) as Total_Area
from crop_yield
group by Season
order by Total_Area desc;
-- INSIGHT: Kharif season uses largest cultivation
-- area of 1702.7 million hectares across India

-- ==============================
-- 5. Year Trend Analysis
-- ==============================

-- Total Production per Year
select Crop_Year,round(sum(`production(mt)`), 2) as Total_Production
from crop_yield
group by Crop_Year
order by Total_Production asc;
-- INSIGHT: 2011 recorded highest production and lowest in 2020
-- showing overall irregular trend over 23 years

-- Average Yield per Year
select Crop_Year,round(avg(`yield(mt/ha)`), 2) as Avg_Yield
from crop_yield
group by Crop_Year
order by Avg_Yield asc;
-- INSIGHT: 2010 has high avg yield of 107.15 MT/ha & lowest in 2020 with 4.42 MT/ha
-- indicating irregular & declining farming efficiency

-- Best Year for Each Crop
select Crop,Crop_Year,Season,round(sum(`production(mt)`), 2) as Total_Production
from crop_yield
group by Crop, Crop_Year,Season
order by Crop, Total_Production desc;
-- INSIGHT: Shows peak production year for every
-- crop helping identify best growing periods

-- Year with Most Crop Varieties
select Crop_Year,count(distinct crop) as Total_Crops
from crop_yield
group by Crop_Year
order by Total_Crops desc
limit 5;
-- INSIGHT: 2016 to 2019 had most diverse crop cultivation
-- with 55 varieties grown across India

-- ==============================
-- 6. Rainfall Impact 
-- ==============================
 
-- Rainfall vs Average Yield
select State,
    round(avg(`annual_rainfall(mm)`), 2) as Avg_Rainfall,
    round(avg(`yield(mt/ha)`), 2) as Avg_Yield
from crop_yield
group by State
order by Avg_Rainfall desc;
-- INSIGHT: Meghalaya shows highest rainfall with 
-- low yield indicating rainfall impact on yield

-- Low Rainfall States & Their Yield
select State,
    round(avg(`annual_rainfall(mm)`), 2) as Avg_Rainfall,
    round(avg(`yield(mt/ha)`), 2) as Avg_Yield
from crop_yield
group by State
order by Avg_Rainfall asc
limit 10;
-- INSIGHT: Haryana has lowest rainfall of 466.91 mm
-- yet achieves above the minimum yield showing rainfall 
-- is not the only factor for productivity

-- =========================================
-- 7.Impact of Fertilizer & Pesticide Usage
-- =========================================

-- Top 10 Crops by Fertilizer Usage
select Crop,round(avg(`fertilizer(kg)`), 2) as Avg_Fertilizer
from crop_yield
group by Crop
order by Avg_Fertilizer desc
limit 10;
-- INSIGHT: Coconut uses highest avg fertilizer
-- indicating most input intensive crop

-- Top 10 Crops by Pesticide Usage
select Crop,round(avg(`pesticide(kg)`), 2) as Avg_Pesticide
from crop_yield
group by Crop
order by Avg_Pesticide desc
limit 10;
-- INSIGHT: Wheat uses highest avg pesticide
-- showing most pest vulnerable crop

-- Fertilizer & Pesticide vs Yield
select State,
    round(avg(`fertilizer(kg)`), 2) as Avg_Fertilizer,
    round(avg(`pesticide(kg)`), 2) as Avg_Pesticide,
    round(avg(`yield(mt/ha)`), 2) as Avg_Yield
from crop_yield
group by State
order by Avg_Yield desc
limit 10;
-- INSIGHT: Goa achieves highest yield with
-- 1455723 kg fertilizer and 3051 kg pesticide usage
-- showing relationship between inputs and output

-- ==============================
-- 8. Advanced Analysis
-- ==============================

-- Highest Yielding Crop per State
select State,Crop,round(avg(`yield(mt/ha)`), 2) as Avg_Yield
from crop_yield
group by State, Crop
having Avg_Yield = (select max(avg_y) 
from (select State as s, round(avg(`yield(mt/ha)`), 2) as avg_y 
from crop_yield 
group by State, Crop) t 
where t.s = crop_yield.state)
order by state;
-- INSIGHT: Coconut is the highest yielding crop in
-- most states showing its agricultural dominance followed hy Sugarcane

-- Year over Year Production Growth
select curr.crop_year,
    round(sum(curr.`production(mt)`), 2) as Current_Production,
    round(sum(prev.`production(mt)`), 2) as Previous_Production,
    round((sum(curr.`production(mt)`) - sum(prev.`production(mt)`)) 
    / sum(prev.`production(mt)`) * 100, 2) as Growth_Percentage
from crop_yield curr
join crop_yield prev on curr.crop = prev.crop and curr.state = prev.state
and curr.crop_year = prev.crop_year + 1
group by curr.crop_year
order by curr.crop_year;
-- INSIGHT: 2004 recorded highest growth of 13.70 %
-- while 2016 saw biggest decline in production

-- Top Crop per Season by Production
select Season,Crop,round(sum(`production(mt)`), 2) as Total_Production
from crop_yield
group by Season, crop
having Total_Production = (select max(total_p)
from (select Season as s, crop,round(sum(`production(mt)`), 2) as total_p
from crop_yield
group by Season,Crop) t
where t.s = crop_yield.Season)
order by season;
-- INSIGHT: Sugarcane dominates Kharif season while
-- Wheat leads Rabi season production