#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <device> (e.g., /dev/sdb)"
    echo "Available devices:"
    lsblk | grep -E "sd[a-z]"
    exit 1
fi

DEVICE=$1
IMAGE_PATH="build/tmp/deploy/images/beaglebone-yocto/core-image-minimal-beaglebone-yocto.mender"

if [ ! -f "$IMAGE_PATH" ]; then
    echo "Error: Image not found at $IMAGE_PATH"
    echo "Build the image first with: ./scripts/build.sh"
    exit 1
fi

echo "WARNING: This will erase all data on $DEVICE"
read -p "Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

echo "Flashing image to $DEVICE..."
sudo dd if="$IMAGE_PATH" of="$DEVICE" bs=1M status=progress
sync

echo "Flashing complete!"
