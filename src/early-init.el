;; ~/.config/emacs/early-init.el
(setq load-prefer-newer t)
(add-to-list 'load-path (expand-file-name "~/.local/share/emacs/site-lisp/ecf"))
(require 'ecf-bootstrap)
