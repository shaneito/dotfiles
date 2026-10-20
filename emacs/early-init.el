;;; early-init.el -*- lexical-binding: t; -*-
(add-to-list 'default-frame-alist '(undecorated . t))
(setq frame-resize-pixelwise t)

;; Hide the scroll bar
(push '(vertical-scroll-bars . nil) default-frame-alist)
;; Padding between the frame edge and the text (pixels)
(push '(internal-border-width . 16) default-frame-alist)
;; Default font: MonoLisa 16pt, set before the first frame to avoid a resize flash
(push '(font . "MonoLisa-16") default-frame-alist)
;; Paint the frame Catppuccin Mocha's background colour until the theme loads
(push '(background-color . "#1e1e2e") default-frame-alist)
