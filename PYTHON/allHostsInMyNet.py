from netaddr import *
import os

for ip in IPNetwork('10.23.12.204/20').iter_hosts():
    response = os.system("ping -t -n 1 -w 10 %s" % ip)
    if response == 0:
        print ip, 'is up!'
    else:
        print ip, 'is down!'


