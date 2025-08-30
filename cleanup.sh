#!/bin/bash

echo "Cleaning up Yocto build environment..."

# Check if running from correct directory
if [ ! -f "setup.sh" ]; then
    echo "Error: Run this script from the project root directory"
    exit 1
fi

# Prompt for confirmation
read -p "This will remove all build directories and cloned repositories. Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleanup cancelled."
    exit 0
fi

# Remove build directory
if [ -d "build" ]; then
    echo "Removing build directory..."
    rm -rf build
fi

# Remove cloned repositories
echo "Removing cloned repositories..."
for repo in poky meta-arm meta-ti meta-mender meta-ros meta-openembedded; do
    if [ -d "$repo" ]; then
        echo "  Removing $repo..."
        rm -rf "$repo"
    fi
done

# Remove any BitBake cache and sstate directories that might exist
if [ -d "sstate-cache" ]; then
    echo "Removing sstate-cache..."
    rm -rf sstate-cache
fi

if [ -d "downloads" ]; then
    echo "Removing downloads..."
    rm -rf downloads
fi

echo "Cleanup complete! You can now run setup.sh again."
