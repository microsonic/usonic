MGMT_FRAMEWORK_DIR := ../../sm/sonic-mgmt-framework

all:
	cd $(MGMT_FRAMEWORK_DIR) && dpkg-buildpackage -us -uc -b && cd ../ && dpkg -i *.deb && cp *.deb /tmp/
