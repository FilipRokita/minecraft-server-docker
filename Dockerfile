FROM ubuntu

RUN apt-get update && \
    # Adjust Java version based on Minecraft server needs:
    # - Java 21 for newer versions (openjdk-21-jre-headless)
    # - Java 8 for older versions (openjdk-8-jre-headless)
    # The line below installs curl, Java 21, and wget; add other packages as needed
    apt-get install -y curl openjdk-21-jre-headless wget

WORKDIR /data

EXPOSE 25565

# Uncomment the line below after completing the initial server configuration (Installation Step 7)
#CMD ["bash", "./run.sh"]