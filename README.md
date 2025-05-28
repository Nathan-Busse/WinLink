# Winux
Inspired from [winapps](https://github.com/winapps-org/winapps)

Winux shares the same idea as winapps however the key difference is that winux focuses on beginner linux users, light weight performance and a automated and streamlined setup GUI as you would when setting up linux distros such as Raspberry OS Desktop.

My intention is not to rip  off winapps but simply to unlock its full potential to all users no matter there linux expereince.

I also want to make Office accessible to linux users without a hypervisor but rather a container and  access the office suite as though it were native to the Linux OS of choice.

**Dependencies (debian/ubuntu)**

1. `sudo apt install git`
2. `sudo apt install curl`
3. `sudo apt install dialog`
4. `sudo apt install libnotify-bin`
5. `sudo apt install netcat`
6. `sudo apt install freerdp3-x11`
7. `sudo apt install virt-manager`
8. `sudo apt install iproute2`

Below is a Python script that will install all these dependencies using `subprocess` to call `apt`:

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
        subprocess.run(
            ["sudo", "apt", "update"], check=True
        )
        subprocess.run(
            ["sudo", "apt", "install", "-y"] + packages, check=True
        )
        print("All dependencies installed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error installing packages: {e}")

if __name__ == "__main__":
    install_packages(dependencies)
````

**Usage:**  
Run the script with:  

```bash
python3 install_deps.py
```