# SQL Join exercise
#
use world;
#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
#
select *  from city where Name like "ping%" order by Population asc;
#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
#
select *  from city where Name like "ran%" order by Population desc;
#
# 3: Count all cities
#
select count(*) from city; 
#
# 4: Get the average population of all cities
#
select avg(Population) from city; 
#
# 5: Get the biggest population found in any of the cities
#
select max(population) from city;
-- select * from city order by population desc;
#
# 6: Get the smallest population found in any of the cities
#
select min(population) from city;
-- select * from city order by population asc;
#
# 7: Sum the population of all cities with a population below 10000
#
select sum(population) from city where population < 10000;
-- select * from city where population < 10000;
#
# 8: Count the cities with the countrycodes MOZ and VNM
#
select count(*) from city where countrycode in ("MOZ", "VNM");
-- select count(*) from city where countrycode = "MOZ";
-- select count(*) from city where countrycode = "VNM";
#
# 9: Get individual count of cities for the countrycodes MOZ and VNM
#
select count(*) from city where countrycode = "MOZ";
select count(*) from city where countrycode = "VNM";
#
# 10: Get average population of cities in MOZ and VNM
#
select avg(population) from city where countrycode in ("MOZ", "VNM");
#
# 11: Get the countrycodes with more than 200 cities
#
select countrycode, count(countryCode) from city group by countrycode having count(countrycode)>200;
#
# 12: Get the countrycodes with more than 200 cities ordered by city count
#
select countrycode, count(countryCode) as Country_Code_Desc from city group by countrycode having count(countrycode)>200 order by count(countrycode) desc;
-- select count(*) from city where countrycode = "BRA";  		-- 250
-- select count(*) from city where countrycode = "CHN"; 		-- 363
-- select count(*) from city where countrycode = "IND"; 		-- 341
-- select count(*) from city where countrycode = "JPN"; 		-- 248
-- select count(*) from city where countrycode = "USA"; 		-- 274
#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
#
-- select c.id, c.name, c.countrycode, cl.language  from city c  join countrylanguage cl where (c.population between 400 and 500) and (c.countrycode = cl.countrycode);
select cl.language  from city c  join countrylanguage cl where (c.population between 400 and 500) and (c.countrycode = cl.countrycode);
#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
#
select c.name, cl.language  from city c  join countrylanguage cl where (c.population between 500 and 600) and (c.countrycode = cl.countrycode);

#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
#
select * from city c join city cx where cx.population = 122199 and c.countrycode = cx.countrycode;
select * from city c where c.countrycode in (select countrycode from city where population = 122199);
-- select * from city where population = 122199; -- SWE
-- select * from city where countrycode ="SWE";
#
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
#
 -- select * exclude(select countrycode from city c where c.population = 122199)  from city c where countrycode = (select countrycode from city c where c.population = 122199) ;
-- todo -> not working
#
# 17: What are the city names in the country where Luanda is capital?
#
select * from city where Countrycode in (select Code from country where Capital in (select id from city where Name = "Luanda"));
-- select id from city where Name = "Luanda";
-- select code from country where Capital in (select id from city where Name = "Luanda");
-- select * from city where CountryCode = "AGO";
#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren
#
-- select CountryCode from city c where c.Name="Yaren";
-- select Region from country ctry where ctry.Code in (select CountryCode from city c where c.Name="Yaren");
-- select * from country ctry where ctry.Region =(select Region from country ctry where ctry.Code in (select CountryCode from city c where c.Name="Yaren")) ;
select Name from city where ID in (select Capital from country ctry where ctry.Region =(select Region from country ctry where ctry.Code in (select CountryCode from city c where c.Name="Yaren")));
#
# 19: What unique languages are spoken in the countries in the same region as the city named Riga
#
-- select CountryCode from city where Name ="Riga";
-- select Region from country where Code = (select CountryCode from city where Name ="Riga");
-- select Code from country where Region = (select Region from country where Code = (select CountryCode from city where Name ="Riga"));
select DISTINCT Language from countrylanguage where CountryCode in (select Code from country where Region = (select Region from country where Code = (select CountryCode from city where Name ="Riga")));
-- select Language from countrylanguage where countryCode = "EST";
-- select Language from countrylanguage where countryCode = "LTU";
-- select Language from countrylanguage where countryCode = "LVA";
#
# 20: Get the name of the most populous city
#
select name, max(population) from city;