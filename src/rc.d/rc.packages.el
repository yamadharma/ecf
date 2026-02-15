;;; -*- mode: emacs-lisp; lexical-binding: t; coding: utf-8-unix; -*-
;;; rc.packages.el

;;; Commentary:

;;
;;  File id
;;
;;      Copyright (C)  2002-2025 Dmitry S. Kulyabov
;;      Keywords:      rc.packages
;;      Author:        Dmitry S. Kulyabov <yamadharma@gmail.com>
;;      Maintainer:    Dmitry S. Kulyabov <yamadharma@gmail.com>
;;
;;      This code is free software in terms of GNU Gen. pub. Lic. v3 or later
;;

;;;  Description:

;;; Change Log:

;;; Code:

;; (desire-conf 'tiny)
(desire-conf 'personal)
;;
;; Mule
;;
(desire-conf 'mule)
;;(desire-conf 'mule-fontset)
;; ----------------------------------------------------------------------
;;
;;{{{ Xemacs

(if (string-match "XEmacs" emacs-version)
    (desired 'xemacs))

;;}}}

;;; Package management

;;;; Packaging
(desire 'package)

;;; Build and install your Emacs Lisp packages on-the-fly and directly from source
;; (desire 'quelpa)

;;; A declarative package management system with a command line interface
(desire 'straight)

;;; Auto update packages
(desire 'auto-package-update)

;;;}}}

;;; compile-angel.el
(desire 'compile-angel)

;; (desire 'esup)

(desire-conf 'site-stuff)

;;{{{ Window System

(if (null window-system)
    ()
  (progn
    (desire-conf 'window-system)
					;    (desire-conf  'faces)
					;    (desire-conf  'multi-frame)
    )
  )


;; (if (null window-system)
;;  ()
;;  (desire-conf 'window-system)
;; )

;; (desire-conf 'window-system)
;; (desire-conf 'test)

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
;;      (desire-conf  'faces)
;;      (desire-conf  'multi-frame)
;;    )
;; )

;;}}}
;;{{{ Serve

;;; Gnuserv
;;(desire-conf 'gnuserv nil "gnuserv")
;; Rely on dtemacs to do this, otherwise a race condition can cause
;; dtemacs to fail.
;; (gnuserv-start)

;;; Emacs daemon
;; (desire-conf 'emacs-daemon)

;;; Emacs server
(desire 'server)

;;}}}

(desire 'general)

(desire 'exec-path-from-shell)
(desire 'compat)

(desire 'async)

(desire 'gcmh)

;;; LSP mode {{{

(desired 'emacs-lsp-booster :precondition-system-executable "emacs-lsp-booster")

(desire 'eglot)

;; (desire 'lsp-mode)

;;{{{ Session Management

(desire 'savehist)

;;}}}

(desire 'uniquify)

(desire-conf 'keys)
(desire-conf 'dialog)
(desire-conf 'mouse)

(desire 'xclip)

(desire 'which-key)

;; (desire 'keycast)

;; ----------------------------------------------------------------------

(desire 'pcache)
(desire 'persistent-soft)

(desire 'alert)

(desire 'rg :precondition-system-executable "rg")

;;;; User interface

;;;;; Icons

;; (desire 'all-the-icons)

(desire 'nerd-icons)

;;; Tabs

;; (desire 'centaur-tabs)

(desire 'tab-bar)

(desire 'tab-line)

(desire 'display-line-numbers)

;; (desire 'nlinum)

(desire 'shrface)

;; (desire 'universal-sidecar)

;;;; Completion

;; (desire 'company)
(desire 'corfu)

;;;; Minibuffer completion

;; (desire 'ido)
;; (desire 'helm-posframe)
;; (desire 'helm)
;; (desire 'ivy)
;; (desire 'selectrum)
(desire 'vertico)

;;;;; Transient
(desire 'transient)

;;;;; Casual Suite
(desire 'casual)

;;

(desire 'hydra)

(desire-conf 'show-paren)
;; (desire-conf 'folding)
;;

(desire 'imenu)

(desire 'ace-window)


;; (desire-conf 'toolbar)

;; Parentesis
(desire 'smartparens)

;;;; Navigation

(desire 'avy)
;;; Window navigation {{{

(desire 'windmove)

;;;}}}

(desire 'apheleia)

(desire 'tree-sitter)

;;;; Spaces

(desire 'stripspace)

(desire 'outline)

;; (desire 'origami)

(desire 'outli :recipe '(:fetcher github :repo "jdtsmith/outli" :branch "main"))

(desire 'hideshow)

(desire 'bicycle)

(desire 'indent-bars)

(desire 'outline-indent)

;;; Spell {{{

;; (desire-conf 'spell)
(desire 'ispell)
;; (desire 'flyspell)
;;(desire-conf 'speck)
;;(desire-conf 'wcheck)

(desire 'jinx)

;; (desire 'langtool)
;; (desire 'flycheck-languagetool)
;; (desire 'lsp-ltex :recipe '(:fetcher github :repo "emacs-languagetool/lsp-ltex" :branch "master" :files ("*.el")))
;; (desire 'eglot-ltex :recipe '(:fetcher github :repo "emacs-languagetool/eglot-ltex" :branch "master" :files ("*.el")))

;;;}}}

;;; Adress book {{{

(desired 'vcard)
(desire 'khardel :precondition-system-executable "khard")
(desire 'khalel :precondition-system-executable "khal")
;; (desire 'org-vcard)
;; (desire 'vdirel)
;; (desire 'bbdb)

;;;}}}

;;; Bibliography {{{

(desire 'biblio)

(desire 'bibtex)

;;;}}}

;;(desire-conf 'yasnippet)

;;;; Work with text

;;;;; Tables

(desire 'lte)

;;;;; Text view

(desire 'texfrag)

;; (desire 'adaptive-wrap)
(desired 'visual-line-mode)

;; (desired 'prettify-symbols-mode)
;; (desire 'pretty-mode)
;; (desire 'prettify-math)
;; (desire 'math-preview)

(desire-conf 'text)

(desire 'move-text)

(desire 'delsel)

(desire 'pandoc-mode)

(desire 'markdown-mode)

(desire 'doc-toc)

(desire 'pdf-meta-edit)

(desire 'pdf-tools)

(desire 'nov)

(desire 'fb2-reader)

;; (desire 'valign)

;;;; Quarto mode
(desire 'quarto-mode)

(desire 'calibredb)

;;;; Time management

(desire 'pomm)

(desire 'org-pomodoro)
;; (desire 'hammy)

;;; LaTeX

(desire 'xenops)

(desire 'cdlatex)

(desire-conf 'xdvi nil "xdvi-search")
(desired 'reftex)
;; (desire-conf 'tex)
(desired 'preview-latex)

(desire 'auctex)
;;;; Org-mode

;; (desire 'org-superstar)
;; (desire 'org-ql)

(desire 'org-appear)
(desire 'org-fragtog)
(desire 'org-custom-cookies)
;; (desire 'svg-tag-mode)
;; (desire 'org-modern-indent :recipe '(:fetcher github :repo "jdtsmith/org-modern-indent" :branch "main" :files ("*.el")))
(desire 'org-modern)
;; (desire 'org-contacts)
;; (desire 'google-contacts)
(desire 'org-edna)
(desire 'org-ref)
(desire 'org-tree-slide)

(desire 'org-transclusion)

;;; Agenda
(desire 'org-super-agenda)

;;(if (desiredp 'org-ql)
;; (desire 'org-agenda-files-track-ql)
(desire 'org-agenda-files-track)
;;)

;;(if (desiredp 'org-ql)
;; (desire 'org-agenda-files-track-ql :recipe '(:fetcher github :repo "nicolas-graves/org-agenda-files-track" :branch "master" :files ("org-agenda-files-track-ql.el")))
;; (desire 'org-agenda-files-track :recipe '(:fetcher github :repo "nicolas-graves/org-agenda-files-track" :branch "master" :files ("org-agenda-files-track.el")))
;;)

;;; Literate
(desire 'org-tanglesync)

;; (desire 'org-gcal)
(desire 'org-journal)

(desire 'org-noter)
;; (desire 'org-noter :recipe '(:fetcher github :repo "org-noter/org-noter" :branch "feature/org-roam-integration" :files ("*.el" "modules/*.el")))

;; (desire 'org-transclusion)

(desire 'org-node)

;; (desire 'org-habit-ng :recipe '(:fetcher codeberg :repo "Trevoke/org-habit-ng" :branch "congruence"))

;;;; GTD
(desire 'org-gtd)

(desired 'mobileorg)

(desire 'org-download)

(desire 'org)

;;; For messaging
;; (desire 'org-msg)

;;;}}}

;;; Notes

;;;;; Org-roam

(desire 'emacsql)

;; (desire 'delve :recipe '(:fetcher github :repo "publicimageltd/delve" :branch "main"))

(desire 'zetteldesk)

(desire 'org-roam-ui :recipe '(:fetcher github :repo "lkarp-744/org-roam-ui"))
;; (desire 'org-roam-ui :recipe '(:fetcher github :repo "lkarp-744/org-roam-ui" :files ("*.el" "public")))
;; (desire 'org-roam-ui)

(desire 'magit-section)
(desire 'org-roam)

;; (desire 'deft)
;; (desire-conf 'zetteldeft nil "zetteldeft" t)

;; (desire 'denote)

;;}}}

;; (desire 'org-gantt-mode :recipe '(:fetcher gitlab :repo "joukeHijlkema/org-gantt-mode" :branch "master"))

(desire 'elgantt :recipe '(:fetcher github :repo "legalnonsense/elgantt" :branch "master"))

(desire' mermaid-mode :precondition-system-executable "mmdc")

(desire 'plantuml-mode)

;; XML, XHTML, HTML {{{

;;(desire-conf 'nxml nil "rng-auto")
                                      ; (desire-conf 'psgml)

;;;}}}
;;;{{{ Palm pilot support

                                      ;(desire-conf 'palm)

;;;}}}

;;; Desktop {{{

;; (desire-conf 'desktop)
(desire-conf 'session nil "session")
(desire-conf 'saveplace nil "saveplace")

(desire 'otpp)

(desire 'ibuffer)
;; (desire 'persp-mode)
;; (desire 'perspective)

(desire 'bufler)

;;; Project management

(desire 'projection)

(desire 'project)

;; (desire 'projectile)

;;; Appointments, diary, calendar {{{

;; Use "M-x calendar RET" to display the calendar and start
;; appointment warnings.

;; (desire-conf 'appt)
(desire 'calendar)
;; (desire-conf 'todo-mode)
;; (desire-conf 'diary "diary-lib")

;;;}}}

;;; These provide options for the various message handling packages {{{

(desire 'browse-url)
;; (desire-conf 'mailcrypt)
;; (desire 'supercite)

;;;}}}

;;; Message {{{

(desire 'smtpmail)
;; (desire 'gnus)
(desire 'message)
;; (desire-conf 'vm)
;; (desire 'wl :ensurename 'wanderlust)
;; (desire-conf 'sendmail)

;; (desire 'mu4e-dashboard :recipe '(:fetcher github :repo "rougier/mu4e-dashboard"))
(desire 'mu4e :precondition-system-executable "mu")

;;; Blogs {{{

;; (desire-conf 'hexo nil "hexo")
;; (desire-conf 'blog-admin nil "blog-admin") ;; Blog admin for emacs with hexo/org-page supported
(desire-conf 'easy-hugo  nil "easy-hugo" t) ;; Emacs major mode for managing hugo

;;;}}}
;;; Miscellaneous {{{

(desire 'ebuku)
(desire-conf 'graphviz-dot-mode nil "graphviz-dot-mode")
;; (desire-conf 'abbrev)
;; (desire-conf 'bibtex)
;; (desire-conf 'calc)
;; (desire-conf 'eiffel-mode)
;; (desire-conf 'filladapt)
;; (desire-conf 'hugs-mode)
;; (desire-conf 'html-helper-mode)
;; (desire-conf 'lispdir)
;; (desire-conf 'php-mode)
;; (desire-conf 'ps-print)
;; (desire-conf 'sh-script)
;; (desire-conf 'shell)
;; (desire-conf 'sql-mode)
;; (desire-conf 'w3)
(desire 'web-mode)
(desire 'gnuplot)

(desire 'pass)


(desire 'multiple-cursors)

(desire 'telega)

(desire 'pocket-reader)

(desire 'wallabag :recipe '(:fetcher github :repo "chenyanming/wallabag.el" :branch "master" :files ("*.el" "*.alist" "*.css")))

(desire 'elfeed)

;;;}}}

;; (desire 'grammarly)

;; (desire 'flycheck-grammarly)

(desire 'dashboard)

;; PERSONAL

;; (require 'chord-mode)  ; edit guitar music.
;; (require 'discography) ; variant of BibTeX mode for discographies.
;;; Different program modes {{{

;;; csv-mode
(desire 'csv-mode)

;;; Ebuild files
(desire 'ebuild-mode :recipe '(:fetcher github :repo "emacsmirror/ebuild-mode" :branch "master"))

;;; Asymptote
(desire 'asy-mode :recipe '(:fetcher github :repo "vectorgraphics/asymptote" :branch "master" :files ("base/asy-mode.el")))

;;; kbd-mode
;; (desire 'kbd-mode :recipe '(:fetcher github :repo "kmonad/kbd-mode" :branch "master"))

;;;;; Julia

(desire 'julia-snail)
;; (desire 'julia-repl)

(desire 'julia-mode)

;;; https://github.com/wwwjfy/emacs-fish
(desire 'fish-mode)

(desire 'speedbar)
;; (desire-conf 'semantic nil "semantic")

;; (desire-conf 'cedet nil "cedet")
;; (desire-conf 'ecb nil "ecb")

;; (desire-conf 'php-mode nil "php-mode")
;; (desire-conf 'eiffel-mode nil "eiffel-mode")

(desire 'ebib)

(desire 'lua-mode)

(desire 'yaml-mode)
(desire 'ini-mode)
(desire 'hcl-mode)

(desire 'magit-gitflow)
(desire 'magit)

;;;}}}
;;; Edit text areas in browsers {{{

(desire 'edit-server)
;; (desire 'atomic-chrome)

;;;}}}
;;; Dired {{{

(desire 'mouse3 :recipe '(:fetcher github :repo "emacsmirror/mouse3" :branch "master" :files ("*.el")))

(desire 'dired)
(desire 'dired+ :recipe '(:fetcher github :repo "emacsmirror/dired-plus" :branch "master" :files ("*.el")))

;; (desire 'ranger)
;; (desire 'efar)
;; (desire 'sunrise-commander :recipe '(:fetcher github :repo "sunrise-commander/sunrise-commander"))
(desire 'dirvish)
;;;}}}

;;; Midnight Commander features (plus) for emacs dired-mode
;; (desire 'diredc)

;; (desire 'neotree)

(desire 'treemacs)
;;; Text navigation {{{

;;; Line annotation for changed and saved lines
(desire 'line-reminder)

;;;}}}

;;; Translator on Emacs
(desire 'gt)

;;;; UI

;;;;; Fonts

(desired 'iosevka)

(desire 'fontset)

;; (desire 'mixed-pitch)
;; (desire-conf 'font-lock)
;; (desire-conf 'font-lock-jit)
;; (desire-conf 'font-lock-lazy)
;; (desire-conf 'font-lock-fast)
;; (desire-conf 'faces)
;; (desire-conf 'color-theme nil "color-theme")
;; (desire-conf 'fira-code-mode nil "fira-code-mode" t) ;; Simple minor mode for Fira Code ligatures

;; (desire 'ligature)

(desire 'unicode-fonts)

;;;;; Modeline

(desire-conf 'modeline)

;;;;; Themes

;;; Nested menu for minor modes
(desire 'minions)

;;; Tabs and ribbons for the mode-line
(desire 'moody)

;;; Spacemacs theme
;; (desire 'spacemacs-theme :precondition-lisp-library "spacemacs-theme-pkg")

;;; Doom themes
;; (desire 'doom-themes)

;; (desire 'zenburn-theme)
;; (desire 'lambda-themes :recipe '(:fetcher github :repo "Lambda-Emacs/lambda-themes" :branch "main"))
;; (desire 'tao-theme)

;;; N Λ N O Theme
;; (desire 'nano-theme)

;;; Increase the padding/spacing of frames and windows
;; (desire 'spacious-padding)

(desire 'modus-themes)

;; (desire 'ef-themes)

;; (desire 'doric-themes)

;; (desire 'posframe)

(desire 'eldoc-box)
;; (desire 'nova :recipe '(:fetcher github :repo "thisisran/nova" :branch "main"))

;; (desire 'zoom)

;;; rc.packages.el ends here
