# Emacs Configuration Framework

## Repositories

- <https://github.com/yamadharma/ecf>
- <https://gitverse.ru/dharma/ecf>
- <https://sourcecraft.dev/yamadharma/ecf>

## Installation

### Site-wide (system administrator)

    sudo make install

This installs:
  - `/usr/share/emacs/site-lisp/ecf-vars.el`
  - `/usr/share/emacs/site-lisp/ecf-bootstrap.el`
  - `/usr/share/emacs/site-lisp/site-start.el`
  - `/usr/share/site-lisp/rc.d/rc.*.el`

Emacs loads `site-start.el` automatically from `/usr/share/emacs/site-lisp/`.
No user configuration needed.

### Per-user (no root)

    make install-user

This installs to `~/.local/share/...`.  Add to `~/.config/emacs/early-init.el`:

    (add-to-list 'load-path (expand-file-name "~/.local/share/emacs/site-lisp/ecf"))
    (require 'ecf-bootstrap)

`ecf-bootstrap` is idempotent: if Emacs already loaded it via
`site-start.el`, the second `require` is a no-op.

### Mixing site-wide and user-local

If `ecf` is installed site-wide but you want your own `rc.d/` and
`desire/` (per-user overrides), set `ECF_PREFIX` in `early-init.el`
*before* loading `ecf-bootstrap`:

    (setenv "ECF_PREFIX" (expand-file-name "~/.local/"))
    (add-to-list 'load-path (expand-file-name "~/.local/share/emacs/site-lisp/ecf"))
    (require 'ecf-bootstrap)

`ecf-bootstrap` prefers the first `load-path` entry, so your per-user
`ecf-vars.el` shadows the site-wide one; all paths (`ecf-etc-path`,
`site-lisp-path`, `ecf-site-lisp-path`, `desire-lisp-path`) follow
`ecf-prefix`.
