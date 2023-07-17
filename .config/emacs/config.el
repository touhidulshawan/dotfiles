(require 'package)
(require 'quelpa-use-package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

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
(global-visual-line-mode t)

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

(use-package nerd-icons-completion
 :after marginalia
 :config
 (nerd-icons-completion-mode)
 (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(require 'org-tempo)

(defun reload-init-file ()
 (interactive)
 (load-file user-init-file)
 (load-file user-init-file))

(use-package evil
    :init
    (setq evil-want-integration t
          evil-want-keybinding nil
          evil-vsplit-window-right t
          evil-split-window-below t
          evil-search-module 'evil-search
          evil-want-keybinding nil
          evil-disable-insert-state-bindings t
          evil-want-Y-yank-to-eol t
          evil-undo-system 'undo-redo)
          (evil-mode)
    :config
    (evil-set-leader 'normal " "))

 (use-package evil-collection
    :after evil
    :config
    (setq evil-collection-mode-list '(dashboard dired ibuffer))
    (evil-collection-init))

;; Enable Commentary
(use-package evil-commentary
   :ensure t
   :after evil
   :bind (:map evil-normal-state-map
            ("gc" . evil-commentary)))

;; Enable Surround
(use-package evil-surround
   :ensure t
   :after evil
   :config
   (global-evil-surround-mode 1))

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

(setq org-ellipsis " ▾"
      org-hide-emphasis-markers t
      org-pretty-entities t
      org-adapt-indentation t
      org-startup-indented t
      org-startup-with-inline-images t
      org-image-actual-wih 400
      org-special-ctrl-a/e '(t . nil)
      org-special-ctrl-k t
      org-src-fontify-natively t
      org-fontify-whole-heading-line t
      org-fontify-quote-and-verse-blocks t
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 2
      org-hide-block-startup nil
      org-src-preserve-indentation nil
      org-startup-folded 'fold
      org-cycle-separator-lines 2
      org-hide-leading-stars t
      org-export-backends '(markdown ascii html icalendar latex o)
      org-export-with-toc nil
      org-highlight-latex-and-related '(native)
      org-goto-auto-isearch nil
      org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
      (sequence "BACKLOG(b)" "ACTIVE(a)"
                "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)"
                "|" "DELEGATED(D)" "CANCELLED(c)"))
      org-agenda-search-view-always-boolean t
      org-agenda-timegrid-use-ampm t
      org-agenda-time-grid
      '((daily today require-timed remove-match)
        (800 830 1000 1030 1200 1230 1400 1430 1600 1630 1700 1730 1800 1830 2000 )
        "......" "────────────────")
      org-agenda-current-time-string
      "← now ─────────────────")

(use-package org-modern
  :hook ((org-mode                 . org-modern-mode)
         (org-agenda-finalize-hook . org-modern-agenda))
  :custom ((org-modern-todo t)
           (org-modern-table nil)
           (org-modern-variable-pitch nil)
           (org-modern-block-fringe nil))
  :commands (org-modern-mode org-modern-agenda)
  :init (global-org-modern-mode))

(use-package toc-org
   :commands toc-org-enable
   :init (add-hook 'org-mode-hook 'toc-org-enable))

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
            "."   '(find-file   :wk "Find file")
            "f c" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit emacs config")
            "f s"  '(save-buffer  :wk "Save buffer")
            "f r"  '(consult-recent-file  :wk "Find recent files"))

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
    "w" '(:ignore t :wk "Windows")
    ;; Window splits
    "w c" '(evil-window-delete :wk "Close window")
    "w n" '(evil-window-new :wk "New window")
    "w s" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")
    ;; Window motions
    "w h" '(evil-window-left :wk "Window left")
    "w j" '(evil-window-down :wk "Window down")
    "w k" '(evil-window-up :wk "Window up")
    "w l" '(evil-window-right :wk "Window right")
    "w w" '(evil-window-next :wk "Goto next window")
    ;; Move Windows
    "w H" '(buf-move-left :wk "Buffer move left")
    "w J" '(buf-move-down :wk "Buffer move down")
    "w K" '(buf-move-up :wk "Buffer move up")
    "w L" '(buf-move-right :wk "Buffer move right")))

(use-package diminish)

(use-package flycheck
 :ensure t
 :defer t
 :diminish
 :init (global-flycheck-mode))

(use-package sudo-edit
:config
  (leader-key
    "fu" '(sudo-edit-find-file :wk "Sudo find file")
    "fU" '(sudo-edit :wk "Sudo edit file")))

(use-package vertico
  :init
  ;; Enable vertico using the vertico-flat-mode
  (require 'vertico-directory)
  (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy)

  (use-package orderless
    :commands (orderless)
    :custom (completion-styles '(orderless flex)))
  (load (concat user-emacs-directory
                "lisp/affe-config.el"))
  (use-package marginalia
    :custom
    (marginalia-annotators
     '(marginalia-annotators-heavy marginalia-annotators-light nil))
    :init
    (marginalia-mode))
  (vertico-mode t)
  :config
  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

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

(use-package cape
  :defer 10
  :bind ("C-c f" . cape-file)
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (defalias 'dabbrev-after-2 (cape-capf-prefix-length #'cape-dabbrev 2))
  (add-to-list 'completion-at-point-functions 'dabbrev-after-2 t)
  (cl-pushnew #'cape-file completion-at-point-functions)
  :config
  ;; Silence then pcomplete capf, no errors or messages!
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)

  ;; Ensure that pcomplete does not write to the buffer
  ;; and behaves as a pure `completion-at-point-function'.
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify))
(use-package yasnippet
  :ensure t
  :init
  (setq yas-nippet-dir "~/.config/emacs/snippets")
  (yas-global-mode))
(use-package yasnippet-snippets
  :ensure t :after yasnippet)
(use-package cape-yasnippet
  :ensure nil
  :quelpa (cape-yasnippet :fetcher github :repo "elken/cape-yasnippet")
  :after yasnippet
  :hook ((prog-mode . yas-setup-capf)
         (text-mode . yas-setup-capf)
         (lsp-mode  . yas-setup-capf)
         (sly-mode  . yas-setup-capf))
  :bind (("C-c y" . cape-yasnippet)
         ("M-+"   . yas-insert-snippet))
  :config
  (defun yas-setup-capf ()
    (setq-local completion-at-point-functions
                (cons 'cape-yasnippet
                      completion-at-point-functions)))
  (push 'cape-yasnippet completion-at-point-functions))
