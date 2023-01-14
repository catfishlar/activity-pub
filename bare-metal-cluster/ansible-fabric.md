# Ansible 


## Provisioning Requirements

Before Ansible can start the machine has to be configured.  Things needed
 * An IP 
 * Ubuntu
 * ubuntu users 

 ##### passwordless sudo

As `root`, `vi /etc/sudoers` add the ubuntu line under the root line. 

    root    ALL=(ALL:ALL) ALL
    ubuntu    ALL=NOPASSWD: ALL


 * sshd 
 * get rid of remote password authentication

## Ansible structure with the above

### Install Ansible

#### Install Conda

https://www.anaconda.com/products/distribution

After install

    (base) HilarysMacPro:ansible lmurdock$ python
    Python 3.9.13 (main, Aug 25 2022, 18:29:29) 
    [Clang 12.0.0 ] :: Anaconda, Inc. on darwin
    Type "help", "copyright", "credits" or "license" for more information.
    >>>

#### Add Conda Forge

    (base) HilarysMacPro:ansible lmurdock$ conda config --show channels
    channels:
      - defaults
    (base) HilarysMacPro:ansible lmurdock$ conda config --add channels conda-forge
    (base) HilarysMacPro:ansible lmurdock$ conda config --show channels
    channels:
        - conda-forge
        - defaults
    (base) HilarysMacPro:ansible lmurdock$ conda config --set channel_priority strict

When this is done.. 

    (base) HilarysMacPro:~ lmurdock$ cat ~/.condarc
    channels:
      - conda-forge
        - defaults
    channel_priority: strict

#### Create Python environment Ansible

    conda create -n ansible python=3.9 --file conda-req.txt -y -v -c conda-forge
    # Activate so the pip that follows will put it in the venv environment
    source activate ansible
    pip install -r requirements.txt

For reasons I try to stay in conda, and specifically conda-forge.  I searched these packages 
with. 

    conda search <package> 

Once this is created I can use mamba to do this. 

    mamba search <package>

Which is faster.  Also nicer for creating other environments etc. 

Contents of conda-req.txt

    mamba=1.1.0
    ansible=7.1.0
    fabric=2.6.0

Note that I also included `fabric`  Going to use that, once I have a working `ssh` connection.  

port = 22
user = os.environ('USER'`)
user = os.environ('PASS'`)

c = Connection(host=ip,port=port, user=user, password=password)
