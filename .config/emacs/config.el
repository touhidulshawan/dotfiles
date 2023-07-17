(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
	use-package-expand-minimally t))

(set-face-attribute 'default nil
  :font "JetBrainsMono Nerd Font"
  :height 105
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "JetBrainsMono Nerd Font"
  :height 90
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrainsMono Nerd Font"
  :height 90 
  :weight 'medium)

(require 'tree-sitter)
(require 'tree-sitter-langs)
(global-tree-sitter-mode t)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(show-paren-mode 1)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(prefer-coding-system 'utf-8)

(fset 'yes-or-no-p 'y-or-n-p)
 ;; use primary as clipboard
 (setq-default x-select-enable-primary t)
 ;; avoid leaving a gap between the frame and the screen
 (setq-default frame-resize-pixelwise t)

;; Vim like scrolling
 (setq scroll-step            1
       scroll-conservatively  10000
       next-screen-context-lines 5
       ;; move by logical lines rather than visual lines (better for macros)
       line-move-visual nil)

(customize-set-value 'recentf-make-menu-items 150)
(customize-set-value 'recentf-make-saved-items 150)

(load-theme 'gruvbox-dark-hard t)

(use-package evil
     :init
     (setq evil-want-integration t
           evil-want-keybinding nil
           evil-vsplit-window-right t
           evil-split-window-below t)
     (evil-mode))

   (use-package evil-collection
     :after evil
     :config
     (setq evil-collection-mode-list '(dashboard dired ibuffer))
     (evil-collection-init))

   ;; jj to escape to normal mode
(evil-escape-mode)
(setq-default evil-escape-key-sequence "jj"
              evil-escape-delay 0.2
              evil-escape-inhibit-functions '(evil-visual-state-p))

(use-package dashboard
  :init
  (setq dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-display-icons-p t
        dashboard-startup-banner "~/.config/emacs/gruvbox.png"
        dashboard-center-content nil
        dashboard-items '((recents . 8)))
        :config
        (dashboard-setup-startup-hook))
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
(setq doom-fallback-buffer-name "*dashboard*")

(setq org-adapt-indentation t
      org-startup-indented t
      org-startup-with-inline-images t
      org-image-actual-width 400
      org-hide-emphasis-markers t
      org-pretty-entities t)
(use-package org-modern
   :init
   :ensure t
   :config)
  (global-org-modern-mode)

(use-package which-key
  :init
    (which-key-mode 1)
  :config
  (setq which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 0.8
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit t
	  which-key-separator " → " ))

(use-package general
  :config
  (general-evil-setup)

  ;; set up 'SPC' as the global leader key
  (general-create-definer leader-key
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (leader-key
    "." '(find-file :wk "Find file")
    "/" '(comment-line :wk "Comment lines"))

  (leader-key
    "b" '(:ignore t :wk "buffer")
    "b i" '(ibuffer :wk "Switch ibuffer")
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b k" '(kill-this-buffer :wk "Kill this buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer"))

 (leader-key
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
    "h r r" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "Reload emacs config"))
 
(leader-key
  "j" '(avy-goto-word-0 :wk "Go to word")
  "l" '(avy-goto-line :wk "Go to line"))
)

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                 ; Allows cycling through candidates
  (corfu-auto t)                  ; Enable auto completion
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  (corfu-preview-current 'insert) ; Do not preview current candidate
  (corfu-preselect 'prompt)
  (corfu-on-exact-match nil)      ; Don't auto expand tempel snippets

  ;; Optionally use TAB for cycling, default is `corfu-complete'.
  :bind (:map corfu-map
              ("M-SPC"      . corfu-insert-separator)
              ("TAB"        . corfu-next)
              ([tab]        . corfu-next)
              ("S-TAB"      . corfu-previous)
              ([backtab]    . corfu-previous)
              ("S-<return>" . corfu-insert)
              ("RET"        . nil))

  :init
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode)) ; Popup completion info
