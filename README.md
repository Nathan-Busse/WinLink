# WinLink

Inspired by [winlink](https://github.com/winlink-org/winlink)

WinLink shares the same idea as winlink, but focuses on bridinging the gap between Microsoft windows appliciations and Linux , lightweight performance, and an automated, streamlined setup GUI—similar to the experience of setting up Linux distros like Raspberry Pi OS Desktop.

My intention is not to rip off winlink, but to expand the core idea and unlock its full potential.
WinLink also aims to make Microsoft Office and Autodesk Fusion accessible to Linux users without a hypervisor, using containers to access the Office suite as though it were native to your Linux OS of choice.

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

5. Reboot your computer with the following command:
```bash
sudo reboot
```


> [!IMPORTANT]
> The iptables kernel module must be loaded for folder sharing with the host to work.
> Check that the output of `lsmod | grep ip_tables` and `lsmod | grep iptable_nat` is non empty.
> If the output of one of the previous command is empty, run `echo -e "ip_tables\niptable_nat" | sudo tee /etc/modules-load.d/iptables.conf` and reboot.

## `Docker`
### Installation
You can find a guide for installing `Docker Engine` [here](https://docs.docker.com/engine/install/).

### Setup `Docker` Container
WinLink utilises `docker compose` to configure Windows VMs. A template [`compose.yaml`](../compose.yaml) is provided.

Prior to installing Windows, you can modify the RAM and number of CPU cores available to the Windows VM by changing `RAM_SIZE` and `CPU_CORES` within `compose.yaml`.

It is also possible to specify the version of Windows you wish to install within `compose.yaml` by modifying `VERSION`.

Please refer to the [original GitHub repository](https://github.com/dockur/windows) for more information on additional configuration options.

> [!NOTE]
> If you want to undo all your changes and start from scratch, run the following. For `podman`, replace `docker compose` with `podman-compose`.
> ```bash
> docker compose down --rmi=all --volumes
> ```

### Installing Windows
You can initiate the Windows installation using `docker compose`.
```bash
cd winlink
docker compose --file ./compose.yaml up
```

You can then access the Windows virtual machine via a VNC connection to complete the Windows setup by navigating to http://127.0.0.1:8006 in your web browser.

### Changing `compose.yaml`
Changes to `compose.yaml` require the container to be removed and re-created. This should __NOT__ affect your data.

```bash
# Stop and remove the existing container.
docker compose --file ~/.config/winlink/compose.yaml down

# Remove the existing FreeRDP certificate (if required).
# Note: A new certificate will be created when connecting via RDP for the first time.
rm ~/.config/freerdp/server/127.0.0.1_3389.pem

# Re-create the container with the updated configuration.
# Add the -d flag at the end to run the container in the background.
docker compose --file ~/.config/winlink/compose.yaml up
```

### Subsequent Use
```bash
docker compose --file ~/.config/winlink/compose.yaml start # Power on the Windows VM
docker compose --file ~/.config/winlink/compose.yaml pause # Pause the Windows VM
docker compose --file ~/.config/winlink/compose.yaml unpause # Resume the Windows VM
docker compose --file ~/.config/winlink/compose.yaml restart # Restart the Windows VM
docker compose --file ~/.config/winlink/compose.yaml stop # Gracefully shut down the Windows VM
docker compose --file ~/.config/winlink/compose.yaml kill # Force shut down the Windows VM
```


### 3. Clone WinLink repository
1. In a new terminal window run the following command to take you to root directory:
```bash
cd
```

2. If you have not doen so already install `git` using the following command:
```bash 
sudo apt isntall git
```

3. Reboot your computer by running the following command:
```bash
sudo reboot
```
4. In a new terminal window run the following command to make sure you are in the `root` directory:
```bash
cd
```

5. Next run the following command:
```bash 
git clone https://github.com/Nathan-Busse/WinLink
```

6. It is a good habit to reboot after installing or reoming packages in linux:
```bash
sudo reboot
```

### 3. Install WinLink Dependencies
1. In a new terminal window run the following command to ensure you are in the `root` directory:
```bash 
cd
```

# WARNING
### Read before proceeding:
**`DO NOT` RUN THE ```bash sudo apt install curl dialog freerdp3-x11 git iproute2 libnotify-bin netcat-openbsd``` COMMAND `BEFORE` INSTALLING `DOCKER ENGINE` `FIRST`!** 

**`You` have been `WARNED`!**

2. Now we need to install all required dependencies for WinLink by running this command:
```bash
sudo apt install -y curl dialog freerdp3-x11 git iproute2 libnotify-bin netcat-openbsd
```


### 4. (Optional) Install All Dependencies via Python Script

You can use the provided Python script to install all dependencies automatically `install_deps.py` in the project's root directory

# Deploy docker creator:
Run the script `compose.sh` located in the root directory:

**Step 1:**
```bash
cd winlink
```

**Step 2:**
```bash
bash compose.sh
```