#!/bin/bash
echo "This Script will work only on Ubuntu 18.04 Bionic Beaver LTS"
read -p "Do you want to proceed? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Breaking the script"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
echo "Proceding to install Kubernetes..."
echo "..................................."
echo "..................................."
echo "..................................."
echo "Installing Docker..."
echo "..................................."
echo "..................................."
echo "..................................."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce=18.06.1~ce~3-0~ubuntu
sudo apt-mark hold docker-ce
echo "veryifing instalation"
echo "..................................."
echo "..................................."
echo "..................................."
ps -ef | grep docker | grep -v grep
[ $?  -eq "0" ] && echo "Docker process is running" || echo "Docker process is not running"
echo "..................................."
echo "..................................."
echo "..................................."
echo "Install Kubeadm, Kubelet, and Kubectl"
echo "..................................."
echo "..................................."
echo "..................................."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update -y
sudo apt-get install -y kubelet=1.12.7-00 kubeadm=1.12.7-00 kubectl=1.12.7-00
sudo apt-mark hold kubelet kubeadm kubectl
echo "..................................."
echo "..................................."
echo "..................................."
read -p "Is this a Kube master Node? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Master "
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl version
