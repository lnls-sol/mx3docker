##############################################################################
# Dockerfile to run MXCuBE web server
##############################################################################

FROM debian:10
MAINTAINER Marcus Oscarsson <marcus.oscarsson@esrf.fr>

ENV TERM linux
ENV USER root

# Install system pacakges

RUN apt-get update && apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install --fix-missing -y mate-desktop-environment-core && \
    apt-get install -y apt-utils curl git sudo build-essential wget \
    tightvncserver emacs xemacs21 vim procps

RUN mkdir /root/.vnc && echo "mxcube" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd
RUN touch /root/.Xresources && touch /root/.Xauthority

RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable

WORKDIR /opt

# Install MXCuBE3 dependencies
COPY debian-install.sh /opt/debian-install.sh
RUN cd /opt && chmod +x debian-install.sh
RUN . /opt/debian-install.sh && install_debian_deps
RUN cd /opt && wget https://raw.githubusercontent.com/mxcube/mxcube3/master/requirements.txt
RUN . /opt/debian-install.sh && install_python_deps
RUN . /opt/debian-install.sh && install_node

COPY mxcube /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/
COPY start-mxcube-server.sh /usr/local/bin/

EXPOSE 8090 8081 5901

# LNLS/Sirius dependencies

# pip
RUN pip3 install pyepics ipython

# Set max bytes for Epics caget/caput
RUN echo "export EPICS_CA_MAX_ARRAY_BYTES=20000000" >> /etc/bash.bashrc

# Add IPs of motor and camera iocs servers
RUN echo "export EPICS_CA_ADDR_LIST=\"10.2.48.42 10.2.48.40 10.20.21.55\"" >> /etc/bash.bashrc

## mxcube3 and HO paths
RUN echo "export PYTHONPATH=\$PYTHONPATH:/opt/mxcube3/" >> /etc/bash.bashrc
RUN echo "export PYTHONPATH=\$PYTHONPATH:/opt/mxcube3/mxcube3/" >> /etc/bash.bashrc
