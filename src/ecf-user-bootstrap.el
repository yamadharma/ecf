;;; ecf-user-bootstrap.el --- per-user bootstrap for ecf  -*- lexical-binding: t; coding: utf-8-unix; -*-

;; Version:         1.0.0
;; Package-Requires: ((emacs "24.3"))
;; Keywords:        convenience, setup
;; URL:             https://github.com/yamadharma/ecf
;; SPDX-License-Identifier: GPL-3.0-or-later

;; Copyright (C) 2002-2025 Dmitry S. Kulyabov

;; This file is NOT part of GNU Emacs.  Distributed under GPL-3.0-or-later,
;; same conditions as GNU Emacs.

;;; Commentary:
;;
;; Per-user bootstrap for `ecf'.
;;
;; Installation:
;;
;;   make install-user                    # defaults to ~/.local/
;;   make install-user USER_PREFIX=~/ecf/ # custom prefix
;;
;; Then add to `~/.config/emacs/early-init.el':
;;
;;   (add-to-list 'load-path
;;                (expand-file-name "~/.local/share/emacs/site-lisp/ecf"))
;;   (require 'ecf-user-bootstrap)
;;
;; Optional override of the install prefix (before the `require'):
;;
;;   (setenv "ECF_USER_PREFIX" (expand-file-name "~/ecf/"))
;;
;; What this file does:
;;
;;   1. Prepends `~/.local/share/site-lisp/rc.d' to `load-path', so
;;      user-local `rc.*.el' files shadow any site-wide ones.
;;
;;   2. Loads `rc.desirepath' and `rc.desire' from user-local paths if
;;      the site-wide `site-start.el' has not already provided them.
;;
;;   3. Once `desire' is loaded (by us, by `site-start.el', or by the
;;      user directly), prepends user-local counterparts of every
;;      `desire-load-path' entry:
;;
;;        ~/.local/share/site-lisp/rc.d/packages/
;;        ~/.local/share/site-lisp/rc.d/lang/ru/
;;        ...
;;
;;      Site-wide entries stay in the list as fallbacks.  A user-local
;;      `packages/org/desire.ecf' therefore overrides
;;      `/usr/share/site-lisp/rc.d/packages/org/desire.ecf'.
;;
;; The file is idempotent: calling `(require 'ecf-user-bootstrap)'
;; twice is a no-op.

;;; Code:

(require 'cl-lib)

;;; ----------------------------------------------------------------------
;;; User-local paths

(defvar ecf-user-prefix
  (file-name-as-directory
   (or (getenv "ECF_USER_PREFIX")
       (expand-file-name "~/.local/")))
  "Per-user install prefix for `ecf'.
Default \"~/.local/\".  Override via the `ECF_USER_PREFIX'
environment variable, or via `make install-user USER_PREFIX=...'.")

(defvar ecf-user-site-lisp
  (expand-file-name "share/site-lisp/" ecf-user-prefix)
  "Per-user `site-lisp' root.")

(defvar ecf-user-rc-d
  (expand-file-name "rc.d" ecf-user-site-lisp)
  "Per-user `rc.d' directory with `rc.*.el' and `*.ecf' files.")

(defvar ecf-user-desire
  (expand-file-name "share/emacs/site-lisp/desire" ecf-user-prefix)
  "Per-user directory with the `desire' package and support modules.")

(defvar ecf-user-bootstrap-dir
  (expand-file-name "share/emacs/site-lisp/ecf" ecf-user-prefix)
  "Per-user directory containing this file.")

;;; ----------------------------------------------------------------------
;;; load-path: prepend user-local rc.d (idempotent)

(setq load-path
      (cons ecf-user-rc-d (delete ecf-user-rc-d load-path)))

;;; ----------------------------------------------------------------------
;;; desirepath / desire: load from user-local, or reuse site-wide

(unless (featurep 'desirepath)
  (condition-case err
      (load (expand-file-name "rc.desirepath" ecf-user-rc-d) nil t)
    (error
     (display-warning
      'ecf-user-bootstrap
      (format "Failed to load rc.desirepath from %s: %s"
              ecf-user-rc-d (error-message-string err))
      :warning))))

(unless (featurep 'desire)
  (condition-case err
      (load (expand-file-name "rc.desire" ecf-user-rc-d) nil t)
    (error
     (display-warning
      'ecf-user-bootstrap
      (format "Failed to load rc.desire from %s: %s"
              ecf-user-rc-d (error-message-string err))
      :warning))))

;;; ----------------------------------------------------------------------
;;; desire-load-path: prepend user-local counterparts

(defun ecf-user--update-desire-load-path ()
  "Prepend user-local counterparts to `desire-load-path'.
For every `<site>/<sub>' entry in `desire-load-path' that has a
counterpart under `ecf-user-rc-d', move the user-local entry to the
front.  Idempotent."
  (when (boundp 'desire-load-path)
    (let ((subpaths
           (if (boundp 'desire-load-subpath-list)
               desire-load-subpath-list
             ;; Fallback if `rc.desire' did not define it:
             '("packages"
               "window-system/console"
               "emacs/common"
               "lang/ru"
               "lang/utf-8"))))
      (dolist (sub (reverse subpaths))
        (let ((user-dir (expand-file-name sub ecf-user-rc-d)))
          (when (file-directory-p user-dir)
            ;; `cons' after `delete' always puts it first, even if it
            ;; was already present elsewhere; keeps the call idempotent.
            (setq desire-load-path
                  (cons user-dir (delete user-dir desire-load-path)))))))))

;; Run now if `desire' is already loaded, otherwise once it is.
(if (featurep 'desire)
    (ecf-user--update-desire-load-path)
  (eval-after-load 'desire
    '(ecf-user--update-desire-load-path)))

;;; ----------------------------------------------------------------------

(provide 'ecf-user-bootstrap)

;;; ecf-user-bootstrap.el ends here
