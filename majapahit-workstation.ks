#  ╔╦╗╔═╗ ╦╔═╗╔═╗╔═╗╦ ╦╦╔╦╗
#  ║║║╠═╣ ║╠═╣╠═╝╠═╣╠═╣║ ║
#  ╩ ╩╩ ╩╚╝╩ ╩╩  ╩ ╩╩ ╩╩ ╩

# versi 1 : workstation
# size original : 7787 + 500

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
part / --size 8287 --fstype ext4
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

### PACKAGE LIVE BASE ###

    @base-x
    @guest-desktop-agents
    @core
    @fonts
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

### MAJAPAHIT WORKSTATION COMMON ###

# Make sure to sync any additions / removals done here with
# workstation-product-environment in comps
    @firefox
    @gnome-desktop
    @guest-desktop-agents
    @hardware-support
    @libreoffice
    @networkmanager-submodules
    @workstation-product

# Exclude unwanted packages from @anaconda-tools group
    -gfs2-utils
    -reiserfs-utils

### VERSION 1 COMMON USER ###

# REBRANDING

    -fedora-logos
    -fedora-release
    -fedora-release-workstation
    -fedora-release-notes
    
    generic-logos
    generic-release
    generic-release-workstation
    generic-release-notes

    -plymouth-theme-charge
    -plymouth-system-theme

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

    # video download
    youtube-dl

    # Provides backup application
    deja-dup
    deja-dup-nautilus
    
    # Add extra gnome applications
    gnome-calendar
    gnome-todo
    gnome-nettool
    gnome-tweaks
    gnome-boxes
    gnome-shell-extension-pomodoro
    gnome-shell-extension-suspend-button
    gnome-shell-extension-disconnect-wifi
    gnome-shell-extension-background-logo
    
    # tweak
    dconf-editor
    
    # Add cosmetic for gnome-terminal
    powerline
    powerline-fonts
    tmux-powerline
    vim-powerline
    
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
    
    # breeze theme
    breeze-cursor-theme
    breeze-icon-theme
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
    gtkhash-nautilus
    raw-thumbnailer
    
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

    # fonts from fedora designer
    aajohan-comfortaa-fonts
    julietaula-montserrat-fonts
    lato-fonts
    open-sans-fonts
    overpass-fonts

    # reduce font
    -lohit*
    -google-noto-sans-sinhala-fonts
    -google-noto-fonts-common
    -google-noto-cjk-fonts-common
    -google-noto-sans-cjk-ttc-fonts
    -google-noto-serif-cjk-ttc-fonts
    -paktype-naskh-basic-fonts
    -khmeros-base-fonts
    -smc-meera-fonts
    -thai-scalable-waree-fonts
    -jomolhari-fonts

    # fonts (we make no bones about admitting we're english-only)
    wqy-microhei-fonts              # a compact CJK font, to replace:
    -naver-nanum-gothic-fonts       # Korean
    -vlgothic-fonts                 # Japanese
    -adobe-source-han-sans-cn-fonts # simplified Chinese
    -adobe-source-han-sans-tw-fonts # traditional Chinese
    -paratype-pt-sans-fonts         # Cyrillic (already supported by DejaVu), huge
    #-stix-fonts                    # mathematical symbols

# PRODUCTIVITY

    # browser
    firefox
    -fedora-bookmarks
    
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
    
    # bootable
    gnome-multi-writer
    
    # cli editor
    vim
    
    # hugo
    hugo

# UI/UX

    # inkscape plugin
    inkscape
    inkscape-psd
    inkscape-sozi
    inkscape-table
    
    # gimp plugin
    gimp
    gimpfx-foundry
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
    gmic-gimp

%end

%post

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
cat > /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=liveuser
FOE

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

# remove fedora-welcome
rm -fr  /usr/share/anaconda/gnome/fedora*

%end

%post --nochroot

cp -fr  recipes/anaconda-core/* \
        $INSTALL_ROOT/

cp -fr  recipes/fedora-bookmarks/* \
        $INSTALL_ROOT/

cp -fr  recipes/firefox/* \
        $INSTALL_ROOT/

cp -fr  recipes/generic-logos/* \
        $INSTALL_ROOT/

cp -fr  recipes/generic-release/* \
        $INSTALL_ROOT/

cp -fr  recipes/icons/* \
        $INSTALL_ROOT/

cp -fr  recipes/plymouth/* \
        $INSTALL_ROOT/

cp -fr  recipes/skel-default/* \
        $INSTALL_ROOT/

cp -fr  recipes/skel-default-root/root/ \
        $INSTALL_ROOT/

cp -fr  recipes/majapahit-homepage/* \
        $INSTALL_ROOT/

cp -fr  recipes/m29-backgrounds-base/* \
        $INSTALL_ROOT/

cp -fr  recipes/m29-backgrounds-gnome/* \
        $INSTALL_ROOT/

cp -fr  recipes/majapahit-gscheme/* \
        $INSTALL_ROOT/

cp -fr  recipes/majapahit-workstation-backgrounds/* \
        $INSTALL_ROOT/

cp -fr  recipes/thememode/* \
        $INSTALL_ROOT/

# only works on x86, x86_64
if [ "$(uname -i)" = "i386" -o "$(uname -i)" = "x86_64" ]; then
  if [ ! -d $LIVE_ROOT/LiveOS ]; then mkdir -p $LIVE_ROOT/LiveOS ; fi
  cp /usr/bin/livecd-iso-to-disk $LIVE_ROOT/LiveOS
fi

%end

%post

# add favourite menus for "WORKSTATION"
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]

favorite-apps=['firefox.desktop', 'nautilus.desktop', 'org.gnome.Evolution.desktop', 'rhythmbox.desktop', 'org.gnome.Software.desktop', 'anaconda.desktop']

FOE

# rebuild schema 
glib-compile-schemas /usr/share/glib-2.0/schemas

%end
