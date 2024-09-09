# Data-Cleaning
This project focuses on cleaning FIFA 2021 messy data-derived web scrapping.



INTRODUCTION
Have you ever been caught off guard by biting into a stone while enjoying a plate of beans?
Just as neglecting to sort your beans can lead to a meal full of unpleasant surprises, skipping data cleaning can leave you with a messy, unreliable dataset. Think of data cleaning is like sorting beans, you meticulously inspect and remove the bad ones (errors or duplicates), group them by size or type (organize data), and discard any foreign objects like stones (filter out irrelevant or noisy data). Both processes ensure that only clean, reliable results remain, whether in your meal or your analysis.
In this post, I will dive into the messy world Kaggle's FIFA 21 raw data(attached fifa_21_raw_data.csv file) derived from web scrapping and needing some serious tidying up. Join me as we transform this data into a refined, insightful resource, ready for meaningful analysis.

DATA PREPARATION
Let me provide some context, If this is your first time reading my article. The SQL used for this analysis is Microsoft SQL Server Management Studio (MSSQL), and the file used is in Comma Separated Value (CSV) format. The first step involves creating a database for your table and then import the file into the database. During the import process, you will need to declare the appropriate data types and determine whether to allow null values for specific columns.

DATA ANALYSIS
1. Table overview: This allows us to visualize all the columns and rows to get an overview of the data before any cleaning actions are taken. The table contains player analysis records with 76 columns and 18,852 rows. The screenshot of the result does not display the entire table. If you're interested, you can download and preview the full data.


2. Dropping Unnecessary Columns: After reviewing the data, we removed columns that were not relevant to the analysis. Columns like Name (as another column includes the players' full names), PhotoURL, PlayerURL, and Loan_date_end (which had limited data) were dropped to simplify the dataset and focus on the essential features.

3. Checking and removing duplicate rows: Duplicate entries can lead to skewed results and analysis. This query groups the data by players_name, club, and nationality, then checks if any combination appears more than once. The duplicated rows identified were removed with a Common Table Expression (CTE), leveraging the ROW_NUMBER() function to assign a unique row number to each duplicate.


4. Displacing similar unwanted characters for multiple columns: Some unwanted characters like "?", "â‚¬" were found among the count of "Injury reserve, contract duration", and some other columns and were removed with an update statement for multiple columns.

5. Displacing different unwanted characters for single columns: The playes_name column had quite an amount of funny characters like ("Kylian Mbappé" written as "Kylian MbappÃ©", "Roberto Suárez Pier", written as "Roberto SuÃ¡rez Pier", "Ciprian Tataruanu" written as "Ciprian TÄƒtÄƒruÈ™anu" among others that were replaced with the correct letters.


CONCLUSION
Data cleaning is more than just a preparatory step in data analysis, it is the key to unlocking the full potential of any dataset. By meticulously refining the FIFA 2021 raw data, I removed unnecessary columns, addressed duplicates, and eliminated unwanted characters. These processes ensured that the data was not only clean and accurate but primed for insightful analysis. Transforming chaotic raw data into a well-organized, structured format, paves the way for more effective analysis and robust model-building.
Just as data cleaning refines raw data for precision, sorting beans ensures uniformity and quality in a meal. Both processes, while distinct, are essential in delivering clean, reliable outcomes in their respective domains.
