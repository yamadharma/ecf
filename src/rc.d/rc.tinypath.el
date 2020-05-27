;;; rc.tinypath.el --- tinypath configuration -*- coding: iso-2022-7bit-unix; -*-

;;; Commentary:

;;
;;  File id
;;
;;      Copyright (C)  2002-2006 Dmitry S. Kulyabov
;;      Keywords:      tinypath
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

;(require 'cl-lib)

(setq debug-on-error nil)   ;; Must be like this in batch byte compile

;(autoload 'ti::package-autoload-create-on-file            "tinylib")
;(autoload 'ti::package-autoload-loaddefs-build-recursive  "tinylib")

;; Cache file location
(custom-set-variables
  '(tinypath--cache-file-prefix
    (concat home-cache-path "/emacs-config-tinypath-cache")
  )
)

;; Disable HOST part in cache file name
; (setq tinypath--cache-file-hostname-function nil)
;(setq tinypath--cache-file-hostname-function 'tinypath-cache-file-hostname)

;; Compressed lisp file support
; (setq tinypath--compression-support 'default)
(custom-set-variables
  '(tinypath--compression-support
    'all
  )
;  '(tinypath--cache-file-postfix
;    ".el.gz"
;  )
)

;;  Peiodic load path syncronization watchdog
; (setq tinypath--load-hook
;  '(tinypath-install tinypath-install-timer)
; )



;; Configure load path `tinypath--load-path-root'
(let 
  (
    (main-xe-load-path)				;; Emacs or Xemacs main dir
    (main-site-lisp-xe-root-path)		;; Emacs or Xemacs main site-lisp root dir
    (site-lisp-xe-root-path)			;; Emacs or Xemacs site-lisp root dir
    (site-lisp-common-root-path)		;; Site-lisp common root dir
    (site-lisp-xe-packages-path)		;; Emacs or Xemacs site-lisp dir
    (site-lisp-common-packages-path)	        ;; Site-lisp common packages dir
    (site-lisp-system-path)			;; Site-lisp system depended dir
  )


;  (setq main-xe-load-path
;    (if (boundp 'xemacs-logo)          
;      (list 
;        (concat rootpath "share/xemacs/lisp")
;      )
;      (list	
;        (concat rootpath "share/emacs")  ;; FIXME??? (concat rootpath "share/emacs/" emacs-version)          
;      )
;    )
;  ) 

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
	        (substring a 0 -5)
              )
	    )
	    t
          )
        )
      )  
      load-path
    )
    ;;
  )

  (setq  tinypath--core-emacs-load-path-list
    main-xe-load-path
  )

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
      (expand-file-name "emacs" site-lisp-path)
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


  (setq tinypath--load-path-root
    (append
      ecf-config-load-path			;; Configuration ecf path
;      main-xe-load-path				;; Emacs or Xemacs main dir
      main-site-lisp-xe-root-path		;; Emacs or Xemacs main site-lisp root dir
      site-lisp-xe-packages-path		;; Emacs or Xemacs site-lisp dir
      site-lisp-common-packages-path	        ;; Site-lisp common packages dir
      site-lisp-system-path			;; Site-lisp system depended dir
    )
  )


) ;; end let

;; Ignored dirs for ecf-mule
(setq tinypath--load-path-ignore-regexp-extra
    "\\|[/\\]ecf-mule"
)

;; Ignored dirs for other version of emacs
;(mapc
; (function
;  (lambda (a) 
;    (if (string-match a emacs-version) () 
;      (setq tinypath--load-path-ignore-regexp-extra
;	    (concat
;	     "\\|/usr/share/emacs/" a "/site-lisp"
;	     tinypath--load-path-ignore-regexp-extra 
;	     )
;       )
;    )
;   )
;  )  
;  (directory-files "/usr/share/emacs" nil "[0-9].*" nil)
;)

;;"\\|[/\\]emacs[/\\]" a "[/\\]+"
;;"\\|[/\\]emacs[/\\]" a "[/\\]leim"

;; Ignored dirs
;(setq tinypath--load-path-ignore-regexp-extra
;  (concat
;    "\\|[/\\]lisp[/\\]language"
;    "\\|[/\\]auctex"
;    tinypath--load-path-ignore-regexp-extra
;  )
;)

(setq tinypath--load-path-ignore-regexp-extra
  (concat
    "\\|[/\\]lisp[/\\]language"
    "\\|[/\\]lisp[/\\]cedet"
    tinypath--load-path-ignore-regexp-extra
  )
)

; "\\|21\\.4[/\\]"
; "\\|/usr/share/emacs/23\\.0\\.0/site-lisp"
;    "\\|[/\\]quail"
;    "\\|[/\\]flim"
;    "\\|[/\\]wl"

;; `tinypath' load
(require 'cl)
;(pushnew tiny-path-lisp-path load-path)
(setq load-path (push tiny-path-lisp-path load-path))

(load "tinypath")

;;; rc.tinypath.el ends here

