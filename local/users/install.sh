#!/bin/sh

useradd vasko
echo vasko:rabbit | chpasswd
echo "Do not forget to change the password for vasko"
