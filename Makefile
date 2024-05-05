# Makefile

.PHONY: all install clean clean-purge

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

clean-cache: postinstall
	rm -rf "${HOME}/.cache/thumbnails/"*