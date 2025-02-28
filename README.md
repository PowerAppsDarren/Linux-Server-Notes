# Linux Server Setup & Configuration

## Step #1: Get a Server 

Get your server from a hosting provider. I personally use and recommend [Hostinger](https://hostinger.com?REFERRALCODE=5Q1DARRENHDY). 

## Step #2: Obtain Server Credentials

You will need the root password to login to your server.

## Step #3: Download & Install Putty

- Download Putty from [here](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
- Install Putty on your local machine
- Open Putty and enter your server IP address in the Host Name field
- Enter 22 in the Port field
- Select SSH as the Connection Type
- Click Open

## Step #4: Login to Server

```bash
root@your-server-ip
pw: your-server-password
```
## Step #5: Update System Packages

First, update your system to ensure you have the latest security patches:

```bash
sudo apt update
sudo apt upgrade -y
```

> Note: The `-y` flag is used to automatically answer yes to all prompts.

## Step #6: Create a New User

Create a New User with Administrative Privileges
Create a non-root user with sudo privileges:

> Originally, sudo stood for "superuser do," as it was initially designed to allow users to run commands with superuser (root) privileges. This remains its most common interpretation and usage in everyday discussions. <br><br>However, the official Sudo project has moved away from this definition. According to the project's website, sudo now means "su 'do'" which suggests a tool that delivers su-like capabilities.

```bash
sudo adduser yourusername
sudo usermod -aG sudo yourusername
```

> The -aG option combines two separate flags that work together to add a user to a supplementary group without removing them from any existing groups.
<br><br>The -a flag stands for "append" and must be used together with the -G option. It ensures that the user is added to the specified group(s) while preserving their existing group memberships.
<br><br>The -G flag specifies the supplementary group(s) that the user should be added to. In this case, the group is also named "sudo".
<br><br>Without the -a flag, using just -G would replace all of the user's existing supplementary group memberships with only the groups specified in the command. This could potentially remove the user from important groups and cause problems with their account permissions.
<br><br>So in this specific example, sudo usermod -aG sudo yourusername safely adds "yourusername" to the "sudo" group, which grants them administrative privileges through the sudo command, while maintaining all their current group memberships.

## Step #7: Verify New User

You can verify that your user exists by running:

```bash
id yourusername
# or
groups yourusername
# or 
id -nG yourusername
# or
sudo whoami
```

## Step #8: Configure SSH Security

Edit the SSH configuration file:

```
sudo nano /etc/ssh/sshd_config
```

### Make these security-focused changes:

- Disable root login: PermitRootLogin no
- Change default SSH port (optional): Port 2222 (choose a port between 1024-65535)
- Allow only your new user: AllowUsers yourusername








- Disable password authentication (after setting up SSH keys)   
    - PasswordAuthentication no

### Set maximum authentication attempts: MaxAuthTries 3

Set up SSH key authentication (on your local machine):




Installing a Desktop Environment
Ubuntu Server doesn't come with a GUI by default, so you'll need to install one:

sudo apt update
sudo apt upgrade -y
sudo apt install ubuntu-desktop -y




sudo apt-get install net-tools
