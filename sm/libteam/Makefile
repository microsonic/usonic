.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e
LIBTEAM_DIR := ../../sm/libteam

all:

	rm -rf ./libteam
	git clone https://github.com/jpirko/libteam.git
	pushd ./libteam 
	git checkout -b teamd -f 5c5e498bff9
	popd

	# Obtain debian packaging
	git clone https://salsa.debian.org/debian/libteam.git tmp
	pushd ./tmp
	git checkout -f 7188c361
	popd

	mv tmp/debian libteam/
	rm -rf tmp
	
