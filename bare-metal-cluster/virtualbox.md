# Virtual Box

 * [End User Documentation](https://www.virtualbox.org/wiki/End-user_documentation)

Built a second one with mac address 08:00:27:94:D0:5B

## Build Out

 * First screen is Oracle VM VirtualBox Manager
 * Press Add
   * Name: Tinkerbell
   * Folder had a space in the name.  made it VirtualBoxVMs
   * Iso Image:  I went and downloaded Ubuntu 22.04 iso for desktop because I might use some desktop features.  
       THis is going to be a pet. 
   * URL for Download https://ubuntu.com/download/desktop
   * Then I search for it. and added it to that line.  The edition type and version
      got detected and they said it would install unattended from there.  
 * Unattended Guest OS Install Setup.  Guest OS is the OS in the virtual box.  As opposed to the 
   OS of the machine that Virtual box is running.  
   * Username:  vboxuser   #//TODO: What Should I have changed this?  
   * Password:  Change it. hint: d m. 
   * Hostname: Tinkerbell
   * DomainName:  #//TODO: what should I have changed this too?  myguest.virtualbox.org
   * I went ahead and checked the guest Additions to add them.  #//TODO: what are they? 
 * Hardware
   * Basememory: 6465MB
   * Processors: 2
   * Not enabling EFI. #//TODO What is that? 
 * Virtual Hard Disk
   * Create a Virtual Hard Drive: 20 GB
   * Not preallocated

### Fixing the Network

Once it was created, you pick tinkerbell and go to settings and pick network and
under that choose "bridge adapter". It will give you a series of 
your network and wifi devices.  

The one you pick will be on a given network and dhcp will give you 
an IP on that network.  Note that the virtual box will have its
own generated mac address which is different than the 
physical network card.  For example

    08:00:27:1d:c9:7e 
    ip 192.168.0.45

is the mac address on this ethernet device in the virtual box.  Whereas on the host
machine the mac and IP are:

    00:e3:e1:cf:b0:d8
    ip 192.168.0.43

The wifi btw is 192.168.0.33

This mac address stays the same even if you shut down the machine and bring it back up.
On the other hand you can bring it down and then go to advanced in network settings and 
you will see the mac address, and you can change it to what ever you want.  There is a also
a cycle button that I assume generates a new valid mac address. 

### Ubuntu

Virtual box creates its user with a password. 

It doesn't make that user a sudoer but it does create a root account with the same password.

So we got a base iso Ubuntu 22.04 on the virtual box, now we do some [Ubuntu things](ubuntu.md)

