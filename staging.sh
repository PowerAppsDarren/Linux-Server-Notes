# =============================================================================
# UPDATE THESE VARIABLES
# =============================================================================
#
# 🔴 USER-INFORMATION 🔴
# USER_NAME                                                                     # CHANGE NEEDED HERE‼️
# USER_EMAIL                                                                    # CHANGE NEEDED HERE‼️
# USER_PASSWORD                                                                 # CHANGE NEEDED HERE‼️
#
# 🔴 SERVER-INFORMATION 🔴
# SERVER_IP_ADDRESS                                                             # CHANGE NEEDED HERE‼️

# =============================================================================
# Update your system to ensure you have the latest security patches
# =============================================================================
sudo apt update && sudo apt upgrade -y

# =============================================================================
# Add a new user with sudo privileges
# Replace 'USER_NAME' with your desired username
# =============================================================================
sudo adduser USER_NAME                                                          # CHANGE NEEDED HERE‼️
sudo usermod -aG sudo USER_NAME                                                 # CHANGE NEEDED HERE‼️

# =============================================================================
# Set up SSH key-based authentication
# =============================================================================
ssh-keygen -t rsa -b 4096 -C "USER_EMAIL"

# This will prompt you to enter a file in which to save the key. Press Enter 
# to accept the default location. You can also set a passphrase for added 
# security, or leave it empty for no passphrase.
ssh-copy-id USER_NAME@SERVER_IP_ADDRESS                                         # CHANGE NEEDED HERE‼️
# Or manually:
# cat ~/.ssh/id_rsa.pub | ssh USER_NAME@SERVER_IP_ADDRESS "mkdir -p ~/.ssh && chmod 700 ~/.ssh && touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && cat >> ~/.ssh/authorized_keys"

