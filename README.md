# Winux

Inspired by [winapps](https://github.com/winapps-org/winapps)

Winux shares the same idea as winapps, but focuses on bridinging the gap between Microsoft windows appliciations and Linux , lightweight performance, and an automated, streamlined setup GUI—similar to the experience of setting up Linux distros like Raspberry Pi OS Desktop.

My intention is not to rip off winapps, but to expand the core idea and unlock its full potential.
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

**Step 2: Install Docker Engine**
1. Uninstal old versions:
Before you can install Docker Engine, you need to uninstall any conflicting packages.

Your Linux distribution may provide unofficial Docker packages, which may conflict with the official packages provided by Docker.
You must uninstall these packages before you install the official version of Docker Engine.

The unofficial packages to uninstall are:

   - docker.io
   - docker-compose
   - docker-compose-v2
   - docker-doc
   - podman-docker

Moreover, Docker Engine depends on `containerd` and `runc`. Docker Engine bundles these dependencies as one bundle: `containerd.io`.
If you have installed the `containerd` or `runc` previously, uninstall them to avoid conflicts with the versions bundled with Docker Engine.

Run the following command to uninstall all conflicting packages:
```bash
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

2. Install using the `apt`repository:
```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

```

3. Install Docker package:
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

4. Verify that the installation is successful by running the `hello-world` image:
```bash
sudo docker run hello-world
```
This command downloads a test image and runs it in a container. When the container runs, it prints a confirmation message and exits.

You have now successfully installed and started Docker Engine.


### 2. Install Winux Dependencies

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