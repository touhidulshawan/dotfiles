;; Minimal UI
(setq-default
 package-native-compile t
 default-frame-alist
 '((tool-bar-lines . 0)
   (menu-bar-lines . 0)
   (undecorated . t)
   (vertical-scroll-bars . nil)
   (horizontal-scroll-bars . nil)))

;; Garbage Collections
(setq gc-cons-percentage 0.6)

;; Compile warnings
;;  (setq warning-minimum-level :emergency)
(setq native-comp-async-report-warnings-errors 'silent) ;; native-comp warning
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))


;; MISC OPTIMIZATIONS ----
;;; optimizations (froom Doom's core.el). See that file for descriptions.
(setq idle-update-delay 1.0)

(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)
(setq fast-but-imprecise-scrolling t)
(setq inhibit-compacting-font-caches t)
