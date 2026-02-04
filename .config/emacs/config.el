(require 'package)
(package-initialize)
  
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(when (< emacs-major-version 29)
  (unless (package-installed-p 'use-package)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install 'use-package)))

(add-to-list 'display-buffer-alist
           '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
             (display-buffer-no-window)
             (allow-no-window . t)))

(recentf-mode t)

(defun prot/keyboard-quit-dwim ()
  "Do-What-I-Mean behaviour for a general `keyboard-quit'.

The generic `keyboard-quit' does not do the expected thing when
the minibuffer is open.  Whereas we want it to close the
minibuffer, even without explicitly focusing it.

The DWIM behaviour of this command is as follows:

- When the region is active, disable it.
- When a minibuffer is open, but not focused, close the minibuffer.
- When the Completions buffer is selected, close it.
- In every other case use the regular `keyboard-quit'."
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))

(define-key global-map (kbd "C-g") #'prot/keyboard-quit-dwim)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-message t)
(setq use-short-answers t)
(setq
 initial-major-mode 'org-mode
 initial-scratch-message ""
 initial-buffer-choice t)

(set-face-attribute 'default nil
                    :font "JetBrains Mono"
                    :height 111
                    :weight 'medium)
(set-face-attribute 'variable-pitch nil
                    :font "Ubuntu"
                    :height 122
                    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
                    :font "JetBrains Mono"
                    :height 111
                    :weight 'medium)
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)

(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)

(add-to-list
 'default-frame-alist '(font . "JetBrains Mono-13"))

(load-theme 'wombat t)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(global-visual-line-mode t)

(show-paren-mode 1)
(electric-pair-mode 1)

(setq make-backup-files nil) 
(setq create-lockfiles nil)

(use-package evil
  :ensure t
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq
   evil-want-integration t
   evil-want-keybinding nil
   evil-vsplit-window-right t
   evil-split-window-below t
   evil-search-module 'evil-search
   evil-want-keybinding nil
   evil-disable-insert-state-bindings t
   evil-want-Y-yank-to-eol t
   evil-undo-system 'undo-redo)
  (evil-mode)
  :config (evil-set-leader 'normal " ") (evil-mode 1))

(use-package evil-collection
:ensure t
:after evil
:config
(setq evil-want-integration t)
(evil-collection-init))

(use-package evil-surround
  :ensure t
  :after evil
  :config (global-evil-surround-mode 1))

(use-package evil-commentary
  :ensure t
  :after evil
  :bind (:map evil-normal-state-map ("gc" . evil-commentary)))

(use-package nerd-icons
  :ensure t)
(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))
(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package savehist
  :ensure nil ; it is built-in
  :hook (after-init . savehist-mode))

(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq tab-always-indent 'complete)
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20)

  (setq corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1) ; shows documentation after `corfu-popupinfo-delay'

  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package trashed
  :ensure t
  :commands (trashed)
  :config
  (setq trashed-action-confirmer 'y-or-n-p)
  (setq trashed-use-header-line t)
  (setq trashed-sort-key '("Date deleted" . t))
  (setq trashed-date-format "%Y-%m-%d %H:%M:%S"))

(use-package avy
  :ensure t
  :defer t
  :config
  (setq avy-case-fold-search nil))

(use-package consult :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq initial-buffer-choice 'dashboard-open)
(setq dashboard-center-content t)
(setq dashboard-vertically-center-content t)
(setq dashboard-show-shortcuts nil)
(setq dashboard-filter-agenda-entry 'dashboard-no-filter-agenda)
(setq dashboard-items '((agenda    . 8)))

(use-package toc-org
    :ensure t
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/journal")
  :config
  (org-roam-db-autosync-mode))

(setq org-ellipsis " ▾")
(setq org-src-fontify-natively t)
(setq org-highlight-latex-and-related '(native))
(setq org-startup-folded 'showeverything)
(setq org-startup-with-inline-images t)
(setq org-image-actual-width 300)
(setq org-fontify-whole-heading-line t)
(setq org-pretty-entities t)
(setq org-hide-emphasis-markers t)
(setq org-adapt-indentation t)
(setq org-startup-indented t)
(setq org-special-ctrl-a/e '(t . nil))
(setq org-special-ctrl-k t)
(setq org-fontify-quote-and-verse-blocks t)
(setq org-src-tab-acts-natively t)
(setq org-edit-src-content-indentation 2)
(setq org-hide-block-startup nil)
(setq org-src-preserve-indentation nil)
(setq org-startup-folded 'fold)
(setq org-cycle-separator-lines 2)
(setq org-goto-auto-isearch nil)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

(setq org-cycle-separator-lines 1)
(setq org-catch-invisible-edits 'show-and-error)
(setq org-src-tab-acts-natively t)

(require 'org-tempo)

(setq org-agenda-files '("~/journal/agenda.org"))

(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :config
  (setq
   ;; org-modern-star '("●" "○" "✸" "✿")
   org-modern-star '("⌾" "✸" "◈" "✿")
   org-modern-list '((42 . "◦") (43 . "•") (45 . "–"))
   org-modern-tag nil
   org-modern-priority nil
   org-modern-todo nil
   org-modern-table nil
   org-modern-variable-pitch nil
   org-modern-block-fringe nil))

(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(setq org-todo-keywords
      '((sequence "TODO(t)" "CRITICAL(c)" "|" "DONE(d)")
        (sequence
         "DROP(o)"
         "WORK-IN-PROGRESS(w)"
         "POSTPONE(p)")))

(setq org-todo-keyword-faces
      '(("TODO"
         :inherit (region org-todo)
         :foreground "DarkOrange1"
         :weight bold)
        ("CRITICAL"
         :inherit (region org-todo)
         :foreground "white smoke"
         :background "dark red"
         :weight bold)
        ("WIP"
         :inherit (org-todo region)
         :foreground "magenta3"
         :weight bold)
        ("DONE" . "SeaGreen4")))

(use-package which-key
:ensure t
:init (which-key-mode 1)
:config
(setq
 which-key-side-window-location 'bottom
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
 which-key-prefix-prefix "◉ "
 which-key-separator " → "))

(use-package general
  :ensure t
  :config (general-evil-setup)

(general-imap
  "j" (general-key-dispatch 'self-insert-command
        :timeout 0.2 "j" 'evil-normal-state))

(general-create-definer
leader-key
:states '(normal insert visual emacs)
:keymaps 'override
:prefix "SPC"
:global-prefix "M-SPC")

(leader-key
  "h" '(:ignore t :wk "Help")
  "h f" '(describe-function :wk "Describe function")
  "h v" '(describe-variable :wk "Describe variable")
  "h r r" '((lambda ()
              (interactive) (load-file "~/.config/emacs/init.el"))
            :wk "Reload emacs config"))

(leader-key 
  "f" '(:ignore t :wk "Files")
  "." '(find-file :wk "Find file")
  "f f" '(find-file :wk "Find file")
  "f c" '((lambda ()
            (interactive)
            (find-file "~/.config/emacs/config.org"))
          :wk "Edit emacs config")
  "f s" '(save-buffer :wk "Save buffer")
  "f r" '(consult-recent-file :wk "Find recent files")
  "f q" '(kill-buffer :wk "Kill buffer"))

(leader-key
  "b" '(:ignore t :wk "buffer")
  "b i" '(ibuffer :wk "Switch ibuffer")
  "b b" '(switch-to-buffer :wk "Switch buffer")
  "b k" '(kill-current-buffer :wk "Kill this buffer")
  "b n" '(next-buffer :wk "Next buffer")
  "b p" '(previous-buffer :wk "Previous buffer")
  "b r" '(revert-buffer :wk "Reload buffer")
  "b s" '(scratch-buffer :wk "Scratch buffer"))

(leader-key
  "w" '(:ignore t :wk "Windows")
  "w c" '(evil-window-delete :wk "Close window")
  "w n" '(evil-window-new :wk "New window")
  "w s" '(evil-window-split :wk "Horizontal split window")
  "w v" '(evil-window-vsplit :wk "Vertical split window")
  "w h" '(evil-window-left :wk "Window left")
  "w j" '(evil-window-down :wk "Window down")
  "w k" '(evil-window-up :wk "Window up")
  "w l" '(evil-window-right :wk "Window right")
  "w w" '(evil-window-next :wk "Goto next window")
  "w H" '(buf-move-left :wk "Buffer move left")
  "w J" '(buf-move-down :wk "Buffer move down")
  "w K" '(buf-move-up :wk "Buffer move up")
  "w L" '(buf-move-right :wk "Buffer move right"))

(leader-key
  "j" '(avy-goto-word-0 :wk "Go to word")
  "l" '(avy-goto-line :wk "Go to line"))

(leader-key
  "g" '(:ignore t :wk "magit")
  "g g" '(magit-status :wk "Magit Status"))

(leader-key
  "i" '(:ignore t :wk "snippets")
  "s" '(yas-insert-snippet :wk "Yas insert snippet"))

(leader-key
  "m" '(:ignore t :wk "Org")
  "m a" '(org-agenda :wk "Org agenda")
  "m e" '(org-export-dispatch :wk "Org export dispatch")
  "m i" '(org-toggle-item :wk "Org toggle item")
  "m t" '(org-todo :wk "Org todo")
  "m B" '(org-babel-tangle :wk "Org babel tangle")
  "m T" '(org-todo-list :wk "Org todo list"))
(leader-key
  "m b" '(:ignore t :wk "Tables")
  "m b -" '(org-table-insert-hline :wk "Insert hline in table"))

(leader-key
  "m d" '(:ignore t :wk "Date/deadline")
  "m d t" '(org-time-stamp :wk "Org time stamp"))

(leader-key
  "m i" '(org-toggle-inline-images :wk "Toggle inline image"))

(leader-key
  "n" '(:ignore t :wk "Org Roam")
  "n l" '(org-roam-buffer-toggle :wk "Org roam buffer toggle")
  "n f" '(org-roam-node-find :wk "Org roam node find")
  "n g" '(org-roam-graph :wk "Org roam graph")
  "n i" '(org-roam-node-insert :wk "Org roam node insert")
  "n c" '(org-roam-capture :wk "Org roam capture")
  "n j" '(org-roam-dailies-capture-today :wk "Org roam today capture")
  "n y" '(org-roam-dailies-capture-yesterday :wk "Org roam yesterday capture")
  "n t" '(org-roam-dailies-capture-tomorrow :wk "Org roam tomorrow capture")
  "n d" '(org-roam-dailies-goto-today :wk "Org roam go to  today")
  )

(leader-key
  "x" '(:ignore t :wk "Consult")
  "x b" '(consult-buffer :wk "consult buffer")
  "x y" '(consult-yank-pop :wk "consult yank pop")
  "x l" '(consult-goto-line :wk "consult goto-line")
  "x f" '(consult-flymake :wk "consult flymake")
  "x i" '(consult-imenu :wk "consult imenu")
  "x g" '(consult-ripgrep :wk "consult ripgre")
  "x x" '(consult-fd :wk "consult find")
  ))
