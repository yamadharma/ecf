;; flyspell-textcat.el -- Switch flyspell language according to
;;                        libtextcat machine categorization for each
;;                        paragraph
;;
;; Copyright (C) 2008 Martin Pohlack
;;
;; Author:  Martin Pohlack <mp26@os.inf.tu-dresden.de>
;; URL:     http://os.inf.tu-dresden.de/~mp26/download/flyspell-textcat.el
;; Version: 0.1
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; If you do not have a copy of the GNU General Public License, you
;; can obtain one by writing to the Free Software Foundation, Inc., 59
;; Temple Place - Suite 330, Boston, MA 02111-1307, USA.

;;; Installation:
;;
;;    (autoload 'flyspell-textcat-setup "flyspell-textcat")
;;    (add-hook 'latex-mode-hook 'flyspell-textcat-setup)
;;
;;    [untested]
;;
;;  Manueally load the library after ispell-multi and just activate
;;  the minor mode via M-x 'flyspell-textcat-mode'.

;;; Commentary:
;;
;;  flyspell-textcat uses an external library (libtextcat) to
;;  automatically categorize the language of the current document.
;;  Currently this is done on a paragraph basis, which makes this
;;  minor mode useful for multi-language documents, without parseable
;;  language tags (such as text files etc.).
;;
;;  This mode was inspire by flyspell-babel.el by Peter Heslin which
;;  tries to extract language information from latex commands.
;;
;;  This mode relies on ispell-multi, which basically caches *spell
;;  processes for each language seen, instead of restarting new ones
;;  all the time a languae change is seen.
;;
;;  [Untested with xemacs]

;;; Customization:
;;
;;    (setq flyspell-textcat-to-ispell-alist
;;          '(("german"  "deutsch")
;;            ("english" "american")
;;            ("french"  "francais")));;

;;; Bugs:
;;
;;   - ispell-multi.el (which flyspell-textcat relies on) seems to
;;     sometimes spawn new aspell processes for each new region
;;     instead of reusing them.  This bug seems to be in ispell-multi
;;     as I have seen this too with flyspell-babel.  So, its not a
;;     real flyspell-textcat bug.

;;; Changes
;;
;; 0.1 Initial public release

(require 'ispell-multi)
(require 'flyspell)

; parse buffer per paragraph
; for each one call libtextcat
; translate the result to ispell dict name
; install property


(defgroup flyspell-textcat nil
  "Switch flyspell language automatically for each paragraph
   according to libtextcat categorization"
  :tag "Switch flyspell language using libtextcat for each paragraph"
  :group 'FlySpell
  :prefix "flyspell-textcat-")

(defcustom flyspell-textcat-to-ispell-alist
  '((german  . deutsch)
    (english . american)
    (french  . francais))
  "Maps libtextcat language names to ispell dictionary names"
  :type 'alist
  :group 'flyspell-textcat)

(defcustom flyspell-textcat-delay 5
  "Seconds of idleness before current paragraph is re-parsed."
  :type 'integer
  :group 'flyspell-textcat)

(defcustom flyspell-textcat-temp-buffer "*flyspell-textcat-output*"
  "Buffer name for temporary output from external tool."
  :type 'string
  :group 'flyspell-textcat)

(defcustom flyspell-textcat-external-classifyier "testtextcat"
  "Name for external classification tool."
  :type 'string
  :group 'flyspell-textcat)

(defcustom flyspell-textcat-external-param
  (expand-file-name "~/.libtextcat.conf")
  "Parameter for external classification tool."
  :type 'string
  :group 'flyspell-textcat)

(defcustom flyspell-textcat-external-regexp
  "^Result == \\[?\\([a-zA-Z]+\\)\\]?.*$"
  "RegExp for extracting results from external classification tool."
  :type 'string
  :group 'flyspell-textcat)

(defun flyspell-textcat-parse-buffer ()
  (goto-char (point-max))
  (save-window-excursion
    (with-temp-message "Categorizing ..."
      (while (and (= (backward-paragraph) 0)
                  (not (input-pending-p)))
        (save-excursion (flyspell-textcat-parse-paragraph-int))))))

(defun flyspell-textcat-parse-paragraph ()
  "Flag the current paragraph."
  (save-window-excursion
    (with-temp-message "Categorizing ..."
      (flyspell-textcat-parse-paragraph-int))))

(defun flyspell-textcat-parse-paragraph-int ()
  "Flag the current paragraph without wrapping protections."
  (backward-paragraph)
  (setq start (point))
  (forward-paragraph)
  (setq end (point))
  ;; get a temp buffer and clear it
  (let ((buffer (get-buffer-create flyspell-textcat-temp-buffer)))
    (save-excursion
      (set-buffer buffer)
      (erase-buffer))
    (unwind-protect
        (setq exit-status
              (call-process-region start end
                                   flyspell-textcat-external-classifyier
                                   nil buffer nil
                                   flyspell-textcat-external-param))))
  (flyspell-textcat-flag-region start end
                                (flyspell-textcat-extract-result)))

(defun flyspell-textcat-extract-result ()
  "Extract the result from the shell buffer."
  (save-excursion
    (set-buffer flyspell-textcat-temp-buffer)
    (goto-char (point-min))
    (re-search-forward flyspell-textcat-external-regexp)
    (match-string 1)))

(defun flyspell-textcat-flag-region (beg end lang)
  (let ((trans (assoc lang flyspell-textcat-to-ispell-alist))
        (buffer-modified-before (buffer-modified-p))
        (after-change-functions nil))
    (when trans
      ;; We have a translation of a libtextcat language name to ispell
      ;; nomenclature
      (setq lang (cadr trans)))
    (cond
     ((not lang)
      ;; A parsed region with a nil dict -- don't spell-check.
      (setq lang "void"))
     ((equal lang "UNKNOW")
      (setq lang "default"))
     ((equal lang "SHORT")
      (setq lang "default"))
     ((and ispell-multi-valid-dictionary-list
           (not (member lang ispell-multi-valid-dictionary-list)))
      ;; A parsed region with an uninstalled dict
      (message "Flyspell-textcat warning: no dictionary installed for %s" lang)
      (setq lang "void")))
    (put-text-property beg end 'ispell-multi-lang lang)
    (set-buffer-modified-p buffer-modified-before)))

(defun flyspell-textcat-start ()
  ;; Be lazy, do not delay buffer startup
  ;(flyspell-textcat-parse-buffer)
  (setq ispell-multi-nil-callback 'flyspell-textcat-parse-paragraph)
  (make-local-variable 'flyspell-large-region)
  (setq flyspell-large-region 'nil)
  (flyspell-mode 1)
  (setq flyspell-generic-check-word-p 'ispell-multi-verify)
  (setq ispell-multi-idler-callback 'flyspell-textcat-parse-buffer)
  (ispell-multi-idler-setup flyspell-textcat-delay)
  (ispell-multi-hack-flyspell-modeline))

(defun flyspell-textcat-stop ()
  (setq flyspell-generic-check-word-p nil)
  (ispell-multi-unhack-flyspell-modeline)
  (flyspell-mode -1))

(define-minor-mode flyspell-textcat-mode
  "Mode to automatically select flyspell language for each
   paragraph using libtextcat" nil
      :group 'flyspell-textcat
      (if flyspell-textcat-mode
          (flyspell-textcat-start)
	(flyspell-textcat-stop)))

(defun flyspell-textcat-setup ()
  (flyspell-textcat-mode 1))

(provide 'flyspell-textcat)
