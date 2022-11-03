(beacon-mode 1)

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(add-hook 'after-init-hook 'global-company-mode)
(keychain-refresh-environment)

;; jj to escape from insert mode
(setq-default evil-escape-key-sequence "jj")
(setq-default evil-escape-delay 0.2)

;; enable gravatars on magit
(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                     (list 'org-agenda-mode)))
      (rainbow-mode 1))))
(global-rainbow-mode 1 )

(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
              (:map dired-mode-map
               :desc "Peep-dired image previews" "d p" #'peep-dired
               :desc "Dired view file" "d v" #'dired-view-file)))

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "Z") 'dired-do-compress
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  (kbd "* %") 'dired-mark-files-regexp
  (kbd "* .") 'dired-mark-extension
  (kbd "* /") 'dired-mark-directories
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'nomacs' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "nomacs")
                              ("jpg" . "nomacs")
                              ("png" . "nomacs")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

;; making delete file go to trash
(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files/")

;; dashboard
(use-package dashboard
  :init      ;; tweak dashboard config before loading it
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "\nKEYBINDINGS:\
\nFind file               (SPC .)     \
Open buffer list    (SPC b i)\
\nFind recent files       (SPC f r)   \
Open the vterm      (SPC o t)\
\nOpen dired file manager (SPC d d)   \
List of keybindings (SPC h b b)")
  (setq dashboard-startup-banner "~/.config/doom/doom-emacs-dash.png")
  (setq dashboard-center-content nil)
  (setq dashboard-items '((recents . 5)
                          (bookmarks . 5)
                          (projects . 5)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book"))))

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
(setq doom-fallback-buffer-name "*dashboard*")

(use-package emojify
  :hook (after-init . global-emojify-mode))

(use-package company
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 3))

(setq shell-file-name "/bin/fish"
      vterm-max-scrollback 5000)

(map! :leader
      :desc "Vterm popup toggle" "v t" #'+vterm/toggle)

;; Theme
(setq doom-theme 'doom-gruvbox)
(setq doom-gruvbox-dark-variant "hard")
(setq doom-themes-enable-bold t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)
(setq all-the-icons-scale-factor 1)


;; Font
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 17 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 17 :weight 'regular))
doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 24 :weight 'regular)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; doom-modeline
(set-face-attribute 'mode-line nil :font "Hack Nerd Font-11")
(setq doom-modeline-height 20
      doom-modeline-bar-width 5)

;; debugger
(setq dap-auto-configure-mode t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; treemacs

;; Custom Keymaps
(map! :leader
      :desc "Go To word" "j" #'avy-goto-word-0
      :desc "Go to line" "l" #'avy-goto-line)

;; location of lua-language-server
(setq lsp-clients-lua-language-server-bin "/usr/bin/lua-language-server")

;; pyright
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))  ; or lsp-deferred

