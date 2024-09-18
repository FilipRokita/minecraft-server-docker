# Minecraft Server in Docker

## Short Description
This project provides a Docker setup for running a Minecraft server. It simplifies the process of setting up and managing Minecraft servers by using Docker, making it easier to deploy and maintain different Minecraft server versions and modpacks.

## Why Use Docker for Minecraft Server?
Running a Minecraft server in a Docker container offers several advantages:
- **Isolation**: Each server runs in its own environment, reducing conflicts with other software.
- **Portability**: Easily move your server setup between different machines.
- **Consistency**: Ensure that the server runs in the same environment every time, reducing issues related to system differences.

## Prerequisites
- Git, Docker and Docker Compose installed on your machine.
- Basic familiarity with Docker commands.

## Tested On
Ubuntu Server 22.04 with:
- [All the Mods 10 - ATM 10](https://www.curseforge.com/minecraft/modpacks/all-the-mods-10)
- [Better MC [FORGE] - BMC4](https://www.curseforge.com/minecraft/modpacks/better-mc-forge-bmc4)
- [RLCraft](https://www.curseforge.com/minecraft/modpacks/rlcraft)

## Installation

1. **Clone the Repository**
    ```bash
    git clone https://github.com/FilipRokita/minecraft-server-docker
    ```

2. **Rename the Repository Folder**
    
    ```bash
    mv minecraft-server-docker mcsrv
    ```

3. **Edit Dockerfile**
    - Open the `Dockerfile` and find the line that installs Java:
    ```dockerfile
    RUN apt-get update && \
        apt-get install -y curl openjdk-21-jre-headless wget
    ```
    - If you are running older version of minecraft change java version to `openjdk-8-jre-headless`
    - If your server needs additional packages, add them to the same line. For example, if `unzip` is required, modify the line to:
    ```dockerfile
    RUN apt-get update && \
        apt-get install -y curl openjdk-17-jre-headless wget unzip
    ```

4. **Download Server Files**
    - Download the Minecraft server files or modpack server files.
    - Place the `.jar` file or unzipped files into the `data` folder.

5. **Build and Run Docker Container**
    ```bash
    docker-compose up -d
    ```

6. **Attach to the Container**
    ```bash
    docker attach mcsrv-mc-1
    ```
    Now you are in the docker container.

7. **Initial Server Configuration**
    - Follow the server or modpack guide for initial setup.
    - Typical steps include:
        - Downloading the `.jar` server file or `.zip` server files and unpack them into `data` folder.
        - Running `java -jar server.jar`.
        - Accepting the EULA by editing `eula.txt`.
        - Creating a `run.sh` script with:
        ```bash
        java -Xmx8G -jar server.jar nogui
        ```
        Note: -Xmx8G change it to any other amount of ram that your server will use, in this case its 8GB
    - Run the server manually for the first time, wait until the world genereates etc. and stop it with `stop`.

8. **Finalize Docker Configuration**
    - Edit the `Dockerfile` to uncomment the `CMD` line and ensure it points to your `run.sh` script.

## Usage

- **Start Server**
    ```bash
    docker compose up -d
    ```

- **Stop Server**
    ```bash
    docker attach mcsrv-mc-1
    stop
    ```

- **Access Server Console**
    ```bash
    docker attach mcsrv-mc-1
    ```

- **Exit Console**
    - Use `Ctrl + P` then `Ctrl + Q`.

## Uninstallation

1. **Remove Project Folder**
    ```bash
    rm -rf mcsrv
    ```

2. **Clean Docker Containers, Images, etc.**
    ```bash
    docker system prune -a
    ```
    **Warning:** This will remove all unused containers, networks, images, and optionally, volumes. Use with caution.
