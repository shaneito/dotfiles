;;; init.el -*- lexical-binding: t; -*-
;; Package archives: GNU and NonGNU ELPA are built in; add MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq package-archive-priorities
      '(("gnu" . 3) ("nongnu" . 2) ("melpa" . 1)))


;; Left Option = Meta; right Option kept for # on UK keyboards
(setq ns-option-modifier 'meta
      ns-right-option-modifier 'none)

(setq custom-file (locate-user-emacs-file "custom.el"))

;; Code and prose faces (height 1.0 = same size as default)
(set-face-attribute 'fixed-pitch nil :family "MonoLisa" :height 1.0)
(set-face-attribute 'variable-pitch nil :family "Inter" :height 1.0)

;; Italic comments, which suit MonoLisa's italics
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)

;; Fallbacks: colour emoji and Nerd Font icons
(set-fontset-font t 'emoji (font-spec :family "Apple Color Emoji") nil 'prepend)
(set-fontset-font t 'symbol (font-spec :family "Symbols Nerd Font Mono") nil 'append)

;; Ligatures (needs MELPA, which you've already added)
(use-package ligature
  :ensure t
  :config
  (ligature-set-ligatures
   'prog-mode
   '("->" "=>" "<-" "<=" ">=" "==" "===" "!=" "!==" "::" ":="
     "&&" "||" "|>" "<|" "++" "--" "//" "/*" "*/" "..." ".."
     "<>" "</" "/>" "</>" "##" "###" "<<" ">>" "**" "=~" "!~"))
  (global-ligature-mode 1))


(use-package catppuccin-theme
  :ensure t
  :config
  (setq catppuccin-flavor 'mocha) ;; latte, frappe, macchiato or mocha
  (load-theme 'catppuccin :no-confirm))


(load custom-file 'noerror)

(which-key-mode 1)
