#!/bin/bash
while read -r line; do printf %s "$line" | sha256sum | cut -f1 -d' '; done < list.txt >>list_out.txt
# sudo rm -rf list.txt
# sudo rm -rf list_out.txt