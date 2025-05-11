# =============================================================================
# This script is designed to set up a new server with the following features:
#
# 1. Update the system to ensure you have the latest security patches.
# 2. Add a new user with sudo privileges.
# 3. Set up SSH key-based authentication for secure access.
# 4. Install essential packages for development and server management.
# 5. Configure the firewall to allow only necessary ports.
# 6. Install and configure Fail2Ban for intrusion prevention
#
# ⚠️ Specific for Debian/Ubuntu Distributions. ⚠️
#
# =============================================================================
# UPDATE THESE VARIABLES
# =============================================================================
#
# 🔴 USER-INFORMATION 🔴
#
# USER_NAME                                                                     # CHANGE NEEDED HERE‼️
# USER_EMAIL                                                                    # CHANGE NEEDED HERE‼️
# USER_PASSWORD                                                                 # CHANGE NEEDED HERE‼️
#
# 🔴 SERVER-INFORMATION 🔴
#
# SERVER_IP_ADDRESS                                                             # CHANGE NEEDED HERE‼️
#
# 🔴 TIMEZONE 🔴
#
# YOUR_TIMEZONE                                                                 # CHANGE NEEDED HERE‼️
# e.g., America/New_York, Europe/London, Asia/Tokyo, etc.
#

# =============================================================================
#
# 1️⃣ Initial Server Access & Security
#
# =============================================================================

# =============================================================================
# Update your system to ensure you have the latest security patches
# =============================================================================
sudo apt update && sudo apt upgrade -y

# =============================================================================
# Add a new user with sudo privileges
# Replace 'USER_NAME' with your desired username
# =============================================================================
sudo adduser USER_NAME                 
sudo usermod -aG sudo USER_NAME        

# =============================================================================
# You can verify that your user exists by running:
# =============================================================================
id USER_NAME
# or
groups USER_NAME
# or 
id -nG USER_NAME
# or
sudo whoami

# =============================================================================
# Set up SSH key-based authentication // If you haven't already done so!
# =============================================================================
ssh-keygen -t rsa -b 4096 -C "USER_EMAIL"

# =============================================================================
# This will prompt you to enter a file in which to save the key. Press Enter 
# to accept the default location. You can also set a passphrase for added 
# security, or leave it empty for no passphrase.
# =============================================================================
# You may want to use git bash for this step if you are on Windows.
# If you are on Linux, you can use the terminal.
# It doesn't seem to work with PowerShell.
# =============================================================================
ssh-copy-id USER_NAME@SERVER_IP_ADDRESS
# Or manually:
# cat ~/.ssh/id_rsa.pub | ssh USER_NAME@SERVER_IP_ADDRESS "mkdir -p ~/.ssh && chmod 700 ~/.ssh && touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && cat >> ~/.ssh/authorized_keys"

# Test SSH Key Login: Log out and log back in as the new user usidng the SSH key.
ssh USER_NAME@SERVER_IP_ADDRESS      
# You should not be prompted for a password. Test sudo access:
sudo whoami
# Should output: root

# =============================================================================
# Don't want to enter password for sudo? Add the following line to the sudoers file:
# =============================================================================
sudo nano /etc/sudoers.d/USER_NAME
USER_NAME ALL=(ALL) NOPASSWD: ALL
# Test it out:
sudo whoami

# =============================================================================
# Disable password authentication for SSH (optional but recommended)
# =============================================================================
sudo nano /etc/ssh/sshd_config
# Change the following lines:
PasswordAuthentication no
PermitEmptyPasswords no
PermitRootLogin no
# =============================================================================
# Save and exit the file.
# Restart SSH service to apply changes:
sudo systemctl restart ssh 
# or
# sudo systemctl restart sshd


# =============================================================================
#
# 2️⃣ System Updates
#
# =============================================================================
# Fetches the latest package lists from all configured repositories (those 
# listed in /etc/apt/sources.list and /etc/apt/sources.list.d/). Updates your 
# local cache so the system knows about the newest versions of packages and 
# their dependencies. Does not install or upgrade anything—it merely refreshes 
# metadata (package names, versions, download URLs).
sudo apt update
#
# Installs available updates for all packages you already have installed, 
# based on the refreshed metadata from apt update. Will not remove any 
# installed packages or install new dependencies beyond what’s strictly 
# necessary to upgrade (for more complex changes you’d use dist-upgrade or 
# full-upgrade). The -y flag (“yes”) automatically answers “yes” to any 
# prompts, so the upgrades proceed without stopping to ask for confirmation.
sudo apt upgrade -y
#
# Reboots the system if the kernel or other critical system components were
# updated. This is important to ensure that the system is running the latest
sudo reboot
#

# =============================================================================
#
# 3️⃣ Basic Firewall Configuration
#
# =============================================================================
sudo apt update
sudo apt install ufw -y
#
sudo ufw allow ssh
# or specify port: sudo ufw allow 22/tcp
#
sudo ufw allow http  # Port 80
sudo ufw allow https # Port 443
#
sudo ufw enable
# Confirm 'y'
#
sudo ufw status verbose

# =============================================================================
#
# 4️⃣ Essential Services Configuration
#
# =============================================================================
# Check status: timedatectl status (Look for NTP service: active). If not active, enable:
sudo timedatectl set-ntp true

