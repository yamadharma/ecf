;;; -*- coding: iso-2022-7bit-unix; -*-

(desire 'tiny)
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

(desire 'site-stuff)

;;{{{ Window System

(if (null window-system)
  ()    
  (progn
    (desire 'window-system)
    (desire  'faces)
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

;(desire 'gnuserv)

;; Rely on dtemacs to do this, otherwise a race condition can cause
;; dtemacs to fail.
;; (gnuserv-start)

;;}}}

;; ----------------------------------------------------------------------

(desire 'keys)
(desire 'dialog)
(desire 'mouse)
;; ----------------------------------------------------------------------

(desire 'fontset)
(desire 'font-lock)
(desire 'font-lock-jit)
; (desire 'font-lock-lazy)
; (desire 'font-lock-fast)
; (desire 'faces)

;;

(desire 'folding)
;(desire 'outline)

;;

(desire 'toolbar)

;; ----------------------------------------------------------------------
;;{{{ Spell

(desire 'spell)
(desire 'flyspell)

;;}}}
;;{{{ BBDB

;; BBDB - Must be loaded before most other things, since other things
;;        may perform special configuration if BBDB is present.

(desire 'bbdb nil "bbdb")

;;}}}
;;{{{ Text

(desire 'text)

;;}}}
;;{{{ LaTeX

(desire 'xdvi nil "xdvi-search")
(desired 'reftex)
(desire 'bibtex)
(desire 'tex)
(desire 'auctex "latex" "tex-site")

;;}}}
;;{{{ Palm pilot support

;(desire 'palm)

;;}}}

;;{{{ Save desktop

(desire 'session nil "session")
; (desire 'desktop)

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

;;{{{ Miscellaneous

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
; (desire 'psgml)
;(desire 'sh-script)
;(desire 'shell)
;;(desire 'sql-mode)
;(desire 'w3)

;;}}}

;; PERSONAL

;(require 'chord-mode)  ; edit guitar music.
;(require 'discography) ; variant of BibTeX mode for discographies.






