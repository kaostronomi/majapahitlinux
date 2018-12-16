#  ╔╦╗╔═╗ ╦╔═╗╔═╗╔═╗╦ ╦╦╔╦╗  ╔═╗╔═╗
#  ║║║║ ║ ║║ ║╠═╝╠═╣╠═╣║ ║───║ ║╚═╗
#  ╩ ╩╚═╝╚╝╚═╝╩  ╩ ╩╩ ╩╩ ╩   ╚═╝╚═╝

# versi 1 : standard
# size original : 7498 + 500

lang en_US.UTF-8
keyboard us
#timezone US/Eastern
timezone Asia/Jakarta
auth --useshadow --passalgo=sha512
selinux --enforcing
firewall --enabled --service=mdns
xconfig --startxonboot
zerombr
clearpart --all
part / --size 7998 --fstype ext4
services --enabled=NetworkManager,ModemManager --disabled=sshd
network --bootproto=dhcp --device=link --activate
rootpw --lock --iscrypted locked
shutdown

# repo fedora
repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch
#repo --name=updates-testing --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-f$releasever&arch=$basearch
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch

# repo rpm-fusion
repo --name=rpmfusion-free --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-$releasever&arch=$basearch
repo --name=rpmfusion-non-free --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch
repo --name=rpmfusion-free-updates --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-$releasever&arch=$basearch
repo --name=rpmfusion-non-free-updates --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-$releasever&arch=$basearch

%packages

#########################
### PACKAGE LIVE BASE ###
#########################

    @base-x
    @guest-desktop-agents
    @standard
    @core
    @fonts
    @input-methods
    @dial-up
    @multimedia
    @hardware-support
    @printing

# Explicitly specified here:
# <notting> walters: because otherwise dependency loops cause yum issues.
    kernel
    kernel-modules
    kernel-modules-extra

# This was added a while ago, I think it falls into the category of
# "Diagnosis/recovery tool useful from a Live OS image".  Leaving this untouched
# for now.
    memtest86+

# The point of a live image is to install
    anaconda
    anaconda-install-env-deps
    @anaconda-tools

# Need aajohan-comfortaa-fonts for the SVG rnotes images
    aajohan-comfortaa-fonts

# Without this, initramfs generation during live image creation fails: #1242586
    dracut-live
    syslinux

# anaconda needs the locales available to run for different locales
    glibc-all-langpacks

####################################
### MAJAPAHIT WORKSTATION COMMON ###
####################################

# Exclude unwanted groups that fedora-live-base.ks pulls in
#-@dial-up
#-@input-methods
#-@standard

# Make sure to sync any additions / removals done here with
# workstation-product-environment in comps
    #@firefox
    @gnome-desktop
    @libreoffice
    @networkmanager-submodules
    @workstation-product

# Exclude unwanted packages from @anaconda-tools group
    -gfs2-utils
    -reiserfs-utils

#############################
### VERSION 1 COMMON USER ###
#############################

# REBRANDING

	-fedora-logos
	-fedora-release
	-fedora-release-workstation
	-fedora-release-notes

	generic-logos
	generic-release
	generic-release-workstation
	generic-release-notes

# BACKGROUNDS

    -f29-backgrounds-gnome
    -f29-backgrounds-base
    -desktop-backgrounds-gnome
    -fedora-workstation-backgrounds
    -gnome-backgrounds

