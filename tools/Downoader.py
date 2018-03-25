import requests
import sys, os, os.path

print('Download CoinBlockerLists main Hosts file')

url = 'https://zerodot1.github.io/CoinBlockerLists/hosts'  
r = requests.get(url)

os.path.expanduser("~"), "Downloads")
with open('hosts', 'wb') as f:  
    f.write(r.content)

# Retrieve HTTP meta-data
print(r.status_code)  
print(r.headers['content-type'])  
print(r.encoding)  