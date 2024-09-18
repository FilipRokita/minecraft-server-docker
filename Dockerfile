FROM ubuntu

RUN apt-get update && \
    # Install required packages: curl, Java 21, and wget
    # Adjust Java version based on Minecraft server needs:
    # - Java 21 for newer versions (openjdk-21-jre-headless)
    # - Java 8 for older versions (openjdk-8-jre-headless)
    # Add more packages as needed
    apt-get install -y curl openjdk-21-jre-headless wget

WORKDIR /data

EXPOSE 25565

# Uncomment the line below after completing the initial server configuration (Step 7)
#CMD ["bash", "./run.sh"]