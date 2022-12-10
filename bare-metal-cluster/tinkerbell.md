# Tinkerbell

References:
 * Main Website [tinkerbell.org](https://tinkerbell.org)

### The Boot Flow
[TInkerbell 101](https://www.youtube.com/watch?v=Y04eCSKaQCc)

Acronyms
 * DHCP -  Dynamic Host Configuration Protocol - Give network configs systems that ask
 * TFTP - Trivial File Transfer Protocol - File transfer
 * PXE - Preboot Execution Environment - Server initiated OS load

The Boot Flow
1. Power on New server. 
2. Complete POST Power On Self Test
4. Bios can also be set to boot to network, instead of local drive
5. It will then broadcast the MAC Address to the network. 
6. DHCP server will then give an IP and the New Server will accept it and will reserve it. 
7. DHCP can also send. IP of the boot server. and the filename of the prelinux.0 preboot OS
8. New Server then request TFTP of preboot OS  from the Boot Server. 
9. PXE will load and run that preboot OS.  
10. PXE code will now send a message with the MAC address and say it is from the given IP and will send the PXE Label
11. Deployment server will see the mac address and thens end the right OS based on the PXE label. 
12. kernel will then get vmlinuz and initradisk with TFTP

Custom Scripting and Old Legacy Software.  THese tech are from the 90s.

### Tinkerbell

Tinkerbell is new. 2020s baremetal stack. 

Components: 
 * Boots - DHCP & IPXE Server - reimplemented TFTP and PXE in Go. 
 * OSIE - In-Memory Boostraper Alpine Linux and Docker engine.
 * Tinkerbell - Provisioning and Workflow engine.  
   * What - Declarative Yaml Template
   * Who A machine or worker
   * This is going to send stuff as containers to OSIE.  
 * Hegel - Metadata Service
   * What ever workflow you right, it can interogate the Hegel metadata.  
   * So every server gets Ubuntu.  But when it does its cloud init
   * Hegel will give the unique metadata for that mac address. 
   * Metadata server is very cloudlike..  Same OS, unique stuff in configuration

[Tinkerbell, a deep dive into the magic of cloud native bare metal]   (https://www.youtube.com/watch?v=YMA70xZlKic&t=4s)

Cloud Native Bare Metal!

Crocodile - Operating system images are created in Crocodile which uses Packer (Hashicorp Packer I believe)
Hook (New version replacing OSIE) - Recently Replaced LinuxKit from Docker. 
ORAS - OCI Registry as Storage 
DOcker - executing Workflows. 
Packer - Part of OS Build

The Boot Flow
1. Through Tink-CLI the admin adds a mapping between a mac address and a tinkerbell worflow
2. This goes into Tink-server (Tinkerbell)
3. Boots - the DHCP server, and TFTP on waiting for new servers 
4. Power on New server. 
2. Complete POST Power On Self Test
4. Bios can also be set to boot to network, instead of local drive
5. It will then broadcast the MAC Address to the network. 
6. Boots will respond and give it the IP
7. Boots will also give it the PXE preboot in memory os with TFTP
8. PXE on the New Server will load and run that preboot OS.  
10. PXE code will now send a message with the MAC address and say it is from the given IP and will send the PXE Label
11. Tink-server will give it the tinkerbell workflow associated with that mac address.  
12. ie say the workflow is to load UBUNTU. THis will get loaded in with containers this will then stream Ubuntu on the hard drive
13. And then its ready to go. 

Common Actions
 * Image2disk
 * oci2disk
 * archive2disk

Typically stream an OS that gets written to a block device. 

PostInstall Actions. 
 * Modify the newly deployed OSm disks, files or install boot loaders. 
 * Kexec/reboot - either reboot the machine or kexec to immediately drop into the new OS.
