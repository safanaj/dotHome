;; -*- mode: Emacs-Lisp; coding: utf-8; unibyte: t; -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; My Name
(setq user-full-name "Marco Bardelli")
(setq user-mail-address "bardelli.marco@gmail.com")

(if (and
     (file-exists-p "/run/NetworkManager/location")
     (string=
      (replace-regexp-in-string
       "\n" ""
       (with-temp-buffer
	 (insert-file-contents "/run/NetworkManager/location") (buffer-string))) "work"))
    (progn
      (setq url-proxy-services
	    '(("http" . "http://m.bardelli:proxyaraknos@10.0.0.37")))
      (setq user-mail-address "m.bardelli@araknos.it")))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; My all is in ~/.emacs.d/emacs.fanaj
(unless (bound-and-true-p user-emacs-directory)
  (setq user-emacs-directory (expand-file-name "~/.emacs.d/")))

(require 'auto-install nil t)
(and (boundp 'auto-install-directory)
     (add-to-list 'load-path auto-install-directory))

(add-to-list 'load-path user-emacs-directory)
; make all yes/no prompts y/n instead
(fset 'yes-or-no-p 'y-or-n-p)
(defun reload-dot-emacs() "" (interactive)
  (eval-buffer
   (find-file-noselect
    (or user-init-file
	(expand-file-name "~/.emacs"))))) ;;"~/.emacs" , this file

(if window-system
      (global-set-key [?\C-<] 'other-window)
  (global-set-key [?\C-z] 'other-window))
(unless (keymapp 'my-prefix-map)
  (define-prefix-command 'my-prefix-map)) ; my-prefix-map

;; do not make backup ~ files
(setq make-backup-files nil)

(require 'sr-speedbar nil t)
(and (featurep 'sr-speedbar)
     (global-set-key (kbd "<f9>") 'sr-speedbar-toggle))

(require 'ecb-autoloads nil t)

(require 'ido)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'my-org
	 (expand-file-name "my-org.el" user-emacs-directory) t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'my-elib
	 (expand-file-name "my-elib.el" user-emacs-directory) t)
(require 'my-bindkeys
	 (expand-file-name "my-bindkeys.el" user-emacs-directory) t)
;; load several elisp by emacswiki
;; (require 'my-elisp
;; 	 (expand-file-name "my-elisp.el" user-emacs-directory) t)

(require 'my-mails
	 (expand-file-name "my-mails.el" user-emacs-directory) t)

(require 'my-cedet
	 (expand-file-name "my-cedet.el" user-emacs-directory) t)


;; usual tuning, default are: max-specpdl-size    1000, max-lisp-eval-depth 500
(setq max-specpdl-size    10000
      max-lisp-eval-depth 5000)

(add-hook 'c-mode-common-hook 'imenu-add-menubar-index)
(add-hook 'c-mode-common-hook 'gtags-mode)
(semanticdb-enable-gnu-global-databases 'c-mode)

;;;;;;;;;;;;;;;;;;;;
;;;; Tiny tools
;; (add-to-list 'load-path
;; 	     "/usr/src/EMACSez/emacs-tiny-tools/lisp/tiny")
;; (add-to-list 'load-path
;; 	     "/usr/src/EMACSez/emacs-tiny-tools/lisp/other")
(require 'tinydebian nil t)
(require 'tinygnus nil t)

;;;;;;;;;;;;;;;;;;;;;
;;;; Google Stuff
;; (add-to-list 'load-path (expand-file-name "g-client" user-emacs-directory))
;; (require 'g)
;; (setq g-user-email "bardelli.marco@gmail.com")
;; (setq g-html-handler 'browse-url-of-buffer)
;; ;(load-file (expand-file-name "g-stub.el" user-emacs-directory))
;; (gcal-emacs-calendar-setup)

;;;;;;;;;;;;;;;;;;;;
;;;; JS coding
(and
 (require 'js2-mode nil t)
 (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))

(when (require 'js-comint nil t)
  ;(setq inferior-js-program-command "/usr/bin/gjs")
  (setq inferior-js-program-command "/usr/bin/smjs")
  (add-hook 'js2-mode-hook '(lambda ()
			      (local-set-key "\C-x\C-e" 'js-send-last-sexp)
			      (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
			      (local-set-key "\C-cb" 'js-send-buffer)
			      (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
			      (local-set-key "\C-cl" 'js-load-file-and-go)
			      ))
  )


;;;;;;;;;;;;;;; Wiki and Web editing
(when (and (daemonp) (require 'edit-server (expand-file-name "emacs_chrome/servers/edit-server.el" user-emacs-directory) t))
  (edit-server-start))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Maunal Customization
(tool-bar-mode 0)
(ido-mode 0)
(load-library "rpm-spec-mode")
(load-library "tramp-loaddefs")







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cedet-android-sdk-root "~/usrc/android-sdk-linux/")
 '(ecb-options-version "2.40")
 '(ede-project-directories (quote ("/home/mbardelli/usrc/Others/libpcap" "/home/mbardelli/src/Akab1/traffik")))
 '(erc-autojoin-domain-only t)
 '(erc-modules (quote (autoaway autojoin button capab-identify completion dcc fill irccontrols keep-place list log match menu move-to-prompt netsplit networks noncommands notify page readonly ring services smiley sound stamp spelling track xdcc)))
 '(erc-user-full-name (quote user-full-name))
 '(flyspell-default-dictionary "italiano")
 '(ibuffer-saved-filter-groups (quote (("programming" ("Terminals" (or (used-mode . eshell-mode) (used-mode . term-mode))) ("Help" (mode . help-mode)) ("GNUS" (or (filename . ".newsrc-dribble") (saved . "gnus"))) ("Custom" (mode . Custom-mode)) ("ERC" (mode . erc-mode))) ("mine-buffers-groups" ("Help" (mode . help-mode)) ("GNUS" (or (filename . ".newsrc-dribble") (saved . "gnus"))) ("Custom" (mode . Custom-mode)) ("ERC" (mode . erc-mode))))))
 '(ibuffer-saved-filters (quote (("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
 '(nnimap-nov-is-evil nil)
 '(org-mobile-directory "/home/mbardelli/org")
 '(safe-local-variable-values (quote ((project-am-localvars-include-path "/usr/include/gtk-2.0" "/usr/lib/gtk-2.0/include" "/usr/include/atk-1.0" "/usr/include/cairo" "/usr/include/pango-1.0" "/usr/include/gio-unix-2.0/" "/usr/include/pixman-1" "/usr/include/freetype2" "/usr/include/directfb" "/usr/include/libpng12" "/usr/include/glib-2.0" "/usr/lib/glib-2.0/include") (semantic-dependency-system-include-path "/home/mbardelli/src/Akab2/gitz/akab2_all/code" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/mw" "/usr/lib/python2.7" "/usr/lib/python2.7/plat-x86_64-linux-gnu" "/usr/lib/python2.7/lib-tk" "/usr/lib/python2.7/lib-dynload" "/usr/local/lib/python2.7/dist-packages" "/usr/lib/python2.7/dist-packages" "/usr/lib/python2.7/dist-packages/PILcompat" "/usr/lib/python2.7/dist-packages/gst-0.10" "/usr/lib/python2.7/dist-packages/gtk-2.0" "/usr/lib/pymodules/python2.7") (semantic-dependency-system-include-path "/home/mbardelli/src/Akab2/gitz/akab2_all/code" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/mw") (encoding . utf8) (epa-file-select-keys . "8D5B478CF7FE4DAA") (make-backup-files) (project-am-localvars-include-path "/usr/include/glib-2.0" "/usr/lib/x86_64-linux-gnu/glib-2.0/include" "/usr/include/gio-unix-2.0/" "/usr/lib/glib-2.0/include") (project-am-localvars-include-path "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/libakutils") (project-am-localvars-include-path "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-plugins/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-plugins/sf_engine/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/sfutil/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-output/libs/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-output/plugins/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/libakutils/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/libakevent/") (project-am-localvars-include-path "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-plugins/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-plugins/sf_engine/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-plugins/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/sfutil/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-output/libs/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-output/plugins/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/libakutils/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/libakevent/") (project-am-localvars-include-path "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-plugins/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-plugins/sf_engine/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/libakutils/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/libakevent/") (indent-tabs-mode . 1) (project-am-localvars-include-path "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-plugins/" "/home/mbardelli/src/Akab2/gitz/akab2_all/code/sources/external/snort/snort-2.9.3.1/src/dynamic-plugins/sf_engine/") (c-indent-offset . 2) (project-am-localvars-include-path "/usr/include/glib-2.0" "/usr/lib/glib-2.0/include" "/usr/include/gio-unix-2.0") (py-indent-offset . 4) (project-am-localvars-include-path "/usr/include/glib-2.0" "/usr/lib/x86_64-linux-gnu/glib-2.0/include" "/usr/include/pango-1.0" "/usr/include/gtk-3.0" "/usr/include/gio-unix-2.0/" "/usr/include/cairo" "/usr/include/atk-1.0" "/usr/include/at-spi2-atk/2.0" "/usr/include/gdk-pixbuf-2.0" "/usr/include/freetype2" "/usr/include/pixman-1" "/usr/include/libpng12" "/usr/include/libdrm" "/usr/include/vte-2.90" "/usr/lib/glib-2.0/include") (encoding . utf-8) (project-am-localvars-include-path "/usr/include/gtk-2.0" "/usr/lib/gtk-2.0/include" "/usr/include/atk-1.0" "/usr/include/cairo" "/usr/include/pango-1.0" "/usr/include/gio-unix-2.0/" "/usr/include/pixman-1" "/usr/include/freetype2" "/usr/include/directfb" "/usr/include/libpng12" "/usr/include/glib-2.0" "/usr/lib/glib-2.0/include" "/usr/include/libxml2" "/usr/include/dbus-1.0" "/usr/include/json-glib-1.0" "/home/fanaj/Progetti/TorrentFinder/src" "/home/fanaj/Progetti/TorrentFinder") (folded-file . t))))
 '(vc-diff-switches "-Nup"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )







;(reload-dot-emacs)
(reload-my-bindkeys)

(put 'narrow-to-region 'disabled nil)
