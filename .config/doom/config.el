;; overwrite variables
(setq user-full-name "Touhidul Shawan"
      user-mail-address "touhidulshawan@gmail.com"
      browse-url-firefox-program "firefox"
      doom-theme 'doom-gruvbox
      doom-gruvbox-dark-variant "hard"
      doom-themes-enable-bold t
      doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 17 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 17 :weight 'regular)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 24 :weight 'regular)
      display-line-numbers 'relative
      yas-triggers-in-field t
      org-directory "~/org/"
      org-auto-align-tags nil
      org-tags-column 0
      org-catch-invisible-edits 'show-and-error
      org-special-ctrl-a/e t
      org-insert-heading-respect-content t
      ;; Org styling, hide markup etc.
      org-hide-emphasis-markers t
      org-pretty-entities t
      org-ellipsis "…"
      ;; Agenda styling
      org-agenda-tags-column 0
      org-agenda-block-separator ?─
      org-agenda-time-grid
      '((daily today require-timed)
        (800 1000 1200 1400 1600 1800 2000)
        " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
      org-agenda-current-time-string
      "⭠ now ─────────────────────────────────────────────────")

;; jj to escape from insert mode
(setq-default evil-escape-key-sequence "jj"
              evil-escape-delay 0.2)

;; custom dashboard
(use-package dashboard
  :init
  (setq dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-startup-banner "~/.config/doom/gruvbox.png"
        dashboard-center-content nil
        dashboard-items '((recents . 8)))
        :config
        (dashboard-setup-startup-hook)
        (dashboard-modify-heading-icons '((recents . "file-text"))))
(setq initial-buffer-choice (lambda ()(get-buffer-create "*dashboard"))
      doom-fallback-buffer-name "*dashboard")

;; org-modern
(use-package! org-modern
  :hook (org-mode . global-org-modern-mode)
  :config
  (setq org-modern-label-border 0.3))


;; custom keys
(map! :leader
      :desc "Go to word" "j" #'avy-goto-word-0
      :desc "Go to line" "l" #'avy-goto-line)
