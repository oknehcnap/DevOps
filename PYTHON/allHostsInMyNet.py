from netaddr import *
import os
import re

os.system("netsh interface ip delete arpcache > nul")
host=raw_input("Enter host, use XXX.XXX.XXX.XXX/XX f.e. 192.168.0.1/24:")
if re.match('\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/\d{1,2}', host) is not None:
    for ip in IPNetwork(host).iter_hosts():
        response = os.system("ping -n 1 -w 1 %s > nul" % ip)
        if response == 0:
            print ip, 'is up!'
        else:
            pass
    raw_input("Press any key to exit...")
else:
    sys.exit("Ip is not valid. Please, use XXX.XXX.XXX.XXX/XX f.e. 192.168.0.1/24")
