(setq package-enable-at-startup nil)
(setq package-install-upgrade-built-in t)

;; Minimal UI
(setq-default
 package-native-compile t
 default-frame-alist
 '((tool-bar-lines . 0)
   (menu-bar-lines . 0)
   (undecorated . t)
   (vertical-scroll-bars . nil)
   (horizontal-scroll-bars . nil)))
