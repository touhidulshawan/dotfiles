;; UI settings
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; enable line number
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; enable syntax highlighting
(global-font-lock-mode t)

;; show matching parentheses
(show-paren-mode 1)

;; font
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

;; package manager
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

;; enable company mode
(add-hook 'after-init-hook 'global-company-mode)

;; theme
(load-theme 'gruvbox-dark-hard t)

;; evil mode
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

;; jj to escape to normal mode
(evil-escape-mode)
(setq-default evil-escape-key-sequence "jj"
              evil-escape-delay 0.2)

;; nerd-icons
(use-package nerd-icons)

;; dashboard
(use-package dashboard
  :init
  (setq dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-startup-banner "~/.config/emacs/gruvbox.png"
        dashboard-center-content nil
        dashboard-items '((recents . 8)))
        :config
        (dashboard-setup-startup-hook)
        (dashboard-modify-heading-icons '((recents . "file-text"))))
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
(setq doom-fallback-buffer-name "*dashboard*")

;; doom-modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; general keybinding
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

;; which key
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

;; org-mode

(use-package org-modern
  :init
  :ensure t
  :config)
(global-org-modern-mode)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-escape avy org-modern company which-key general doom-modeline gruvbox-theme dashboard nerd-icons use-package evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
