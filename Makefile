
prefix=/usr
SITELISPROOT=$(prefix)/share/site-lisp
SITELISP=$(SITELISPROOT)/common/packages
DESTDIR=.

INSTALL = /bin/install -c
INSTALL_DATA = ${INSTALL} -m 644


all:

install:
	mkdir -p ${DESTDIR}/$(SITELISP)
	cd src/skeleton ; \
	    cp -R * ${DESTDIR}/${SITELISPROOT}
	cd src ; \
	    cp -R rc.d ${DESTDIR}/${SITELISPROOT}
	cd src ; \
	    cp -R ecf ${DESTDIR}/${SITELISP}
	mkdir -p ${DESTDIR}/etc/ecf


