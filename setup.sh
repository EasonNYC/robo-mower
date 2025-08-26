#!/bin/bash
set -e

echo "Setting up BeagleBone ROS2 Yocto build environment..."

# Check if running from correct directory
if [ ! -f "setup.sh" ]; then
    echo "Error: Run this script from the project root directory"
    exit 1
fi

# Clone required repositories
echo "Cloning Yocto layers..."
git clone -b kirkstone git://git.yoctoproject.org/poky.git || echo "poky already exists"
git clone -b kirkstone https://github.com/beagleboard/meta-beagleboard.git || echo "meta-beagleboard already exists"
git clone -b kirkstone https://github.com/mendersoftware/meta-mender.git || echo "meta-mender already exists"
git clone -b kirkstone https://github.com/ros/meta-ros.git || echo "meta-ros already exists"
git clone -b kirkstone https://git.openembedded.org/meta-openembedded || echo "meta-openembedded already exists"

# Initialize build environment
echo "Initializing build environment..."
cd poky
source oe-init-build-env ../build

# Copy configuration templates
echo "Setting up configuration files..."
if [ ! -f ../build/conf/local.conf ]; then
    cp ../conf/local.conf.template ../build/conf/local.conf
    echo "Created local.conf from template."
fi

if [ ! -f ../build/conf/bblayers.conf ]; then
    cp ../conf/bblayers.conf.template ../build/conf/bblayers.conf
    # Replace placeholders
    sed -i "s|##OEROOT##|$(pwd)|g" ../build/conf/bblayers.conf
    sed -i "s|##BUILDDIR##|$(pwd)/../build|g" ../build/conf/bblayers.conf
fi

echo "Setup complete!"
echo "todo:"
echo "1. Edit build/conf/local.conf with Mender tenant token"
echo "2. Run: source poky/oe-init-build-env build"
echo "3. Run: bitbake core-image-minimal"
