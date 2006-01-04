;;; site-start.el -*- coding: iso-2022-7bit-unix; -*-

;;{{{ Win32 environment hook

(if (eq system-type 'windows-nt)
  (setenv "USER" (downcase (getenv "USERNAME"))
    (setenv "HOME" (getenv "USERPROFILE"))
  )
)

;;}}}
;;{{{ Global Variables

(defvar rootpath
  (expand-file-name "/usr/")
  "*Name of emacs prefix directory."
)

(defvar home-cache-path
  (expand-file-name "~/.cache/elisp/")
  "*Name of directory where various emacs related files reside."
)

(defvar ecf-home-etc-path
  (expand-file-name "~/.config/ecf/")
  "*Name ecf config files directory."
)

(defvar ecf-etc-path
    "/etc/ecf"    
    "*Host-wide ecf config files directory."
)

(defvar site-lisp-path
  (concat rootpath "share/site-lisp")
  "*Name of directory where various emacs related site-wide files reside."    
)

(defvar ecf-site-lisp-path
  (expand-file-name "rc.d" site-lisp-path)     
  "*Site-wide ecf config files directory."
)

(defvar tiny-path-lisp-path
  (expand-file-name "common/packages/tiny-tools/tiny" site-lisp-path)
  "*Name of directory where tinypath.el reside."    
)

(defvar home-etc-path
  (expand-file-name "~/.config/")
  "*Name home config files directory."
)

(defvar emacs-etc-dir
  (expand-file-name "~/.config/")
  "*Name of directory where various emacs related files reside."
)

;;}}}
;;{{{ Prepare needed dirs

(if (not (file-directory-p home-cache-path))
  (make-directory home-cache-path t)          
)

(if (not (file-directory-p emacs-etc-dir))
  (make-directory emacs-etc-dir t)          
)

(if (not (file-directory-p "~/tmp"))
  (make-directory "~/tmp" t)          
)

;;}}}
;;{{{ Tinypath load

;; Search user, host-wide, site-wide configs

(setq ecf-config-load-path
  (list
    ecf-home-etc-path
    ecf-etc-path
    ecf-site-lisp-path
  )
)

(setq load-path
  (append
    ecf-config-load-path
    load-path	
  )
)

(load "rc.tinypath")

;;}}}
;;{{{ Desire load

;; Directory order hack
(setq load-path
  (append
    ecf-config-load-path
    load-path	
  )
)

(load "rc.desire")

;;}}}

;;;  end of site-start.el

