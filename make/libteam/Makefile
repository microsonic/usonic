LIBTEAM_DIR := ../../sm/libteam

all:
	cd $(LIBTEAM_DIR) && make all
	cd $(LIBTEAM_DIR) && dpkg-buildpackage -us -uc -b && cd ../ && dpkg -i *.deb && cp *.deb /tmp/
        

