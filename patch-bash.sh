#!/bin/sh
# Quick and dirty fix to patch bash.  Make sure you have GCC installed.
# -Radar

mkdir src
cd src
wget http://ftp.gnu.org/gnu/bash/bash-4.3.tar.gz
#download all patches
for i in $(seq -f "%03g" 0 25); do wget     http://ftp.gnu.org/gnu/bash/bash-4.3-patches/bash43-$i; done
tar zxvf bash-4.3.tar.gz 
cd bash-4.3
#apply all patches
for i in $(seq -f "%03g" 0 25);do patch -p0 < ../bash43-$i; done
#build and install
./configure && make && make install
cd .. 
cd ..
rm -r src

#do a little test.  If it doesn't print "vulnerable", you're good.

env x='() { :;}; echo vulnerable' bash -c "echo this is a test"
