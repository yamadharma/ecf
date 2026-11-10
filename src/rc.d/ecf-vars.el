;;; ecf-vars.el --- ecf global variables  -*- lexical-binding: t; coding: utf-8-unix; -*-

;; Version:         1.0.0
;; Package-Requires: ((emacs "24.3"))
;; Keywords:        convenience, setup
;; URL:             https://github.com/yamadharma/ecf
;; SPDX-License-Identifier: GPL-3.0-or-later

;; Copyright (C) 2002-2026 Dmitry S. Kulyabov

;; This file is NOT part of GNU Emacs.  Distributed under GPL-3.0-or-later,
;; same conditions as GNU Emacs.

;;; Commentary:
;;
;; Variables only — no side effects.  Loaded by `ecf-bootstrap', which
;; is loaded either by `site-start.el' (site-wide install) or by the
;; user's `early-init.el' (per-user install).
;;
;; See `ecf-prefix': set it (via `ECF_PREFIX' env var or `setq' before
;; `require') to install `ecf' anywhere other than /usr/.

;;; Code:

;;; OS / Emacs flavour predicates {{{

(defconst NATIVECOMP
  (if (fboundp 'native-comp-available-p) (native-comp-available-p)))

(defconst EMACS27+ (> emacs-major-version 26))
(defconst EMACS28+ (> emacs-major-version 27))
(defconst EMACS29+ (> emacs-major-version 28))
(defconst EMACS30+ (> emacs-major-version 29))

(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))
(defconst IS-WINDOWS (memq system-type '(cygwin windows-nt ms-dos)))
(defconst IS-BSD     (or IS-MAC (eq system-type 'berkeley-unix)))

;;}}}

;;; Win32 environment hook {{{

(when IS-WINDOWS
  (when (getenv "USERNAME")
    (setenv "USER" (downcase (getenv "USERNAME"))))
  (when (getenv "USERPROFILE")
    (setenv "HOME" (getenv "USERPROFILE"))))

;;}}}

;;; XDG Base Directory Specification {{{

(defvar xdg_data_home
  (or (getenv "XDG_DATA_HOME") (expand-file-name "~/.local/share/")))
(defvar xdg_config_home
  (or (getenv "XDG_CONFIG_HOME") (expand-file-name "~/.config/")))
(defvar xdg_data_dirs
  (getenv "XDG_DATA_DIRS"))
(defvar xdg_cache_home
  (or (getenv "XDG_CACHE_HOME") (expand-file-name "~/.cache/")))

;;}}}

;;; ECF prefix / rootpath {{{

(defvar ecf-prefix
  (or (getenv "ECF_PREFIX") "/usr/")
  "Installation prefix for `ecf'.
Defaults to \"/usr/\" for a site-wide install.
For a per-user install, set to \"~/.local/\" (or another directory)
via the `ECF_PREFIX' environment variable, or `setq' before
`(require 'ecf-vars)'.")

(defvar rootpath (expand-file-name ecf-prefix)
  "Deprecated alias for `ecf-prefix'.
Kept for compatibility with code that reads `rootpath' directly.
New code should use `ecf-prefix'.")

;;}}}

;;; ECF path variables {{{

(defvar home-cache-path
  (expand-file-name "elisp/" xdg_cache_home)
  "*Name of directory where various temporary Emacs files reside.")

(defvar ecf-home-etc-path
  (expand-file-name "ecf/" xdg_config_home)
  "*Per-user ecf config directory.")

(defvar home-data-path
  (expand-file-name "elisp/" xdg_data_home)
  "*Name of directory where various Emacs data files reside.")

(defvar ecf-etc-path
  (concat (expand-file-name ecf-prefix) "etc/ecf/")
  "*Host-wide ecf config directory.")

(defvar site-lisp-path
  (concat (expand-file-name ecf-prefix) "share/site-lisp/")
  "*Name of directory where site-wide Emacs Lisp files reside.")

(defvar ecf-site-lisp-path
  (expand-file-name "rc.d" site-lisp-path)
  "*Site-wide ecf config directory (rc.*.el files).")

(defvar desire-lisp-path
  (expand-file-name "share/emacs/site-lisp/desire" rootpath)
  "*Directory where desire and its support modules live.")

(defvar home-etc-path  xdg_config_home
  "*Home config directory.")

(defvar emacs-etc-dir  xdg_config_home
  "*Directory where Emacs-related files reside.")

;;}}}

(provide 'ecf-vars)
;;; ecf-vars.el ends here
