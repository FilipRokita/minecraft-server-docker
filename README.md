# Minecraft Server in Docker

## Table of Contents
- [Overview](#overview)
- [Why Use Docker for Minecraft Server?](#why-use-docker-for-minecraft-server)
- [Prerequisites](#prerequisites)
- [Tested On](#tested-on)
- **[Installation](#installation)**
- **[Usage](#usage)**
- [Uninstallation](#uninstallation)
- [Troubleshooting](#troubleshooting)
- [Additional Information](#additional-information)

## Overview
This project provides a Docker setup for running a Minecraft server. It simplifies the process of setting up and managing Minecraft servers by using Docker, making it easier to deploy and maintain different Minecraft server versions and modpacks.

## Why Use Docker for Minecraft Server?
Running a Minecraft server in a Docker container offers several advantages:
- **Isolation**: Each server runs in its own environment, reducing conflicts with other software.
- **Portability**: Easily move your server setup between different machines.
- **Consistency**: Ensure that the server runs in the same environment every time, reducing issues related to system differences.

## Prerequisites
- Git and Docker Engine installed on your machine.
- Basic familiarity with Docker commands.

## Tested On
Ubuntu Server 22.04 with:
- [All the Mods 9-0.3.2](https://www.curseforge.com/minecraft/modpacks/all-the-mods-9)
- [All the Mods 10-0.53](https://www.curseforge.com/minecraft/modpacks/all-the-mods-10)
- [Better MC [FORGE] BMC4 v32.5](https://www.curseforge.com/minecraft/modpacks/better-mc-forge-bmc4)
- [Paper 1.21.1](https://papermc.io/)
- [RLCraft 1.12.2 - Release v2.9.3](https://www.curseforge.com/minecraft/modpacks/rlcraft)
- [Vanilla 1.21.1](https://www.minecraft.net/pl-pl/download/server)

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
    - Open the `Dockerfile` and locate the line that installs Java:
        ```dockerfile
        RUN apt-get update && \
            apt-get install -y curl openjdk-21-jdk wget
        ```
    - If you are running an older version of Minecraft, change the Java version to `openjdk-8-jdk`. Additionally, if your server requires extra packages (such as `unzip`) add them to this line. For example:
        ```dockerfile
        RUN apt-get update && \
            apt-get install -y curl openjdk-8-jdk wget unzip
        ```
        Some servers might work with only `openjdk-X-jre-headless`, but you’ll need to experiment to find what works best.

4. **Create a Symlink to Docker Volume**
   - From inside the `mcsrv` directory, create a symlink to the Docker volume for easy access to your data:
     ```bash
     docker compose up && docker compose down
     ln -s /var/lib/docker/volumes/mcsrv_data/_data data
     ```
   - *Note:* The path to the volume may vary. You can check the exact path using `docker volume inspect mcsrv_data`

5. **Download Server Files**
    - Download the Minecraft server files or modpack server files.
    - Place the `.jar` file or unzipped files into the `data` folder.

6. **Build and Run Docker Container**
    ```bash
    docker compose up -d
    ```
    *Note:* You must run this command inside `mcsrv` folder

7. **Attach to the Container**
    ```bash
    docker attach mcsrv-mc-1
    ```
    You are now in the Docker container.

8. **Initial Server Configuration**
    - Follow the server or modpack guide for the initial setup. If no guide is available, common steps include:
        - Run `java -jar server.jar`.
        - Accept the EULA by editing `eula.txt`.
            ```bash
            echo eula=true > eula.txt
            ```
        - Create a `run.sh` script with:
            ```bash
            java -Xmx8G -jar server.jar nogui
            ```
            *Note:* Adjust `-Xmx8G` to match the amount of RAM your server will use (in this case, 8GB).
    - Run the server manually for the first time, wait until the world generates, and stop it with `stop`.

9. **Detach and Stop the Container**
    - Use `Ctrl + P`, then `Ctrl + Q` to detach from the container.
    - Run this command inside `mcsrv` folder to stop the container:
    ```bash
    docker compose down
    ```

10. **Finalize Docker Configuration**
    - Edit the `Dockerfile` to uncomment the `CMD` line and ensure it points to your `run.sh` script.
    - If necessary, modify the line to match the script provided by the modpack. (e.g, `startserver.sh`, `start.sh`, etc.)

## Usage

- **Start Server**
    ```bash
    docker compose up -d
    ```
    *Note*: If you are running this command for the first time after installation, use `docker compose up -d --build`. Also, ensure you are executing the command inside the `mcsrv` folder.

- **Stop Server**
    ```bash
    docker attach mcsrv-mc-1
    stop
    ```

- **Stop Server (Emergency)**
    ```bash
    docker compose down
    ```
    *Note:* Use this command inside `mcsrv` folder if the server is unresponsive or crashes.

- **Access Server Console**
    ```bash
    docker attach mcsrv-mc-1
    ```

- **Exit Console**
    - Use `Ctrl + P`, then `Ctrl + Q`.

## Uninstallation

1. **Remove Folder**
    ```bash
    rm -rf mcsrv
    ```

2. **Remove Docker Container, Image, and Volume**
    ```bash
    docker container rm -f mcsrv-mc-1
    docker image rm mcsrv-mc
    docker volume rm mcsrv_data
    ```

## Troubleshooting
For issues or questions, refer to:
- [Docker Docs](https://docs.docker.com/)

## Additional Information

**Version:** 1.0.14  
**Date:** 2024-09-18  
**License:** [MIT License](LICENSE)  
**Author:** [Filip Rokita](https://www.filiprokita.com/)