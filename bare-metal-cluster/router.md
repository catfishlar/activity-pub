# My Router

I have a Century link [C4000XG](https://www.centurylink.com/content/dam/home/help/internet/downloads/modem-user-guides/C4000_Datasheet_05-2020.pdf)

Internal network on 192.168.1 if you go to the interface in Safari it looks aweful, need to use Chrome. 

## DNS

The router has Dynamic DNS.  This is for the routers outside IP to DNS.  It is defaulted to 
off.  You can chose DynDNS.  For this you need a user account on DynDNS.com.  

I could actually serve a real site from here with DynDNS and port forwarding. 

## DHCP Reservations

Set a fixed location for the 6 machines, by getting there mac addresses and associating them 
with IPs

    i5nuc1 is 192.168.0.50
    i5nuc2 is 192.168.0.51
    i5nuc3 is 192.168.0.52
    i3nuc1 is 192.168.0.53
    i3nuc2 is 192.168.0.54
    i3nuc3 is 192.168.0.55

## DNS Host Mapping 

Allows Internal DNS names for these fixed IPs.   Which is kinda handy. 

So I set the ips in the DHCP reservations according to the names above. 


