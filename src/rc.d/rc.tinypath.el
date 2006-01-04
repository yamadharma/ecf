;;; rc.tinypath.el --- tinypath configuration -*- coding: iso-2022-7bit-unix; -*-

;;; Commentary:

;;
;;  File id
;;
;;      Copyright (C)  2002-2004 Dmitry S. Kulyabov
;;      Keywords:      tinypath
;;      Author:        Dmitry S. Kulyabov
;;      Maintainer:    Dmitry S. Kulyabov <dharma@mx.pfu.edi.ru>
;;
;;      This code is free software in terms of GNU Gen. pub. Lic. v2 or later
;;
;;  Description
;;
;;

;;; Change Log:

;;; Code:

(require 'cl)

(setq debug-on-error nil)   ;; Must be like this in batch byte compile

(autoload 'ti::package-autoload-create-on-file            "tinylib")
(autoload 'ti::package-autoload-loaddefs-build-recursive  "tinylib")

;; Cache file location
(custom-set-variables
  '(tinypath-:cache-file-prefix
    (concat home-cache-path "emacs-config-tinypath-cache")
  )
)

;; Disable HOST part in cache file name
; (setq tinypath-:cache-file-hostname-function nil)

;; Compressed lisp file support
;(custom-set-variables
;  '(tinypath-:compression-support 
;    'all
;  )
;  '(tinypath-:cache-file-postfix
;    ".el.gz"
;  )
;)


;; Configure load path `tinypath-:load-path-root'
(let 
  (
    (main-xe-load-path)				;; Emacs or Xemacs main dir
    (site-lisp-xe-root-path)			;; Emacs or Xemacs site-lisp root dir
    (site-lisp-common-root-path)		;; Site-lisp common root dir
    (site-lisp-xe-packages-path)		;; Emacs or Xemacs site-lisp dir
    (site-lisp-common-packages-path)	        ;; Site-lisp common packages dir
    (site-lisp-system-path)			;; Site-lisp system depended dir
  )

  ;; Emacs or Xemacs main dir
  (setq main-xe-load-path
    (if (boundp 'xemacs-logo)          
      (list 
        (concat rootpath "share/xemacs/lisp")
      )
      (list	
        (concat rootpath "share/emacs")  ;; FIXME??? (concat rootpath "share/emacs/" emacs-version)          
      )
    )
  ) 
  
  ;; Emacs or Xemacs site-lisp root dir
  (setq site-lisp-xe-root-path
    (if (boundp 'xemacs-logo)
      (concat site-lisp-path "xemacs")
      (concat site-lisp-path "emacs")
    )
  ) 
  
  ;; Site-lisp common root dir
  (setq site-lisp-common-root-path
    (expand-file-name "common" site-lisp-path)
  )
  
  ;; Site-lisp common packages dir
  (setq site-lisp-common-packages-path
    (list
      (expand-file-name "packages" site-lisp-common-root-path)
    )
  )    
  
  ;; Emacs or Xemacs site-lisp dir   
  (setq site-lisp-xe-packages-path
    (list
      (expand-file-name "packages" site-lisp-xe-root-path)
    )
  )    

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


  (setq tinypath-:load-path-root
    (append
      ecf-config-load-path			;; Configuration ecf path
      main-xe-load-path				;; Emacs or Xemacs main dir
      site-lisp-xe-packages-path		;; Emacs or Xemacs site-lisp dir
      site-lisp-common-packages-path	        ;; Site-lisp common packages dir
      site-lisp-system-path			;; Site-lisp system depended dir
    )
  )


) ;; end let

;; Ignored dirs for ecf-mule
(setq tinypath-:load-path-ignore-regexp-extra
    "\\|[/\\]ecf-mule"
)

;; Ignored dirs
(setq tinypath-:load-path-ignore-regexp-extra
  (concat
    "\\|[/\\]lisp[/\\]language"
    "\\|[/\\]auctex"
    tinypath-:load-path-ignore-regexp-extra
  )
)

;    "\\|[/\\]quail"
;    "\\|[/\\]flim"
;    "\\|[/\\]wl"    

;; `tinypath' load
(pushnew tiny-path-lisp-path load-path)

(load "tinypath")

;;; rc.tinypath.el ends here

