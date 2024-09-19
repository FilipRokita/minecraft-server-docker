FROM ubuntu

RUN apt-get update && \
    # Adjust Java version based on Minecraft server needs, generally:
    # - Java 21 (openjdk-21-jdk) for newer MC versions
    # - Java 8 (openjdk-8-jdk) for older MC versions
    # Check compatibility at https://docs.papermc.io/paper/getting-started or just google "minecraft 1.x.x java version"
    # The line below installs curl, Java 21, and wget; add other packages as needed
    apt-get install -y curl openjdk-21-jdk wget

WORKDIR /data

EXPOSE 25565

# INSTALLATION STEP 9 - Uncomment/modify the line below after completing the initial server configuration.
#CMD ["bash", "./run.sh"]