import json
import requests

url = 'https://login.microsoftonline.com/common/oauth2/v2.0/token'
clientId = 'f6edad7f-2ae1-4bf0-8208-c4e35c490a37'
botHandle= 'ottob_sniknej'
clientSecret = '3yPaBDjOmeecvcqyTP1hbji'
data = 'client_id=' + clientId + '&client_secret=' + clientSecret + '&grant_type=client_credentials&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default'
r = requests.post(url, data=data)
token = json.loads(r.content)
print r.content

# message = {"content" : "Hi! (wave)"}
headers = {'Authorization': 'Bearer (%s)' % token['access_token']}
get_chats = requests.get('https://docs.botframework.com/v3/directline/tokens/generate', headers=headers)
print get_chats.content
