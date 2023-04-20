sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
ansible-galaxy install jaredhocutt.gnome_extensions
wget https://raw.githubusercontent.com/TheTradeBakery/UbuntuDesktop/e0eede59e9dadff7b031df2a91a8632ca74f3262/ubuntu_setup.yaml
ansible-playbook --ask-become-pass ubuntu_setup.yaml
rm ubuntu_setup.yaml