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
wget -q -O ${uuid}.zip $download_url
    if ! gnome-extensions list | grep --quiet ${uuid}; then
    echo $USER
    busctl --machine=$USER@.host --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${uuid}
fi
gnome-extensions enable ${uuid}
rm ${uuid}.zip
