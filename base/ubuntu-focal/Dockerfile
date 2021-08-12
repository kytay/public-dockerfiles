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
curl ca-certificates apt-transport-https gnupg lsb-release

# TimeZone Configuration
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
echo $TZ /etc/timezone && \
dpkg-reconfigure --frontend noninteractive tzdata

CMD ["/bin/bash"]