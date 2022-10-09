#!/bin/bash

for i in $(ls /tmp/*.acsm); do /usr/bin/knock $i; done