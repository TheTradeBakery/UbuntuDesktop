sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
wget https://raw.githubusercontent.com/TheTradeBakery/UbuntuDesktop/main/ubuntu_setup.yaml
ansible-playbook --ask-become-pass ubuntu_setup.yaml
rm ubuntu_setup.yaml