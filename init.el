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

(use-package ace-jump-mode
  :ensure t
  :bind   (("C-;" . ace-jump-line-mode)))

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

(use-package mew
  :ensure t
  :config
  (setq mew-fcc "+fcc"))

(use-package markdown-mode
  :ensure t)

(use-package w3m
  :ensure t)

(use-package beacon
  :ensure t
  :config
  (custom-set-variables
   '(beacon-color "red")
   '(beacon-mode t)
   '(beacon-size 70)
   '(minimap-mode t)
   '(minimap-width-fraction 0.05)))

(use-package rainbow-mode
  :ensure t
  :diminish rainbow-mode
  :config (rainbow-mode t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(beacon-color "red")
 '(beacon-mode t)
 '(beacon-size 70)
 '(column-number-mode t)
 '(display-time-mode t)
 '(minimap-mode t)
 '(minimap-width-fraction 0.05)
 '(nav-boring-file-regexps
   (quote
    ("^[.][^.].*$" "^[.]$" "~$" "[.]elc$" "[.]pyc$" "[.]o$" "[.]bak$" "^_MTN$" "^blib$" "^CVS$" "^RCS$" "^SCCS$" "^_darcs$" "^_sgbak$" "^autom4te.cache$" "^cover_db$" "^_build$" "[.]obj$" "[.]gas$" "[.]lst$" "[.]bin$" "[.]map$" "[.]bim$" "[.]hrb$" "[.]sys$")))
 '(package-selected-packages
   (quote
    (rust-mode cargo racer flycheck-rust flycheck-pos-tip robe smart-compile ruby-electric inf-ruby reverse-theme flycheck corral smart-newline rainbow-delimiters paredit slime neotree yasnippet-snippets company sr-speedbar helm-projectile projectile helm-gtags flymake-cursor cmake-ide rtags pdf-tools yatex powerline elfeed w3m request require orgmine quelpa yasnippet nav auto-complete-c-headers auto-complete auctex-latexmk beacon emacs-w3m markdown-mode undo-tree helm hl-line+ anzu org-mode ace-jump-mode use-package elmine auto-save-buffers-enhanced)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(use-package powerline
  :if window-system
  :ensure t
  :config
  (powerline-default-theme)
  (custom-set-faces
   '(powerline-active1 ((t (:inherit mode-line :background "orange red" :foreground "white" :weight semi-light))))
   '(powerline-active2 ((t (:inherit mode-line :background "dark salmon" :foreground "black" :weight semi-light))))
   '(powerline-inactive1 ((t (:inherit mode-line :background "orange red" :foreground "white" :weight semi-light))))
   '(powerline-inactive2 ((t (:inherit mode-line :background "dark salmon" :foreground "black" :weight semi-light))))))

;; 設定: http://blog.515hikaru.net/entry/2015/11/10/000000
(use-package yatex
  :ensure t
  :config
  (setq auto-mode-alist
        (append '(("\\.tex$" . yatex-mode)
                  ("\\.ltx$" . yatex-mode)
                  ("\\.sty$" . yatex-mode)) auto-mode-alist ))
  (setq YaTeX-kanji-code 4) ; UTF-8 の設定
  (add-hook 'yatex-mode-hook
            '(lambda ()
               (setq YaTeX-use-AMS-LaTeX t) ; align で数式モードになる
               (setq YaTeX-use-hilit19 nil
                     YateX-use-font-lock t)))

  (setq YaTeX-math-funcs-list
        '(("Q" "mathbb{Q}" "(Q)")
          ("ZZ" "mathbb{Z}" "ZZ")
          ("R" "mathbb{R}" "R")
          ("C" "mathbb{C}" "C")
          ("N" "mathbb{N}" "N")
          ("Z>0" "mathbb{Z}_{>0}" "Z>0")
          ("|/" "\mid \hspace{-.67em}/" "|/")
          ("F" "mathbb{F}" "F")
          ("Fp" "mathbb{F}_p" "F_p")
          ("Fq" "mathbb{F}_q" "F_q")
          ("E" "mathcal{E}" "E")
          ("D" "mathcal{D}" "D")
          ("H" "mathcal{H}" "H")))
  (setq YaTeX-math-key-list-private
        '(("," . YaTeX-math-funcs-list))))

;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(default ((t (:family "セプテンバー等幅Ｎ３" :foundry "unknown" :slant normal :weight thin :height 120 :width normal))))
;; '(powerline-active1 ((t (:inherit mode-line :background "orange red" :foreground "white" :weight semi-light))))
;; '(powerline-active2 ((t (:inherit mode-line :background "dark salmon" :foreground "black" :weight semi-light))))
;; '(powerline-inactive1 ((t (:inherit mode-line :background "orange red" :foreground "white" :weight semi-light))))
;; '(powerline-inactive2 ((t (:inherit mode-line :background "dark salmon" :foreground "black" :weight semi-light)))))

(use-package pdf-tools
  :ensure t)

;; C/C++の設定

;; flymake
;; cf.
;; https://www.hiroom2.com/2015/09/18/emacs%E3%81%AEflymake%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E4%BD%BF%E3%81%84%E6%96%B9/
;; http://d.hatena.ne.jp/nyaasan/20071216/p1

;; (use-package flymake-cursor
;;   :ensure t)

;; (require 'flymake)

;; (defun flymake-cc-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;          (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;     (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

;; (push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)
;; (push '("\\.c$" flymake-cc-init) flymake-allowed-file-name-masks)
;; (push '("\\.h$" flymake-cc-init) flymake-allowed-file-name-masks)

;; (add-hook 'c++-mode-hook '(lambda () (flymake-mode t)))
;; (add-hook 'c-mode-hook '(lambda () (flymake-mode t)))

;; cf. http://emacs-jp.github.io/packages/helm/helm-gtags.html
;; 事前に $ sudo apt install global
(use-package helm-gtags
  :ensure t
  :config
  (add-hook 'c-mode-hook 'helm-gtags-mode)
  (add-hook 'c++-mode-hook 'helm-gtags-mode)
  (add-hook 'helm-gtags-mode-hook
            '(lambda ()
            (local-set-key (kbd "M-r") 'helm-gtags-find-tag)
            (local-set-key (kbd "C-r") 'helm-gtags-pop-stack))))

(use-package projectile
  :ensure t
  :diminish
  :config
  (require 'projectile)
  (projectile-global-mode))

(use-package helm-projectile
  :ensure t
  :config
  (require 'helm-projectile)
  (helm-projectile-on))

(use-package rust-mode
  :ensure t
  :config
  (require 'rust-mode))

(use-package sr-speedbar
  :ensure t
  :diminish
  :config
  (require 'sr-speedbar)
  (setq sr-speedbar-right-side nil)
  (global-set-key (kbd "C-x C-d") 'sr-speedbar-toggle))

;; cf. https://qiita.com/sune2/items/b73037f9e85962f5afb7
(use-package company
  :ensure t
  :config
  (require 'company)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)
  (add-hook 'c-mode-hook 'company-mode)
  (add-hook 'c++-mode-hook 'company-mode))

(use-package yasnippet
  :ensure t
  :config
  (require 'yasnippet)
  (setq yas-snippet-dirs
        '("~/.emacs.d/mysnippets"
          yas-installed-snippets-dir))
  (add-hook 'c-mode-hook 'yas-minor-mode))

(use-package yasnippet-snippets
  :ensure t)

(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "sbcl")
  (require 'slime)
  (slime-setup '(slime-repl slime-fancy slime-banner)))

(use-package paredit
  :ensure t
  :config
  (require 'paredit)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-interacton-mode-hook 'enable-paredit-mode))
  
(use-package rainbow-delimiters
  :ensure t
  :diminish
  :config
  (require 'rainbow-delimiters)
  (rainbow-delimiters-mode t))

(use-package flycheck
  :ensure t
  :diminish
  :config
  (require 'flycheck)
  (add-hook 'prog-mode-hook #'global-flycheck-mode))

(use-package flycheck-pos-tip
  :ensure t
  :config
  (require 'flycheck-pos-tip))

(use-package flycheck-rust
  :ensure t
  :config
  (with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))

(use-package smart-newline
  :ensure t
  :bind
  (("C-j" . smart-newline))
  :config
  (require 'smart-newline))

(use-package corral
  :ensure t
  :bind
  (("M-8" . corral-parentheses-backward)
   ("M-9" . corral-parentheses-forward)
   ("M-[" . corral-brackets-backward)
   ("M-]" . corral-brackets-forward)
   ("M-{" . corral-braces-backward)
   ("M-}" . corral-braces-forward)
   ("M-\"" . corral-double-quotes-backward)))

(use-package reverse-theme
  :ensure t)

(use-package inf-ruby
  :ensure t)

(use-package ruby-electric
  :ensure t)

(use-package smart-compile
  :ensure t
  :bind (("C-c c" . smart-compile))
  :config
  (require 'smart-compile)
  (with-eval-after-load 'rust-mode
    (add-to-list 'smart-compile-alist '("\\.rs$" . "rustc %f && ./%n"))))

(use-package robe
  :ensure t
  :config
  (require 'robe))


(use-package racer
  :ensure t
  :config
  (add-hook 'rust-mode #'racer-mode)
  (add-hook 'racer-mode #'eldoc-mode)
  (add-hook 'racer-mode #'company-mode))

(use-package cargo
  :ensure t
  :config
  (add-hook 'rust-mode 'cargo-minor-mode))
