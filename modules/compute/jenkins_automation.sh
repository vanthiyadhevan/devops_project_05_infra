#!/bin/bash

set -e

# Update the Repodsitory
sudo apt-get update -y

# install javajdk-17 for run the jenkins application
sudo apt install openjdk-21-jdk -y
sudo apt install unzip -y


# install maven and unzip

# set -euo pipefail

# ==============================
# Configurable variables
# ==============================
MAVEN_VERSION=3.8.9
MAVEN_TAR="apache-maven-${MAVEN_VERSION}-bin.tar.gz"
MAVEN_URL="https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_TAR}"
MAVEN_INSTALL_DIR="/opt/maven"
PROFILE_SCRIPT="/etc/profile.d/maven.sh"

# ==============================
# Step 1: Download Maven tarball
# ==============================
cd /home/ubuntu
if [ ! -f "$MAVEN_TAR" ]; then
    echo "[INFO] Downloading Maven $MAVEN_VERSION..." 
    wget -q "$MAVEN_URL"
else
    echo "[INFO] Tarball already exists: $MAVEN_TAR" 
fi

# ==============================
# Step 2: Extract Maven
# ==============================
if [ -d "apache-maven-${MAVEN_VERSION}" ]; then
    echo "[INFO] Directory apache-maven-${MAVEN_VERSION} already extracted" 
else
    echo "[INFO] Extracting $MAVEN_TAR..." 
    tar -xvzf "$MAVEN_TAR"
fi

# ==============================
# Step 3: Install to /opt/maven
# ==============================
sudo mkdir -p "$MAVEN_INSTALL_DIR"
sudo cp -r "apache-maven-${MAVEN_VERSION}/"* "$MAVEN_INSTALL_DIR"

# ==============================
# Step 4: Create profile script
# ==============================
if [ ! -f "$PROFILE_SCRIPT" ]; then
    echo "[INFO] Creating $PROFILE_SCRIPT" 
    sudo tee "$PROFILE_SCRIPT" > /dev/null <<EOF
export M2_HOME=$MAVEN_INSTALL_DIR
export PATH=\$M2_HOME/bin:\$PATH
EOF
    sudo chmod 644 "$PROFILE_SCRIPT"
else
    echo "[INFO] $PROFILE_SCRIPT already exists. Skipping." 
fi

# ==============================
# Step 5: Cleanup (with checks)
# ==============================
if [ -d "/home/ubuntu/apache-maven-${MAVEN_VERSION}" ]; then
    echo "[INFO] Removing extracted directory..." 
    rm -rf "/home/ubuntu/apache-maven-${MAVEN_VERSION}"
fi

if [ -f "/home/ubuntu/${MAVEN_TAR}" ]; then
    echo "[INFO] Removing tarball..." 
    rm -f "/home/ubuntu/${MAVEN_TAR}"
fi

# ==============================
# Step 6: Validate installation
# ==============================
# echo "[INFO] Reloading profile..."
# shellcheck disable=SC1090
source "$PROFILE_SCRIPT"
# echo "[INFO] Maven version check:"
mvn -version > /dev/null


sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install jenkins -y

sudo systemctl enable jenkins 
sudo systemctl start jenkins

sudo apt-get install git -y

