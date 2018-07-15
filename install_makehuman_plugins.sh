#!/bin/bash

makehumanPluginPath="/usr/share/makehuman/plugins"

get_zip() {
	WRITEFOLDER=`mktemp -d`
	TMPFILE=`mktemp`
	wget -q "$1" -O "$TMPFILE"
	# unzip -l "$TMPFILE"
	unzip -o -q -d "$WRITEFOLDER" "$TMPFILE" "$2/*"
	rsync -a --delete "$WRITEFOLDER/$2" "$3"
	rm "$TMPFILE"
	rm -R "$WRITEFOLDER"
}

################################################################
# These go into the "plugins" directory under MakeHuman
#

# Core dependency for most community plugins
get_zip https://github.com/makehumancommunity/community-plugins-mhapi/archive/master.zip "community-plugins-mhapi-master/1_mhapi" "$makehumanPluginPath"

# Adds functionality for downloading assets (such as clothes) from within MakeHuman
get_zip https://github.com/makehumancommunity/community-plugins-assetdownload/archive/master.zip "community-plugins-assetdownload-master/8_asset_downloader" "$makehumanPluginPath"

# Enables communication with MakeHuman from the outside (for example from Blender)
get_zip https://github.com/makehumancommunity/community-plugins-socket/archive/master.zip "community-plugins-socket-master/8_server_socket" "$makehumanPluginPath"


# Interchange format for Blender/MakeHuman (makehuman side)
get_zip https://bitbucket.org/Diffeomorphic/mhx2-makehuman-exchange/get/48e3d46d488e.zip "Diffeomorphic-mhx2-makehuman-exchange-48e3d46d488e/9_export_mhx2" "$makehumanPluginPath"


################################################################
# These are installed in Blender
#

# Interchange format for Blender/MakeHuman (makehuman side)
get_zip https://bitbucket.org/Diffeomorphic/mhx2-makehuman-exchange/get/48e3d46d488e.zip "Diffeomorphic-mhx2-makehuman-exchange-48e3d46d488e/import_runtime_mhx2" "$HOME/.config/blender/2.79/scripts/addons"

# Synchronize mesh and pose online from makehuman without the need to re-export
get_zip https://github.com/makehumancommunity/community-plugins/raw/master/blender_distribution/MH_Community.zip "MH_Community" "$HOME/.config/blender/2.79/scripts/addons"

