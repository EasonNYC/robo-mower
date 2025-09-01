# Inherit extrausers to enable EXTRA_USERS_PARAMS
inherit extrausers

#add to image
IMAGE_INSTALL:append = " sudo base-passwd"

# Robomower user configuration
EXTRA_USERS_PARAMS = " groupadd -f sudo; \
                       useradd -m -p '\$6\$EOJ17ZXS3dZFIOz5\$GxANI8rK64Au6q4bIuQU0KsIwh8z2LKAF8EhRdx8RHU6zGboD2cm5ias13xdQAmMBobAA9PZmH58kA2BUnp1i/' robomower; \
                       usermod -a -G sudo robomower;"

#create and add to sudoers file
ROOTFS_POSTPROCESS_COMMAND += "setup_sudo_config; setup_custom_banner; "

setup_sudo_config() {
    install -d ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d
    echo "%sudo ALL=(ALL) ALL" > ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/01-sudo
    chmod 440 ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/01-sudo
}

setup_custom_banner() {
    echo "RoboMower Linux (Built: $(date +%Y-%m-%d_%H:%M))" > ${IMAGE_ROOTFS}${sysconfdir}/issue
    echo "" >> ${IMAGE_ROOTFS}${sysconfdir}/issue
}