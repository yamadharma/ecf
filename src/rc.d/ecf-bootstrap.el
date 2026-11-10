;;; ecf-bootstrap.el --- bootstrap ecf  -*- lexical-binding: t; coding: utf-8-unix; -*-

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
;; Bootstrap for ecf: sets up directories, extends `load-path', and
;; loads `rc.desirepath' and `rc.desire'.
;;
;; Loaded via `require' from `site-start.el' (site-wide install) or
;; from the user's `early-init.el' (per-user install).  Idempotent:
;; `require' guards against double-loading.

;;; Code:

(require 'ecf-vars)

;;; Prepare needed directories {{{

(dolist (dir (list home-cache-path home-data-path emacs-etc-dir "~/tmp"))
  (unless (file-directory-p dir)
    (make-directory dir t)))

;;}}}

;;; Native-comp eln-cache {{{

(when (boundp 'native-comp-eln-load-path)
  (startup-redirect-eln-cache
   (expand-file-name "eln/" home-cache-path)))

;;}}}

;;; Extend load-path with ecf config dirs {{{

(defvar ecf-config-load-path
  (list ecf-home-etc-path ecf-etc-path ecf-site-lisp-path)
  "Directories searched for ecf configuration (rc.* and .ecf).
Order: user, host-wide, site-wide.  Used by `rc.desire'.")

(dolist (dir ecf-config-load-path)
  (add-to-list 'load-path dir))

;;}}}

;;; Load rc.desirepath and rc.desire {{{

;; rc.desirepath sets up `desirepath' (load-path scanning and cache).
;; rc.desire sets up `desire' (declarative package configuration) and
;; builds `desire-load-path' from ecf-site-lisp-path, ecf-etc-path,
;; ecf-home-etc-path.

(require 'rc-desirepath nil t)   ; prefer feature if provided
(unless (featurep 'rc-desirepath)
  (load "rc.desirepath" nil t))

(require 'rc-desire nil t)
(unless (featurep 'rc-desire)
  (load "rc.desire" nil t))

;;}}}

(provide 'ecf-bootstrap)
;;; ecf-bootstrap.el ends here
