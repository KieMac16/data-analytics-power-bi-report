# Data Analytics Power BI Report

## 1. Import and clean the Data



----------------------------------------

### Import and clean the Data

For each of the following, click on the 'get data' option to start the process. Then, choose the appropriate option depending on the data source:
- Import the Orders table by connecting to the Azure SQL database using the database credentials option. If you are having issues connecting to this database ensure you don't select the orders_db section, and you don't need to include this in the optional database entry.
- Import the Products table using the csv option, finding the file in your downloads unless you've stored this elsewhere.
- Import the Stores table by connecting to the Azure Blob storage option. This data might not load as you'd expect, with a table appearing and only one row of information. Use the 'drill down' button on the 'name' column to load the data. This column should have the Products.csv text in the cell below the column heading.
- Import the Customers table by selecting get data, folder. This will load the files in your folder and combine them into a single table if you select 'combine and transform'. Ensure the zip file is unzipped.

Ensure the data is clean by eliminating rows with null values (you can do this by filtering the null values out and the save & load the query), ensure all columns are named consistently (I have opted for a 'Customer Info' style), ensure all columns have the correct data type (you can click on the data type for each column heading), delete any unused columns and split columns if you think this would benefit your analysis.
