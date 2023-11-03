# Data Analytics Power BI Report

## 1. Import and clean the data
## 2. Creating the data model
## 3. Customer Detail Page

----------------------------------------

## Import and clean the data

For each of the following, click on the 'get data' option to start the process. Then, choose the appropriate option depending on the data source:
- Import the Orders table by connecting to the Azure SQL database using the database credentials option. If you are having issues connecting to this database ensure you don't select the orders_db section, and you don't need to include this in the optional database entry.
- Import the Products table using the csv option, finding the file in your downloads unless you've stored this elsewhere.
- Import the Stores table by connecting to the Azure Blob storage option. This data might not load as you'd expect, with a table appearing and only one row of information. Use the 'drill down' button on the 'name' column to load the data. This column should have the Products.csv text in the cell below the column heading.
- Import the Customers table by selecting get data, folder. This will load the files in your folder and combine them into a single table if you select 'combine and transform'. Ensure the zip file is unzipped.

Ensure the data is clean by eliminating rows with null values (you can do this by filtering the null values out and the save & load the query), ensure all columns are named consistently (I have opted for a 'Customer Info' style), ensure all columns have the correct data type (you can click on the data type for each column heading), delete any unused columns and split columns if you think this would benefit your analysis.

----------------------------------------

## Creating the data model

### *Date Table*
- To create a date table, I used the following DAX expression when creating a new table in Power Query Editor:
  
    Date = \
    ADDCOLUMNS (\
        CALENDAR (\
            MIN(Orders[Order Date]),\
            MAX(Orders[Shipping Date])\
        ),\
        "Year", YEAR([Date]),\
        "Month", MONTH([Date]),\
        "Day", DAY([Date])\
    )
    
*You need to right click on the date table and select 'Mark as date table'*

- I then used formulae like the following, to create StartofMonth/Quarter/Year columns by clicking on "New Column" whilst selecting my date table on the data tab (to ensure your new columns land in your date table):

StartofMonth = MONTH('Date'[Date])

- I also looked at using the SWITCH function to ensure I could have worded Months etc:

StartofMonthName = SWITCH('Date'[StartofMonth], 1, "Jan", 2, "Feb", 3, "Mar", 4, "Apr", 5, "May", 6, "Jun", 7, "Jul", 8, "Aug", 9, "Sep", 10, "Oct", 11, "Nov", 12, "Dec")

- And finally I created a Date Hierarcy to allow me to drill down into data by date types - This is as simple as right clikcing on your first date type and selecting 'Create Hierarchy'. Then, in order, right click on the next date type and click 'Add to hierarchy', selecting your date hierarchy.

*Screenshot of Date Hierarchy*
![image](https://github.com/KieMac16/data-analytics-power-bi-report/assets/145379671/2fa66ce6-b745-475b-a0c4-476df7560330)

### *Building the model*
On the left of the screen you can see three views - Report, Table and Model. Click on 'Model View' and ensure your tables have the appropriate relationships. Ensure the relationships are one-to-many, if possible, and ensure the filter direction is one-way (single) from the one to many column. If there's more than one relationship between two tables, make the correct decision on which relationship is active.

*Screenshot of Model View*
![image](https://github.com/KieMac16/data-analytics-power-bi-report/assets/145379671/486dfdaa-43cf-4768-b262-8820dcbf849f)

### *Create a Measure Table*
The best approach to creating a measure table is by doing so in Model View with Power Query Editor so that the table appears in the Query Editor.
To do this, click 'New Table' and name the table 'Measures Table'.
After adding a new measure to the table you can delete the existing column when creating the table.
Now, ensure you have clicked on the measure table before you create any new measures - which ensures your new measure is stored in your measures table.

### *Create key measures*
I created key measures to prepare for analysis, using DAX expressions:\
- TotalOrders = COUNT(Orders[Product Code])
- TotalProfit = SUMX(Orders, (RELATED(Products[Sale Price]) - RELATED(Products[Cost Price])) * Orders[Product Quantity])
- TotalQuantity = SUM(Orders[Product Quantity])
- TotalCustomers = DISTINCTCOUNT(Orders[User ID])
- Total Revenue = SUMX(Orders, Orders[Product Quantity] * RELATED(Products[Sale Price]))
- RevenueYTD = CALCULATE(\
    [Total Revenue],\
    DATESYTD('Date'[Date])\
    )
- ProfitYTD = CALCULATE(\
    [TotalProfit],\
    DATESYTD('Date'[Date])\
  )

*Screenshot of Measures Table*
![image](https://github.com/KieMac16/data-analytics-power-bi-report/assets/145379671/596c86e7-a31c-43ee-b04f-4a6b2d5d71ea)

### *Create a Geography Hierarcy*
As before with the date hierarchy, we can do the same with Geography.
Ensure the data categories are correct for this, so I made sure the 'Region' data category was changed to 'Continent', for example.

*Screenshot of Geography Hierarchy*
![image](https://github.com/KieMac16/data-analytics-power-bi-report/assets/145379671/84a05821-1ffa-4ad1-80de-861987e5f4bc)

----------------------------------------

## Customer Detail Page
I created the following visuals, whilst ensuring I followed a consistent format using the format tab for each visual:
- Headline Card Visuals
- Summary Chart
- Line Chart
- Top 20 Customers Table
- Top Customer Cards
- Date Slicer\
These were fairly easy to produce, with time mainly taken to ensure they were formatted in a presentable way. However, the 'Top Customer Cards' were initially tricky as I couldn't produce a TopN filter, as I used the 'Card' visual. To get around this, I created 3 tables and then applied the TopN filter by adding the 'Full Name' column to each visual filter.

*My finished customer detail page*
![image](https://github.com/KieMac16/data-analytics-power-bi-report/assets/145379671/09208b57-fabc-4207-82d6-a6c56eb512a0)


