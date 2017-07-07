import socket
	
 
def portScan (tgtIp, tgtPort, code = 1):
    try:
        s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(0.1)
        result=s.connect_ex((tgtIp, tgtPort))
        if result == 0:
            code = result
        s.close()
    except Exception, e:
        pass
    return code
 
print "Port Scanner."
host=raw_input("Enter host address: ")
print "Scanning started..."
 
for port in range(1,200):
    try:
        response = portScan(host, port)
        if response == 0:
            print ("Port %d: is opened" % port)
    except Exception, e:
        pass
        
 
raw_input("Press any key to exit...")