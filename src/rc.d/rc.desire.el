;;; rc.desire.el --- path configuration for `desire.el'  -*- lexical-binding: t; coding: utf-8-unix; -*-

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
;; Site configuration for `desire'.
;;
;; Builds `desire-load-path' from:
;;   - `ecf-site-lisp-path'     (/usr/share/site-lisp/rc.d)
;;   - `ecf-etc-path'           (/etc/ecf)
;;   - `ecf-home-etc-path'      ($XDG_CONFIG_HOME/ecf)
;; crossed with subpath list (`packages', `window-system/*',
;; `system/*', `emacs/*', `lang/*').
;;
;; This is site-admin bootstrap; it is not a `package.el' package,
;; which is why there is no `Version:' or `Package-Requires:' here.

;;; Code:

(require 'desire)
(require 'ecf-lang)

(let
    ((desire-window-system-load-path)		;; Window System
     (desire-system-load-path)			;; OS
     (desire-xe-version-load-path)		;; Emacs or Xemacs
     (desire-lang-load-path)			;; Languages
     (desire-load-subpath-list)			;; Main subdirs
     (desire-config-dir-list)			;; Main config dirs
     )

  ;; Window System
  (setq desire-window-system-load-path
	(if (null window-system)
	    (list
             "window-system/console"
	     )
	  (list
           "window-system/common"
           (concat "window-system/" (format "%s" window-system))
	   )
	  ) ;; end if
	)

  ;;; OS
  ;; (setq desire-system-load-path
  ;;   (cond
  ;;     ((eq system-type 'windows-nt)
  ;;       (list "system/w32")
  ;;     )
  ;;   ) ;; end cond
  ;; )

  (setq desire-system-load-path
	(cond
	 (IS-WINDOWS (list "system/windows"))
	 (IS-BSD (list "system/bsd"))
	 (IS-MAC (list "system/mac"))
	 ))



  ;; Emacs or Xemacs
  (setq desire-xe-version-load-path
	(if (boundp 'xemacs-logo)
	    (list
             "xemacs/common"
	     )
	  (list
           "emacs/common"
           (concat "emacs/" (format "%s" emacs-major-version))
           (concat "emacs/" (format "%s" emacs-major-version) "/" (format "%s" emacs-minor-version))
	   )
	  ) ;; end if
	)

  ;; Languages
  (setq desire-lang-load-path
	(mapcar (function (lambda (x) (concat "lang/" x))) ecf-lang-list)
	)

  ;; Main subdirs
  (setq desire-load-subpath-list
	(append
	 ;; Packages
	 (list "packages" )
	 ;; Window System
	 desire-window-system-load-path
	 ;; OS
	 desire-system-load-path
	 ;; Emacs or Xemacs
	 desire-xe-version-load-path
	 ;; Languages
	 desire-lang-load-path
	 )
	)

  ;; Main config dirs
  (setq desire-config-dir-list
	(list
	 ecf-site-lisp-path
	 ecf-etc-path
	 ecf-home-etc-path
	 )
	)

  (setq desire-load-path
	(apply 'append
	       (mapcar
		(lambda (x)
		  (mapcar
		   (lambda (y) (expand-file-name x y))
		   desire-config-dir-list
		   )
		  )
		desire-load-subpath-list
		)
	       )
	)

  (add-to-list 'auto-mode-alist
	       (cons
		(concat (regexp-quote desire-extension) "\\'")
		'emacs-lisp-mode
		)
	       )

  (setq desire-custom-theme-load-path
	(concat site-lisp-path "themes")
	)

  ) ;; end let

;;; rc.desire.el ends here
