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
;;;; Org , copied from doc.norang.org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/org-mode/lisp"))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
;; flyspell mode for spell checking everywhere
(add-hook 'org-mode-hook 'turn-on-flyspell 'append)
(add-hook 'message-mode-hook 'orgstruct++-mode 'append)
(add-hook 'message-mode-hook 'turn-on-auto-fill 'append)
(add-hook 'message-mode-hook 'bbdb-define-all-aliases 'append)
(add-hook 'message-mode-hook 'orgtbl-mode 'append)
(add-hook 'message-mode-hook 'turn-on-flyspell 'append)
(add-hook 'message-mode-hook
          '(lambda () (setq fill-column 72))
          'append)
(add-hook 'message-mode-hook
          '(lambda () (local-set-key (kbd "C-c M-o") 'org-mime-htmlize))
          'append)
;; Enable abbrev-mode
(add-hook 'org-mode-hook (lambda () (abbrev-mode 1)))

;; Bindings ??? XXX
;(global-set-key (kbd "<f11>") 'org-clock-goto)
;(global-set-key (kbd "C-<f11>") 'org-clock-in)
(global-set-key (kbd "C-c r") 'org-capture)

(setq org-use-fast-todo-selection t)
(setq org-treat-S-cursor-todo-selection-as-state-change nil)
;; Keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))
;; Faces
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))
;; Triggers
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING" . t) ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;; Capture / Remember / Notes
(setq org-default-notes-file "~/org/refile.org")
;; Capture templates for: TODO tasks, Notes, appointments, phone calls, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/org/refile.org")
               "* TODO %?\n%U\n%a\n  %i" :clock-in t :clock-resume t)
              ("n" "note" entry (file "~/org/refile.org")
               "* %? :NOTE:\n%U\n%a\n  %i" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/org/diary.org")
               "* %?\n%U\n  %i" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/org/refile.org")
               "* TODO Review %c\n%U\n  %i" :immediate-finish t)
              ("p" "Phone call" entry (file "~/org/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
	      )))

;; Remove empty LOGBOOK drawers on clock out
(defun org/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(add-hook 'org-clock-out-hook 'org/remove-empty-drawer-on-clock-out 'append)

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
;(ido-mode (quote both))
(ido-mode nil)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun org/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'org/verify-refile-target)

;; AGENDA
(setq org-agenda-files "~/.org-agenda-files")
;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)
;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
	       ((org-agenda-overriding-header "Notes")
		(org-tags-match-list-sublevels t)))
	      ("h" "Habits" tags-todo "STYLE=\"habit\""
	       ((org-agenda-overriding-header "Habits")
		(org-agenda-sorting-strategy
		 '(todo-state-down effort-up category-keep))))
	      (" " "Agenda"
	       ((agenda "" nil)
		(tags "REFILE"
		      ((org-agenda-overriding-header "Tasks to Refile")
		       (org-tags-match-list-sublevels nil)))
		(tags-todo "-CANCELLED/!"
			   ((org-agenda-overriding-header "Stuck Projects")
			    (org-tags-match-list-sublevels 'indented)))
		(tags-todo "-WAITING-CANCELLED/!NEXT"
			   ((org-agenda-overriding-header "Next Tasks")
			    (org-agenda-todo-ignore-scheduled t)
			    (org-agenda-todo-ignore-deadlines t)
			    (org-tags-match-list-sublevels t)
			    (org-agenda-sorting-strategy
			     '(todo-state-down effort-up category-keep))))
		(tags-todo "-REFILE-CANCELLED/!-HOLD-WAITING"
			   ((org-agenda-overriding-header "Tasks")
			    (org-agenda-todo-ignore-scheduled t)
			    (org-agenda-todo-ignore-deadlines t)
			    (org-agenda-sorting-strategy
			     '(category-keep))))
		(tags-todo "-CANCELLED/!"
			   ((org-agenda-overriding-header "Projects")
			    (org-agenda-sorting-strategy
			     '(category-keep))))
		(tags-todo "-CANCELLED/!WAITING|HOLD"
			   ((org-agenda-overriding-header "Waiting and Postponed Tasks")
			    (org-agenda-todo-ignore-scheduled t)
			    (org-agenda-todo-ignore-deadlines t)))
		(tags "-REFILE/"
		      ((org-agenda-overriding-header "Tasks to Archive"))))
	       nil)
	      ("r" "Tasks to Refile" tags "REFILE"
	       ((org-agenda-overriding-header "Tasks to Refile")
		(org-tags-match-list-sublevels nil)))
	      ("#" "Stuck Projects" tags-todo "-CANCELLED/!"
	       ((org-agenda-overriding-header "Stuck Projects")))
	      ("n" "Next Tasks" tags-todo "-WAITING-CANCELLED/!NEXT"
	       ((org-agenda-overriding-header "Next Tasks")
		(org-agenda-todo-ignore-scheduled t)
		(org-agenda-todo-ignore-deadlines t)
		(org-tags-match-list-sublevels t)
		(org-agenda-sorting-strategy
		 '(todo-state-down effort-up category-keep))))
	      ("R" "Tasks" tags-todo "-REFILE-CANCELLED/!-HOLD-WAITING"
	       ((org-agenda-overriding-header "Tasks")
		(org-agenda-sorting-strategy
		 '(category-keep))))
	      ("p" "Projects" tags-todo "-CANCELLED/!"
	       ((org-agenda-overriding-header "Projects")
		(org-agenda-sorting-strategy
		 '(category-keep))))
	      ("w" "Waiting Tasks" tags-todo "-CANCELLED/!WAITING|HOLD"
	       ((org-agenda-overriding-header "Waiting and Postponed tasks"))
	       (org-agenda-todo-ignore-scheduled 'future)
	       (org-agenda-todo-ignore-deadlines 'future))
	      ("A" "Tasks to Archive" tags "-REFILE/"
	       ((org-agenda-overriding-header "Tasks to Archive"))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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


;; usual tuning, default are: max-specpdl-size    1000, max-lisp-eval-depth 500
(setq max-specpdl-size    10000
      max-lisp-eval-depth 5000)

(add-hook 'c-mode-common-hook 'imenu-add-menubar-index)

;;;;;;;;;;;;;;;;;;;;
;;;; Tiny tools
(add-to-list 'load-path
	     "/usr/src/EMACSez/emacs-tiny-tools/lisp/tiny")
(add-to-list 'load-path
	     "/usr/src/EMACSez/emacs-tiny-tools/lisp/other")
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







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(erc-autojoin-domain-only t)
 '(erc-modules (quote (autoaway autojoin button capab-identify completion dcc fill irccontrols keep-place list log match menu move-to-prompt netsplit networks noncommands notify page readonly ring services smiley sound stamp spelling track xdcc)))
 '(erc-user-full-name (quote user-full-name))
 '(flyspell-default-dictionary "italiano")
 '(ibuffer-saved-filter-groups (quote (("mine-buffers-groups" ("Help" (mode . help-mode)) ("GNUS" (or (filename . ".newsrc-dribble") (saved . "gnus"))) ("Custom" (mode . Custom-mode)) ("ERC" (mode . erc-mode))))))
 '(ibuffer-saved-filters (quote (("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
 '(nnimap-nov-is-evil nil)
 '(org-mobile-directory "/home/mbardelli/org")
 '(safe-local-variable-values (quote ((encoding . utf-8) (project-am-localvars-include-path "/usr/include/gtk-2.0" "/usr/lib/gtk-2.0/include" "/usr/include/atk-1.0" "/usr/include/cairo" "/usr/include/pango-1.0" "/usr/include/gio-unix-2.0/" "/usr/include/pixman-1" "/usr/include/freetype2" "/usr/include/directfb" "/usr/include/libpng12" "/usr/include/glib-2.0" "/usr/lib/glib-2.0/include" "/usr/include/libxml2" "/usr/include/dbus-1.0" "/usr/include/json-glib-1.0" "/home/fanaj/Progetti/TorrentFinder/src" "/home/fanaj/Progetti/TorrentFinder") (folded-file . t))))
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
