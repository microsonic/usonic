.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e
LIBTEAM_DIR := ../../sm/libteam

all:

	rm -rf ./libteam
	git clone https://github.com/jpirko/libteam.git
	pushd ./libteam 
	git checkout -b teamd -f c7237377dead39ae4a711297203bacf7edb9fa41

	# Apply patch series
	stg init
	stg import -s ../patch/series
	popd

	# Obtain debian packaging
	git clone https://salsa.debian.org/debian/libteam.git tmp
	pushd ./tmp
	git checkout -f debian/1.30-1
	popd

	mv tmp/debian libteam/
	rm -rf tmp
	
