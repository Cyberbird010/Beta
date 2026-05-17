#!/bin/bash
# COSC-3411 - Beta Team Automation Script

PORT=8080
LOG_FILE="../utils/activity.log"

echo "=================================================="
echo "          BETA TEAM SIMULATION RUNNER             "
echo "=================================================="

# 1. Automatic dependency check
if ! command -v python3 &> /dev/null; then
    echo "[-] Error: Python3 is not installed. Exiting."
    exit 1
fi

# 2. Automatically prepare log files
mkdir -p ../utils
touch "$LOG_FILE"

# 3. Automatically discover local IP to build the attack link
echo "[+] Generating simulation link..."
LOCAL_IP=$(hostname -I | awk '{print $1}')
echo "--------------------------------------------------"
echo "    SEND THIS LINK TO VICTIM:"
echo "    http://$LOCAL_IP:$PORT"
echo "--------------------------------------------------"

# 4. Launch web server and log incoming connections
echo "[+] Starting local deployment server on port $PORT..."
echo "[+] Monitoring incoming traffic. Press [CTRL+C] to stop."
echo "--------------------------------------------------"

cd templates || exit
python3 -m http.server "$PORT" 2>&1 | tee -a "$LOG_FILE"
