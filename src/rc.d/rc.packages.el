;;; -*- mode: emacs-lisp; lexical-binding: t; coding: utf-8-unix; origami-fold-style: triple-braces; -*-
;;; rc.packages.el

;;; Commentary:

;;
;;  File id
;;
;;      Copyright (C)  2002-2024 Dmitry S. Kulyabov
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
;;; Build and install your Emacs Lisp packages on-the-fly and directly from source
(desire 'quelpa)
;;; A declarative package management system with a command line interface
;; (desire 'straight)
;;; Auto update packages
(desire 'auto-package-update)

;;}}}

;; (desire 'esup)

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
;;{{{ Serve

;;; Gnuserv
;;(desire-old 'gnuserv nil "gnuserv")
;; Rely on dtemacs to do this, otherwise a race condition can cause
;; dtemacs to fail.
;; (gnuserv-start)

;;; Emacs daemon
;; (desire-old 'emacs-daemon)

;;; Emacs server
(desire 'server)

;;}}}

(desire 'general)

(desire 'exec-path-from-shell)
(desire 'compat)

(desire 'async)
(desire 'gcmh)

;; ----------------------------------------------------------------------

;;{{{ Session Management

(desire 'savehist)

;;}}}

(desire 'uniquify)

(desire-old 'keys)
(desire-old 'dialog)
(desire-old 'mouse)

;; (desire 'xclip)

(desire 'which-key)
;; (desire 'keycast)

;; ----------------------------------------------------------------------

(desire 'pcache)
(desire 'persistent-soft)

(desire 'alert)

(desire 'rg :precondition-system-executable "rg")

;;{{{ UI

(desire 'ligature)

;; (desire 'all-the-icons)
(desire 'nerd-icons)
;; (desire 'mixed-pitch)

(desire-old 'fontset)
(desire-old 'font-lock)
(desire-old 'font-lock-jit)
;; (desire-old 'font-lock-lazy)
;; (desire-old 'font-lock-fast)
;; (desire-old 'faces)
;; (desire-old 'color-theme nil "color-theme")
;; (desire-old 'fira-code-mode nil "fira-code-mode" t) ;; Simple minor mode for Fira Code ligatures

(desire 'unicode-fonts)

;; (desire-old 'theme)
;; (desire-old 'modeline)

;; (desire 'zoom)

;; (desire 'centaur-tabs)
(desire 'tab-bar)
(desire 'tab-line)

;;}}}
;;; LSP mode {{{

(desired 'emacs-lsp-booster :precondition-system-executable "emacs-lsp-booster")
(desire 'eglot)
;; (desire 'lsp-mode)

;;; }}}
;;

;; (desire 'tree-sitter)

(desire 'hydra)

(desire 'bicycle)
(desire 'hideshow)

(desire-old 'show-paren)
;; (desire-old 'folding)
;; (desire-old 'outline)
(desire 'origami)

;;

(desire 'imenu)

(desire 'ace-window)


;; (desire-old 'toolbar)


;; ----------------------------------------------------------------------

(desire 'flycheck)

;;{{{ Minibuffer completion

(desire 'vertico)
;; (desire 'ido)
;; (desire 'helm-posframe)
;; (desire 'helm)
;; (desire 'ivy)
;; (desire 'selectrum)

;;}}}
;;{{{ Minibuffer completion

;; (desire 'company)
(desire 'corfu)

;;}}}

;; Parentesis
(desire 'smartparens)

;;{{{ Spell

;; (desire-old 'spell)
(desire 'ispell)
(desire 'flyspell)
;;(desire-old 'speck)
;;(desire-old 'wcheck)

;; (desire 'flycheck-languagetool)
;; (desire 'langtool)

;; (desire 'lsp-ltex :recipe '(:fetcher github :repo "emacs-languagetool/lsp-ltex" :branch "master" :files ("*.el")))
;; (desire 'eglot-ltex :recipe '(:fetcher github :repo "emacs-languagetool/eglot-ltex" :branch "master" :files ("*.el")))

;;}}}
;;{{{ Adress book

(desired 'vcard)
(desire 'khardel :precondition-system-executable "khard")
(desire 'khalel :precondition-system-executable "khal")
;; (desire 'org-vcard)
;; (desire 'vdirel)

;; BBDB - Must be loaded before most other things, since other things
;;        may perform special configuration if BBDB is present.

;; (desire 'bbdb)

;;}}}
;;{{{ Bibliography

(desire 'biblio)
(desire 'bibtex)

;;}}}

;; (desire 'project)
(desire 'projectile)

;;(desire-old 'yasnippet)

;;{{{ Text

(desire 'texfrag)

;; (desire 'adaptive-wrap)
(desired 'visual-line-mode)

;; (desired 'prettify-symbols-mode)
;; (desire 'pretty-mode)
;; (desire 'prettify-math)
;; (desire 'math-preview)

(desire 'pandoc-mode)

(desire' mermaid-mode :precondition-system-executable "mmdc")

(desire-old 'text)
(desire-old 'markdown-mode nil "markdown-mode" t)

(desire 'plantuml-mode)

(desire 'pdf-tools)
(desire 'nov)
(desire 'fb2-reader)

;; (desire 'valign)

;;}}}
;;; Time management 

(desire 'pomm)
(desire 'org-pomodoro)
;; (desire 'hammy)

;;{{{

(desire 'mouse3 :recipe '(:fetcher github :repo "emacsmirror/mouse3" :branch "master" :files ("*.el")))

(desire 'dired)
(desire 'dired+ :recipe '(:fetcher github :repo "emacsmirror/dired-plus" :branch "master" :files ("*.el")))

;; (desire 'ranger)
;; (desire 'efar)
;; (desire 'sunrise-commander :recipe '(:fetcher github :repo "sunrise-commander/sunrise-commander"))
(desire 'dirvish)


;;}}}
;;{{{ LaTeX

;; (desire 'xenops)
;; (desire 'lsp-latex :precondition-system-executable "texlab")

(desire 'cdlatex)

(desire-old 'xdvi nil "xdvi-search")
(desired 'reftex)
;; (desire-old 'tex)
(desired 'preview-latex)
(desire 'auctex)
;; (desire 'auctex :initname "latex")
;; (desire 'auctex :initname "latex" :precondition-lisp-library "tex-site")

;;}}}
;;{{{ org-mode

;; (desire 'org-ql)

(desire 'org-appear)
(desire 'org-fragtog)

(desire 'org-custom-cookies)

;; (desire 'svg-tag-mode)
(desire 'org-superstar)
;; (desire 'org-modern-indent :recipe '(:fetcher github :repo "jdtsmith/org-modern-indent" :branch "main" :files ("*.el")))
(desire 'org-modern)

;; (desire 'org-contacts)
;; (desire 'google-contacts)

(desire 'org-edna)

(desire 'org-ref)

(desire 'org-tree-slide)

;;; Org agenda
(desire 'org-super-agenda)

;;(if (desiredp 'org-ql)
;; (desire 'org-agenda-files-track-ql)
  (desire 'org-agenda-files-track)
;;)

;;(if (desiredp 'org-ql)
;; (desire 'org-agenda-files-track-ql :recipe '(:fetcher github :repo "nicolas-graves/org-agenda-files-track" :branch "master" :files ("org-agenda-files-track-ql.el")))
;; (desire 'org-agenda-files-track :recipe '(:fetcher github :repo "nicolas-graves/org-agenda-files-track" :branch "master" :files ("org-agenda-files-track.el")))
;;)

(desire 'org-tanglesync)

;; (desire 'org-gcal)
(desire 'org-journal)

(desire 'org-noter)
;; (desire 'org-noter :recipe '(:fetcher github :repo "org-noter/org-noter" :branch "feature/org-roam-integration" :files ("*.el" "modules/*.el")))


(desire 'org-transclusion)
(desire 'org-gtd)

(desired 'mobileorg)
(desire 'org)

;; For messaging
;; (desire 'org-msg)

;;; Org-roam

(desire 'emacsql)

;; (desire 'delve :recipe '(:fetcher github :repo "publicimageltd/delve" :branch "main"))
(desire 'zetteldesk)

;; (desire 'org-roam-server)
;; (desire 'org-roam-ui :recipe '(:host github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))
;; (desire 'org-roam-ui :recipe '(:fetcher github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))
(desire 'org-roam-ui)


(desire 'magit-section)
(desire 'org-roam)

;;}}}
;;{{{ Notes

(desire 'deft)
;; (desire-old 'zetteldeft nil "zetteldeft" t)

;;}}}
;;{{{ XML, XHTML, HTML

;;(desire-old 'nxml nil "rng-auto")
; (desire-old 'psgml)

;;}}}

;;{{{ Palm pilot support

;(desire-old 'palm)

;;}}}

;;{{{ Desktop

;; (desire-old 'desktop)
(desire-old 'session nil "session")
(desire-old 'saveplace nil "saveplace")

(desire 'ibuffer)
;; (desire 'persp-mode)
;; (desire 'perspective)
;; (desire 'bufler)
;; (desire 'tabspaces)

;;}}}
;;{{{ Appointments, diary, calendar.

;; Use "M-x calendar RET" to display the calendar and start
;; appointment warnings.

;; (desire-old 'appt)
(desire 'calendar)
;; (desire-old 'todo-mode)
;; (desire-old 'diary "diary-lib")

;;}}}
;;{{{ These provide options for the various message handling packages

(desire 'browse-url)
;; (desire-old 'mailcrypt)
;; (desire 'supercite)

;;}}}
;;{{{ Message handing packages

(desire 'smtpmail)

;; (desire 'gnus)
(desire 'message)
;; (desire-old 'vm)
;; (desire 'wl :ensurename 'wanderlust)
;; (desire-old 'sendmail)

;; (desire 'mu4e-dashboard :recipe '(:fetcher github :repo "rougier/mu4e-dashboard"))
(desire 'mu4e :precondition-system-executable "mu")

;;}}}
;;{{{ Programming

(desire 'speedbar)
;; (desire-old 'semantic nil "semantic")

;; (desire-old 'cedet nil "cedet")
;; (desire-old 'ecb nil "ecb")

;; (desire-old 'php-mode nil "php-mode")
;; (desire-old 'eiffel-mode nil "eiffel-mode")

(desire 'ebib)

(desire 'lua-mode)

;;; Julia
;;; Code completion and syntax checking
;(desire 'eglot-jl)
;;; REPL integration
(desire 'julia-snail)
;; (desire 'julia-repl)
;;; Syntax highlighting and latex symbols 
(desire 'julia-mode)


(desire 'yaml-mode)
(desire 'ini-mode)
(desire 'hcl-mode)

(desire 'magit-gitflow)
(desire 'magit)

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
(desire 'web-mode)
(desire 'gnuplot)

(desire 'pass)


(desire 'multiple-cursors)

(desire 'neotree)
;; (desire 'treemacs)

(desire 'telega)
(desire 'pocket-reader)

;;}}}

;; (desire 'grammarly)

;; (desire 'flycheck-grammarly)

(desire 'dashboard)

;;{{{ Themes

;;; Nested menu for minor modes
(desire 'minions)

;;; Tabs and ribbons for the mode-line
(desire 'moody)

;;; Spacemacs theme
;; (desire 'spacemacs-theme :precondition-lisp-library "spacemacs-theme-pkg")

;;; Doom themes
;; (desire 'doom-themes)

;; (desire 'zenburn-theme)
(desire 'modus-themes)
;; (desire 'ef-themes)
;; (desire 'lambda-themes :recipe '(:fetcher github :repo "Lambda-Emacs/lambda-themes" :branch "main"))
;; (desire 'tao-theme)

;;; N Λ N O Theme
;; (desire 'nano-theme)

;;; Increase the padding/spacing of frames and windows
;; (desire 'spacious-padding)

;;}}}

;; PERSONAL

;; (require 'chord-mode)  ; edit guitar music.
;; (require 'discography) ; variant of BibTeX mode for discographies.


;;; rc.packages.el ends here
