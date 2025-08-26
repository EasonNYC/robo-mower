#!/bin/bash
set -e

echo "Starting Yocto build..."

# Check if build environment is set up
if [ ! -d "build" ]; then
    echo "Error: Build environment not initialized. Run ./setup.sh first"
    exit 1
fi

# Source build environment
cd poky
source oe-init-build-env ../build

# Start build
echo "Building core-image-minimal..."
bitbake core-image-minimal

echo "Build complete! Images available in tmp/deploy/images/beaglebone-yocto/"
