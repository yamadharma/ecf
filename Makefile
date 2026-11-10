# --- Common ---
DESTDIR ?=
prefix  ?= /usr

# Site-wide defaults
SITELISPROOT    = $(prefix)/share/site-lisp
EMACS_SITELISP  = $(prefix)/share/emacs/site-lisp

# User-local defaults
USER_PREFIX     = $(HOME)/.local
USER_SITELISP   = $(USER_PREFIX)/share/emacs/site-lisp
USER_ECF_DIR    = $(USER_SITELISP)/ecf
USER_RC_D       = $(USER_PREFIX)/share/site-lisp/rc.d
USER_DESIRE_DIR = $(USER_SITELISP)/desire

.PHONY: install install-site install-user uninstall-user

install: install-site

# ---------------------------------------------------------------------------
# Site-wide (requires root)
# ---------------------------------------------------------------------------
install-site:
	@echo "==> Installing ecf site-wide to $(DESTDIR)$(prefix)"
	mkdir -p $(DESTDIR)$(EMACS_SITELISP)
	mkdir -p $(DESTDIR)$(SITELISPROOT)/rc.d

	# ecf-vars + ecf-bootstrap + site-start: next to each other,
	# so (require 'ecf-vars) / (require 'ecf-bootstrap) work.
	cp src/ecf-vars.el      $(DESTDIR)$(EMACS_SITELISP)/
	cp src/ecf-bootstrap.el $(DESTDIR)$(EMACS_SITELISP)/
	cp src/site-start.el    $(DESTDIR)$(EMACS_SITELISP)/

	# rc.* configuration
	cp src/rc.d/*.el        $(DESTDIR)$(SITELISPROOT)/rc.d/

	# desire package + support modules
	cp src/desire/*.el      $(DESTDIR)$(EMACS_SITELISP)/desire/
	cp src/desire/ecf-mule/*.el $(DESTDIR)$(EMACS_SITELISP)/desire/ecf-mule/

# ---------------------------------------------------------------------------
# Per-user install (no root required)
#
# Default prefix: ~/.local/
# Override:       make install-user USER_PREFIX=/some/where
# Or env var:     ECF_USER_PREFIX=/some/where make install-user
# ---------------------------------------------------------------------------

USER_PREFIX ?= $(HOME)/.local
USER_ECF_DIR     = $(USER_PREFIX)/share/emacs/site-lisp/ecf
USER_DESIRE_DIR  = $(USER_PREFIX)/share/emacs/site-lisp/desire
USER_RC_D_DIR    = $(USER_PREFIX)/share/site-lisp/rc.d

.PHONY: install-user uninstall-user check-user

install-user:
	@echo "==> Installing ecf per-user to $(USER_PREFIX)"
	mkdir -p $(USER_ECF_DIR)
	mkdir -p $(USER_DESIRE_DIR)/ecf-mule
	mkdir -p $(USER_RC_D_DIR)

	# ecf-user-bootstrap.el (this file's install target).
	cp src/ecf-user-bootstrap.el $(USER_ECF_DIR)/

	# desire package + support modules.
	cp src/desire/*.el             $(USER_DESIRE_DIR)/
	cp src/desire/ecf-mule/*.el    $(USER_DESIRE_DIR)/ecf-mule/

	# rc.d configuration files.
	cp src/rc.d/*.el               $(USER_RC_D_DIR)/

	@echo
	@echo "==> Done.  Add to your ~/.config/emacs/early-init.el:"
	@echo
	@echo "  (add-to-list 'load-path"
	@echo "               (expand-file-name \"$(USER_ECF_DIR)\"))"
	@echo "  (require 'ecf-user-bootstrap)"
	@echo
	@echo "Then in your ~/.config/emacs/init.el, after user init runs:"
	@echo
	@echo "  (load \"rc.packages\")"
	@echo
	@echo "See $(USER_ECF_DIR)/ecf-user-bootstrap.el for details."
	@echo "To override the install prefix at runtime, set"
	@echo "  (setenv \"ECF_USER_PREFIX\" ...)"
	@echo "in early-init.el *before* the require."

uninstall-user:
	@echo "==> Removing per-user ecf install from $(USER_PREFIX)"
	rm -rf $(USER_ECF_DIR)
	rm -rf $(USER_DESIRE_DIR)
	rm -rf $(USER_RC_D_DIR)
	@echo
	@echo "Remove the (require 'ecf-user-bootstrap) line from"
	@echo "~/.config/emacs/early-init.el manually."

check-user:
	@echo "==> Checking per-user ecf install under $(USER_PREFIX)"
	@fail=0; \
	for f in \
	  share/emacs/site-lisp/ecf/ecf-user-bootstrap.el \
	  share/emacs/site-lisp/desire/desire.el \
	  share/emacs/site-lisp/desire/desire-straight.el \
	  share/emacs/site-lisp/desire/desire-quelpa.el \
	  share/emacs/site-lisp/desire/desirepath.el \
	  share/emacs/site-lisp/desire/ecf-lang.el \
	  share/emacs/site-lisp/desire/ecf-mule.el \
	  share/site-lisp/rc.d/rc.desirepath.el \
	  share/site-lisp/rc.d/rc.desire.el ; do \
	  if [ ! -f "$(USER_PREFIX)/$$f" ]; then \
	    echo "  MISSING: $(USER_PREFIX)/$$f"; fail=1; \
	  fi; \
	done; \
	if [ $$fail -ne 0 ]; then \
	  echo "check-user: FAILED"; exit 1; \
	fi; \
	echo "check-user: OK"
