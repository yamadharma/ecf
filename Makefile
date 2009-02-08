
prefix=/usr
SITELISPROOT=$(prefix)/share/site-lisp
SITELISP=$(SITELISPROOT)/common/packages
DESTDIR=.

INSTALL = /bin/install -c
INSTALL_DATA = ${INSTALL} -m 644


all:

install:
	mkdir -p ${DESTDIR}/$(SITELISP)
	cp -R src/skeleton/* ${DESTDIR}/${SITELISPROOT}
	cp -R src/rc.d ${DESTDIR}/${SITELISPROOT}
	cp -R src/ecf ${DESTDIR}/${SITELISP}
	mkdir -p ${DESTDIR}/etc/ecf
	mkdir ${DESTDIR}/$(prefix)/bin
	cp other/bin/* ${DESTDIR}/$(prefix)/bin
