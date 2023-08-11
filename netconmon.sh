#!/bin/bash

# Thematic color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function display_banner() {
  clear
  echo -e "${GREEN}==========================================="
  echo -e "       Network Examination Tool"
  echo -e "===========================================${NC}"
}

function display_connections() {
  echo -e "${RED}Displaying TCP and UDP connections...${NC}"
  ss -tuln
  read -p "Press [Enter] to continue..."
}

function monitor_network() {
  echo -e "${RED}Monitoring network traffic with iftop...${NC}"
  sudo iftop
  read -p "Press [Enter] to continue..."
}

function check_firewall_status() {
  echo -e "${RED}Checking firewall status with UFW...${NC}"
  sudo ufw status
  read -p "Press [Enter] to continue..."
}

function analyze_packets() {
  echo -e "${RED}Analyzing packets with Wireshark...${NC}"
  sudo wireshark
}

function network_statistics() {
  echo -e "${RED}Displaying network statistics with netstat...${NC}"
  netstat -s
  read -p "Press [Enter] to continue..."
}

function list_network_interfaces() {
  echo -e "${RED}Listing all network interfaces...${NC}"
  ip link show
  read -p "Press [Enter] to continue..."
}

function exit_program() {
  echo -e "${GREEN}Exiting...${NC}"
  exit 0
}

while true; do
  display_banner
  echo "1. Display Current Connections (TCP/UDP)"
  echo "2. Monitor Network Traffic (requires iftop)"
  echo "3. Check Firewall Status (requires UFW)"
  echo "4. Analyze Packets with Wireshark (requires Wireshark)"
  echo "5. View Network Statistics (netstat)"
  echo "6. List Network Interfaces"
  echo "7. Exit"
  read -p "Choose an option (1-7): " choice

  case $choice in
    1) display_connections ;;
    2) monitor_network ;;
    3) check_firewall_status ;;
    4) analyze_packets ;;
    5) network_statistics ;;
    6) list_network_interfaces ;;
    7) exit_program ;;
    *) echo -e "${RED}Invalid choice, please try again.${NC}" ;;
  esac
done
