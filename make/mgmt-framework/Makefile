MGMT_FRAMEWORK_DIR := ../../sm/sonic-mgmt-framework
MGMT_COMMON_DIR := ../../sm/sonic-mgmt-common

all:
	cd $(MGMT_COMMON_DIR) && dpkg-buildpackage -us -uc -b && cd ../ && dpkg -i *.deb && cp *.deb /tmp/
	cd $(MGMT_FRAMEWORK_DIR) && dpkg-buildpackage -us -uc -b && cd ../ && dpkg -i *.deb && cp *.deb /tmp/
