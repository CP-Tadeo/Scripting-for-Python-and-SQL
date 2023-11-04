USE pokemon;
SELECT * FROM pokemon INTO OUTFILE 'pokemon_names-National-test3.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';