ARG PARAM_UBUNTU_VERSION=latest
ARG PARAM_TZ=UTC

FROM ubuntu:${PARAM_UBUNTU_VERSION}
WORKDIR /opt

# Environment for timezone setup
ENV TZ=${PARAM_TZ}

# Basic commands for ubuntu images
# 1       - disable policy-rc.d , refer - https://stackoverflow.com/questions/46247032/how-to-solve-invoke-rc-d-policy-rc-d-denied-execution-of-start-when-building
# 2 & 3   - apt update and install without apt recommendations
RUN echo -e '#!/bin/bash \nexit 0' > /usr/sbin/policy-rc.d \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
curl  ca-certificates apt-transport-https gnupg lsb-release tzdata unzip openjdk-17-jdk-headless \
&& apt-get upgrade -y \
&& apt-get autoremove -y \
&& apt-get purge -y --auto-remove \
&& rm -rf /var/lib/apt/lists/*

# TimeZone Configuration
# 4       - setup noninteractive timezone
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
echo $TZ /etc/timezone && \
dpkg-reconfigure --frontend noninteractive tzdata

RUN curl -L "https://edownloads.tibco.com/Installers/tap/EMS-CE/10.2.1/TIB_ems-ce_10.2.1_linux_x86_64.zip?SJCDPTPG=1700289623_72fd9fa3800805f3064b1d015aa10745&ext=.zip" -o ems.zip \
&& unzip ems.zip \
&& cd $(ls | grep TIB) \
&& for f in tar/*; do tar -xvf $f; done \
&& mv opt/* /opt \
&& rm -Rf /opt/TIB_ems* \
&& rm /opt/ems.zip

CMD ["/bin/bash"]