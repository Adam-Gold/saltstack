#!/bin/bash
sed -i '/munin:.*/d' /etc/passwd
sed -i '/munin:.*/d' /etc/group
sed -i 's/^munin-async:/munin:/g' /etc/passwd
sed -i 's/^munin-async:/munin:/g' /etc/group
