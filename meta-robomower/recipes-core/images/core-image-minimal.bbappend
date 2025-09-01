# Inherit extrausers to enable EXTRA_USERS_PARAMS
inherit extrausers

#add to image
IMAGE_INSTALL:append = " sudo"

# Robomower user configuration
EXTRA_USERS_PARAMS = " useradd -m -p '\$1\$vy7886eb\$KVWoTYB1CRumveRAjfAny.' robomower; \
                       usermod -a -G sudo robomower;"

#create and add to sudoers file
ROOTFS_POSTPROCESS_COMMAND += "setup_sudo_config; "

setup_sudo_config() {
    install -d ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d
    echo "%sudo ALL=(ALL) ALL" > ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/01-sudo
    chmod 440 ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/01-sudo
}