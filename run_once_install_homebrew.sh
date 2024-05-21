#!/bin/sh

# Function to check if Homebrew is installed
check_homebrew() {
  if command -v brew &> /dev/null; then
    echo "Homebrew is already installed"
    return 0
  else
    return 1
  fi
}

# Function to install Homebrew
install_homebrew() {
  echo "Downloading and installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Main script
if check_homebrew; then
  echo "Skipping Homebrew installation"
else
  install_homebrew
fi