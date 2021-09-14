;;; rc.packages.el -*- mode: emacs-lisp; lexical-binding: t; coding: utf-8-unix; -*-

;;; Commentary:

;;
;;  File id
;;
;;      Copyright (C)  2002-2021 Dmitry S. Kulyabov
;;      Keywords:      rc.packages
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

;; (desire-old 'tiny)
(desire-old 'personal)
;;
;; Mule
;;
(desire-old 'mule)
;;(desire-old 'mule-fontset)
;; ----------------------------------------------------------------------
;;
;;{{{ Xemacs

(if (string-match "XEmacs" emacs-version)
    (desired 'xemacs))

;;}}}
;;{{{ Package repositories

;;; Packaging
(desire 'package)
;;; Auto update packages
(desire 'auto-package-update)
;;; A declarative package management system with a command line interface
(desire 'straight)

;;}}}

(desire-old 'site-stuff)

;;{{{ Window System

(if (null window-system)
    ()
  (progn
    (desire-old 'window-system)
;    (desire-old  'faces)
;    (desire-old  'multi-frame)
  )
)


;; (if (null window-system)
;;  ()
;;  (desire-old 'window-system)
;; )

;; (desire-old 'window-system)
;; (desire-old 'test)

;; (if (eq window-system 'w32)
;;  (progn
;;    (desired 'window-system)
;;    (desired 'window-system-w32)
;;  )
;; )

;; (if (and window-system
;;	 (member window-system '(x gtk))
;;	 (x-display-color-p)
;;    )
;;    (progn
;;      (desired 'window-system)
;;      (desire-old  'faces)
;;      (desire-old  'multi-frame)
;;    )
;; )

;;}}}
;;{{{ Gnuserv

;;(desire-old 'gnuserv nil "gnuserv")

;; Rely on dtemacs to do this, otherwise a race condition can cause
;; dtemacs to fail.
;; (gnuserv-start)

;;}}}
;;{{{ Emacs daemon

(desire-old 'emacs-daemon)

;;}}}

(desire 'exec-path-from-shell)

;; ----------------------------------------------------------------------

(desire-old 'keys)
(desire-old 'dialog)
(desire-old 'mouse)
;; ----------------------------------------------------------------------

;;{{{ UI

(desire 'ligature)

(desire 'all-the-icons)
;; (desire 'mixed-pitch)

(desire-old 'fontset)
(desire-old 'font-lock)
(desire-old 'font-lock-jit)
;; (desire-old 'font-lock-lazy)
;; (desire-old 'font-lock-fast)
;; (desire-old 'faces)
;; (desire-old 'color-theme nil "color-theme")
;; (desire-old 'fira-code-mode nil "fira-code-mode" t) ;; Simple minor mode for Fira Code ligatures
(desire-old 'theme)

(desire-old 'modeline)

;;}}}
;;{{{ Themes

;; (desire 'moody)

;;(desire-old 'spacemacs-theme nil "spacemacs-theme-pkg" t)
;;(desire 'spaceline)

(desire 'doom-themes)

;; (desire 'zenburn-theme)
;; (desire 'modus-themes)

;;}}}
;;

(desire-old 'show-paren)
(desire-old 'folding)
;; (desire-old 'outline)
(desire 'origami)


;;

(desire 'imenu)

;; (desire-old 'toolbar)

;; ----------------------------------------------------------------------
;;{{{ Spell

;; (desire-old 'spell)
(desire 'ispell)
(desire 'flyspell)
;;(desire-old 'speck)
;;(desire-old 'wcheck)

;;}}}
;;{{{ Completion

(desire 'marginalia)

(desire 'company)

(desire 'helm-rg :precondition-system-executable "rg")
(desire 'helm-posframe)
(desire 'helm)

;; (desire 'ivy)
;; (desire 'selectrum)

;;}}}
;;{{{ Adress book

(desired 'vcard)
(desire 'khardel :precondition-system-executable "khard")

;; BBDB - Must be loaded before most other things, since other things
;;        may perform special configuration if BBDB is present.

(desire 'bbdb)

;;}}}


(desire 'projectile)

;;(desire-old 'yasnippet)

(desire 'centaur-tabs)

;;{{{ Text

(desire 'adaptive-wrap)

(desire 'pandoc-mode)

(desire' mermaid-mode :precondition-system-executable "mmdc")

(desire-old 'text)
(desire-old 'markdown-mode nil "markdown-mode" t)

;;}}}
;;{{{ org-mode

;; (desire 'org-contacts)
;; (desire 'google-contacts)

(desire 'org-ref)


(desire 'org-superstar)
(desire 'org-super-agenda)

(desire 'org-gcal)
(desire 'org-journal)

(desired 'mobileorg)
(desire 'org)

;; (desire 'org-roam-server)
(desire 'org-roam)

(desire 'org-appear)
(desire 'org-fragtog)

(desire 'org-vcard)
;; (desire 'vdirel)

;;}}}
;;{{{ Notes

(desire 'deft)
;; (desire-old 'zetteldeft nil "zetteldeft" t)

;;}}}
;;{{{ Bibliography

(desire 'bibtex-completion)
(desire 'biblio)
(desire 'bibtex)
(desire 'ebib)

;;}}}
;;{{{ LaTeX

(desire 'cdlatex)

(desire-old 'xdvi nil "xdvi-search")
(desired 'reftex)
;; (desire-old 'tex)
(desired 'preview-latex nil "preview-latex")
;; (desire-old 'auctex "latex" "tex-site")
(desire 'auctex :initname "latex" :precondition-lisp-library "tex-site")

;;}}}
;;{{{ XML, XHTML, HTML

;;(desire-old 'nxml nil "rng-auto")
; (desire-old 'psgml)

;;}}}

;;{{{ Palm pilot support

;(desire-old 'palm)

;;}}}

;;{{{ Save desktop

; (desire-old 'desktop)
(desire-old 'session nil "session")
(desire-old 'saveplace nil "saveplace")

;;}}}
;;{{{ Appointments, diary, calendar.

;; Use "M-x calendar RET" to display the calendar and start
;; appointment warnings.

;; (desire-old 'appt)
(desire 'calendar)
;; (desire-old 'todo-mode)
;; (desire-old 'diary "diary-lib")

;;}}}
;;{{{ These provide options for the various message handling packages.

(desire 'browse-url)
; (desire-old 'mailcrypt)
; (desire-old 'supercite)

;;}}}
;;{{{ Message handing packages.

(desire 'smtpmail)

;; (desire 'gnus)
;; (desire-old 'message)
;; (desire-old 'vm)
;; (desire 'wl :ensurename 'wanderlust)
;; (desire-old 'sendmail)
(desire 'mu4e :precondition-system-executable "mu")

;;}}}
;;{{{ Programming

;; (desire-old 'speedbar nil "speedbar")
;; (desire-old 'semantic nil "semantic")

;; (desire-old 'cedet nil "cedet")
;; (desire-old 'ecb nil "ecb")

;; (desire-old 'php-mode nil "php-mode")
;; (desire-old 'eiffel-mode nil "eiffel-mode")

(desire-old 'lua-mode nil "lua-mode" t)
(desire-old 'julia-mode nil "julia-mode" t)
(desire 'yaml-mode)
(desire 'ini-mode)

(desire 'magit)
(desire 'magit-gitflow)

;;}}}
;;{{{ Blogs

;; (desire-old 'hexo nil "hexo")
;; (desire-old 'blog-admin nil "blog-admin") ;; Blog admin for emacs with hexo/org-page supported
(desire-old 'easy-hugo  nil "easy-hugo" t) ;; Emacs major mode for managing hugo

;;}}}
;;{{{ Miscellaneous

(desire-old 'graphviz-dot-mode nil "graphviz-dot-mode")
;; (desire-old 'abbrev)
;; (desire-old 'bibtex)
;; (desire-old 'calc)
;; (desire-old 'eiffel-mode)
;; (desire-old 'filladapt)
;; (desire-old 'hugs-mode)
;; (desire-old 'html-helper-mode)
;; (desire-old 'lispdir)
;; (desire-old 'php-mode)
;; (desire-old 'ps-print)
;; (desire-old 'sh-script)
;; (desire-old 'shell)
;; (desire-old 'sql-mode)
;; (desire-old 'w3)

(desire 'pass)
(desire 'keycast)

(desire 'multiple-cursors)

(desire 'treemacs)

;;}}}

;; (desire 'grammarly)
;; (desire 'lsp-mode)

;; (desire 'flycheck-grammarly)

(desire 'doom-modeline)

;; PERSONAL

;; (require 'chord-mode)  ; edit guitar music.
;; (require 'discography) ; variant of BibTeX mode for discographies.


;;; rc.packages.el ends here
