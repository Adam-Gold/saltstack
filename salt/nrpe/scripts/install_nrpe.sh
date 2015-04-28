#!/bin/bash
./configure --enable-ssl --enable-command-args
make all
make install-plugin
make install-daemon