# BASIC
    # rpmfusion
    rpmfusion-free-release
    rpmfusion-nonfree-release

	# detect hardware
	inxi

	# Provides backup application
	deja-dup
	deja-dup-nautilus

	# Add extra gnome applications
	gnome-calendar
    gnome-todo
	-gnome-nettool
    gnome-tweaks
    -gnome-boxes
	gnome-shell-extension-pomodoro
    gnome-shell-extension-suspend-button
    gnome-shell-extension-disconnect-wifi
 	gnome-shell-extension-background-logo

	# tweak
	dconf-editor

	## Add cosmetic for gnome-terminal
	#powerline
	#powerline-fonts
	#tmux-powerline
	#vim-powerline

	# image viewer
	eog

	# printer
	epson-inkjet-printer-escpr
	gutenprint-cups
	stylus-toolbox
	iscan-firmware
	lsb

	# thumbnail
	gnome-directory-thumbnailer

	# android
	gvfs-mtp
	android-tools

	# encrypt
	blivet-gui
	gnupg
	seahorse
	seahorse-sharing

	# theme for libre office
	breeze-gtk

	# compress
	lzma
    lha
    arj
	unarj
	unace
	dpkg
	p7zip
	p7zip-plugins
	bzip2-devel
	unrar
	bzip2-libs.i686
	file-roller

	# nautilus extention
	nautilus-search-tool
	nautilus-image-converter
	file-roller-nautilus
	brasero-nautilus
	seahorse-nautilus
	deja-dup-nautilus
	raw-thumbnailer
    gnome-terminal-nautilus

	# codec
	ffmpeg
	gstreamer-plugins-base
	gstreamer-plugins-bad
	gstreamer-plugins-ugly
	gstreamer-plugins-good-extras
	gstreamer-plugins-bad-extras
	gstreamer-plugins-bad-nonfree
	gstreamer-ffmpeg
	gstreamer1-libav
	gstreamer1-plugins-base 
	gstreamer1-plugins-ugly
	gstreamer1-plugins-good
	gstreamer1-plugins-good-extras
	gstreamer1-plugins-bad-free
	gstreamer1-plugins-bad-nonfree
	gstreamer1-plugins-bad-freeworld
	gstreamer1-plugin-mpg123

# PRODUCTIVITY

	# browser
    # epiphany to firefox
	epiphany

	# office
	libreoffice
	libreoffice-langpack-en
	libreoffice-help-en

    # rss
    feedreader

	#torrent
	transmission-gtk

	#parted
	gparted

	#disc burner
	brasero

	# music
	rhythmbox

	# chat & call
	empathy

	# irc
	polari

	# text editor
	gedit

	# git
	git
	git-crypt

	# session
	tmux
    	
    # video editor
    pitivi

	# remote desktop
	vinagre
	vino

# UI/UX

	# inkscape plugin
	inkscape
	inkscape-psd
	inkscape-sozi
	inkscape-table
	
	# gimp plugin
	gimp
	gimp-paint-studio
	gimp-dds-plugin 
	gimp-fourier-plugin 
	gimp-gap
	gimp-high-pass-filter
	gimp-layer-via-copy-cut
	gimp-lensfun
	gimp-lqr-plugin
	gimp-normalmap
	gimp-paint-studio
	gimp-resynthesizer
	gimp-save-for-web
	gimp-separate+
	gimp-wavelet-decompose
	gimpfx-foundry
	gmic-gimp

%end

%post

echo "######################################";
echo "#######     READY FOR POST    ########";
echo "######################################";

cat >> /etc/rc.d/init.d/livesys << EOF
#!/bin/bash
#
# live: Init script for live image
#
# chkconfig: 345 00 99
# description: Init script for live image.
### BEGIN INIT INFO
# X-Start-Before: display-manager chronyd
### END INIT INFO

. /etc/init.d/functions

if ! strstr "\`cat /proc/cmdline\`" rd.live.image || [ "\$1" != "start" ]; then
    exit 0
fi

if [ -e /.liveimg-configured ] ; then
    configdone=1
fi

exists() {
    which \$1 >/dev/null 2>&1 || return
    \$*
}

