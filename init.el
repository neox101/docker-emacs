
;; this file is user-init-file
(setq user-init-file (or load-file-name (buffer-file-name)))
;; user-emacs-directory is defined in subr.el , which is same as this.
(setq user-emacs-directory (file-name-directory user-init-file))


(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(let ((packages (getenv "EMACS_PACKAGES")))
  (when packages
    (dolist (package (split-string packages))
      (add-to-list 'package-selected-packages (intern package)))))

(package-install-selected-packages)
(message "Hello")

(eval-after-load "ox-html" (setq org-html-prefer-user-labels t))
(message "Hello World")
