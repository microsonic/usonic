LIBTEAM_DIR := ../../sm/libteam/libteam/

all:
	cd $(LIBTEAM_DIR) && git config --global user.email "BPraveen@palcnetworks.com"
	cd $(LIBTEAM_DIR) && stg init
	cd $(LIBTEAM_DIR) && stg import -s ../patch/series

	cd $(LIBTEAM_DIR) && dpkg-buildpackage -us -uc -b && cd ../ && dpkg -i *.deb && cp *.deb /tmp/
        

