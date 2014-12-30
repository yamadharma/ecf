;;; latex-paren.el --- highlight matching LaTeX parens.

;; F.J.Wright@Maths.QMW.ac.uk, 26 September 1998

;; For GNU Emacs 20 only

;; Based closely on paren.el by RMS

;; latex-paren.el is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; It is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;;; Commentary:

;; Load this and it will improve show-paren-mode highlighting on
;; whatever paren matches the one before or after point in LaTeX mode.
;; It attempts to handle \(, \[, \{ and $ as well as (, [ and {.

;; I suggest that you put this library somewhere in your `load-path'
;; and hang it on `latex-mode-hook' by putting this in `.emacs', so
;; that it is loaded only if necessary:

;; (add-hook 'latex-mode-hook
;;           (function (lambda () (require 'latex-paren))))

;;; Code:

;; General code to handle overloading of the standard show-paren-mode
;; to allow buffer-local handling of paren highlighting.  (Done this
;; way to avoid modifying, and remain compatible with, paren.el.
;; Cannot just use a local hook, because it may be necessary to
;; REPLACE the standard function, which would be on the global hook,
;; and a local hook can only add to the global hook value.)

(require 'paren)

(defvar show-paren-functions 'std-show-paren-function
  "Function (or list of functions) to highlight matching parentheses etc.
The function(s) will be run automatically by a timer.
Give this variable buffer-local values to run custom functions.
Not to be changed by the casual user, hence not customizable!")

(fset 'std-show-paren-function (symbol-function 'show-paren-function))
(defun show-paren-function () (run-hooks 'show-paren-functions))


;; Specific code for LaTeX mode.

(let ((fn (function (lambda ()
		      (set (make-local-variable 'show-paren-functions)
			   'latex-show-paren-function)
		      ))))
  (add-hook 'latex-mode-hook fn)
  (apply fn nil))

(defun latex-show-paren-function ()
  ;; Do nothing if no window system to display results with.
  ;; Do nothing if executing keyboard macro.
  ;; Do nothing if input is pending.
  (when window-system
    (let (pos dir mismatch face (oldpos (point)) charquote)
      (cond ((eq (char-syntax (preceding-char)) ?\))
	     (setq dir -1)
	     (setq charquote (uncharquote (char-after (- (point) 2)))))
	    ((eq (char-syntax (following-char)) ?\()
	     (setq dir 1)
	     (setq charquote (uncharquote (preceding-char)))) 
	    ((and (eq (char-syntax (preceding-char)) ?\$)
		  (not (eq (char-syntax (char-after (- (point) 2))) ?/)))
	     (setq dir -1))
	    ((and (eq (char-syntax (following-char)) ?\$)
		  (not (eq (char-syntax (preceding-char)) ?/)))
	     (setq dir 1)))
      ;;
      ;; Find the other end of the sexp.
      (when dir
	(save-excursion
	  (save-restriction
	    ;; Determine the range within which to look for a match.
	    (when blink-matching-paren-distance
	      (narrow-to-region
	       (max (point-min) (- (point) blink-matching-paren-distance))
	       (min (point-max) (+ (point) blink-matching-paren-distance))))
	    ;; Scan across one sexp within that range.
	    ;; Errors or nil mean there is a mismatch.
	    (condition-case ()
		(setq pos (scan-sexps (point) dir))
	      (error (setq pos t mismatch t)))
	    ;; If found a "matching" paren, see if it is the right
	    ;; kind of paren to match the one we started at.
	    (when (integerp pos)
	      (let* ((beg (min pos oldpos)) (end (max pos oldpos))
		     (begchar (char-after beg)))
		(setq mismatch
		      (not (eq (char-before end)
			       (if (eq (char-syntax begchar) ?\$) begchar
				 ;; This can give nil.
				 (matching-paren begchar))))))))))
      (if charquote (recharquote charquote))
      ;;
      ;; Highlight the other end of the sexp, or unhighlight if none.
      (if (not pos)
	  (progn
	    ;; If not at a paren that has a match,
	    ;; turn off any previous paren highlighting.
	    (and show-paren-overlay (overlay-buffer show-paren-overlay)
		 (delete-overlay show-paren-overlay))
	    (and show-paren-overlay-1 (overlay-buffer show-paren-overlay-1)
		 (delete-overlay show-paren-overlay-1)))
	;;
	;; Use the correct face.
	(if mismatch
	    (progn
	      (if show-paren-ring-bell-on-mismatch
		  (beep))
	      (setq face 'show-paren-mismatch-face))
	  (setq face 'show-paren-match-face))
	;;
	;; If matching backwards, highlight the closeparen
	;; before point as well as its matching open.
	;; If matching forward, and the openparen is unbalanced,
	;; highlight the paren at point to indicate misbalance.
	;; Otherwise, turn off any such highlighting.
	(if (and (= dir 1) (integerp pos))
	    (when (and show-paren-overlay-1
		       (overlay-buffer show-paren-overlay-1))
	      (delete-overlay show-paren-overlay-1))
	  (let ((from (if (= dir 1)
			  (point)
			(forward-point -1)))
		(to (if (= dir 1)
			(forward-point 1)
		      (point))))
	    (if show-paren-overlay-1
		(move-overlay show-paren-overlay-1 from to (current-buffer))
	      (setq show-paren-overlay-1 (make-overlay from to)))
	    ;; Always set the overlay face, since it varies.
	    (overlay-put show-paren-overlay-1 'face face)))
	;;
	;; Turn on highlighting for the matching paren, if found.
	;; If it's an unmatched paren, turn off any such highlighting.
	(unless (integerp pos)
	  (delete-overlay show-paren-overlay))
	(let ((to (if (or (eq show-paren-style 'expression)
			  (and (eq show-paren-style 'mixed)
			       (not (pos-visible-in-window-p pos))))
		      (point)
		    pos))
	      (from (if (or (eq show-paren-style 'expression)
			    (and (eq show-paren-style 'mixed)
				 (not (pos-visible-in-window-p pos))))
			pos
		      (save-excursion
			(goto-char pos)
			(forward-point (- dir))))))
	  (if show-paren-overlay
	      (move-overlay show-paren-overlay from to (current-buffer))
	    (setq show-paren-overlay (make-overlay from to))))
	;;
	;; Always set the overlay face, since it varies.
	(overlay-put show-paren-overlay 'face face)))))

(defun uncharquote (c)
  (cond ((eq (char-syntax c) ?/)
	 (modify-syntax-entry c ".") c)))

(defun recharquote (c) (modify-syntax-entry c "/"))

(provide 'latex-paren)

;;; latex-paren.el ends here
