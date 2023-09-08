(add-to-list 'load-path "~/.config/emacs/scripts")

(require 'elpaca-setup)

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(defun reload-init-file ()
  (interactive)
  (load-file user-init-file)
  (load-file user-init-file))

(use-package diminish)

(use-package rainbow-mode
 :diminish
 :hook org-mode prog-mode)

(use-package sudo-edit)

(use-package centered-cursor-mode :diminish centered-cursor-mode)

(use-package magit :commands magit-status :ensure t)

(use-package avy
  :defer t
  :config
  (setq avy-case-fold-search nil))

(setq inhibit-startup-message t)
(setq use-short-answers t) ;; When emacs asks for "yes" or "no", let "y" or "n" suffice
(setq confirm-kill-emacs 'yes-or-no-p) ;; Confirm to quit
(setq
 initial-major-mode 'org-mode ;; Major mode of new buffers
 initial-scratch-message ""
 initial-buffer-choice t) ;; Blank scratch buffer

(set-face-attribute 'default nil
		    :font "JetBrainsMono Nerd Font"
		    :height 110
		    :weight 'medium)
(set-face-attribute 'variable-pitch nil
		    :font "JetBrainsMono Nerd Font"
		    :height 120
		    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
		    :font "JetBrainsMono Nerd Font"
		    :height 110
		    :weight 'medium)
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)

(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)

(add-to-list
 'default-frame-alist '(font . "JetBrainsMono Nerd Font-11"))

(use-package gruvbox-theme :config (load-theme 'gruvbox-dark-medium t))

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(global-visual-line-mode t)

(use-package
 dashboard
 :init
 (setq
  dashboard-set-heading-icons t
  dashboard-set-file-icons t
  dashboard-display-icons-p t
  dashboard-startup-banner "~/.config/emacs/gruvbox.png"
  dashboard-center-content nil
  dashboard-items '((recents . 8)))
 :config (dashboard-setup-startup-hook))
(setq initial-buffer-choice
      (lambda () (get-buffer-create "*dashboard*")))
(setq doom-fallback-buffer-name "*dashboard*")

(use-package doom-modeline :ensure t :init (doom-modeline-mode 1))

(use-package dired-open
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv"))))

(use-package peep-dired
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook)
  :config
    (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
    (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
    (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)
)

(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; (add-to-list 'default-frame-alist '(alpha-background . 90))

(require 'org-tempo)

(fset 'yes-or-no-p 'y-or-n-p)
;; use primary as clipboard
(setq-default x-select-enable-primary t)
;; avoid leaving a gap between the frame and the screen
(setq-default frame-resize-pixelwise t)

;; Vim like scrolling
(setq
 scroll-step 1
 scroll-conservatively 10000
 next-screen-context-lines 5
 ;; move by logical lines rather than visual lines (better for macros)
 line-move-visual nil)

(show-paren-mode 1)
(electric-pair-mode 1)

(setq make-backup-files nil)

(setq create-lockfiles nil)

(use-package
 evil
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

(use-package
 evil-collection
 :after evil
 :config
 (setq evil-want-integration t)
 (evil-collection-init))

(use-package
 evil-commentary
 :ensure t
 :after evil
 :bind (:map evil-normal-state-map ("gc" . evil-commentary)))

(use-package
 evil-surround
 :ensure t
 :after evil
 :config (global-evil-surround-mode 1))

(use-package
which-key
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

(use-package
general
:config (general-evil-setup)

(general-imap
"j"
(general-key-dispatch
 'self-insert-command
 :timeout 0.2 "j" 'evil-normal-state))

(general-create-definer
 leader-key
 :states '(normal insert visual emacs)
 :keymaps 'override
 :prefix "SPC"
 :global-prefix "M-SPC")

(leader-key
 "h"
 '(:ignore t :wk "Help")
 "h f"
 '(describe-function :wk "Describe function")
 "h v"
 '(describe-variable :wk "Describe variable")
 "h r r"
 '((lambda ()
     (interactive)
     (load-file "~/.config/emacs/init.el"))
   :wk "Reload emacs config"))

(leader-key
 "."
 '(find-file :wk "Find file")
 "f c"
 '((lambda ()
     (interactive)
     (find-file "~/.config/emacs/config.org"))
   :wk "Edit emacs config")
 "f s"
 '(save-buffer :wk "Save buffer")
 "f r"
 '(consult-recent-file :wk "Find recent files"))

(leader-key
 "fu"
 '(sudo-edit-find-file :wk "Sudo find file")
 "fU"
 '(sudo-edit :wk "Sudo edit file"))

(leader-key
 "b"
 '(:ignore t :wk "buffer")
 "b i"
 '(ibuffer :wk "Switch ibuffer")
 "b b"
 '(switch-to-buffer :wk "Switch buffer")
 "b k"
 '(kill-this-buffer :wk "Kill this buffer")
 "b n"
 '(next-buffer :wk "Next buffer")
 "b p"
 '(previous-buffer :wk "Previous buffer")
 "b r"
 '(revert-buffer :wk "Reload buffer"))

(leader-key "n" '(scratch-buffer :wk "Scratch Buffer"))

(leader-key
 "w"
 '(:ignore t :wk "Windows")
 ;; Window splits
 "w c"
 '(evil-window-delete :wk "Close window")
 "w n"
 '(evil-window-new :wk "New window")
 "w s"
 '(evil-window-split :wk "Horizontal split window")
 "w v"
 '(evil-window-vsplit :wk "Vertical split window")
 ;; Window motions
 "w h"
 '(evil-window-left :wk "Window left")
 "w j"
 '(evil-window-down :wk "Window down")
 "w k"
 '(evil-window-up :wk "Window up")
 "w l"
 '(evil-window-right :wk "Window right")
 "w w"
 '(evil-window-next :wk "Goto next window")
 ;; Move Windows
 "w H"
 '(buf-move-left :wk "Buffer move left")
 "w J"
 '(buf-move-down :wk "Buffer move down")
 "w K"
 '(buf-move-up :wk "Buffer move up")
 "w L"
 '(buf-move-right :wk "Buffer move right"))

(leader-key
 "j"
 '(avy-goto-word-0 :wk "Go to word")
 "l"
 '(avy-goto-line :wk "Go to line"))

(leader-key
 "g"
 '(:ignore t :wk "magit")
 "g g"
 '(magit-status :wk "Magit Status"))

(leader-key
 "m"
 '(:ignore t :wk "Org")
 "m a"
 '(org-agenda :wk "Org agenda")
 "m e"
 '(org-export-dispatch :wk "Org export dispatch")
 "m i"
 '(org-toggle-item :wk "Org toggle item")
 "m t"
 '(org-todo :wk "Org todo")
 "m B"
 '(org-babel-tangle :wk "Org babel tangle")
 "m T"
 '(org-todo-list :wk "Org todo list"))
(leader-key
 "m b"
 '(:ignore t :wk "Tables")
 "m b -"
 '(org-table-insert-hline :wk "Insert hline in table"))

(leader-key
 "m d"
 '(:ignore t :wk "Date/deadline")
 "m d t"
 '(org-time-stamp :wk "Org time stamp"))

(leader-key
 "m i" '(org-toggle-inline-images :wk "Toggle inline image"))

(leader-key "tw" '(writeroom-mode :which-key "writeroom-mode")))

(use-package
 corfu
 :init
 (global-corfu-mode)
 (corfu-popupinfo-mode)
 :config
 (setq
  corfu-auto t
  corfu-echo-documentation t
  corfu-scroll-margin 0
  corfu-count 8
  corfu-max-width 50
  corfu-min-width corfu-max-width
  corfu-auto-prefix 2)

 ;; Make Evil and Corfu play nice
 (evil-make-overriding-map corfu-map)
 (advice-add 'corfu--setup :after 'evil-normalize-keymaps)
 (advice-add 'corfu--teardown :after 'evil-normalize-keymaps)

 (corfu-history-mode 1)
 (savehist-mode 1)
 (add-to-list 'savehist-additional-variables 'corfu-history)

 (defun corfu-enable-always-in-minibuffer ()
   (setq-local corfu-auto nil)
   (corfu-mode 1))
 (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer
	   1))

(use-package
cape
:defer 10
:bind ("C-c f" . cape-file)
:init
;; Add `completion-at-point-functions', used by `completion-at-point'.
(defalias
  'dabbrev-after-2 (cape-capf-prefix-length #'cape-dabbrev 2))
(add-to-list 'completion-at-point-functions 'dabbrev-after-2 t)
(cl-pushnew #'cape-file completion-at-point-functions)
:config
;; Silence then pcomplete capf, no errors or messages!
(advice-add
 'pcomplete-completions-at-point
 :around #'cape-wrap-silent)

;; Ensure that pcomplete does not write to the buffer
;; and behaves as a pure `completion-at-point-function'.
(advice-add
 'pcomplete-completions-at-point
 :around #'cape-wrap-purify))

(use-package
 vertico
 :init
 ;; Enable vertico using the vertico-flat-mode
 (require 'vertico-directory)
 (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy)

 (use-package
  orderless
  :commands (orderless)
  :custom (completion-styles '(orderless flex)))
 (load (concat user-emacs-directory "lisp/affe-config.el"))
 (use-package
  marginalia
  :custom
  (marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init (marginalia-mode))
 (vertico-mode t)
 :config
 ;; Do not allow the cursor in the minibuffer prompt
 (setq minibuffer-prompt-properties
       '(read-only t cursor-intangible t face minibuffer-prompt))
 (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
 ;; Enable recursive minibuffers
 (setq enable-recursive-minibuffers t))
(setq native-comp-deferred-compilation t)

(use-package consult)

(use-package nerd-icons-completion
 :after marginalia
 :config (nerd-icons-completion-mode)
 (add-hook
  'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package
 kind-icon
 :config
 (setq kind-icon-default-face 'corfu-default)
 (setq kind-icon-default-style
       '(:padding
	 0
	 :stroke 0
	 :margin 0
	 :radius 0
	 :height 0.9
	 :scale 1))
 (setq kind-icon-blend-frac 0.08)
 (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
 (add-hook
  'counsel-load-theme
  #'(lambda ()
      (interactive)
      (kind-icon-reset-cache)))
 (add-hook
  'load-theme
  #'(lambda ()
      (interactive)
      (kind-icon-reset-cache))))

(use-package yasnippet
 :diminish yas-minor-mode
 :ensure t
 :init
 (setq yas-nippet-dir "~/.config/emacs/snippets")
 (yas-global-mode 1))
;; Silences the warning when running a snippet with backticks (runs a command in the snippet)
(require 'warnings)
(add-to-list 'warning-suppress-types '(yasnippet backquote-change))

(use-package yasnippet-snippets :ensure t :after yasnippet)

(with-eval-after-load 'ox-latex
  (add-to-list
   'org-latex-classes
   '("org-plain-latex"
     "\\documentclass{article}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
(setq org-latex-listings 't)

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

(setq org-todo-keywords
      '((sequence "TODO(t)" "CRITICAL(c)" "|" "DONE(d)")
        (sequence
         "HIGH(h)"
         "MEDIUM(m)"
         "LOW(l)"
         "DUP(u)"
         "WIP(w)"
         "POC(p)"
         "PENDING PAYMENT(e)"
         "|"
         "FALSE POSITIVE(f)"
         "VALIDATE(v)"
         "REPORTED(r)")))

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
        ("HIGH"
         :inherit (region org-todo)
         :foreground "white smoke"
         :background "red"
         :weight bold)
        ("MEDIUM"
         :inherit (region org-todo)
         :foreground "white smoke"
         :background "firebrick"
         :weight bold)
        ("LOW"
         :inherit (region org-todo)
         :foreground "white smoke"
         :background "indian red"
         :weight bold)
        ("FALSE POSITIVE"
         :inherit (region org-todo)
         :foreground "gray9"
         :background "coral"
         :weight bold)
        ("DUP"
         :inherit (org-todo region)
         :foreground "tan2"
         :weight bold)
        ("POC"
         :inherit (org-todo region)
         :foreground "MediumPurple2"
         :weight bold)
        ("WIP"
         :inherit (org-todo region)
         :foreground "magenta3"
         :weight bold)
        ("REPORTED"
         :inherit (region org-todo)
         :foreground "DarkGoldenrod2"
         :weight bold)
        ("VALIDATE"
         :inherit (region org-todo)
         :foreground "SpringGreen2"
         :weight bold)
        ("DONE" . "SeaGreen4")))

(setq org-lowest-priority ?F)
(setq org-default-priority ?E)

(setq org-priority-faces
      '((65 . "red2")
        (66 . "Gold1")
        (67 . "Goldenrod2")
        (68 . "PaleTurquoise3")
        (69 . "DarkSlateGray4")
        (70 . "PaleTurquoise4")))

(use-package
 toc-org
 :commands toc-org-enable
 :init (add-hook 'org-mode-hook 'toc-org-enable))

(use-package
 org-modern
 :hook (org-mode . org-modern-mode)
 :config
 (setq
  ;; org-modern-star '("●" "○" "✸" "✿")
  org-modern-star '("⌾" "✸" "◈" "◇")
  org-modern-list '((42 . "◦") (43 . "•") (45 . "–"))
  org-modern-tag nil
  org-modern-priority nil
  org-modern-todo nil
  org-modern-table nil
  org-modern-variable-pitch nil
  org-modern-block-fringe nil))

(use-package
 evil-org
 :ensure t
 :after org
 :config
 (require 'evil-org-agenda)
 (evil-org-agenda-set-keys)
 (add-hook 'org-mode-hook (lambda () (evil-org-mode 1))))

(use-package visual-fill-column
  :defer t
  :config
  (setq visual-fill-column-center-text t))

(use-package writeroom-mode
  :defer t
  :config
  (setq writeroom-maximize-window nil
        writeroom-mode-line t
        writeroom-global-effects nil ;; No need to have Writeroom do any of that silly stuff
        writeroom-extra-line-spacing 3) 
  (setq writeroom-width visual-fill-column-width))
