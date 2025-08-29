#!/bin/bash
set -e

echo "Setting up BeagleBone ROS2 Yocto build environment..."

# Load secrets if available
if [ -f "secrets.env" ]; then
    source secrets.env
    echo "Loaded secrets from secrets.env"
else
    echo "WARNING: secrets.env not found. Create it with your Mender token."
fi

# Check if running from correct directory
if [ ! -f "setup.sh" ]; then
    echo "Error: Run this script from the project root directory"
    exit 1
fi

# Clone required repositories
echo "Cloning Yocto layers..."
git clone -b kirkstone git://git.yoctoproject.org/poky.git || echo "poky already exists"
git clone -b kirkstone https://git.yoctoproject.org/meta-ti || echo "meta-ti already exists"
git clone -b kirkstone https://github.com/mendersoftware/meta-mender.git || echo "meta-mender already exists"
git clone -b kirkstone https://github.com/ros/meta-ros.git || echo "meta-ros already exists"
git clone -b kirkstone https://git.openembedded.org/meta-openembedded || echo "meta-openembedded already exists"

# Copy configuration templates
echo "Setting up configuration files..."
mkdir -p build/conf
cp conf/local.conf.template build/conf/local.conf
cp conf/bblayers.conf.template build/conf/bblayers.conf

# Replace placeholders in bblayers.conf
PROJECT_ROOT=$(pwd)
sed -i "s|##OEROOT##|${PROJECT_ROOT}/poky|g" build/conf/bblayers.conf
sed -i "s|##BUILDDIR##|${PROJECT_ROOT}/build|g" build/conf/bblayers.conf

# Initialize build environment
echo "Initializing build environment..."
cd poky
source oe-init-build-env ../build


echo "Setup complete!"
echo "1. Edit secrets.env with Mender tenant token"
echo "2. Run: source secrets.env && source poky/oe-init-build-env build"
echo "3. Run: bitbake core-image-minimal"
