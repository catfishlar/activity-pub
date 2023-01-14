#  Kubernetes for Tinkerbell

In the Sandbox there is a link for using Kubernetes.   https://github.com/tinkerbell/sandbox

THat link simply points to the helm document.  https://github.com/tinkerbell/charts/tree/main/tinkerbell/stack

In that document you have the prerequisits: 

> * Kubernetes 1.23+
> * Kubectl 1.23+
> * Helm 3.9.4+

Along with instructions on fixing the charts for your kubernetes set up.  The kubernetes we need can be on a single 
host.  And actually a very useful set of instructions can be found in the sandbox where they have a 
`setup.sh` for kubernetes on your tinkerbell host.  

## Setting Up Tinkerbell Host Kubernetes

I'm playing along with `setup.sh` in https://github.com/tinkerbell/sandbox/tree/main/deploy/stack/helm

I set up my own virtualbox with a bridge network.  The main sudo user is `ubuntu`
ip is 192.168.0.46

After bringing it up a Virtualbox with 22.04 iso I did the following:

 * enabled sshd
 * created ubuntu user
 * added `ubuntu` user to sudoers, passwordless
 * added ssh keys for passwordless ssh from local. 
    

### Install Docker

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	add-apt-repository "deb https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	update_apt
	apt-get install --no-install-recommends containerd.io docker-ce docker-ce-cli
	gpasswd -a vagrant docker

Two things about mine are different. I'm using Ubuntu 22.4 which is jammy.  But they are actually using `lsb_release -cs` 
so that is no problem. The other difference is I am not using vagrant. 

Running this. 

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

needed to install curl

    sudo apt  install curl
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

got this warning: 

    Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).

then:

	sudo add-apt-repository "deb https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

Update_apt  is a funcion in setup.sh

    sudo apt-get update

	sudo apt-get install --no-install-recommends containerd.io docker-ce docker-ce-cli
	sudo gpasswd -a ubuntu docker

NOTE: you have to restart your shell to be able to use `docker`  command without sudo.  

### Install Kubectl

	curl -LO https://dl.k8s.io/v1.25.2/bin/linux/amd64/kubectl
	chmod +x ./kubectl
	mv ./kubectl /usr/local/bin/kubectl

Running 

	sudo curl -LO https://dl.k8s.io/v1.25.2/bin/linux/amd64/kubectl
	sudo chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/kubectl


### Install K3d

    wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | TAG=v5.4.6 bash

So what is this..

    https://k3d.io/

Turns out this is the most recent version, so going for it.  


### Start K3d

	k3d cluster create --network host --no-lb --k3s-arg "--disable=traefik,servicelb" --k3s-arg "--kube-apiserver-arg=feature-gates=MixedProtocolLBService=true" --host-pid-mode
	mkdir -p ~/.kube/
	k3d kubeconfig get -a >~/.kube/config
	until kubectl wait --for=condition=Ready nodes --all --timeout=600s; do sleep 1; done

Running in host mode..  so exposed to 192.168.0.1 network where the nucs are. 

    sudo 	k3d cluster create --network host --no-lb --k3s-arg "--disable=traefik,servicelb" --k3s-arg "--kube-apiserver-arg=feature-gates=MixedProtocolLBService=true" --host-pid-mode

    sudo mkdir -p ~/.kube/
    sudo k3d kubeconfig get -a >~/.kube/config

Got a permission error because root owned ~/.kube   So.  

    mkdir -p ~/.kube/
    k3d kubeconfig get -a >~/.kube/config

But this time I got not being able to run docker.. so I remmbered I did added ubuntu to the docker group in this shell
and needed to relog.  reloging.  I reran the k3d command and it worked. 

Then finally 

    until kubectl wait --for=condition=Ready nodes --all --timeout=600s; do sleep 1; done

and got the ok. 

### Install Helm

	helm_ver=v3.9.4

	curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
	chmod 700 get_helm.sh
	./get_helm.sh --version "$helm_ver"

Check the site there is a 3.10 version but that has some upgrades. We really just want this cluster for tinkerbell so 
we stick with 3.9.4 and that verison is the last one before 3.10.  

	sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
	sudo chmod 700 get_helm.sh
	sudo ./get_helm.sh --version v3.9.4

Needed git. 

    sudo apt-get git 

then the get_helm.sh line. 

