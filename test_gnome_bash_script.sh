#!/bin/bash
id=$1
gnome_version=$(gnome-shell --version | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')
url="https://extensions.gnome.org/extension-info/?pk=${id}&shell_version=${gnome_version}"
extension_info=$(curl $url -s)
download_url_extension=$(echo $extension_info | grep -o -P '(?<="download_url": ").*(?="})')
uuid=$(echo $extension_info | grep -o -P '(?<="uuid": ").*(?=", "name")')
pretty_name=$(echo $extension_info | grep -o -P '(?<="name": ").*(?=", "creator")')
download_url="https://extensions.gnome.org${download_url_extension}"
echo $pretty_name 
if ! ls ~/.local/share/gnome-shell/extensions/ | grep --quiet ${uuid}; then
    wget -q -O ${uuid}.zip $download_url
    localuser=$(eval getent passwd {$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)..$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)} | cut -d: -f1)
    busctl --user --machine=$localuser@.host call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${uuid}
    # gnome-extensions enable ${uuid} # will not work as root therefore commented out
    rm ${uuid}.zip
fi

