#!/bin/bash

# Colors for thematic appearance
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function display_banner() {
  clear
  echo -e "${GREEN}==========================================="
  echo -e "       Arch Linux User Management Tool"
  echo -e "===========================================${NC}"
}

function create_user() {
  read -p "Enter the noble username to be summoned: " username
  sudo useradd -m $username
  echo -e "${BLUE}User ${username} hath been summoned forth.${NC}"
  read -p "Press [Enter] to continue..."
}

function delete_user() {
  read -p "Enter the username to be vanquished: " username
  sudo userdel -r $username
  echo -e "${BLUE}User ${username} hath been vanquished.${NC}"
  read -p "Press [Enter] to continue..."
}

function modify_user() {
  read -p "Enter the username to be transformed: " username
  read -p "Enter the new shell of enlightenment (e.g., /bin/bash): " shell
  sudo usermod -s $shell $username
  echo -e "${BLUE}User ${username} hath been transformed.${NC}"
  read -p "Press [Enter] to continue..."
}

function list_users() {
  echo -e "${BLUE}Behold, the list of noble users:${NC}"
  awk -F':' '{ print $1}' /etc/passwd
  read -p "Press [Enter] to continue..."
}

function exit_program() {
  echo -e "${GREEN}Farewell, dear friend. Until we meet again...${NC}"
  exit 0
}

while true; do
  display_banner
  echo "1. Summon a User"
  echo "2. Vanquish a User"
  echo "3. Transform a User's Shell"
  echo "4. Behold the List of Users"
  echo "5. Farewell"
  read -p "Choose thy destiny (1-5): " choice

  case $choice in
    1) create_user ;;
    2) delete_user ;;
    3) modify_user ;;
    4) list_users ;;
    5) exit_program ;;
    *) echo -e "${BLUE}A mysterious choice, my friend. Pray, try again.${NC}" ;;
  esac
done
