# Ubuntu 22.04 

* first steps..
* Install Docker

## first steps.. 

The vboxuser is not a sudoer but root uses the same password. 

#### Create Admin User

So the first thing I want to do is go to root, create the standard aws ubuntu user `ubuntu`
and then make `ubuntu` a `sudoer` and use that for my admin account. 
    
    su -
    apt update 
    useradd -m ubuntu
     this creates a /home/ubuntu
    passwd ubuntu
    su ubuntu
    cd 
    pwd

Change your shell to bash.. or whatevs

    chsh

when it asks you which shell. 

    /bin/bash

You can also steal the default .bashrc that is created with the virtualbox user by copying it to /tmp and then 
copying it to your home. 

### Set up sshd 

    apt-get install openssh-server
    systemctl enable ssh --now

login to this box from the mac. 

    lmurdock$ ssh ubuntu@192.168.0.45
    $ su -
    root@Tinkerbell:~#

### Add Ubuntu user to sudoers no password

    root@Tinkerbell:~# vi /etc/sudoers

find root line and add the ubuntu line. 

    # User privilege specification
    root    ALL=(ALL:ALL) ALL
    ubuntu    ALL=NOPASSWD: ALL

### TODO: Password less login

from my mac terminal

    ssh-copy-id ubuntu@192.168.0.45

now I can log in with simply 

    ssh ubuntu@192.168.0.45

Next from `ubuntu` get rid of password ssh logins.

    $ sudo vi /etc/ssh/sshd_config

I removed the comment out of `PasswordAuthentication` and changed `yes` to `no`
and then added the `PubKeyAuthentication` line.

    #   ForwardX11Trusted yes
       PasswordAuthentication no
       PubkeyAuthentication yes
    #   HostbasedAuthentication no

And then restart

    $  systemctl restart sshd.service
    ==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
    Authentication is required to restart 'ssh.service'.
    Authenticating as: root
    Password: 
    ==== AUTHENTICATION COMPLETE ===
    $
    
This didn't work. vboxuser could still log in with password

Rebooting didn't help either. 


## Docker 

Folowing along to this.  https://docs.docker.com/engine/install/ubuntu/

    ubuntu@Tinkerbell:~$ sudo apt-get remove docker docker-engine docker.io containerd runc

Containers, volumes, and networks are stored in `/var/lib/docker`  and are not 
removed with the `apt-get remove`.  I didn't have anything there. 

### Install Using the Repository

     sudo apt-get update
     sudo apt-get install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
     sudo mkdir -p /etc/apt/keyrings
     curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

at which point `docker.gpg` is in the `/etc/apt/keyrings` directory.

Setup the repository. 

     echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
     
Then redo the update. 

    sudo apt-get update

And finally install. 

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

Test.

    sudo docker run hello-world

Seeing the version of docker-engine

    docker version
    docker compose version

### Installing Kubectl with snap

I found this [Official Kubectl install instructions](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
in the section "Install using other package management"

>      snap install kubectl --classic
>      kubectl version --client

Looking up `--classic` I got this link on [classic confinement](https://ubuntu.com/blog/how-to-snap-introducing-classic-confinement)

So. 

        ubuntu@Tinkerbell:~/src/sandbox$ sudo snap install kubectl --classic
        kubectl 1.26.0 from Canonical✓ installed
