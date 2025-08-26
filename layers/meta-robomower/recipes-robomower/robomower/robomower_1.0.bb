DESCRIPTION = "Robotic lawn mower control system"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS = "ros-humble-rclcpp ros-humble-std-msgs ros-humble-geometry-msgs"
RDEPENDS_${PN} = "ros-humble-rclcpp ros-humble-std-msgs"

SRC_URI = "file://robomower-control.cpp \
           file://robomower-node \
           file://robomower.service"

S = "${WORKDIR}"

inherit systemd

SYSTEMD_SERVICE_${PN} = "robomower.service"

do_install() {
    # Install ROS2 nodes
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/robomower-node ${D}${bindir}
    
    # Install systemd service
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/robomower.service ${D}${systemd_unitdir}/system
}

FILES_${PN} += "${systemd_unitdir}/system/robomower.service"
