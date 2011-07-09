;;; rc.desire.el --- path configuration for `desire.el' -*- coding: iso-2022-7bit-unix; -*-

;;; Commentary:

;;
;;  File id
;;
;;      Copyright (C)  2002-2006 Dmitry S. Kulyabov
;;      Keywords:      rc.desire
;;      Author:        Dmitry S. Kulyabov <yamadharma@gmail.com>
;;      Maintainer:    Dmitry S. Kulyabov <yamadharma@gmail.com>
;;
;;      This code is free software in terms of GNU Gen. pub. Lic. v2 or later
;;
;;  Description
;;
;;

;;; Change Log:

;;; Code:

(require 'desire)
(require 'ecf-lang)

(let
  (
    (desire-window-system-load-path)		;; Window System
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

  ;; OS
  (setq desire-system-load-path
    (cond
      ((eq system-type 'windows-nt)
        (list "system/w32")
      )
    ) ;; end cond
  )

  ;; Emacs or Xemacs    
  (setq desire-xe-version-load-path
    (if (boundp 'xemacs-logo)
      (list
        "xemacs/common"
      )
      (list
        "emacs/common"
        (concat "emacs/" (format "%s" emacs-major-version))
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

) ;; end let

;;; rc.desire.el ends here
