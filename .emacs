;; -*- mode: Emacs-Lisp; coding: utf-8; unibyte: t; -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; My Name
(setq user-full-name "Marco Bardelli")

;; My all is in ~/.emacs.d/emacs.fanaj
(unless (bound-and-true-p user-emacs-directory)
  (setq user-emacs-directory (expand-file-name "~/.emacs.d/")))
(add-to-list 'load-path user-emacs-directory)
; make all yes/no prompts y/n instead
(fset 'yes-or-no-p 'y-or-n-p)
(defun reload-dot-emacs() "" (interactive)
  (eval-buffer (find-file-noselect user-init-file))) ;;"~/.emacs" , this file

(if window-system
      (global-set-key [?\C-<] 'other-window)
  (global-set-key [?\C-z] 'other-window))
(unless (keymapp 'my-prefix-map)
  (define-prefix-command 'my-prefix-map)) ; my-prefix-map


(require 'my-elib
	 (expand-file-name "my-elib.el" user-emacs-directory) t)
(require 'my-bindkeys
	 (expand-file-name "my-bindkeys.el" user-emacs-directory) t)
(require 'mail-and-gnus
	 (expand-file-name "mail-and-gnus.el" user-emacs-directory) t)

;; load several elisp by emacswiki
(require 'my-elisp
	 (expand-file-name "my-elisp.el" user-emacs-directory) t)


;; usual tuning, default are: max-specpdl-size    1000, max-lisp-eval-depth 500
(setq max-specpdl-size    10000
      max-lisp-eval-depth 5000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Load a clean cedet
(defsubst load-upstream-cedet ()
  (load-file (expand-file-name "~/Progetti/cedet/TREE/common/cedet.el")))

(or nil (bound-and-true-p cedet-version)
    (dolist (LP load-path)
      (and (string-match "cedet$" LP)
	   (setq load-path
		 (remove LP load-path))))
    (load-upstream-cedet)
    )

(add-hook 'c-mode-common-hook 'imenu-add-menubar-index)


;;;;;;;;;;;;;;;;;;;;;
;;;; Google Stuff
(add-to-list 'load-path (expand-file-name "g-client" user-emacs-directory))
(require 'g)
(setq g-user-email "bardelli.marco@gmail.com")
(setq g-html-handler 'browse-url-of-buffer)
;(load-file (expand-file-name "g-stub.el" user-emacs-directory))
(gcal-emacs-calendar-setup)


;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Maunal Customization
(tool-bar-mode 0)







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(nnimap-nov-is-evil nil t)
 '(safe-local-variable-values (quote ((project-am-localvars-include-path "/usr/include/gtk-2.0" "/usr/lib/gtk-2.0/include" "/usr/include/atk-1.0" "/usr/include/cairo" "/usr/include/pango-1.0" "/usr/include/gio-unix-2.0/" "/usr/include/pixman-1" "/usr/include/freetype2" "/usr/include/directfb" "/usr/include/libpng12" "/usr/include/glib-2.0" "/usr/lib/glib-2.0/include" "/usr/include/libxml2" "/usr/include/dbus-1.0" "/home/fanaj/Progetti/TorrentFinder/src" "/home/fanaj/Progetti/TorrentFinder") (folded-file . t))))
 '(vc-diff-switches "-Nup"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )







;(reload-dot-emacs)
(reload-my-bindkeys)
