SWSS_COMMON_DIR := ../../sm/sonic-swss-common

all:
	cd $(SWSS_COMMON_DIR) && DEB_BUILD_OPTIONS="parallel=`nproc`" dpkg-buildpackage -us -uc -b && cd ../ && dpkg -i *.deb && cp *.deb /tmp/
