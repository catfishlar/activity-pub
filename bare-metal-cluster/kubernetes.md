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

	sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
	sudo chmod 700 get_helm.sh
	sudo ./get_helm.sh --version v3.9.4

### Figure out the Run Time Variables.

At this point in the setup.sh, line 113

    	helm_customize_values "$loadbalancer_ip" "$helm_chart_version"

We need to understand the Parameters that get sent in.. So  Main says

	local host_ip=$1
	local worker_ip=$2
	local worker_mac=$3
	local manifests_dir=$4
	local loadbalancer_ip=$5
	local helm_chart_version=$6
	local loadbalancer_interface=$7
	local namespace="tink-system"

This gets called from vagrant. https://github.com/tinkerbell/sandbox/blob/main/deploy/infrastructure/vagrant/Vagrantfile

With.. 

    provisioner.vm.provision :shell, path: STACK_DIR + "/setup.sh", args: [PROVISIONER_IP, MACHINE1_IP, MACHINE1_MAC, DEST_DIR, LOADBALANCER_IP, HELM_CHART_VERSION, HELM_LOADBALANCER_INTERFACE]

And these values are defined as: 

    LIBVIRT_HOST_IP = ENV["LIBVIRT_HOST_IP"] || "192.168.56.1"
    PROVISIONER_IP = ENV["PROVISIONER_IP"] || "192.168.56.4"
    LOADBALANCER_IP = ENV["LOADBALANCER_IP"] || "192.168.56.4"
    MACHINE1_IP = ENV["MACHINE1_IP"] || "192.168.56.43"
    MACHINE1_MAC = (ENV["MACHINE1_MAC"] || "08:00:27:9E:F5:3A").downcase
    USE_POSTGRES = ENV["USE_POSTGRES"] || ""
    USE_HELM = ENV["USE_HELM"] || ""
    HELM_CHART_VERSION = ENV["HELM_CHART_VERSION"] || "0.1.2"
    HELM_LOADBALANCER_INTERFACE = ENV["HELM_LOADBALANCER_INTERFACE"] || "eth1"
    STACK_OPT = "compose/"
    STACK_BASE_DIR = "../../stack/"
    STACK_DIR = STACK_BASE_DIR + STACK_OPT
    DEST_DIR_BASE = "/sandbox/stack/"
    DEST_DIR = DEST_DIR_BASE + STACK_OPT

Ok so Provisioner and Loadbalancer are the same IP and are the IP of virtual box that is running the K3d stack which will
host Tinkerbell. 

    local tinkerbell2=192.168.0.46 
    local host_ip=$tinkerbell2
	local worker_ip=$2
	local worker_mac=$3
	local manifests_dir=$4 # Totally Not clear what this is.  
	local loadbalancer_ip=$tinkerbell2
	local helm_chart_version=0.2.0
	local loadbalancer_interface="enp0s3"  # See below
	local namespace="tink-system" # Hardcoded in Run_helm

So things to work out.  

##### Load balancer interface

In the scripts they used `eth1` but for ours .  I sshed to `tinkerbell2` and did 

    $ ip addr
    ....
    2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
        link/ether 08:00:27:94:d0:5b brd ff:ff:ff:ff:ff:ff
        inet 192.168.0.46/24 brd 192.168.0.255 scope global dynamic noprefixroute enp0s3
           valid_lft 3246sec preferred_lft 3246sec
        inet6 fe80::44b9:44eb:d0d8:d9ef/64 scope link noprefixroute 
           valid_lft forever preferred_lft forever

So `enp0s3`

##### Helm Chart Version

The Helm charts that matter are not even in Sandbox.  they are in.  https://github.com/tinkerbell/charts  I forget
why I know this.. but yeah. 

So in helm the Chart version is in the `tinkerbell/stack/Chart.yaml` and the value is `0.2.0`

This standard location is described here. https://helm.sh/docs/topics/charts/

##### Manifests Dir

