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