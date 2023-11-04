import scrapy
import os

class PokemonSpider(scrapy.Spider):
    name = 'pokemon_spider'
    unova = False
    alola = False
    National = True
    if alola:
        start_urls = ['https://www.serebii.net/sunmoon/alolapokedex.shtml'] #alola
    if unova:
        start_urls = ['https://www.serebii.net/black2white2/unovadex.shtml'] #unova2
    if National:
        start_urls = ['https://www.serebii.net/pokemon/nationalpokedex.shtml'] #national

    class MyCustomError(Exception):
        pass
    if unova and alola:
        raise MyCustomError("###############Cant do that####################")
    

    if unova:
        def parse(self, response):
            for row in response.css('table.tab tr:not(:first-child)'):
            #for row in response.css('table.tab tr'): 
            #  ^ this makes it so it ignores the headers 
                # name = row.css('td.fooinfo a::text').get() #alola
                # abilities = row.css('td.fooinfo a[href^="/abilitydex/"]::text').getall() #alola
                # stats = [stat.strip() for stat in row.css('td.fooinfo:not(:has(table))::text').getall() if stat.strip()] #alola
                # stats = stats[2:] #alola
                dex_num = row.css('td.cen::text').get()
                name = row.css('td.cen a::text').get() #unova2
                abilities = row.css('td.cen a[href^="/abilitydex/"]::text').getall() #unova
                stats = [stat.strip() for stat in row.css('td.cen:not(:has(table))::text').getall() if stat.strip()] #unova
                stats = stats[2:] #unova
                # HP = stats[0]
                # ATK = stats[1]
                # DEF = stats[2]
                # SPA = stats[3]
                # SPD = stats[4]
                # SPE = stats[5]
                if name and abilities and stats and dex_num:
                    yield {
                        'Pokedex Number': dex_num.strip(),
                        'name': name.strip(),
                        'abilities': [ability.strip() for ability in abilities],
                        'stats': stats
                        # 'HP': HP.strip(),
                        # 'ATK': ATK.strip(),
                        # 'DEF':DEF.strip(),
                        # 'SPA':SPA.strip(),
                        # 'SPD':SPD.strip(),
                        # 'SPE':SPE.strip()
                        # 'HP': HP,
                        # 'ATK': ATK,
                        # 'DEF':DEF,
                        # 'SPA':SPA,
                        # 'SPD':SPD,
                        # 'SPE':SPE
                    }
    if alola:
        def parse(self, response):
            for row in response.css('table.tab tr:not(:first-child)'):
            #for row in response.css('table.tab tr'): 
            #  ^ this makes it so it ignores the headers 
                dex_num = row.css('td.fooinfo::text').get()
                name = row.css('td.fooinfo a::text').get() #alola
                abilities = row.css('td.fooinfo a[href^="/abilitydex/"]::text').getall() #alola
                stats = [stat.strip() for stat in row.css('td.fooinfo:not(:has(table))::text').getall() if stat.strip()] #alola
                stats = stats[2:] #alola
                # name = row.css('td.cen a::text').get() #unova2
                # abilities = row.css('td.cen a[href^="/abilitydex/"]::text').getall() #unova
                # stats = [stat.strip() for stat in row.css('td.cen:not(:has(table))::text').getall() if stat.strip()] #unova
                # stats = stats[2:] #unova
                # HP = stats[0]
                # ATK = stats[1]
                # DEF = stats[2]
                # SPA = stats[3]
                # SPD = stats[4]
                # SPE = stats[5]
                if name and abilities and stats and dex_num:
                    yield {
                        'Pokedex Number': dex_num.strip(),
                        'name': name.strip(),
                        'abilities': [ability.strip() for ability in abilities],
                        'stats': stats
                        # 'HP': HP.strip(),
                        # 'ATK': ATK.strip(),
                        # 'DEF':DEF.strip(),
                        # 'SPA':SPA.strip(),
                        # 'SPD':SPD.strip(),
                        # 'SPE':SPE.strip()
                        # 'HP': HP,
                        # 'ATK': ATK,
                        # 'DEF':DEF,
                        # 'SPA':SPA,
                        # 'SPD':SPD,
                        # 'SPE':SPE
                    }
    if National:
        def parse(self, response):
            pokemon_data = {}  # Dictionary to store Pokémon data

            for row in response.css('table.dextable tr:not(:first-child)'):
                dex_num = row.css('td.fooinfo::text').get()
                name = row.css('td.fooinfo a[href^="/pokemon/"]::text').get()
                abilities = row.css('td.fooinfo a[href^="/abilitydex/"]::text').getall()
                stats = [stat.strip() for stat in row.css('td.fooinfo:not(:has(table))::text').getall() if stat.strip()]
                stats = stats[1:]

                types = row.css('td.fooinfo a[href^="/pokemon/type/"] img::attr(src)').getall()
                types = [url.split('/')[-1].split('.')[0] for url in types]

                abilities += ['None'] * (3 - len(abilities))

                if not dex_num or not name:
                    continue
                
                dex_num = dex_num.split("#")[1]
                form_id = f"{dex_num.strip()}_{name.strip()}"
                stats += ['None'] * (6 - len(stats))
                HP, ATK, DEF, SPA, SPD, SPE = stats if len(stats) == 6 else print('ok')

                if form_id not in pokemon_data:
                    pokemon_data[form_id] = {
                        'Pokedex Number': dex_num.strip(),
                        'name': name.strip(),
                        'ability 1': abilities[0].strip(),
                        'ability 2': abilities[1].strip(),
                        'ability 3': abilities[2].strip(),
                        'HP': HP,
                        'ATK': ATK,
                        'DEF': DEF,
                        'SPA': SPA,
                        'SPD': SPD,
                        'SPE': SPE,
                        'Type1': types[0] if len(types) >= 1 else '---',  # Set Type1, or 'None' if no type
                        'Type2': types[1] if len(types) == 2 else '---',  # Set Type2, or 'None' if no second type
                    }

            for form_data in pokemon_data.values():
                yield form_data

    if unova:
        if os.path.exists('pokemon_names-unova2-test.csv'): #unova
            os.remove('pokemon_names-unova2-test.csv') #unova
    if alola:
        if os.path.exists('pokemon_names-alola-test.csv'): #alola
            os.remove('pokemon_names-alola-test.csv') #alola
    if National:
        if os.path.exists('pokemon_names-National.csv'): #alola
            os.remove('pokemon_names-National.csv') #alola

            


# # if os.path.exists('pokemon_names-alola-test.csv'): #alola
# #     os.remove('pokemon_names-alola-test.csv') #alola

# if os.path.exists('pokemon_names-unova2-test.csv'): #unova
#     os.remove('pokemon_names-unova2-test.csv') #unova