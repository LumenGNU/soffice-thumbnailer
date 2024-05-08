# Makefile

.PHONY: all install clean clean-cache deb

all: install postinstall

install: /usr/share/thumbnailers/soffice.thumbnailer /usr/local/bin/soffice_thumbnailer

/usr/share/thumbnailers/soffice.thumbnailer: soffice.thumbnailer
	sudo cp $< $@

/usr/local/bin/soffice_thumbnailer: soffice_thumbnailer
	sudo cp $< $@
	sudo chmod +x $@

postinstall:
	-nautilus -q
	-nemo -q
	-caja -q
	rm -rf "${HOME}/.cache/thumbnails/fail"

clean:
	sudo rm -f /usr/share/thumbnailers/soffice.thumbnailer
	sudo rm -f /usr/local/bin/soffice_thumbnailer
	rm -f soffice-thumbnailer.deb
	rm -rf soffice-thumbnailer

clean-cache: postinstall
	rm -rf "${HOME}/.cache/thumbnails/"*

deb: soffice.thumbnailer soffice_thumbnailer control postinst
	mkdir -p soffice-thumbnailer/DEBIAN
	cp control soffice-thumbnailer/DEBIAN/
	cp postinst soffice-thumbnailer/DEBIAN/
	chmod a+x soffice-thumbnailer/DEBIAN/postinst
	mkdir -p soffice-thumbnailer/usr/local/bin/
	cp soffice_thumbnailer soffice-thumbnailer/usr/local/bin/
	mkdir -p soffice-thumbnailer/usr/share/thumbnailers/
	cp soffice.thumbnailer soffice-thumbnailer/usr/share/thumbnailers/
	dpkg-deb --build soffice-thumbnailer
	rm -rf soffice-thumbnailer