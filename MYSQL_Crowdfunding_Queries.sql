create database crowdfunding;
use crowdfunding;
select * from projects;
select * from crowdfunding_category;
select * from crowdfunding_creator;
select * from crowdfunding_location;

#Total number of projects based on outcomes
select STATE,count(projectID) AS TOTAL_PROJECTS from projects GROUP BY STATE;

#Total Number of Projects based on Locations
select Country,count(ID) AS TOTAL_PROJECTS from crowdfunding_location group by country;

#Total Number of Projects based on  Category
select name,count(ID) AS TOTAL_PROJECTS from crowdfunding_category group by name;

select from_unixtime(created_at) as Date from projects;
select year(from_unixtime(created_at)) as year ,count(projectID) as total_projects from projects group by year;

select quarter((from_unixtime(created_at))) as quarter ,count(projectID) as total_projects from projects group by quarter;

select monthname((from_unixtime(created_at)))as month ,count(projectID) as total_projects from projects group by month;


 #Successful Projects
	#Amount Raised 
	#Number of Backers
	#Avg NUmber of Days for successful projects
    
    select name,(goal*static_usd_rate) as amount_raised from projects where state="successful";
    select name,backers_count from projects where state ="successful";
    
   select round(avg(
    datediff(
    from_unixtime(launched_at),
    from_unixtime(created_at))
    )) as avg_days
    from projects;
    
    # . Top Successful Projects :Based on Number of Backers Based on Amount Raised.
      select name,(goal*static_usd_rate) as amount_raised from projects where state="successful" order by amount_raised desc limit 5;
	  select name,backers_count from projects where state ="successful" order by backers_count desc limit 5;

#Percentage of Successful Projects  by Category
select c.name as category_name , (sum(p.state="successful")*100)/count(p.projectID) as percentage 
from projects p join crowdfunding_category c on p.category_id = c.id group by c.name;
select * from projects;

select year(from_unixtime(created_at)) as year, (sum(state="successful")*100/count(*)) as percentage from projects  group by year;
select monthname(from_unixtime(created_at)) as month, (sum(state="successful")*100/count(*)) as percentage from projects  group by month ;

# Percentage of Successful projects by Goal Range
select 
case 
when goal <5000 then "Low"
when goal between 5000 and 10000 then "moderate"
else "high"
end as goal_range,
sum(state="successful")*100/count(*) as percentage from projects group by  goal_range;