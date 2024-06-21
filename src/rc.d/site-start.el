;;; -*- mode: emacs-lisp; lexical-binding: t; coding: utf-8-unix; origami-fold-style: triple-braces; -*-
;;; site-start.el 

;;; Commentary:

;;
;;  File id
;;
;;      Copyright (C)  2002-2024 Dmitry S. Kulyabov
;;      Keywords:      site-start
;;      Author:        Dmitry S. Kulyabov <yamadharma@gmail.com>
;;      Maintainer:    Dmitry S. Kulyabov <yamadharma@gmail.com>
;;
;;      This code is free software in terms of GNU Gen. pub. Lic. v3 or later
;;
;;  Description
;;
;;

;;; Change Log:

;;; Code:

;;; Variables

(defconst NATIVECOMP (if (fboundp 'native-comp-available-p) (native-comp-available-p)))
(defconst EMACS27+   (> emacs-major-version 26))
(defconst EMACS28+   (> emacs-major-version 27))
(defconst EMACS29+   (> emacs-major-version 28))
(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))
(defconst IS-WINDOWS (memq system-type '(cygwin windows-nt ms-dos)))
(defconst IS-BSD     (or IS-MAC (eq system-type 'berkeley-unix)))

;;{{{ Win32 environment hook

(if (eq system-type 'windows-nt)
  (progn
    (setenv "USER" (downcase (getenv "USERNAME")))
    (setenv "HOME" (getenv "USERPROFILE"))))

;;}}}
;;{{{ Global Variables

;;{{{ XDG Base Directory Specification
;; http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html

(defvar xdg_data_home
  (or (getenv "XDG_DATA_HOME") (expand-file-name "~/.local/share/")))

(defvar xdg_config_home
  (or (getenv "XDG_CONFIG_HOME") (expand-file-name "~/.config/")))

;(defvar xdg_data_dirs
;  (getenv "XDG_DATA_DIRS")
;)

(defvar xdg_cache_home
  (or (getenv "XDG_CACHE_HOME") (expand-file-name "~/.cache/")))

;;}}}

(defvar rootpath
  (expand-file-name "/usr/")
  "*Name of emacs prefix directory.")

(defvar home-cache-path
  (expand-file-name "elisp/" xdg_cache_home)
  "*Name of directory where various temporal emacs related files reside.")

(defvar ecf-home-etc-path
  (expand-file-name "ecf/" xdg_config_home)
  "*Name ecf config files directory.")

(defvar home-data-path
  (expand-file-name "elisp/" xdg_data_home)
  "*Name of directory where various temporal emacs related files reside.")

(defvar ecf-etc-path
    "/etc/ecf/"
    "*Host-wide ecf config files directory.")

(defvar site-lisp-path
  (concat rootpath "share/site-lisp/")
  "*Name of directory where various emacs related site-wide files reside.")

(defvar ecf-site-lisp-path
  (expand-file-name "rc.d" site-lisp-path)
  "*Site-wide ecf config files directory.")

(defvar desire-lisp-path
  ;; (expand-file-name "common/packages/ecf/tiny" site-lisp-path)
  (expand-file-name "share/emacs/site-lisp/desire" rootpath)
  "*Name of directory where desire reside.")

(defvar home-etc-path
  xdg_config_home
  "*Name home config files directory.")

(defvar emacs-etc-dir
  xdg_config_home
  "*Name of directory where various emacs related files reside.")

;;}}}
;;{{{ Prepare needed dirs

(if (not (file-directory-p home-cache-path))
    (make-directory home-cache-path t))

(if (not (file-directory-p home-data-path))
    (make-directory home-data-path t))

(if (not (file-directory-p emacs-etc-dir))
    (make-directory emacs-etc-dir t))

(if (not (file-directory-p "~/tmp"))
    (make-directory "~/tmp" t))

;;}}}

;;; Set eln-cache dir
(when (boundp 'native-comp-eln-load-path)
  (startup-redirect-eln-cache (expand-file-name "eln/" home-cache-path)))

;;{{{ Desirepath load

;; Search user, host-wide, site-wide configs

(setq ecf-config-load-path
  (list
    ecf-home-etc-path
    ecf-etc-path
    ecf-site-lisp-path))

(setq load-path
  (append
    ecf-config-load-path
    load-path))

(load "rc.desirepath")

;;}}}
;;{{{ Desire load

;; Directory order hack
(setq load-path
  (append
    ecf-config-load-path
    load-path))

(load "rc.desire")

;;}}}

;;;  end of site-start.el