livedir="LiveOS"
for arg in \`cat /proc/cmdline\` ; do
  if [ "\${arg##rd.live.dir=}" != "\${arg}" ]; then
    livedir=\${arg##rd.live.dir=}
    continue
  fi
  if [ "\${arg##live_dir=}" != "\${arg}" ]; then
    livedir=\${arg##live_dir=}
  fi
done

# enable swaps unless requested otherwise
swaps=\`blkid -t TYPE=swap -o device\`
if ! strstr "\`cat /proc/cmdline\`" noswap && [ -n "\$swaps" ] ; then
  for s in \$swaps ; do
    action "Enabling swap partition \$s" swapon \$s
  done
fi
if ! strstr "\`cat /proc/cmdline\`" noswap && [ -f /run/initramfs/live/\${livedir}/swap.img ] ; then
  action "Enabling swap file" swapon /run/initramfs/live/\${livedir}/swap.img
fi

mountPersistentHome() {
  # support label/uuid
  if [ "\${homedev##LABEL=}" != "\${homedev}" -o "\${homedev##UUID=}" != "\${homedev}" ]; then
    homedev=\`/sbin/blkid -o device -t "\$homedev"\`
  fi

  # if we're given a file rather than a blockdev, loopback it
  if [ "\${homedev##mtd}" != "\${homedev}" ]; then
    # mtd devs don't have a block device but get magic-mounted with -t jffs2
    mountopts="-t jffs2"
  elif [ ! -b "\$homedev" ]; then
    loopdev=\`losetup -f\`
    if [ "\${homedev##/run/initramfs/live}" != "\${homedev}" ]; then
      action "Remounting live store r/w" mount -o remount,rw /run/initramfs/live
    fi
    losetup \$loopdev \$homedev
    homedev=\$loopdev
  fi

  # if it's encrypted, we need to unlock it
  if [ "\$(/sbin/blkid -s TYPE -o value \$homedev 2>/dev/null)" = "crypto_LUKS" ]; then
    echo
    echo "Setting up encrypted /home device"
    plymouth ask-for-password --command="cryptsetup luksOpen \$homedev EncHome"
    homedev=/dev/mapper/EncHome
  fi

  # and finally do the mount
  mount \$mountopts \$homedev /home
  # if we have /home under what's passed for persistent home, then
  # we should make that the real /home.  useful for mtd device on olpc
  if [ -d /home/home ]; then mount --bind /home/home /home ; fi
  [ -x /sbin/restorecon ] && /sbin/restorecon /home
  if [ -d /home/liveuser ]; then USERADDARGS="-M" ; fi
}

findPersistentHome() {
  for arg in \`cat /proc/cmdline\` ; do
    if [ "\${arg##persistenthome=}" != "\${arg}" ]; then
      homedev=\${arg##persistenthome=}
    fi
  done
}

if strstr "\`cat /proc/cmdline\`" persistenthome= ; then
  findPersistentHome
elif [ -e /run/initramfs/live/\${livedir}/home.img ]; then
  homedev=/run/initramfs/live/\${livedir}/home.img
fi

# if we have a persistent /home, then we want to go ahead and mount it
if ! strstr "\`cat /proc/cmdline\`" nopersistenthome && [ -n "\$homedev" ] ; then
  action "Mounting persistent /home" mountPersistentHome
fi

if [ -n "\$configdone" ]; then
  exit 0
fi

# add liveuser user with no passwd
action "Adding live user" useradd \$USERADDARGS -c "Live System User" liveuser
passwd -d liveuser > /dev/null
usermod -aG wheel liveuser > /dev/null

# Remove root password lock
passwd -d root > /dev/null

# turn off firstboot for livecd boots
systemctl --no-reload disable firstboot-text.service 2> /dev/null || :
systemctl --no-reload disable firstboot-graphical.service 2> /dev/null || :
systemctl stop firstboot-text.service 2> /dev/null || :
systemctl stop firstboot-graphical.service 2> /dev/null || :

# don't use prelink on a running live image
sed -i 's/PRELINKING=yes/PRELINKING=no/' /etc/sysconfig/prelink &>/dev/null || :

# turn off mdmonitor by default
systemctl --no-reload disable mdmonitor.service 2> /dev/null || :
systemctl --no-reload disable mdmonitor-takeover.service 2> /dev/null || :
systemctl stop mdmonitor.service 2> /dev/null || :
systemctl stop mdmonitor-takeover.service 2> /dev/null || :

# don't enable the gnome-settings-daemon packagekit plugin
gsettings set org.gnome.software download-updates 'false' || :

# don't start cron/at as they tend to spawn things which are
# disk intensive that are painful on a live image
systemctl --no-reload disable crond.service 2> /dev/null || :
systemctl --no-reload disable atd.service 2> /dev/null || :
systemctl stop crond.service 2> /dev/null || :
systemctl stop atd.service 2> /dev/null || :

# turn off abrtd on a live image
systemctl --no-reload disable abrtd.service 2> /dev/null || :
systemctl stop abrtd.service 2> /dev/null || :

# Don't sync the system clock when running live (RHBZ #1018162)
sed -i 's/rtcsync//' /etc/chrony.conf

# Mark things as configured
touch /.liveimg-configured

# add static hostname to work around xauth bug
# https://bugzilla.redhat.com/show_bug.cgi?id=679486
# the hostname must be something else than 'localhost'
# https://bugzilla.redhat.com/show_bug.cgi?id=1370222
echo "localhost-live" > /etc/hostname

# disable gnome-software automatically downloading updates
cat >> /usr/share/glib-2.0/schemas/org.gnome.software.gschema.override << FOE
[org.gnome.software]
download-updates=false
FOE

# don't autostart gnome-software session service
rm -f /etc/xdg/autostart/gnome-software-service.desktop

# disable the gnome-software shell search provider
cat >> /usr/share/gnome-shell/search-providers/org.gnome.Software-search-provider.ini << FOE
DefaultDisabled=true
FOE

# don't run gnome-initial-setup
mkdir ~liveuser/.config
touch ~liveuser/.config/gnome-initial-setup-done

# suppress anaconda spokes redundant with gnome-initial-setup
cat >> /etc/sysconfig/anaconda << FOE
[NetworkSpoke]
visited=1

[PasswordSpoke]
visited=1

[UserSpoke]
visited=1
FOE

# make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop ""
  # need to move it to anaconda.desktop to make shell happy
  mv /usr/share/applications/liveinst.desktop /usr/share/applications/anaconda.desktop

  # Make the welcome screen show up
  if [ -f /usr/share/anaconda/gnome/majapahit-welcome.desktop ]; then
    mkdir -p ~liveuser/.config/autostart
    cp /usr/share/anaconda/gnome/majapahit-welcome.desktop /usr/share/applications/
    cp /usr/share/anaconda/gnome/majapahit-welcome.desktop ~liveuser/.config/autostart/
  fi

  # Copy Anaconda branding in place
  if [ -d /usr/share/lorax/product/usr/share/anaconda ]; then
    cp -a /usr/share/lorax/product/* /
  fi
fi

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# set up auto-login
#cat > /etc/gdm/custom.conf << FOE
#[daemon]
#AutomaticLoginEnable=True
#AutomaticLogin=liveuser
#FOE

# Turn off PackageKit-command-not-found while uninstalled
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF
# live end : /etc/rc.d/init.d/livesys

# bah, hal starts way too late
cat > /etc/rc.d/init.d/livesys-late << EOF
#!/bin/bash
#
# live: Late init script for live image
#
# chkconfig: 345 99 01
# description: Late init script for live image.

. /etc/init.d/functions

if ! strstr "\`cat /proc/cmdline\`" rd.live.image || [ "\$1" != "start" ] || [ -e /.liveimg-late-configured ] ; then
    exit 0
fi

exists() {
    which \$1 >/dev/null 2>&1 || return
    \$*
}

touch /.liveimg-late-configured

# read some variables out of /proc/cmdline
for o in \`cat /proc/cmdline\` ; do
    case \$o in
    ks=*)
        ks="--kickstart=\${o#ks=}"
        ;;
    xdriver=*)
        xdriver="\${o#xdriver=}"
        ;;
    esac
done

# if liveinst or textinst is given, start anaconda
if strstr "\`cat /proc/cmdline\`" liveinst ; then
   plymouth --quit
   /usr/sbin/liveinst \$ks
fi
if strstr "\`cat /proc/cmdline\`" textinst ; then
   plymouth --quit
   /usr/sbin/liveinst --text \$ks
fi

# configure X, allowing user to override xdriver
if [ -n "\$xdriver" ]; then
   cat > /etc/X11/xorg.conf.d/00-xdriver.conf <<FOE
Section "Device"
	Identifier	"Videocard0"
	Driver	"\$xdriver"
EndSection
FOE
fi

EOF

chmod 755 /etc/rc.d/init.d/livesys
/sbin/restorecon /etc/rc.d/init.d/livesys
/sbin/chkconfig --add livesys

chmod 755 /etc/rc.d/init.d/livesys-late
/sbin/restorecon /etc/rc.d/init.d/livesys-late
/sbin/chkconfig --add livesys-late

# enable tmpfs for /tmp
systemctl enable tmp.mount

# make it so that we don't do writing to the overlay for things which
# are just tmpdirs/caches
# note https://bugzilla.redhat.com/show_bug.cgi?id=1135475
cat >> /etc/fstab << EOF
vartmp   /var/tmp    tmpfs   defaults   0  0
EOF

# work around for poor key import UI in PackageKit
rm -f /var/lib/rpm/__db*
releasever=$(rpm -q --qf '%{version}\n' --whatprovides system-release)
basearch=$(uname -i)
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
echo "Packages within this LiveCD"
rpm -qa
# Note that running rpm recreates the rpm db files which aren't needed or wanted
rm -f /var/lib/rpm/__db*

# go ahead and pre-make the man -k cache (#455968)
/usr/bin/mandb

# make sure there aren't core files lying around
rm -f /core*

# remove random seed, the newly installed instance should make it's own
rm -f /var/lib/systemd/random-seed

# convince readahead not to collect
# FIXME: for systemd

echo 'File created by kickstart. See systemd-update-done.service(8).' \
    | tee /etc/.updated >/var/.updated

# Drop the rescue kernel and initramfs, we don't need them on the live media itself.
# See bug 1317709
rm -f /boot/*-rescue*

# Disable network service here, as doing it in the services line
# fails due to RHBZ #1369794
/sbin/chkconfig network off

# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id

# set generic logo to majapahit os
sed -i -e 's/Generic/Majapahit OS/g' /etc/fedora-release /etc/issue /etc/issue.net
sed -i -e 's/Fedora/Majapahit OS/g' /etc/fedora-release /etc/issue /etc/issue.net

cat >/etc/os-release << EOF
NAME=Majapahit
VERSION="29 (Twenty Nine)"
ID="majapahit"
VERSION_ID=29
PRETTY_NAME="Majapahit 29 (Twenty Nine)"
ANSI_COLOR="0;34"
CPE_NAME="cpe:/o:majapahitlinux:majapahit:1"
HOME_URL="https://www.majapahitlinux.org/"
SUPPORT_URL="https://www.majapahitlinux.org/support/"
BUG_REPORT_URL="https://bug.majapahitlinux.org/"
REDHAT_BUGZILLA_PRODUCT="Majapahit"
REDHAT_BUGZILLA_PRODUCT_VERSION=29
REDHAT_SUPPORT_PRODUCT="Majapahit"
REDHAT_SUPPORT_PRODUCT_VERSION=29
PRIVACY_POLICY_URL="https://www.majapahitlinux.org/privacy/"
EOF

# Add link to majapahit linux
cat >> /usr/share/applications/majapahit.desktop << FOE
[Desktop Entry]
Name=Majapahit Homepage
GenericName=Majapahit Homepage
Comment=Reference of Majapahit
Exec=xdg-open https://www.majapahitlinux.org/
Type=Application
Icon=fedora-logo-icon
Categories=Network;GNOME;GTK;WebBrowser;
FOE
chmod a+x /usr/share/applications/majapahit.desktop

# GNOME Setting
rm /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['org.gnome.Epiphany.desktop', 'nautilus.desktop', 'org.gnome.Evolution.desktop', 'rhythmbox.desktop', 'org.gnome.Terminal.desktop', 'inkscape.desktop', 'gimp.desktop', 'libreoffice-writer.desktop', 'anaconda.desktop']
enabled-extensions=['background-logo@fedorahosted.org', 'suspend-button@laserb', 'alternate-tab@gnome-shell-extensions.gcampax.github.com', 'disconnect-wifi@kgshank.net', 'user-theme@gnome-shell-extensions.gcampax.github.com']

[org.gnome.desktop.interface]
gtk-theme='Adwaita-dark'
icon-theme='Adwaita'
cursor-theme='Adwaita'
monospace-font-name='Monospace 10'
font-name='Cantarell 10'
document-font-name='Sans 10'
clock-show-date=true
clock-show-seconds=true
show-battery-percentage=true

[org.gnome.shell.extensions.user-theme]
name=''

[org.gnome.desktop.background]
picture-uri='file:///usr/share/backgrounds/arjuna/default/arjuna.xml'

[org.gnome.desktop.screensaver]
picture-uri='file:///usr/share/backgrounds/arjuna/default/arjuna.xml'

[org.gnome.nautilus.icon-view]
default-zoom-level='standard'

[org.gtk.Settings.FileChooser]
sort-directories-first=true

[org.gnome.desktop.peripherals.touchpad]
natural-scroll=true
two-finger-scrolling-enabled=true
tap-to-click=true

[org.gnome.desktop.wm.preferences]
button-layout='appmenu:minimize,maximize,close'
titlebar-font='Cantarell Bold 10'

[org.gnome.desktop.media-handling]
autorun-never=true

[org.gnome.settings-daemon.plugins.color]
night-light-enabled=true

[org.gnome.builder.editor]
style-scheme-name='builder-dark'

[org.gnome.rhythmbox]
show-album-art=false

[org.gnome.settings-daemon.plugins.media-keys]
home='<Super>e'
www='<Super>w'

[org.fedorahosted.background-logo-extension]
logo-always-visible=true
logo-size=12
logo-border=16
logo-position='bottom-center'
logo-file='/usr/share/majapahit-logos/majapahit_lightbackground.svg'


[org.gnome.shell.extensions.suspend-button]
suspend-default=true

[org.gnome.gedit.preferences.editor]
display-line-numbers=true
display-overview-map=true
insert-spaces=true
scheme='builder-dark'

[org.gnome.Epiphany]
enable-smooth-scrolling=true

[org.gnome.Epiphany.ui]
tabs-bar-visibility-policy='always'

[org.gnome.Epiphany.state]
is-maximized=true

[org.gnome.Epiphany.sync]
sync-history-enabled=true
sync-passwords-enabled=true

[org.gnome.desktop.datetime]
automatic-timezone=true

FOE

rm /usr/share/glib-2.0/schemas/org.gnome.login-screen.gschema.override
cat >> /usr/share/glib-2.0/schemas/org.gnome.login-screen.gschema.override << FOE

[org.gnome.login-screen]
logo='/usr/share/majapahit-logos/majapahit-gdm-logo.svg'
enable-smartcard-authentication=false

FOE

# rebuild scheme

# ETC/SKEL

# .bashrc
cat >> /etc/skel/.bashrc << FOE

#youtube-dl
alias yt="youtube-dl -if webm+bestaudio"
#youtube-dl playlist
alias ytp="youtube-dl -Atif webm+bestaudio"
#youtube-dl music only
alias ytm="youtube-dl -if bestaudio"

# dnf update
alias da="sudo dnf update"
# dnf install
alias di="sudo dnf install"
# dnf remove
alias dr="sudo dnf remove"
# dnf info
alias dif="sudo dnf info"
# dnf autoremove
alias dx="sudo dnf autoremove"
# dnf search
alias ds="sudo dnf search"

FOE

# .bash_profile
cat >> /etc/skel/.bash_profile << FOE
# Tmux
if [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

FOE

# .tmux.conf
cat >> /etc/skel/.tmux.conf << FOE

# Reloaded
bind r source-file ~/.tmux.conf \; display "Reloaded config"

# Split
bind V split-window -h
bind H split-window

FOE

# .config/mimeapps.list
mkdir /etc/skel/.config/
cat >> /etc/skel/.config/mimeapps.list << FOE
[Default Applications]
x-scheme-handler/mailto=org.gnome.Evolution.desktop
text/plain=org.gnome.gedit.desktop
text/html=org.gnome.Epiphany.desktop
application/xml=org.gnome.gedit.desktop

[Added Associations]
x-scheme-handler/mailto=org.gnome.Evolution.desktop;
text/plain=org.gnome.gedit.desktop;
application/octet-stream=org.gnome.gedit.desktop
text/html=org.gnome.Epiphany.desktop;org.gnome.gedit.desktop
application/x-java-keystore=org.gnome.gedit.desktop
application/xml=org.gnome.gedit.desktop

FOE

# vim
mkdir /etc/skel/.vim
mkdir /etc/skel/.vim/undo
mkdir /etc/skel/.vim/backup
mkdir /etc/skel/.vim/plugged
mkdir /etc/skel/.vim/autoload

cat >> /etc/skel/.vimrc << FOE
filetype plugin indent on
syntax on
set nocompatible
set hidden
set number
set background=dark
set cursorline
set history=1000
set undolevels=1000
set title
set showmode
set showcmd
set mouse=a
set relativenumber
set path+=**
set wildmenu
set ttimeoutlen=50
set textwidth=0
set colorcolumn=
set backspace=indent,eol,start
set autoread
set ignorecase
set laststatus=2
set statusline=%f
set statusline+=%y
set noerrorbells
set nowrap
set expandtab
set smarttab
set autoindent
set smartindent
set sw=4 sts=4 ts=4 "shiftwidth softtabstop tabstop
set t_Co=256
hi  clear ModeMsg " disable color statusline on insert mode and visual mode

let mapleader=","

" move the window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" navigation (insert mode)
inoremap <A-h> <Esc>i
inoremap <A-j> <Esc>ja
inoremap <A-k> <Esc>ka
inoremap <A-l> <Esc>la

" move the window (insert mode)
inoremap <C-h> <Esc><C-w>ha
inoremap <C-j> <Esc><C-w>ja
inoremap <C-k> <Esc><C-w>ka
inoremap <C-l> <Esc><C-w>la

" quick restart vimrc
nnoremap <silent> <leader>r :source $MYVIMRC<CR>

" open vimrc
nnoremap <silent> <leader>ev :e ~/.vimrc<CR>

" backup 
set noswapfile
set backup
set backupdir=~/.vim/backup,~/.backup,~/backup,/var/backup,/backup
set backupskip=/backup/*,/private/backup/*
set directory=~/.vim/backup,~/.backup,~/backup,/var/backup,/backup
set writebackup

" split window
" horizontal split
nnoremap <silent> <leader>- :sp <CR>
" vertical split
nnoremap <silent> <leader>\ :vsp <CR><C-w>l<CR>

" turn on persistent undo
if has('persistent_undo')
    set undodir=~/.vim/undo//
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

FOE

# copy skel to root
cp -fr /etc/skel/* /root

# copy skel to root (hidden files)
cp -fr /etc/skel/.[^.]* /root

# plymouthd
sed -i 's/^Theme=.*/Theme=majapahit/' /usr/share/plymouth/plymouthd.defaults /etc/plymouth/plymouthd.conf

# firefox seting, if install
mkdir -p /usr/lib64/firefox/browser/defaults/preferences/
rm /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js
cat >> /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js << FOE
pref("app.update.auto",                     false);
pref("app.update.enabled",                  false);
pref("app.update.autoInstallEnabled",       false);
pref("general.smoothScroll",                true);
pref("intl.locale.matchOS",                 true);
pref("intl.locale.requested",               "");
pref("toolkit.storage.synchronous",         0);
pref("toolkit.networkmanager.disable",      false);
pref("offline.autoDetect",                  true);
pref("browser.backspace_action",            2);
pref("browser.display.use_system_colors",   true);
pref("browser.download.folderList",         1);
pref("browser.link.open_external",          3);
pref("browser.shell.checkDefaultBrowser",   false);
pref("network.manage-offline-status",       true);
pref("extensions.shownSelectionUI",         true);
pref("ui.SpellCheckerUnderlineStyle",       1);
pref("startup.homepage_override_url",       "");
/* pref("browser.startup.homepage",            "data:text/plain,browser.startup.homepage=http://start.fedoraproject.org/"); */
/* pref("browser.newtabpage.pinned",           '[{"url":"http://start.fedoraproject.org/","title":"Fedora Project - Start Page"}]'); */
pref("geo.wifi.uri", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
pref("media.gmp-gmpopenh264.provider.enabled",false);
pref("media.gmp-gmpopenh264.autoupdate",false);
pref("media.gmp-gmpopenh264.enabled",false);
pref("media.gmp-gmpopenh264.enabled",false);
pref("plugins.notifyMissingFlash", false);
/* See https://bugzilla.redhat.com/show_bug.cgi?id=1226489 */
pref("browser.display.use_system_colors", false);
pref("layers.use-image-offscreen-surfaces", false);
/* Allow sending credetials to all https:// sites */
pref("network.negotiate-auth.trusted-uris", "https://");
pref("spellchecker.dictionary_path","/usr/share/myspell");
pref("browser.uiCustomization.state",'{"placements":{"widget-overflow-fixed-list":[],"PersonalToolbar":["personal-bookmarks"],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","sidebar-button","disable-html5-autoplay_afnankhan-browser-action","savepage-we_dw-dev-browser-action","ublock0_raymondhill_net-browser-action","_7b1bf0b6-a1b9-42b0-b75d-252036438bdc_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"]},"seen":["disable-html5-autoplay_afnankhan-browser-action","savepage-we_dw-dev-browser-action","ublock0_raymondhill_net-browser-action","_7b1bf0b6-a1b9-42b0-b75d-252036438bdc_-browser-action","developer-button"],"dirtyAreaCache":["PersonalToolbar","nav-bar","toolbar-menubar","TabsToolbar"],"currentVersion":14,"newElementCount":2}');
pref("extensions.webextensions.uuids",'{"formautofill@mozilla.org":"a2e3d4dc-b2f2-4ef2-a3f0-6f8abeebf566","webcompat@mozilla.org":"7f5fbf14-c714-4480-8b8e-b23518572ae3","screenshots@mozilla.org":"5e62461f-01c5-45c1-b2fb-6d08aacc629e","{7b1bf0b6-a1b9-42b0-b75d-252036438bdc}":"77468003-f5ee-4ba6-b61f-b3c4eed3676b","disable-html5-autoplay@afnankhan":"f4d170fd-4d88-4865-9d79-c4f0296d1608","savepage-we@DW-dev":"a049a530-2b55-4e56-924c-19ba00420ad4","uBlock0@raymondhill.net":"d1830386-9c95-407a-b1e9-079db35c7da0"}');
pref("distribution.fedora.bookmarksProcessed","false");
FOE

# darkmode
cat >> /usr/bin/darkmode << FOE
#!/bin/bash

gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.builder night-mode 'true'
gsettings set org.gnome.builder.editor style-scheme-name 'builder-dark'
gsettings set org.gnome.gedit.preferences.editor scheme 'builder-dark'
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'
FOE

chmod +x /usr/bin/darkmode

# lightmode
cat >> /usr/bin/lightmode << FOE
#!/bin/bash

gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
gsettings set org.gnome.builder night-mode 'false'
gsettings set org.gnome.builder.editor style-scheme-name 'builder'
gsettings set org.gnome.gedit.preferences.editor scheme 'classic'
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'light'
FOE

chmod +x /usr/bin/lightmode

%end

%post --nochroot
# --nochroot is copy from local

echo "###############################################";
echo "#######     READY FOR POST NOCHROOT    ########";
echo "###############################################";

# majapahit-linux welcome
cp -fr recipes/anaconda/gnome/ $INSTALL_ROOT/usr/share/anaconda/

# plymouth theme
cp -fr recipes/plymouth/ $INSTALL_ROOT/usr/share/

# change artwork anaconda installer
cp -fr recipes/anaconda/pixmaps/ $INSTALL_ROOT/usr/share/anaconda/

# adding icons
cp -fr recipes/icons/ $INSTALL_ROOT/usr/share/

# properties for background
cp -fr recipes/gnome-background-properties $INSTALL_ROOT/usr/share/

# add majapahit background
cp -fr recipes/backgrounds/ $INSTALL_ROOT/usr/share/

# add majapahit background logo
cp -fr recipes/majapahit-logos $INSTALL_ROOT/usr/share/

# add license background
cp -fr recipes/licenses/ $INSTALL_ROOT/usr/share/

# adding majapahit-help
cp -fr recipes/doc/ $INSTALL_ROOT/usr/share/

# and remove fedora-release doc
rm -fr $INSTALL_ROOT/usr/share/doc/fedora-release-notes/

# and remove shortcut fedora-release doc
rm -fr $INSTALL_ROOT/usr/share/applications/fedora-release-notes.desktop
rm -fr $INSTALL_ROOT/usr/share/applications/fedora-release-notes.webapp.desktop

%end

%post

# rebuild schema 
glib-compile-schemas /usr/share/glib-2.0/schemas

%end