Well from the vagrant call we get `/sandbox/stack/compose` but I don't think that is where we are going. 

We need to look for how it is used. 

##### Worker IP and Mac

This is the machine that we want to load.. lets seen where this takes us. 


### Customize Helm Values

    tinkerbell2=192.168.0.46
    loadbalancer_ip=$tinkerbell2
	helm_chart_version=0.2.0
	helm inspect values oci://ghcr.io/tinkerbell/charts/stack --version "$helm_chart_version" >/tmp/stack-values.yaml
	sed -i "s/192.168.2.111/${loadbalancer_ip}/g" /tmp/stack-values.yaml

Oh there is a reason we care about the `charts` repo and not the `sandbox` repo.

### Helm Install Tink Stack

	helm_chart_version=0.2.0
	loadbalancer_interface="enp0s3" 
	namespace="tink-system"
    trusted_proxies=$(kubectl get nodes -o jsonpath='{.items[*].spec.podCIDR}' | tr ' ' ',')

The get nodes -o jsonpath is described https://kubernetes.io/docs/reference/kubectl/jsonpath/
to get a sense of what it is working against do `kubectl get nodes -o json`  jsonpath lets you 
filter down to some part of a json doc.   Basically.  The trusted proxy is k3d. 

    helm install stack-release oci://ghcr.io/tinkerbell/charts/stack --version "$helm_chart_version" --create-namespace --namespace "$namespace" --wait --set "boots.boots.trustedProxies=${trusted_proxies}" --set "hegel.hegel.trustedProxies=${trusted_proxies}" --set "kubevip.interface=$loadbalancer_interface" --values /tmp/stack-values.yaml

So this fails.. and its because of a recent improvement where you don't have to double the name.   

    https://github.com/tinkerbell/charts/commit/99682947f6eb251e7daa2552d652a6d08c4108b6

gah so the final correct run.. 

    helm install stack-release oci://ghcr.io/tinkerbell/charts/stack --version 0.2.0 --create-namespace --namespace tink-system --wait --set boots.trustedProxies=10.42.0.0/24 --set hegel.trustedProxies=10.42.0.0/24 --set kubevip.interface=enp0s3 --values /tmp/stack-values.yaml

At this point you have a running Tinkerbell stack.  But even if it was the right thing..  My MacPro went to sleep 
and when I woke it.. I got.. 

    Error: INSTALLATION FAILED: timed out waiting for the condition

Rerunning.. get me. 

    Error: INSTALLATION FAILED: cannot re-use a name that is still in use

So I guess we need to be able to use the tink system to see whats going on.. and shutting it down.


## Using the Tink Stack

### Seeing The Tink Stack

Showing all the pods regardless of namespace

    ubuntu@tinkerbell2:~$ kubectl get pod -A
    NAMESPACE     NAME                                      READY   STATUS    RESTARTS       AGE
    kube-system   coredns-b96499967-89lmf                   1/1     Running   3 (153m ago)   18d
    kube-system   local-path-provisioner-7b7dc8d6f5-c5sps   1/1     Running   4 (152m ago)   18d
    kube-system   metrics-server-668d979685-9gsm4           1/1     Running   5 (152m ago)   18d
    tink-system   hegel-58b567d49d-44hls                    1/1     Running   0              23m
    tink-system   kube-vip-9m2ts                            1/1     Running   0              23m
    tink-system   boots-76b4d758c4-s5dfv                    1/1     Running   0              23m
    tink-system   tink-controller-6b7d78d5d4-qp7bd          1/1     Running   0              23m
    tink-system   tink-server-6444c7d846-zlcv5              1/1     Running   0              23m
    tink-system   tink-stack-c7c964666-sxh6j                1/1     Running   0              23m
    tink-system   rufio-798b6689b4-l4m74                    1/1     Running   0              23m

