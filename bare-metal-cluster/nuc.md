# Intel NUC

I have set up the following by Mac Address in my [router](router.md)

    i5nuc1 is 192.168.0.50
    i5nuc2 is 192.168.0.51
    i5nuc3 is 192.168.0.52
    i3nuc1 is 192.168.0.53
    i3nuc2 is 192.168.0.54
    i3nuc3 is 192.168.0.55

All have 16G of ram and 2 to 4 cores.  

## Setting up for PXE Boot

Reference: 
 * How to enable Pre-Boot Execution Environment (PXE boot) in BIOS? https://www.intel.com/content/www/us/en/support/articles/000054990/intel-nuc/intel-nuc-kits.html
   Unfortunately my nuc doesn't isn't set up exactly as they suggest. Still PXE boot is an OLD thing so.. 

The way I have it set up is as follows:

 * I turned off UEFI boot
 * Set Legacy Boot
 * Put LAN IBA GE Slot 0 - as the first boot drive. 
 * turned off Boot Network Device Last

I then rebooted and did the F10 thing to get it ready. 

I did `docker compose up` without the D so I could see the logs.   And then when it settled down. I hit return on the
boot menu for LAN 0. 

Tinkerbell did some stuff. and on my NUC I saw 

      PXE->EB: !PXE at 9772:0070, etc etc
      
      iPXE 1.0.0+ 
      Welcome to Neverland! 
      press Ctrl-B for the iPXE command line....

THen it did Net0 with the right Mac  and TXE 1 x"network unreachable" .... 

THe it goes to Next server, and that is Tinkerbell host.   Grabs ipxe

      http://192.168.0.45/auto.ipxe .. ok
      auto.ipxe : 1145 bytes [script]
      Tinkerbell Boots iPXE
      http://192.168.0.45/phone-home ... ok
      http://192.168.0.45:8080/vmlinuxz-x86_64... 45%

Then a bunch of stuff and you see the whale and then.. clear screen and... 

     
      machine1 login: root (automatic login)
      
      Welcome to LinuxKit!
      
      NOTE: This System is namespaced: to access, use `ctr -n services.linuxkit ...`
      (ns: getty) machine1:~#[      8.967503] IPVS: ftp: loaded support on port[0] = 21
      [     8.998458] random: crng init done
      [     9.106692] Initializing XFRM netlink socket
      [    81.792710] nf_conntrack: default automatic helper assignment has been turned off for security reasons and CT-based firewall 
                      rule not found. Use the iptables CT target to attach helpers instead.
       [12967.629975] perf: interupt took too long (2519 > 2500), lowering kernel.perf_even_max_sample_rate to 79000

It never resolves.. 

Mean while Tinkerbell log ends with error and stops interacting.  Full log of the server during the above interaction is [here](notes.txt) 

      compose-boots-1                         | {"level":"info","ts":1672339869.2525506,"caller":"dhcp4-go@v0.0.0-20190402165401-39c137f31ad3/handler.go:61","msg":"","service":"github.com/tinkerbell/boots","pkg":"dhcp","pkg":"dhcp","event":"send","mac":"b8:ae:ed:78:a1:14","dst":"192.168.0.54","iface":"enp0s3","xid":"\"4e:10:1e:15\"","type":"DHCPACK","address":"192.168.0.54"}
      compose-hegel-1                         | {"level":"info","ts":1672339869.3988936,"caller":"http/handlers.go:128","msg":"got ip from request","service":"github.com/tinkerbell/hegel","userIP":"192.168.0.54"}
      compose-web-assets-server-1             | 2022/12/29 18:51:09 [error] 30#30: *2 open() "/usr/share/nginx/html/workflow/ca.pem" failed (2: No such file or directory), client: 192.168.0.54, server: localhost, request: "GET /workflow/ca.pem HTTP/1.1", host: "192.168.0.45:8080"
      compose-web-assets-server-1             | 192.168.0.54 - - [29/Dec/2022:18:51:09 +0000] "GET /workflow/ca.pem HTTP/1.1" 404 153 "-" "Go-http-client/1.1" "-"
      compose-boots-1                         | {"level":"info","ts":1672339876.5476007,"caller":"syslog/receiver.go:113","msg":"host=192.168.0.54 facility=daemon severity=ERR app-name=77538d077e30 procid=847 msg=\"{\\\"level\\\":\\\"info\\\",\\\"ts\\\":1672341893.8711987,\\\"caller\\\":\\\"cmd/root.go:133\\\",\\\"msg\\\":\\\"no config file found\\\",\\\"service\\\":\\\"github.com/tinkerbell/tink\\\"}\\n\"","service":"github.com/tinkerbell/boots","pkg":"syslog"}
      compose-boots-1                         | {"level":"info","ts":1672339876.5483232,"caller":"syslog/receiver.go:113","msg":"host=192.168.0.54 facility=daemon severity=ERR app-name=77538d077e30 procid=847 msg=\"{\\\"level\\\":\\\"info\\\",\\\"ts\\\":1672341893.872114,\\\"caller\\\":\\\"cmd/root.go:45\\\",\\\"msg\\\":\\\"starting\\\",\\\"service\\\":\\\"github.com/tinkerbell/tink\\\",\\\"version\\\":\\\"9c098c1\\\"}\\n\"","service":"github.com/tinkerbell/boots","pkg":"syslog"}


 