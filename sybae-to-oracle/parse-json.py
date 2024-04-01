import json
import pprint
json_obj=json.load(open("C:\WorkArea\\forkumar\\sybase-to-oracle\\sybase-to-oracle.json"))
#pprint.pprint(json_obj)
for item in json_obj:
    print(item["choices"][0]["message"]["content"])