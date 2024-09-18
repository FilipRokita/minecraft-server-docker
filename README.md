# Minecraft Server in Docker

## Short Description
This project provides a Docker setup for running a Minecraft server. It simplifies the process of setting up and managing Minecraft servers by using Docker, making it easier to deploy and maintain different Minecraft server versions and modpacks.

## Why Use Docker for Minecraft Server?
Running a Minecraft server in a Docker container offers several advantages:
- **Isolation**: Each server runs in its own environment, reducing conflicts with other software.
- **Portability**: Easily move your server setup between different machines.
- **Consistency**: Ensure that the server runs in the same environment every time, reducing issues related to system differences.

## Prerequisites
- Git, Docker, and Docker Compose installed on your machine.
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
    - Open the `Dockerfile` and locate the line that installs Java:
    ```dockerfile
    RUN apt-get update && \
        apt-get install -y curl openjdk-21-jre-headless wget
    ```
    - If you are running an older version of Minecraft, change the Java version to `openjdk-8-jre-headless`.
    - If your server runs an older Minecraft version and requires additional packages (e.g., `unzip`), modify the line to:
    ```dockerfile
    RUN apt-get update && \
        apt-get install -y curl openjdk-8-jre-headless wget unzip
    ```

4. **Download Server Files**
    - Download the Minecraft server files or modpack server files.
    - Place the `.jar` file or unzipped files into the `data` folder.

5. **Build and Run Docker Container**
    ```bash
    docker-compose up -d
    ```
    *Note:* You must run this command inside `mcsrv` folder

6. **Attach to the Container**
    ```bash
    docker attach mcsrv_minecraft
    ```
    You are now in the Docker container.  
    *Note:* You must run this command inside `mcsrv` folder

7. **Initial Server Configuration**
    - Follow the server or modpack guide for initial setup. Common steps include:
        - Run `java -jar server.jar`.
        - Accept the EULA by editing `eula.txt`.
        - Create a `run.sh` script with:
        ```bash
        java -Xmx8G -jar server.jar nogui
        ```
        *Note:* Adjust `-Xmx8G` to match the amount of RAM your server will use (in this case, 8GB).
    - Run the server manually for the first time, wait until the world generates, and stop it with `stop`.

8. **Finalize Docker Configuration**
    - Edit the `Dockerfile` to uncomment the `CMD` line and ensure it points to your `run.sh` script.
    - If necessary, modify `run.sh` to match the script provided by the modpack. (e.g, `startserver.sh`, `start.sh`)

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
    - Use `Ctrl + P`, then `Ctrl + Q`.

## Uninstallation

1. **Remove Folder**
    ```bash
    rm -rf mcsrv
    ```

2. **Clean Docker Containers, Images, etc.**
    ```bash
    docker system prune -a
    ```
    **Warning:** This will remove all unused containers, networks, images, and optionally, volumes. Use with caution.
