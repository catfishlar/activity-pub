# USB Install

As the tinkerbell drama dragged on I ended up installing ubuntu 22.4 on some of the nucs with a USB Drive. 

 * got an Iso here https://ubuntu.com/download/desktop
 * Created a USB stick with https://ubuntu.com/tutorials/create-a-usb-stick-on-macos
 * Install Ubuntu
 * Normal install, install updates
 * Erase disk.. when I go forward I get an error. 
 * Advanced features changed the file system to ZFS no encryption, then hit back button then forward.  Finally install enabled. 
 * add my lmurdock user.  I named them same as in the [nuc document](nuc.md) required password to login. 



## Post OS Install

### Enable sshd 

    sudo apt install openssh-server
    sudo systemctl enable --now ssh
    sudo systemctl status ssh