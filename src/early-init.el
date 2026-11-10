;; ~/.config/emacs/early-init.el
(setq load-prefer-newer t)
;; Обязательно: включить ecf-user-bootstrap
(add-to-list 'load-path
             (expand-file-name "~/.local/share/emacs/site-lisp/ecf"))
(require 'ecf-user-bootstrap)

;; Опционально: другой prefix
;; (setenv "ECF_USER_PREFIX" (expand-file-name "~/ecf/"))
