FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://ros2-setup.sh"

do_install:append() {
    # Add ROS2 environment setup to /etc/profile.d
    install -d ${D}${sysconfdir}/profile.d
    install -m 0644 ${WORKDIR}/ros2-setup.sh ${D}${sysconfdir}/profile.d/
}