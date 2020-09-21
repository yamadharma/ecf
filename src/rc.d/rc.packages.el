;;; rc.packages.el -*- coding: iso-2022-7bit-unix; -*-

;;; Commentary:

;;
;;  File id
;;
;;      Copyright (C)  2002-2006 Dmitry S. Kulyabov
;;      Keywords:      rc.packages
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

; (desire 'tiny)
(desire 'personal)
;;
;; Mule
;;
(desire 'mule)
;(desire 'mule-fontset)
;; ----------------------------------------------------------------------
;;
;;{{{ Xemacs

(if (string-match "XEmacs" emacs-version)
    (desired 'xemacs)
)

;;}}}
;;{{{ Package repositories

;; MELPA
(desire 'melpa)
;; Auto update packages
(desire 'auto-package-update nil "auto-package-update" t)

;;}}}

(desire 'site-stuff)

;;{{{ Window System

(if (null window-system)
  ()
  (progn
    (desire 'window-system)
;    (desire  'faces)
;    (desire  'multi-frame)
  )
)


;(if (null window-system)
;  ()
;  (desire 'window-system)
;)

;(desire 'window-system)
;(desire 'test)

;(if (eq window-system 'w32)
;  (progn
;    (desired 'window-system)
;    (desired 'window-system-w32)
;  )	
;)

;(if (and window-system
;	 (member window-system '(x gtk))
;	 (x-display-color-p)
;    )
;    (progn
;      (desired 'window-system)
;      (desire  'faces)
;      (desire  'multi-frame)
;    )
;)

;;}}}
;;{{{ Gnuserv

(desire 'gnuserv nil "gnuserv")

;; Rely on dtemacs to do this, otherwise a race condition can cause
;; dtemacs to fail.
;; (gnuserv-start)

;;}}}
;;{{{ Emacs daemon

;; (desire 'emacs-daemon)

;;}}}
;; ----------------------------------------------------------------------

(desire 'keys)
(desire 'dialog)
(desire 'mouse)
;; ----------------------------------------------------------------------

(desire 'fontset)
(desire 'font-lock)
(desire 'font-lock-jit)
;; (desire 'font-lock-lazy)
;; (desire 'font-lock-fast)
;; (desire 'faces)
;; (desire 'color-theme nil "color-theme")
(desire 'fira-code-mode nil "fira-code-mode" t) ;; Simple minor mode for Fira Code ligatures
(desire 'theme)

;;

(desire 'show-paren)
(desire 'folding)
;(desire 'outline)

;;

;; (desire 'toolbar)

;; ----------------------------------------------------------------------
;;{{{ Spell

(desire 'spell)
(desire 'ispell)
(desire 'flyspell)
;;(desire 'speck)
;;(desire 'wcheck)

;;}}}
;;{{{ BBDB

;; BBDB - Must be loaded before most other things, since other things
;;        may perform special configuration if BBDB is present.

(desire 'bbdb nil "bbdb")

;;}}}
;(desire 'yasnippet)
;;{{{ Text

(desire 'text)
(desire 'markdown-mode nil "markdown-mode" t)

;;}}}
;;{{{ org-mode

(desired 'mobileorg)
(desire 'org)

;;}}}
;;{{{ LaTeX

(desire 'ebib nil "ebib")
(desire 'xdvi nil "xdvi-search")
(desired 'reftex)
(desire 'bibtex)
(desire 'tex)
(desired 'preview-latex nil "preview-latex")
(desire 'auctex "latex" "tex-site")

;;}}}
;;{{{ XML, XHTML, HTML

(desire 'nxml nil "rng-auto")
; (desire 'psgml)

;;}}}

;;{{{ Palm pilot support

;(desire 'palm)

;;}}}

;;{{{ Save desktop

; (desire 'desktop)
(desire 'session nil "session")
(desire 'saveplace nil "saveplace")

;;}}}
;;{{{ Appointments, diary, calendar.

;; Use "M-x calendar RET" to display the calendar and start
;; appointment warnings.

;(desire 'appt)
;(desire 'calendar)
;(desire 'todo-mode)
;(desire 'diary "diary-lib")

;;}}}
;;{{{ These provide options for the various message handling packages.

; (desire 'browse-url)
; (desire 'mailcrypt)
; (desire 'supercite)

;;}}}
;;{{{ Message handing packages.

(desire 'gnus)
;(desire 'message)
;(desire 'vm)
;(desire 'wl)
;(desire 'sendmail)

;;}}}
;;{{{ Programming

;(desire 'speedbar nil "speedbar")
;(desire 'semantic nil "semantic")

;(desire 'cedet nil "cedet")
;(desire 'ecb nil "ecb")

;(desire 'php-mode nil "php-mode")
;(desire 'eiffel-mode nil "eiffel-mode")

(desire 'lua-mode nil "lua-mode" t)
(desire 'julia-mode nil "julia-mode" t)
(desire 'yaml-mode nil "yaml-mode" t)

;;}}}
;;{{{ Blogs

(desire 'hexo nil "hexo")
;(desire 'blog-admin nil "blog-admin") ;; Blog admin for emacs with hexo/org-page supported
(desire 'easy-hugo  nil "easy-hugo" t) ;; Emacs major mode for managing hugo

;;}}}
;;{{{ Miscellaneous

(desire 'graphviz-dot-mode nil "graphviz-dot-mode")
;(desire 'abbrev)
;(desire 'bibtex)
;(desire 'calc)
;(desire 'eiffel-mode)
;(desire 'filladapt)
;(desire 'hugs-mode)
;(desire 'html-helper-mode)
;(desire 'lispdir)
;(desire 'php-mode)
;(desire 'ps-print)
;(desire 'sh-script)
;(desire 'shell)
;;(desire 'sql-mode)
;(desire 'w3)

;;}}}

;; PERSONAL

;(require 'chord-mode)  ; edit guitar music.
;(require 'discography) ; variant of BibTeX mode for discographies.


;;; rc.packages.el ends here
