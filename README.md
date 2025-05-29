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

### 2. Install Docker (Required for Container Backend)

If you plan to use the Docker backend (recommended for running Windows/Office in a container), install Docker:
```bash

```

```bash
sudo systemctl enable --now docker
```

```bash
sudo usermod -aG docker $USER
```

```bash
sudo reboot
```
> **Note:** Reboot is required for group changes to take effect.

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