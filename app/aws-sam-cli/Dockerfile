FROM ubuntu:focal

# Environment for timezone setup
ENV TZ=Asia/Singapore

# Basic commands for ubuntu images
# 1       - disable policy-rc.d , refer - https://stackoverflow.com/questions/46247032/how-to-solve-invoke-rc-d-policy-rc-d-denied-execution-of-start-when-building
# 2 & 3   - apt update and install without apt recommendations
# 4       - install requirements for docker installations
# 5       - install misc requirements for cron, timezone and utils
# 6       - install requirements for aws-sam setup
RUN echo -e '#!/bin/bash \nexit 0' > /usr/sbin/policy-rc.d && \
apt-get update && \
apt-get install -y --no-install-recommends \
curl ca-certificates apt-transport-https gnupg lsb-release \
software-properties-common cron tar sudo tzdata \
unzip iproute2

# TimeZone Configuration
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
echo $TZ /etc/timezone && \
dpkg-reconfigure --frontend noninteractive tzdata

# Install docker-ce
# https://docs.docker.com/engine/install/ubuntu/
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

# Install aws-sam
# Refer - https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-linux.html
RUN mkdir /aws && cd /aws && \
curl -LO https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip && \
unzip ./aws-sam-cli-linux-x86_64.zip && \
./install && \
rm -Rf /aws/*

CMD ["/bin/bash"]