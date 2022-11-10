from scapy.all import *
import time

def allow_connections(num,sleep_time):
    print("Allow Connections")
    global pcount,scount
    for i in range(num):
        ip=IP(src=src_ip,dst=dst_ip)  
        SYN=TCP(sport=pcount,dport=dport,flags="S",seq=scount)
        send(ip/SYN)
        scount = scount + 1
        pcount = pcount + 1
        time.sleep(sleep_time)

def deny_connections(num):
    print("Deny Connections")
    global pcount,scount
    for i in range(num):
        ip=IP(src=src_ip,dst=dst_ip)  
        SYN=TCP(sport=pcount,dport=dport,flags="S",seq=scount)
        send(ip/SYN)
        scount = scount + 1
        pcount = pcount + 1



if __name__ == "__main__":
    src_ip = "40.0.0.2"
    dst_ip = "40.0.0.1"
    dport = 5
    pcount = 3000
    scount = 12345
    #deny_connections(100)
    allow_connections(10,2)
    

'''
for i in range(100):
    ip=IP(src=src_ip,dst=dst_ip)  
    SYN=TCP(sport=pcount,dport=dport,flags="S",seq=scount)
    send(ip/SYN)
    scount = scount + 1
    pcount = pcount + 1
    time.sleep(2)
'''
