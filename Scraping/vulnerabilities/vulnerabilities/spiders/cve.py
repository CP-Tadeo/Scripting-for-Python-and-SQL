import scrapy
import os
from os.path import dirname
import csv
import json
import sqlite3

#current_dir = os.path.dirname(__file__)
#url = os.path.join(current_dir, 'source-EXPLOIT-DB.html')
#url = "file:///Users/Norbert/Experimental_Codes/Scraping/vulnerabilities/vulnerabilities/spiders/source-EXPLOIT-DB.html"
#^^works!
#url = f"file://{os.path.join(current_dir, 'source-EXPLOIT-DB.html')}"

# current_dir = os.path.dirname(os.path.abspath(__file__))
# relative_path = 'source-EXPLOIT-DB.html'
# url = f"file://{os.path.join(current_dir, relative_path)}"

# relative_path = 'source-EXPLOIT-DB.html'
# url = f"file://{os.path.abspath(relative_path)}"

# current_dir = os.path.dirname(__file__)
# relative_path = 'source-EXPLOIT-DB.html'
# absolute_path = os.path.abspath(os.path.join(current_dir, relative_path))
# relative_url = os.path.relpath(absolute_path).replace("\\", "/")
# url = f"file:///{relative_url}"

# from urllib.parse import quote
# current_dir = os.path.dirname(os.path.abspath(__file__))
# relative_path = 'source-EXPLOIT-DB.html'
# absolute_path = os.path.abspath(os.path.join(current_dir, relative_path))
# url = "file:///" + quote(absolute_path)

#
# current_dir = os.path.dirname(os.path.abspath(__file__))
# relative_path = 'source-EXPLOIT-DB.html'
# absolute_path = os.path.abspath(os.path.join(current_dir, relative_path))

# drive, path = os.path.splitdrive(absolute_path)

# # Construct the URL
# url = "file://" + path.replace("\\", "/")
#
#above works

current_dir = os.path.dirname(os.path.abspath(__file__))
# relative_path = 'source-EXPLOIT-DB.html'
# absolute_path = os.path.abspath(os.path.join(current_dir, relative_path))

drive, path = os.path.splitdrive(os.path.abspath(os.path.join(current_dir, 'source-EXPLOIT-DB.html')))

# Construct the URL
url = "file://" + path.replace("\\", "/")

class CveSpider(scrapy.Spider):
    print("###############THIS IS THE URL: "+ url)
    name = "cve"
    allowed_domains = ["cve.mitre.org"]
    #start_urls = ["https://cve.mitre.org/data/refs/refmap/source-EXPLOIT-DB.html"]
    
    #start_urls = [f"file://{url}"]
    start_urls = [url]
    
    def parse(self, response):
        connection = sqlite3.connect('vuln.db')
        table = 'CREATE TABLE vulns (exploit TEXT, cve TEXT)'
        cursor = connection.cursor()
        cursor.execute(table)
        connection.commit()
        for child in response.xpath('//table'):
            if len(child.xpath('tr'))> 100:
                table=child
                break
        count = 0
        data = {}
        # csv_file = open('vulnerabilities.csv', 'w') #if csv
        # writer = csv.writer(csv_file) #if csv
        # writer.writerow(['exploit id', 'cve id']) #if csv

        # json_file = open('vulnerabilities.json','w')  #json


        for row in table.xpath('//tr'): 
            if count > 100:
                break
            try:
                exploit_id = (row.xpath('td//text()')[0].extract())
                cve_id = row.xpath('td//text()')[2].extract()
                # writer.writerow([exploit_id, cve_id]) #if csv
                # data[exploit_id] = cve_id  #json
                cursor.execute('INSERT INTO vulns (exploit, cve) VALUES(?, ?)', (exploit_id, cve_id))
                connection.commit()
                count += 1
            except IndexError:
                pass
        # csv_file.close() #if csv

        # json.dump(data, json_file) #json
        # json_file.close() #json
