import requests
import sys
import timeit
from requests import ConnectionError

print "PingHTTP."
url = "http://" + raw_input("HOST:")
print "Pinging " + url + " ..."
headers = {
    'user-agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'}
try:
    for i in range(1, 5):
        t1 = timeit.default_timer()
        r = requests.get(url, headers=headers)
        t2 = timeit.default_timer()
        time = t2 - t1
        bytesQuantity = sys.getsizeof(r.content)
        response = r.status_code
        if response <= 299:
            print "%d) Response [%d] bytes = %d time = %f" % (i, response, bytesQuantity, time)
        elif response <= 399:
            print "%d)Redirection [%d] bytes = %d time = %f" % (i, response, bytesQuantity, time)
        elif response <= 499:
            print "%d)Client error [%d] bytes = %d time = %f" % (i, response, bytesQuantity, time)
        else:
            print "%d)Server error [%d] bytes = %d time = %f" % (i, response, bytesQuantity, time)


except ConnectionError:
    sys.exit("Connection Error. Please, check your internet connection.")

raw_input("Press any key to continue...")
