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

# Function to check if Git is installed
check_git() {
  if command -v git &> /dev/null; then
    echo "Git is already installed"
    return 0
  else
    return 1
  fi
}

# Function to install Git
install_git() {
  echo "Installing Git..."
  brew install git
}

# Function to check if Ansible is installed
check_ansible() {
  if command -v ansible &> /dev/null; then
    echo "Ansible is already installed"
    return 0
  else
    return 1
  fi
}

# Function to install Ansible
install_ansible() {
  echo "Installing Ansible..."
  brew install ansible
}

# Function to clone GitHub repository
clone_repo() {
  local repo_url="$1"
  local dest_dir="$2"

  if [ -d "$dest_dir" ]; then
    echo "Directory $dest_dir already exists. Pulling latest changes..."
    git -C "$dest_dir" pull
  else
    echo "Cloning repository from $repo_url to $dest_dir..."
    git clone "$repo_url" "$dest_dir"
  fi
}

# Function to run Ansible playbook
run_ansible_playbook() {
  local playbook_path="$1"

  echo "Running Ansible playbook $playbook_path..."
  ansible-playbook "$playbook_path" -K
}

# Main script
if [ "$(uname)" = "Darwin" ]; then
  echo "Detected macOS (Darwin)"

  if check_homebrew; then
    echo "Skipping Homebrew installation"
  else
    install_homebrew
  fi

  if check_git; then
    echo "Skipping Git installation"
  else
    install_git
  fi

  if check_ansible; then
    echo "Skipping Ansible installation"
  else
    install_ansible
  fi

elif [ "$(uname)" = "Linux" ]; then
  echo "Detected Linux"
  
  # Add Linux specific installation commands here
  echo "Linux specific installation not implemented"

else
  echo "Unsupported operating system"
  exit 1
fi

# Variables
REPO_URL="https://github.com/urielblanco/workstation.git"
DEST_DIR="$HOME/.workstation"
PLAYBOOK_PATH="$DEST_DIR/setup.yml"

# Clone the repository
clone_repo "$REPO_URL" "$DEST_DIR"

# Run the Ansible playbook
run_ansible_playbook "$PLAYBOOK_PATH"