showing all namespaces

    ubuntu@tinkerbell2:~$ kubectl get namespace -A
    NAME              STATUS   AGE
    default           Active   18d
    kube-system       Active   18d
    kube-public       Active   18d
    kube-node-lease   Active   18d
    tink-system       Active   25m

getting the namespace

    ubuntu@tinkerbell2:~$ kubectl get namespace tink-system
    NAME          STATUS   AGE
    tink-system   Active   62s


getting the pods in the namespace

    ubuntu@tinkerbell2:~$ kubectl get pods -n  tink-system
    NAME                               READY   STATUS    RESTARTS   AGE
    tink-controller-6b7d78d5d4-dbrfh   1/1     Running   0          8m9s
    boots-76b4d758c4-vr2vz             1/1     Running   0          8m9s
    kube-vip-rvqp2                     1/1     Running   0          8m9s
    rufio-798b6689b4-mmn7f             1/1     Running   0          8m9s
    tink-stack-c7c964666-x8v2l         1/1     Running   0          8m9s
    hegel-58b567d49d-cvrtn             1/1     Running   0          8m9s
    tink-server-6444c7d846-79fjl       1/1     Running   0          8m9s



### Shutting It Down

ubuntu@tinkerbell2:~$ kubectl delete namespace tink-system
namespace "tink-system" deleted

ubuntu@tinkerbell2:~$ 
ubuntu@tinkerbell2:~$ kubectl get namespace tink-system
Error from server (NotFound): namespaces "tink-system" not found

### Bringing it Back Up

    tinkerbell2=192.168.0.46
    loadbalancer_ip=$tinkerbell2
    helm_chart_version=0.2.0
    loadbalancer_interface="enp0s3" 
    namespace="tink-system"
    helm inspect values oci://ghcr.io/tinkerbell/charts/stack --version "$helm_chart_version" >/tmp/stack-values.yaml
    sed -i "s/192.168.2.111/${loadbalancer_ip}/g" /tmp/stack-values.yaml
    trusted_proxies=$(kubectl get nodes -o jsonpath='{.items[*].spec.podCIDR}' | tr ' ' ',') 
    helm install stack-release oci://ghcr.io/tinkerbell/charts/stack --version $helm_chart_version \
        --create-namespace --namespace $namespace --wait \
        --set boots.trustedProxies=$trusted_proxies \
        --set hegel.trustedProxies=$trusted_proxies \
        --set kubevip.interface=$loadbalancer_interface \
        --values /tmp/stack-values.yaml

Eventually with this output.

    WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/ubuntu/.kube/config
    WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/ubuntu/.kube/config
    NAME: stack-release
    LAST DEPLOYED: Sat Jan 21 22:59:51 2023
    NAMESPACE: tink-system
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    ubuntu@tinkerbell2:~$ 

### Upload Manifests.

Note that this is pulled out of setup.sh but it is missing and export. 

    export TINKERBELL_CLIENT_GW=192.168.0.1

This ends up not being a problem for fake installs... but caused trouble when I did it. 

    apply_manifests() {
        local worker_ip=$1
        local worker_mac=$2
        local manifests_dir=$3
        local host_ip=$4
        local namespace=$5
        local gateway_ip=$6
    
        disk_device="/dev/sda"
        if lsblk | grep -q vda; then
            disk_device="/dev/vda"
        fi
        export DISK_DEVICE="$disk_device"
        export TINKERBELL_CLIENT_IP="$worker_ip"
        export TINKERBELL_CLIENT_MAC="$worker_mac"
        export TINKERBELL_HOST_IP="$host_ip"
        export TINKERBELL_CLIENT_GW="$gateway_ip
    
        for i in "$manifests_dir"/{hardware.yaml,template.yaml,workflow.yaml}; do
            envsubst <"$i"
            echo -e '---'
        done >/tmp/manifests.yaml
        kubectl apply -n "$namespace" -f /tmp/manifests.yaml
        kubectl apply -n "$namespace" -f "$manifests_dir"/ubuntu-download.yaml
    }