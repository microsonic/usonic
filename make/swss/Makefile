SWSS_DIR := ../../sm/sonic-swss

all:
	cd $(SWSS_DIR) && dpkg-buildpackage -us -uc -b && cd ../ && dpkg -i *.deb && cp *.deb /tmp/
