FROM ubuntu:focal

# Environment for timezone setup
ENV TZ=Asia/Singapore

ENV SAM_CLI_TELEMETRY=0
ENV AWS_ACCESS_KEY_ID=acess123
ENV AWS_SECRET_ACCESS_KEY=secret123
ENV AWS_REGION=localhost
ENV DYNAMODB_ENDPOINT=http://localhost:8000

# Basic commands for ubuntu images
# 1       - disable policy-rc.d , refer - https://stackoverflow.com/questions/46247032/how-to-solve-invoke-rc-d-policy-rc-d-denied-execution-of-start-when-building
# 2 & 3   - apt update and install without apt recommendations
# 4       - install requirements for docker installations
# 5       - install misc requirements for cron, timezone and utils
# 6       - install requirements for aws-sam, dynamodb setup
RUN echo -e '#!/bin/bash \nexit 0' > /usr/sbin/policy-rc.d && \
apt-get update && \
apt-get install -y --no-install-recommends \
curl ca-certificates apt-transport-https gnupg lsb-release \
software-properties-common cron tar sudo tzdata \
unzip iproute2 openjdk-8-jdk

# Include s6-overlay init system
ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /

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

# Install latest nodejs - lts
# https://github.com/nodesource/distributions/blob/master/README.md#deb
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
apt-get install -y nodejs

# Install aws-sam
# Refer - https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-linux.html
RUN mkdir /aws && cd /aws && \
curl -LO https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip && \
unzip ./aws-sam-cli-linux-x86_64.zip && \
./install && \
rm -Rf /aws/*

# Install aws-dyanmodb-local
# Refer - https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html
RUN mkdir /dynamodb && cd /dynamodb && \
curl -LO https://s3.ap-southeast-1.amazonaws.com/dynamodb-local-singapore/dynamodb_local_latest.tar.gz && \
tar -xvf ./dynamodb_local_latest.tar.gz

# Install dynamodb-admin
# Refer - https://www.npmjs.com/package/dynamodb-admin
RUN npm install -g dynamodb-admin

COPY ./services.d /etc/services.d

ENTRYPOINT ["/init"]