import sys
import os
import requests
import json

class ArpRunner:
    def __init__(self):
        self.run = os.system
        self.mac = sys.argv[1]
        self.send = Smartthings()

    def arpIt(self):
        '''
        thanks to schettj : https://community.smartthings.com/t/presence-sensor-device-associated-with-local-wifi/17305
        Using arp to get incomplete/connected devices
        Cross checking with the address leases
        returns 0 for present/returns 1 for everything else
        '''
        cmd = """
        rm /tmp/f1
        rm /tmp/f2
        arp | cut -d ' ' -f 2,4 | tr A-F a-f | sort -t ' ' -k 2 | grep -v incomplete | awk  '{ print $2 " " $1}' > /tmp/f1
        cat /var/lib/misc/dnsmasq.leases | cut -d ' ' -f 2,4 | sort  > /tmp/f2
        awk 'NR==FNR {h[$1] = $2; next} {print $1,h[$1]}' /tmp/f2 /tmp/f1 | grep -q %s
        """ % self.mac
        #sends the cmd to transaction function to evaluate the current state
        self.send.transaction(self.run(cmd))


class Smartthings:
    def __init__(self):
       # I have them set up as environment variables and reads them from there
       self.appID = sys.argv[2]
       self.aToken = sys.argv[3]

    def transaction(self, cmd):
        # gets the return of any function passed in i.e(arpIt())
        if cmd != 0:
             self.state = "away"
             stat = "not present"
             print "Status: Not Present(Away)"

        if cmd == 0:
            self.state = "home"
            stat = "present"
            print "Status: Present(Home)"
    
        self.url = "https://graph-na02-useast1.api.smartthings.com/api/smartapps/installations/%s/Phone/%s?access_token=%s" % (self.appID, self.state, self.aToken)
        '''
        GETS THE STATUS FROM SMARTTHINGS
        IF THE SAME DOES NOTHING :)
        '''
        stateUrl =  "https://graph-na02-useast1.api.smartthings.com/api/smartapps/installations/%s/Phone/state?access_token=%s" % (self.appID,  self.aToken)
        location = requests.get(stateUrl)
        resp = location.json()
        print (resp['value'],stat)
        if resp['value'] != stat:
            send_state = requests.get(self.url)
            print send_state.status_code
        else:
            print "Values are the same: PyState{%s}, STstate{%s}" % (resp['value'], stat)


if __name__ == '__main__':
    ar = ArpRunner()
    ar.arpIt()
