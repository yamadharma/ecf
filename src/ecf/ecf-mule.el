;; ecf-mule.el -*- coding: iso-2022-7bit-unix; -*-

;; function name: suffix-cut-from
;;   Cuts str after mychar and return.
;;   Returns nil when mychar is not in str.
(defun suffix-cut-from (str mychar)
  (let 
    (
      (ret nil)
      (counter 0)
    )
    (while (< counter (length str))
      (if (string= (substring str counter (1+ counter)) mychar)
	(setq ret counter)
      )
      (setq counter (1+ counter))
    )
    (if ret
	(setq ret (substring str 0 ret))
    )
    ret
  )
)

;; function name: prefix-cut-from
;;   Cuts str befor mychar and return.
;;   Returns nil when mychar is not in str.
(defun prefix-cut-from (str mychar)
  (let 
    (
      (ret nil)
      (counter 0)
    )
    (while (< counter (length str))
      (if (string= (substring str counter (1+ counter)) mychar)
	(setq ret counter)
      )
      (setq counter (1+ counter))
    )
    (if ret
	(setq ret (substring str (1+ ret) (length str)))
    )
    ret
  )
)

;;
;; Test cases for suffix-cut-from
;; (eval (suffix-cut-from ("ja_JP.eucJP", "."))
;; (eval (suffix-cut-from ("ja_JP.eucJP", "_")))
;; (eval (suffix-cut-from ("ja_JP.eucJP", "nonexit")
;;

;; Where is the system dot-emacs for languages
(let 
  (
    (lang)
    (dot-cands-list nil)
  )

  ;; w32-system-coding-system = cp1251
  (setq lang
    (if (eq system-type 'windows-nt)
      (cond
        ;; Russian
        ((equal (w32-get-current-locale-id) 1049)
          "ru_RU.CP1251"
        )
      )
      ;; else
      (getenv "LANG")
    ) ; end if
  )

  (setq system-dot-emacs
    (downcase 
      "ecf-mule/"
    )
  )      

;  (setq system-dot-emacs
;    (downcase 
;      (concat "ecf-mule/" (suffix-cut-from lang "_") "/")
;    )
;  )      

;  (setq system-dot-emacs "")

  ;; Exactly match (in downcase) (i.e. ja_jp.eucjp)
  (setq dot-cands-list 
    (list 
      (downcase 
        (concat system-dot-emacs lang ".el")
      )
    )
  )

  ;; Only codeset match (in downcase) (i.e. eucjp)  
  (if (stringp (prefix-cut-from lang "."))
    (setq dot-cands-list
      (append 
        (list 
          (downcase
            (concat system-dot-emacs (prefix-cut-from lang ".") ".el")
   	  )
        )
	dot-cands-list
      )
    )
  )

  ;; Without codeset match (in downcase) (i.e. ja_jp)
  (if (stringp (suffix-cut-from lang "."))
    (setq dot-cands-list
      (append 
        (list 
          (downcase
            (concat system-dot-emacs (suffix-cut-from lang ".") ".el")
   	  )
        )
	dot-cands-list
      )
    )
  )
  
  ;; Just language name (in downcase) (i.e. ja)
  (if (stringp (suffix-cut-from lang "_"))
    (setq dot-cands-list
      (append 
        (list 
          (downcase
            (concat system-dot-emacs (suffix-cut-from lang "_") ".el")
	  )
        )
	dot-cands-list
      )
    )
  )
  
  ;; Default
;(setq dot-cands-list
;(append dot-cands-list (list (concat system-dot-emacs ".el"))))
  ;;(append dot-cands-list)

 (setq my-dot-cands-list 
        dot-cands-list)

  
  (while (consp dot-cands-list)
    (if (locate-library (car dot-cands-list))
      (prog1 
        (load (car dot-cands-list))
        (setq dot-cands-list 
    	  (cdr dot-cands-list)
	)	  
;        (setq dot-cands-list nil)
      )
      (setq dot-cands-list 
        (cdr dot-cands-list)
      )
    )
  )
)

(provide 'ecf-mule)

;;
