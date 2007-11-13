;; ecf-mule/utf-8.el  -*- coding: utf-8 -*-

;;{{{ Coding system

(set-default-coding-systems 'utf-8)	
(prefer-coding-system 'utf-8)

(setq default-buffer-file-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(set-selection-coding-system 'utf-8)
(setq selection-coding-system 'utf-8)

(setq file-name-coding-system 'utf-8)
(setq default-process-coding-system 'utf-8)

(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;;}}}