# =============================================================================
#
# 5️⃣ Optional but Recommended Steps
#
# =============================================================================
sudo apt update
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
# Basic config is often sufficient, customize /etc/fail2ban/jail.local if needed.
#
# Configure Automatic Security Updates (Unattended Upgrades):
sudo apt update
sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure -plow unattended-upgrades
# Review config: sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
#
# Set Timezone:
sudo timedatectl set-timezone America/New_York  #YOUR_TIMEZONE
# List timezones: timedatectl list-timezones
#
# Install Basic Monitoring Tools (Optional): Tools like htop, iotop, iftop can be useful.
sudo apt install htop iotop iftop -y


# =============================================================================
# 6️⃣ CADDY Installation
# Caddy automatically handles HTTPS (via Let’s Encrypt) and routes traffic to Portainer.
# Caddyfile location: /etc/caddy/Caddyfile
# =============================================================================
sudo apt install caddy -y
sudo systemctl enable caddy
sudo systemctl start caddy
caddy version
# Check status: sudo systemctl status caddy
# or: sudo journalctl -u caddy --no-pager --no-full --since "1 hour ago"
# or: sudo journalctl -u caddy --no-pager --no-full --since "yesterday"
# =============================================================================
# Firewall Integration : Pair Caddy’s configuration with UFW (firewall) rules to further restrict access
# =============================================================================
sudo ufw deny from <malicious_ip> to any port 80
# =============================================================================
# After editing the Caddyfile, reload Caddy:
sudo systemctl reload caddy



# =============================================================================
# =============================================================================
# =============================================================================
How do I get a list of all installed packages on my system?
How can I verify the installation and configuration of these packages?
# =============================================================================
# 7️⃣ 
# =============================================================================
Here’s a step-by-step guide to install essential monitoring & diagnostic tools on a Linux server (Ubuntu/Debian or CentOS/RHEL), with references to the provided knowledge base:

- iftop (Real-Time Bandwidth Monitoring)
- Purpose : Monitor network bandwidth usage in real time 
- Installation:
```bash
sudo apt update && sudo apt install iftop  
```
# =============================================================================
# =============================================================================
ncdu
(Disk Usage Analyzer)
Purpose : Analyze disk usage interactively.
sudo apt install ncdu  
# =============================================================================
# =============================================================================
nmon
System Performance Monitor)
Purpose : Monitor CPU, memory, disk I/O, and network activity.
sudo apt install nmon  
# =============================================================================
# =============================================================================
sudo apt install nmap  
# =============================================================================
# =============================================================================
sudo apt install screen  
# =============================================================================
# =============================================================================
sudo apt install bash-completion  
# =============================================================================
# =============================================================================
sudo apt install htop  
# =============================================================================
# =============================================================================
Summary of Tools & Use Cases
iftop
Real-time network bandwidth monitoring
ncdu
Disk usage analysis
nmon
System performance metrics
nmap
Network scanning and port discovery
screen
Terminal session management
bash-completion
CLI efficiency improvement

For advanced monitoring (e.g., server health checks), consider tools like Nagios 
 or SolarWinds 
, though these often require additional configuration. Always ensure dependencies and repositories (like EPEL for CentOS) are configured for seamless installation.
# =============================================================================
# =============================================================================
BACKUPS
# =============================================================================
# =============================================================================
sudo nano /usr/local/bin/backup.sh  
# =============================================================================
# =============================================================================

# =============================================================================
# =============================================================================

# =============================================================================
# =============================================================================

# =============================================================================
# =============================================================================

# =============================================================================
# =============================================================================

# =============================================================================
# =============================================================================

# =============================================================================
# =============================================================================

# =============================================================================
# =============================================================================

# =============================================================================
# =============================================================================

# =============================================================================
# =============================================================================

Git Server - For hosting Git repositories
Organizr
Watchtower
Jupyter 


Grafana - For monitoring and visualization

Elastic Stack (formerly ELK) - For log storing, searching, and visualization
Heimdall - A dashboard to organize and access all your web applications

Plex
Crashplan*
MakeMKV
Handbrake
Dokuwiki
Portainer
RStudio
Jupyter
Unifi Controller

Traefik
Organizr
NginxProxyManager
Plex
NZBGet or SABnzbd
Sonarr
Radarr
Komga
Transmission
jDownloader
wg-easy (Wireguard server)
Vaultwarden

Plex - Media server
iSpy - IPCam/audio stream/CC-TV manager
Photoprism - Photo library management (Google Photos replacement)
PiHole - A sort of DNS level firewall
BabyBuddy - Childcare metric tracker (feedings,diapers,naps,weight,etc)
Heimdall - A simple hub/gui for all the server apps.



- Huly
- Formbricks
- N8N
- Shields.io 
- Nocodb
- Strapi
- FlowiseAI
- Scira
- LimeSurvey
- https://wsrv.nl/ - https://github.com/weserv/images
- fastapi
- hugging-face-transformer
- FreeAPI
- php-bb
- Directus


paperless Paperless Office
Atlassian Confluence
Atlassian Jira
Atlassian Bitbucket


On A Laptop (why Laptop? It has a Battery included ;-) )
Portainer-agent (to acces it from my other Portainer)
Openhab3 (Smarthome)
NodeRed
Mosquitto(MQTT)
Deconz (Zibgee Controller)
Grafana


I use on my NAS:
piHole
HomeAssistant
deconz
Portainer
Flame
Lenpaste
Moquitto
NodeRed
unbound
Uptime Kuma
Grafana

Nextcloud
Nginx Reverse Proxy
Watchtower (keeps your container up to date)
Jellyfin
Lidarr
Syncthing