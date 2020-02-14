SAIREDIS_DIR := ../../sm/sonic-sairedis

all: step1 step2

# step1 builds meta library, redis SAI library and VS SAI library
# change SONAME of VS SAI library so that it can be used as a normal SAI library
step1:
	cp control.1 $(SAIREDIS_DIR)/debian/control
	cp rules.1 $(SAIREDIS_DIR)/debian/rules
	cd $(SAIREDIS_DIR) && dpkg-buildpackage -us -uc -b && cd ../ && dpkg -i *.deb && cp *.deb /tmp/
	patchelf --set-soname libsai.so /usr/lib/x86_64-linux-gnu/libsaivs.so.0.0.0
	cd /usr/lib/x86_64-linux-gnu/ && ln -sf libsaivs.so libsai.so

# step2 builds the syncd package without VS option enabled
# the syncd executable links to libsai.so which is actually libsaivs.so
step2:
	cp control.2 $(SAIREDIS_DIR)/debian/control
	cp rules.2 $(SAIREDIS_DIR)/debian/rules
	cp syncd.install $(SAIREDIS_DIR)/debian/syncd.install
	cd $(SAIREDIS_DIR) && dpkg-buildpackage -us -uc -b && cd ../ && dpkg -i *.deb && cp *.deb /tmp/
