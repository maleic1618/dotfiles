;; default settings
(global-linum-mode)
(show-paren-mode)
(keyboard-translate ?\C-h ?\C-?)
(setq inhibit-startup-message t)
(setq x-select-enable-clipboard t)
(setq-default indent-tabs-mode nil)
(menu-bar-mode 0)
(tool-bar-mode 0)
(set-frame-parameter nil 'fullscreen 'fullboth)
;;(load-theme 'tsdh-dark t)
(setq make-backup-files nil)
(define-key mode-specific-map "c" 'compile)
(setq auto-mode-alist
      (append '(("\\.nas$" . asm-mode))
              auto-mode-alist))
(put 'use-package 'lisp-indent-function '1)
;;(add-to-list 'default-frame-alist
;;             '(font . "セプテンバー等幅Ｎ３-12:bold"))
(setq compilation-scroll-output t)
(server-start)
(global-hl-line-mode)
(set-face-attribute hl-line-face nil :underline t)
(column-number-mode t)
(line-number-mode t)
(setq truncate-partial-width-windows nil)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-/") 'indent-region)
(electric-pair-mode t)

;; transparent
(defun set-alpha (alpha-num)
  "set frame parameter 'alpha"
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha (cons alpha-num '(90))))
(if window-system 
    (set-frame-parameter nil 'alpha 100))

;; open init.el
(defun open-init-el ()
  (interactive)
  (switch-to-buffer (find-file-noselect "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c C-e") 'open-init-el)

;; modeline

(setq display-time-string-forms
      '((format "%s/%s/%s(%s) %s:%s" year month day dayname 24-hours minutes)
        load))
(setq display-time-24hr-format t)
(display-time)

;; newline below current line
(defun my-insert-newline-and-indent ()
  "insert new line below current line"
  (interactive)
  (end-of-line)
  (unless (string-equal ";" (char-to-string (following-char)))
    (insert ";"))
  (smart-newline))
(global-set-key (kbd "C-j") 'my-insert-newline-and-indent)

;; additional configuration

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org"   . "http://orgmode.org/elpa/"))
(unless package-archive-contents
  (package-refresh-contents)
  (package-initialize))
(unless (require 'use-package nil t)
  (package-install 'use-package))

(use-package diminish
  :ensure t
  :config (require 'diminish))

(use-package bind-key
  :ensure t
  :config (require 'bind-key))

(use-package quelpa
  :ensure t
  :config
  (setq quelpa-upgrade-p nil
        quelpa-checkout-melpa-p nil
        quelpaupdate-melpa-p nil
        quelpa-melpa-recipe-stores nil))

(use-package org
  :ensure t)

(use-package anzu
  :ensure t
  :diminish anzu-mode
  :config (global-anzu-mode))

(use-package helm
  :ensure t
  :diminish (helm-mode)
  :bind   (("M-x"   . helm-M-x)
           ("C-x b" . helm-buffers-list)
           ("C-x C-f". helm-find-files))
  :config
  (require 'helm-config)
  (helm-mode t))

(use-package undo-tree
  :ensure t
  :diminish (undo-tree-mode)
  :bind   (("M-/" . undo-tree-redo)
           ("C-/" . undo-tree-undo)
           ("C-x u" . undo-tree-visualize))
  :config (global-undo-tree-mode t))

(use-package auto-save-buffers-enhanced
  :ensure t
  :config
  (setq auto-save-buffers-enhanced-interval 1)
  (auto-save-buffers-enhanced t))
