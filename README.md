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

```
root@your-server-ip
pw: your-server-password
```
## Step #5: Update System Packages

First, update your system to ensure you have the latest security patches:

```
sudo apt update
sudo apt upgrade -y
```

> Note: The `-y` flag is used to automatically answer yes to all prompts.

## Step #6: Create a New User

Create a New User with Administrative Privileges
Create a non-root user with sudo privileges:

> Originally, sudo stood for "superuser do," as it was initially designed to allow users to run commands with superuser (root) privileges. This remains its most common interpretation and usage in everyday discussions. <br><br>However, the official Sudo project has moved away from this definition. According to the project's website, sudo now means "su 'do'" which suggests a tool that delivers su-like capabilities.

```
sudo adduser yourusername
sudo usermod -aG sudo yourusername
```

> Note: Replace `yourusername` with your desired username.


Installing a Desktop Environment
Ubuntu Server doesn't come with a GUI by default, so you'll need to install one:

sudo apt update
sudo apt upgrade -y
sudo apt install ubuntu-desktop -y
