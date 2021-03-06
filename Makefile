
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
	mkdir -p ${DESTDIR}/$(prefix)/bin
	cp other/bin/* ${DESTDIR}/$(prefix)/bin
	mkdir -p ${DESTDIR}/${SITELISP}/ecf/other
	cp other/lisp/* ${DESTDIR}/${SITELISP}/ecf/other
	mkdir -p ${DESTDIR}/${SITELISP}/ecf/tiny
	cp other/tiny/* ${DESTDIR}/${SITELISP}/ecf/tiny
	mkdir -p ${DESTDIR}/${SITELISP}/themes
	cp other/themes/* ${DESTDIR}/${SITELISP}/themes


