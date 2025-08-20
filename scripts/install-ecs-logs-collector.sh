#!/usr/bin/env bash
set -exo pipefail

# ECS Logs Collector Installation Script
# Installs the AWS ECS logs collector from the git submodule
# Uses the pinned version from the submodule

# Configuration
readonly INSTALLATION_DIR="/opt/amazon/ecs"
readonly VERSION_FILE="ECS_LOG_COLLECTOR_VERSION"
readonly SCRIPT_FILE="ecs-logs-collector.sh"
readonly SUBMODULE_DIR="amazon-ecs-logs-collector"

# Create directory for optional shell scripts
sudo mkdir -p ${INSTALLATION_DIR}

# Set appropriate file permissions
sudo chmod 755 ${INSTALLATION_DIR}

# Get the current commit hash from the submodule
COMMIT_HASH=$(git -C ${SUBMODULE_DIR} rev-parse HEAD)

# Copy ecs-logs-collector.sh from submodule
echo "Installing ${SCRIPT_FILE} from submodule at commit: ${COMMIT_HASH}"
sudo cp ${SUBMODULE_DIR}/${SCRIPT_FILE} ${INSTALLATION_DIR}/${SCRIPT_FILE}

# Add execute permissions
sudo chmod +x ${INSTALLATION_DIR}/${SCRIPT_FILE}

# Write commit hash to version file
echo ${COMMIT_HASH} | sudo tee ${INSTALLATION_DIR}/${VERSION_FILE}

# Set appropriate file permissions
sudo chmod 644 ${INSTALLATION_DIR}/${VERSION_FILE}
