# Winux

Inspired by [winapps](https://github.com/winapps-org/winapps)

Winux shares the same idea as winapps, but focuses on beginner Linux users, lightweight performance, and an automated, streamlined setup GUI—similar to the experience of setting up Linux distros like Raspberry Pi OS Desktop.

My intention is not to rip off winapps, but to unlock its full potential for all users, regardless of their Linux experience.

Winux also aims to make Microsoft Office accessible to Linux users without a hypervisor, using containers to access the Office suite as though it were native to your Linux OS of choice.

---

## Setup Process (Debian/Ubuntu)

### 1. Update Your System

Open your terminal and run:
```bash
sudo apt update
sudo apt full-upgrade -y
sudo reboot
```

### 2. Install Docker (Required for Container Backend)

If you plan to use the Docker backend (recommended for running Windows/Office in a container), install Docker:
```bash
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
sudo reboot
```
> **Note:** Reboot is required for group changes to take effect.

### 3. Install Winux Dependencies

Install all required dependencies for Winux:
```bash
sudo apt install -y git curl dialog libnotify-bin netcat freerdp3-x11 virt-manager iproute2
```

### 4. (Optional) Install All Dependencies via Python Script

You can use the provided Python script to install all dependencies automatically:

Save the following as `install_deps.py` in the project directory:

````python
import subprocess

dependencies = [
    "git",
    "curl",
    "dialog",
    "libnotify-bin",
    "netcat",
    "freerdp3-x11",
    "virt-manager",
    "iproute2"
]

def install_packages(packages):
    try:
        subprocess.run(["sudo", "apt", "update"], check=True)
        subprocess.run(["sudo", "apt", "install", "-y"] + packages, check=True)
        print("All dependencies installed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error installing packages: {e}")

if __name__ == "__main__":
    install_packages(dependencies)
````