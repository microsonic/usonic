SWSS_DIR := ../../sm/sonic-swss

all:
	cd $(SWSS_DIR) && DEB_BUILD_OPTIONS="parallel=`nproc`" dpkg-buildpackage -us -uc -b && cd ../ && dpkg -i *.deb && cp *.deb /tmp/
