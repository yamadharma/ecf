;;; default.el --- user-wide Emacs defaults for `desire'  -*- lexical-binding: t; coding: utf-8-unix; -*-

;; Copyright (C) 2002-2026 Dmitry S. Kulyabov

;; This file is NOT part of GNU Emacs.  Distributed under the same
;; conditions as GNU Emacs, which are as follows:

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Commentary:
;;
;; Emacs loads this file *after* `site-start.el' and *after* the
;; user's `init.el'.  Its only job is to trigger the master package
;; list once the user's own configuration has had a chance to run.
;;
;; When migrating from `rc.packages.el' to `packages.ecf', replace
;; `(load "rc.packages")' with:
;;
;;   (desire 'packages :no-precondition-check t :ensure nil)
;;
;; (or `desire-packages' if you want to avoid the name clash with any
;; existing `packages' package from ELPA).

;;; Code:

(load "rc.packages")

;;; default.el ends here
