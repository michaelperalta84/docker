#!/bin/bash

set -e

echo "🟡 Paso 1: Actualizando el sistema..."
sudo apt update && sudo apt -y full-upgrade

# Reinicia si es necesario
if [ -f /var/run/reboot-required ]; then
  echo "🔁 Requiere reinicio. Reiniciando..."
  sudo reboot -f
fi

echo "🟡 Paso 2: Instalando herramientas base..."
sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update

echo "🟢 Instalando kubeadm, kubelet y kubectl..."
sudo apt -y install kubelet kubeadm kubectl containerd
sudo apt-mark hold kubelet kubeadm kubectl containerd

echo "📌 Versiones instaladas:"
kubectl version --client
kubeadm version

echo "🛑 Paso 4: Desactivando SWAP..."
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

echo "🛠️ Paso 5: Habilitando módulos del kernel..."
sudo modprobe overlay
sudo modprobe br_netfilter

echo "🔧 Paso 6: Agregando configuración sysctl..."
sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

echo "🧩 Paso 7: Configurando carga persistente de módulos..."
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF


echo "⚙️ Paso 9: Configurando containerd..."
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml > /dev/null

# Activar Systemd como cgroup driver
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl status containerd --no-pager

echo "📥 Paso 10: Pre-cargando imágenes de Kubernetes..."
sudo kubeadm config images pull

echo "🛠️ Paso 11: Configurando DNS local (opcional)..."
echo "127.0.0.1 localhost" | sudo tee -a /etc/hosts
echo "$(hostname -I | awk '{print $1}') k8scp" | sudo tee -a /etc/hosts

echo "🚀 Paso 12: Inicializando el clúster..."
sudo kubeadm init \
  --pod-network-cidr=172.24.0.0/16 \
  --cri-socket=unix:///run/containerd/containerd.sock \
  --upload-certs \
  --control-plane-endpoint=k8scp

echo "🛠️ Paso 13: Configurando kubectl para el usuario actual..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "📡 Paso 14: Verificando clúster..."
export KUBECONFIG=$HOME/.kube/config
kubectl cluster-info

echo "✅ Kubernetes y containerd están completamente instalados y configurados."


kubeadm join k8scp:6443 --token fmtqtw.kidvr4auo9r3ea0x \
        --discovery-token-ca-cert-hash sha256:e5a18e6430e3c60be5c4b4eeb514649e11243b74fba936a335b28b452f29903d


openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'


kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl get pods --all-namespaces