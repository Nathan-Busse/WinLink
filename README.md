# Winux

Inspired by [winapps](https://github.com/winapps-org/winapps)

Winux shares the same idea as winux, but focuses on beginner Linux users, lightweight performance, and an automated, streamlined setup GUI—similar to the experience of setting up Linux distros like Raspberry Pi OS Desktop.

My intention is not to rip off winux, but to unlock its full potential for all users, regardless of their Linux experience.

Winux also aims to make Microsoft Office and Autodesk Fusion accessible to Linux users without a hypervisor, using containers to access the Office suite as though it were native to your Linux OS of choice.

---

## Setup Process (Debian/Ubuntu)

### 1. Update Your System

Open your terminal and run:
```bash
sudo apt update
```

```bash
sudo apt full-upgrade -y
```

```bash
sudo reboot
```
# Before we do anything else we need to install Docker:
## It is paramount to install Docker first before the dependencies...

### Installing Docker for Ubuntu/Mint
**Step 1: Install GNOME**
```bash
sudo apt install gnome-terminal
```

**Step 2: Install Docker Desktop**
1. Set up Docker's package repository. 
   - See step one of [install using the apt repository](https://docs.docker.com/engine/install/ubuntu/  #install-using-the-repository)
  
2. Download the latest [DEB package](https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64)
   - For checksums see the [Release notes.](https://docs.docker.com/desktop/release-notes/)

3. Install the package using `apt`:
```bash
    sudo apt-get update
```

```bash
sudo apt-get install ./docker-desktop-amd64.deb
```
**Note**
At the end of the installation processs, `apt` displays an error due to installing a downloaded package.
You can ignore this error message. The message is as follows:
```bash 
N: Download is performed unsandboxed as root, as file '/home/user/Downloads/docker-desktop.deb' couldn't be accessed by user '_apt'. - pkgAcquire::Run (13: Permission denied)
```
By default, Docker Desktop is installed at `/opt/docker-desktop`.

The DEB package includes a post-install script that completes additional setup steps automatically.

The post-install script:

- Sets the capability on the Docker Desktop binary to map privileged ports and set resource limits.
- Adds a DNS name for Kubernetes to `/etc/hosts`.
- Creates a symlink from `/usr/local/bin/com.docker.cli` to `/usr/bin/docker`. 
  This is because the classic Docker CLI is installed at `/usr/bin/docker`. 
  The Docker Desktop installer also installs a Docker CLI binary that includes cloud-integration capabilities and is essentially a wrapper for the Compose CLI, at `/usr/local/bin/com.docker.cli`. 
  The symlink ensures that the wrapper can access the classic Docker CLI.

**Step 3: Launch Docker Desktop**
Open a terminal and run the following command:
```bash
systemctl --user start docker-desktop
```
When Docker Desktop starts, it creates a dedicated [context](https://docs.docker.com/engine/context/working-with-contexts) that the Docker CLI can use as a target and sets it as the current context in use. This is to avoid a clash with a local Docker Engine that may be running on the Linux host and using the default context. On shutdown, Docker Desktop resets the current context to the previous one.

The Docker Desktop installer updates Docker Compose and the Docker CLI binaries on the host. It installs Docker Compose V2 and gives users the choice to link it as docker-compose from the Settings panel. Docker Desktop installs the new Docker CLI binary that includes cloud-integration capabilities in `/usr/local/bin/com.docker.cli` and creates a symlink to the classic Docker CLI at `/usr/local/bin`.

After you’ve successfully installed Docker Desktop, you can check the versions of these binaries by running the following commands:
```bash
docker compose version
```
```bash
docker --version
```
```bash
docker version
```
To enable Docker Desktop to start on sign in run the following command below:
```bash
systemctl --user enable docker-desktop
```

To stop Docker Desktop, run the follwoing command below:
```bash
systemctl --user stop docker-desktop
```

# Upgrade Docker Desktop
When a new version for Docker Desktop is released, the Docker UI shows a notification. You need to download the new package each time you want to upgrade Docker Desktop and run:

To upgrade Docker Desktop run the following command below:
```bash
sudo apt-get install ./docker-desktop-amd64.deb
```

### 3. Install Winux Dependencies

Install all required dependencies for Winux:
```bash
sudo apt install -y curl dialog freerdp3-x11 git iproute2 libnotify-bin netcat-openbsd
```

#WARNING
**DO NOT RUN THE ```bash sudo apt autopurge curl dialog freerdp3-x11 git iproute2 libnotify-bin netcat-openbsd``` COMMAND TO UNINSTALL IF YOU MADE A MISTAKE IT WILL DELETE YOUR GPU DRIVER AND DESKTOP ENVIRONMENT.

it is recoverable with a bootable usb of linux mint

### 4. (Optional) Install All Dependencies via Python Script

You can use the provided Python script to install all dependencies automatically `install_deps.py` in the project's root directory

# Deploy docker creator:
Run the script `compose.sh` located in the root directory:

**Step 1:**
```bash
cd winux
```

**Step 2:**
```bash
bash compose.sh
```