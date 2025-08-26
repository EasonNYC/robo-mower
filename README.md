# BeagleBone Black ROS2 Yocto Project

Base Yocto Linux distribution for BeagleBone Black with ROS2 Humble and Mender OTA update capability.

## Features

- **BeagleBone Black** optimized base yocto build
- **ROS2 Humble** integration
- **Mender OTA** for updates
- **Robomower custom bblayer** for Easons robot lawnmower application


## Quick Start

### Prerequisites
- Ubuntu 20.04/22.04 LTS host system
- 60GB+ free disk space
- 8GB+ RAM
- BeagleBone Black with 8GB+ microSD card (16GB+ preffered)

### Setup
```bash
git clone https://github.com/EasonNYC/todo.git
cd beaglebone-ros2-yocto
./setup.sh
```

## Project Structure
├── README.md
├── setup.sh                    # Automated setup
├── conf/                       # Configuration templates
├── scripts/                    # Build and utility scripts
├── layers/meta-robomower/      # Custom robomower recipes
├── docs/                       # Additional documentation
└── build/                      # Build directory (created by setup)

