;; ecf-mule/ru.el -*- coding: iso-2022-7bit-unix; -*-

(codepage-setup 866)
(codepage-setup 1251)

(define-coding-system-alias 'koi8-u 'koi8-r)

(define-coding-system-alias 'windows-1251 'cp1251)
(define-coding-system-alias 'win-1251 'cp1251)

;;{{{ Create Cyrillic-CP1251 Language Environment menu item

(set-language-info-alist
  "Cyrillic-CP1251" 
    `(
      (charset cyrillic-iso8859-5)
      (coding-system cp1251)
      (coding-priority cp1251)
      (input-method . "cyrillic-jcuken")
      (features cyril-util)
      (unibyte-display . cp1251)
      (sample-text . "Russian (Русский)    Здравствуйте!")
      (documentation . "Support for Cyrillic CP1251.")
    )
    '("Cyrillic")
)

;;}}}

(message "ru.el !!!!!!!!!!!!!!!!!!!!")

