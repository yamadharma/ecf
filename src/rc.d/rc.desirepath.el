;;; rc.desirepath.el --- site configuration for `desirepath.el'  -*- lexical-binding: t; coding: utf-8-unix; origami-fold-style: triple-braces; -*-

;; Copyright (C) 2002-2026 Dmitry S. Kulyabov

;; This file is NOT part of GNU Emacs.  Distributed under the same
;; conditions as GNU Emacs, which are as follows:

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Commentary:
;;
;; Site configuration for `desirepath.el'.
;;
;; Sets up:
;;   - `desirepath--cache-file-prefix'  (in $XDG_CACHE_HOME/elisp)
;;   - `desirepath--cache-file-hostname-function' (default nil = no hostname)
;;   - `desirepath--compression-support'
;;   - `desirepath--load-path-root'     (main Emacs install tree)
;;   - `desirepath--load-path-ignore-regexp-extra' (ignore ecf-mule)
;;
;; Then loads `desirepath' and pushes `desire-lisp-path' on `load-path'.
;;
;; This is site-admin bootstrap; not a `package.el' package.

;;; Code:

(setq debug-on-error nil)   ;; Must be like this in batch byte compile

;; Cache file location
(custom-set-variables
 '(desirepath--cache-file-prefix
   (concat home-cache-path "ecf-load-path-cache")))

;;; Compressed lisp file support
;; (setq desirepath--compression-support 'default)
(custom-set-variables
 '(desirepath--compression-support
   'all)
 ;; '(desirepath--cache-file-postfix
 ;;   ".el.gz"
 ;; )
 )

;;  Peiodic load path syncronization watchdog
;; (setq desirepath--load-hook
;;  '(desirepath-install desirepath-install-timer)
;; )



;; Configure load path `desirepath--load-path-root'
(let
    (
     (main-xe-load-path)				;; Emacs or Xemacs main dir
     (main-site-lisp-xe-root-path)		;; Emacs or Xemacs main site-lisp root dir
     (site-lisp-xe-root-path)			;; Emacs or Xemacs site-lisp root dir
     (site-lisp-common-root-path)		;; Site-lisp common root dir
     (site-lisp-xe-packages-path)		;; Emacs or Xemacs site-lisp dir
     (site-lisp-common-packages-path)		;; Site-lisp common packages dir
     (site-lisp-system-path)			;; Site-lisp system depended dir
     )


  ;;  (setq main-xe-load-path
  ;;    (if (boundp 'xemacs-logo)
  ;;      (list
  ;;        (concat rootpath "share/xemacs/lisp")
  ;;      )
  ;;      (list
  ;;        (concat rootpath "share/emacs")  ;; FIXME??? (concat rootpath "share/emacs/" emacs-version)
  ;;      )
  ;;    )
  ;;  )

  ;; Emacs or Xemacs main dir

  (if (boundp 'xemacs-logo)
      (setq main-xe-load-path
	    (list
	     (concat rootpath "share/xemacs/lisp")
	     (concat rootpath "share/xemacs/xemacs-package")
	     (concat rootpath "share/xemacs/site-packages")
	     (concat rootpath "share/xemacs/mule-packages")
	     )
	    )
    ;; Emacs part
    (mapc
     (function
      (lambda (a)
	(if (string-match "\\([/\\]Resources[/\\]lisp$\\|[/\\]emacs[/\\][0-9]+\.[0-9]+.*[/\\]lisp$\\)"  a)
	    (setq main-xe-load-path
		  (list
		   (substring a 0 -5)))
	  t)))
     load-path))

  (setq  desirepath--core-emacs-load-path-list main-xe-load-path)

  ;; FIXME This is very dirty
  (setq main-site-lisp-xe-root-path
	(if (boundp 'xemacs-logo)
	    (list
	     (concat rootpath "share/xemacs/lisp")
	     )
	  (list
	   (concat rootpath "share/emacs/site-lisp")
	   )
	  )
	)

  ;; Emacs or Xemacs site-lisp root dir
  (setq site-lisp-xe-root-path
	(if (boundp 'xemacs-logo)
	    (expand-file-name "xemacs" site-lisp-path)
	  (expand-file-name "emacs" site-lisp-path)))

  ;; Site-lisp common root dir
  (setq site-lisp-common-root-path
	(expand-file-name "common" site-lisp-path))

  ;; Site-lisp common packages dir
  (setq site-lisp-common-packages-path
	(list
	 (expand-file-name "packages" site-lisp-common-root-path)))

  ;; Emacs or Xemacs site-lisp dir
  (setq site-lisp-xe-packages-path
	(list
	 (expand-file-name "packages" site-lisp-xe-root-path)))

  ;; Site-lisp system depended dir
  (setq site-lisp-system-path
	(cond
	 ((eq system-type 'windows-nt)
	  (list
	   (expand-file-name "win32" site-lisp-xe-root-path)
	   (expand-file-name "win32" site-lisp-common-root-path)
	   )
	  )
	 ) ;; end cond
	)


  (setq desirepath--load-path-root
	(append
	 ecf-config-load-path			;; Configuration ecf path
	 ;; main-xe-load-path				;; Emacs or Xemacs main dir
	 main-site-lisp-xe-root-path		;; Emacs or Xemacs main site-lisp root dir
	 site-lisp-xe-packages-path		;; Emacs or Xemacs site-lisp dir
	 site-lisp-common-packages-path		;; Site-lisp common packages dir
	 site-lisp-system-path			;; Site-lisp system depended dir
	 ))
  ) ;; end let

;; Ignored dirs for ecf-mule
(setq desirepath--load-path-ignore-regexp-extra
      "\\|[/\\]ecf-mule")

;; Ignored dirs for other version of emacs
;; (mapc
;; (function
;;  (lambda (a)
;;    (if (string-match a emacs-version) ()
;;      (setq desirepath--load-path-ignore-regexp-extra
;; 	    (concat
;; 	     "\\|/usr/share/emacs/" a "/site-lisp"
;; 	     desirepath--load-path-ignore-regexp-extra
;; 	     )
;;       )
;;    )
;;   )
;;  )
;;  (directory-files "/usr/share/emacs" nil "[0-9].*" nil)
;; )

;;"\\|[/\\]emacs[/\\]" a "[/\\]+"
;;"\\|[/\\]emacs[/\\]" a "[/\\]leim"

;; Ignored dirs
;; (setq desirepath--load-path-ignore-regexp-extra
;;  (concat
;;    "\\|[/\\]lisp[/\\]language"
;;    "\\|[/\\]auctex"
;;    desirepath--load-path-ignore-regexp-extra
;;  )
;; )

(setq desirepath--load-path-ignore-regexp-extra
      (concat
       "\\|[/\\]lisp[/\\]language"
       "\\|[/\\]lisp[/\\]cedet"
       desirepath--load-path-ignore-regexp-extra))

;; "\\|21\\.4[/\\]"
;; "\\|/usr/share/emacs/23\\.0\\.0/site-lisp"
;;    "\\|[/\\]quail"
;;    "\\|[/\\]flim"
;;    "\\|[/\\]wl"

;; `desirepath' load
(require 'cl-lib)
(cl-pushnew desire-lisp-path load-path :test 'string=)
(load "desirepath")

;;; rc.desirepath.el ends here
