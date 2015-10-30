FROM ubuntu:14.04

# Install base packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl lib32gcc1 -y

# install steamcmd
RUN mkdir -p /opt/steamcmd &&\
    cd /opt/steamcmd &&\
    curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz


# install csGo
RUN mkdir -p /opt/l4d2
RUN /opt/steamcmd/steamcmd.sh \
            +login anonymous \
            +force_install_dir /opt/l4d2 \
            +app_update 222860 validate \
            +quit

# add settings file
ADD cfg/* /opt/l4d2/left4dead2/cfg/

# create volume
VOLUME /opt/l4d2 

# Expose ports
EXPOSE 27015/udp
EXPOSE 27015/tcp


WORKDIR /opt/l4d2
CMD ["/opt/l4d2/srcds_run", "-game", "left4dead2", "-usercon", "-ip 0.0.0.0"]
#ENTRYPOINT ["./srcds_run"]
