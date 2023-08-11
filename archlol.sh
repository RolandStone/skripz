#!/bin/bash

# Thematic color codes
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function display_banner() {
  clear
  echo -e "${GREEN}==========================================="
  echo -e "       Exploration of Arch Linux"
  echo -e "===========================================${NC}"
}

function explore_pacman() {
  echo -e "${YELLOW}Behold the power of Pacman, Arch Linux's package manager!${NC}"
  echo -e "${YELLOW}Let's search for a package. Type the name or part of it:${NC}"
  read -p "Package to search for: " package
  pacman -Ss $package
  read -p "Press [Enter] to continue..."
}

function install_package() {
  echo -e "${YELLOW}Installation made easy! Let's install a package using Pacman:${NC}"
  read -p "Package to install: " package
  sudo pacman -S $package
}

function system_update() {
  echo -e "${YELLOW}Keeping Arch fresh and updated with a single command!${NC}"
  sudo pacman -Syu
}

function view_system_info() {
  echo -e "${YELLOW}Arch Linux's flexibility allows you to tailor the system to your needs. Let's view the system info:${NC}"
  uname -a
  read -p "Press [Enter] to continue..."
}

function exit_program() {
  echo -e "${GREEN}Farewell, fellow Arch enthusiast! Until next time...${NC}"
  exit 0
}

while true; do
  display_banner
  echo "1. Explore Pacman (Search Packages)"
  echo "2. Install a Package with Pacman"
  echo "3. Update the System"
  echo "4. View System Information"
  echo "5. Farewell"
  read -p "Choose your adventure (1-5): " choice

  case $choice in
    1) explore_pacman ;;
    2) install_package ;;
    3) system_update ;;
    4) view_system_info ;;
    5) exit_program ;;
    *) echo -e "${YELLOW}An unexpected path! Let's try again, shall we?${NC}" ;;
  esac
done
