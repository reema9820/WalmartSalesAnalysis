# WalmartSalesAnalysis

## Project Overview

This project involves analyzing sales data from Walmart to uncover insights into product performance, customer behavior, and revenue trends. The analysis is conducted using SQL, focusing on creating and manipulating a database of sales data to answer key business questions.

## Table of Contents

1. [Project Setup](#project-setup)
2. [Database Schema](#database-schema)
3. [Data Cleaning](#data-cleaning)
4. [Data Analysis](#data-analysis)
    - [General Queries](#general-queries)
    - [Product Analysis](#product-analysis)
    - [Customer Analysis](#customer-analysis)
    - [Sales Analysis](#sales-analysis)
5. [Insights](#insights)
6. [Usage](#usage)
7. [Contributing](#contributing)
8. [License](#license)


## Project Setup

To set up this project, follow these steps:

1. **Install MySQL:** Ensure that MySQL is installed on your system. You can download it from [here](https://dev.mysql.com/downloads/).
2. **Create Database:** Run the following command to create the database if it doesn't already exist:
    ```sql
    CREATE DATABASE walmartSales IF NOT EXISTS;
    ```
3. **Create Tables:** Run the SQL script provided in the `SalesAnalysis.sql` file to create the necessary tables and perform data analysis.

## Database Schema

The project uses a single table named `sales` with the following columns:

- `invoice_id`: VARCHAR(30) - Primary Key
- `branch`: VARCHAR(5)
- `city`: VARCHAR(30)
- `customer_type`: VARCHAR(30)
- `gender`: VARCHAR(30)
- `product_line`: VARCHAR(100)
- `unit_price`: DECIMAL(10,2)
- `quantity`: INT
- `tax_pct`: FLOAT(6,4)
- `total`: DECIMAL(12,4)
- `date`: DATETIME
- `time`: TIME
- `payment`: VARCHAR(15)
- `cogs`: DECIMAL(10,2)
- `gross_margin_pct`: FLOAT(11,9)
- `gross_income`: DECIMAL(12,4)
- `rating`: FLOAT(2,1)
- `time_of_day`: VARCHAR(20)
- `day_name`: VARCHAR(10)
- `month_name`: VARCHAR(10)

## Data Cleaning

Initial data cleaning involves adding columns to better categorize and analyze the data, such as `time_of_day`, `day_name`, and `month_name`. These columns are generated based on existing `time` and `date` data.

## Data Analysis

### General Queries

- **Unique Cities:** Determine the number of unique cities in the dataset.
- **Branch Locations:** Identify the city associated with each branch.

### Product Analysis

- **Unique Product Lines:** Identify distinct product lines.
- **Top Selling Product Lines:** Find the product lines with the highest sales volume.
- **Revenue by Month:** Calculate total revenue per month.

### Customer Analysis

- **Customer Types:** Determine the most common customer types.
- **Payment Methods:** Identify the most popular payment methods.
- **Gender Distribution:** Analyze customer gender distribution across branches.

### Sales Analysis

- **Sales by Time of Day:** Analyze the distribution of sales across different times of the day.
- **Revenue by Customer Type:** Determine which customer type contributes the most to revenue.
- **Tax/VAT Analysis:** Identify the city and customer type with the highest average tax percentage.

## Insights

The analysis provides insights into sales performance, customer preferences, and revenue trends at Walmart. Some key findings include:

- Evening hours see the highest sales.
- Certain product lines consistently outperform others in terms of sales and revenue.
- Specific customer types contribute more to overall revenue and VAT.

## Usage

To use this project:

1. Clone the repository or download the `SalesAnalysis.sql` file.
2. Set up the database as per the instructions in the [Project Setup](#project-setup) section.
3. Run the queries to generate insights.

## Contributing

Contributions to this project are welcome! If you have suggestions for improvements or new features, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


