SET GLOBAL local_infile=1;
USE pokemon;
SET @csv_directory = SUBSTRING_INDEX(USER(), '@', -1);

-- Import the CSV file using LOAD DATA INFILE with the correct file path
LOAD DATA LOCAL INFILE 'C:/Users/Norbert/Experimental_Codes/SomeMySQLfiles/pokemon_names-National-test2.csv' into TABLE pokemon
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;