
# kytay/dnsmasq-focal

## Introduction
Build a custom ubuntu:focal based dnsmasq.
Configured to use "Asia/Singapore" TimeZone.
Refer to dnsmasq-sample.conf for recommended configurations.

## Get Source
https://github.com/kytay/public-dockerfiles/tree/main/app/kytay_dnsmasq-focal

## Reference
https://thekelleys.org.uk/dnsmasq/doc.html
https://blog.csainty.com/2016/09/running-dnsmasq-in-docker.html
https://computingforgeeks.com/install-and-configure-dnsmasq-on-ubuntu/
https://www.howtoforge.com/how-to-setup-local-dns-server-using-dnsmasq-on-ubuntu-20-04/
https://qiita.com/bmj0114/items/9c24d863bcab1a634503

## Example

### To build image

```bash
docker build -t kytay/dnsmasq-focal .
```

### To run container.

```bash
docker run --name dnsmasq \
--cap-add=NET_ADMIN --net=host \
-v $(pwd)/dnsmasq-sample.conf:/etc/dnsmasq.conf \
kytay/dnsmasq-focal
```