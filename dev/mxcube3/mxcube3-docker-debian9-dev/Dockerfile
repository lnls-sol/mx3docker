##############################################################################
# Dockerfile to run MXCuBE web server
##############################################################################

FROM debian:10
MAINTAINER Marcus Oscarsson <marcus.oscarsson@esrf.fr>

ENV PATH /opt/conda/bin:$PATH
ENV TERM linux
ENV USER root

# Install system paackges
RUN apt-get update --fix-missing && apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y apt-utils curl git build-essential wget \
    vim procps && \
    apt-get install -y bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1

#RUN mkdir /root/.vnc && echo "mxcube" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd
RUN touch /root/.Xresources && touch /root/.Xauthority

#RUN \
#  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
#  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
#  apt-get update && \
#  apt-get install -y google-chrome-stable

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
  /bin/bash ~/miniconda.sh -b -p /opt/conda && \
  rm ~/miniconda.sh

RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
  echo "conda activate base" >> ~/.bashrc

RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

RUN conda init bash

WORKDIR /opt

# Install MXCuBE3 dependencies (conda)
COPY debian-install.sh /opt/debian-install.sh
RUN cd /opt && chmod +x debian-install.sh
#RUN . /opt/debian-install.sh && install_debian_deps
RUN ls && cd /opt && wget https://raw.githubusercontent.com/lnls-sol/mxcube3/lnls/conda-environment.yml
RUN . /opt/debian-install.sh && install_conda_req
#RUN . /opt/debian-install.sh && install_python_deps
#RUN . /opt/debian-install.sh && install_node

COPY mxcube /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/
COPY start-mxcube-server.sh /usr/local/bin/
COPY stop-mxcube.sh /usr/local/bin/

EXPOSE 8090 8081 5901

# LNLS/Sirius dependencies

# conda
RUN conda install -y -n mxcube -c conda-forge pyepics
RUN conda install -y -n mxcube ipython


# Set max bytes for Epics caget/caput
RUN echo "export EPICS_CA_MAX_ARRAY_BYTES=20000000" >> /etc/bash.bashrc

# Add IPs of motor and camera iocs servers
#RUN echo "export EPICS_CA_ADDR_LIST=\"10.2.48.42 10.2.48.40 10.20.21.55\"" >> /etc/bash.bashrc

## mxcube3 and HO paths
RUN echo "export PYTHONPATH=\$PYTHONPATH:/opt/mxcube3/" >> /etc/bash.bashrc
RUN echo "export PYTHONPATH=\$PYTHONPATH:/opt/mxcube3/mxcube3/" >> /etc/bash.bashrc

# LNLS NFS mounts

RUN apt-get install nfs-common -y

RUN mkdir /usr/local/sol-nfs
RUN mkdir /usr/local/setup-bl
RUN mkdir /usr/local/sol

# Make this in the host instead and mount to the container with -v
#RUN chmod +w /etc/fstab
#RUN sh -c "echo '10.10.10.13:/usr/local/sol-nfs   /usr/local/sol-nfs     nfs defaults 0 0' >> /etc/fstab"
#RUN sh -c "echo '10.10.10.13:/usr/local/setup-bl   /usr/local/setup-bl     nfs defaults 0 0' >> /etc/fstab"
#RUN sh -c "echo '10.10.10.13:/usr/local/setup-bl/SOL/docker-gui/sol /usr/local/sol     nfs defaults 0 0' >> /etc/fstab"

# LNLS scan scripts

COPY lnls-scripts/install_py4syn.sh /root/
RUN /root/install_py4syn.sh

COPY lnls-scripts/config_sol_widgets.sh /root/
RUN /root/config_sol_widgets.sh

COPY lnls-scripts/config_scan_utils.sh /root/
RUN /root/config_scan_utils.sh

# Set timezone
RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

# ODBC (access to users portal db)
# See docs at:
#https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15#debian17
RUN apt install unixodbc unixodbc-dev -y
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt update
RUN ACCEPT_EULA=Y apt-get install msodbcsql17
RUN conda install -y -n mxcube pyodbc

