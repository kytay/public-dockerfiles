FROM kytay/ubuntu-docker

RUN apt-get update && \
apt-get install -y python3 git unzip

RUN mkdir /sam && \
cd /sam && \
curl -LO https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip && \
unzip *.zip && \
./install && \
echo \
  "alias sam-local-startapi='sam local start-api \
  --host 0.0.0.0 --container-host host.docker.internal'" | tee ~/.bash_aliases > /dev/null

RUN mkdir /aws && cd /aws
WORKDIR /aws

# sam local start-api --host 0.0.0.0 --container-host host.docker.internal
# https://github.com/aws/aws-sam-cli/issues/2436#issuecomment-827950506

CMD ["/bin/bash"]