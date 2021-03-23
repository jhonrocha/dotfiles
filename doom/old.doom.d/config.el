;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Don't truncate, wrap instead
(set-default 'truncate-lines nil)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jhon Rocha"
      user-mail-address "jhmrocha@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(if (> (display-pixel-width) 2000)
        (setq doom-font (font-spec :family "FiraMono Nerd Font" :size 20 :weight 'semi-light)
        doom-variable-pitch-font (font-spec :family "FiraMono Nerd Font" :size 21))
    (setq doom-font (font-spec :family "FiraMono Nerd Font" :size 19 :weight 'semi-light)
    doom-variable-pitch-font (font-spec :family "FiraMono Nerd Font" :size 20)))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq hour
        (string-to-number
            (substring (current-time-string) 11 13)))
(if (or (> hour 17) (< hour 6))
        (setq doom-theme 'doom-one)
    (setq doom-theme 'doom-one-light))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :weight regular))))
  '(org-level-2 ((t (:inherit outline-2 :weight regular))))
  '(org-level-3 ((t (:inherit outline-3 :weight regular))))
  '(org-level-4 ((t (:inherit outline-4 :weight regular))))
  '(org-level-5 ((t (:inherit outline-5 :weight regular))))
  '(org-level-6 ((t (:inherit outline-5 :weight regular))))
  '(org-level-7 ((t (:inherit outline-5 :weight regular))))
  '(org-level-8 ((t (:inherit outline-5 :weight regular))))
  '(org-done ((t (:inherit org-headline-done :weight regular))))
  '(org-todo ((t (:weight regular))))
)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; transparent adjustment: MOVED To External Compositor
;; (set-frame-parameter (selected-frame)'alpha '(90 . 90))
;; (add-to-list 'default-frame-alist'(alpha . (90 . 90)))


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(use-package flycheck
  :ensure t
  :custom
  (flycheck-display-errors-delay 0)
  :config
  (global-flycheck-mode)
  ;; use eslint with web-mode for jsx files
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  ;; Workaround for eslint loading slow
  ;; https://github.com/flycheck/flycheck/issues/1129#issuecomment-319600923
  (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t)))

(map! :leader
    "o a" #'org-agenda
    "f k" #'kill-this-buffer
    "r r" #'query-replace
    "j" #'previous-buffer
    "k" #'next-buffer
    "l" #'evil-switch-to-windows-last-buffer)

(map!
    "C-'" #'org-cycle-agenda-files
    "M-d" #'+vterm/toggle
    "M-D" #'+vterm/here
    "M-h" #'evil-window-left
    "M-j" #'evil-window-down
    "M-k" #'evil-window-up
    "M-l" #'evil-window-right
    "M-i" #'+workspace:switch-next
    "M-u" #'+workspace:switch-previous)

(map! :mode 'vterm-mode
    :i "C-k" #'vterm-send-C-k
    :i "C-j" #'vterm-send-C-j
    "M-d" #'+vterm/toggle
    "M-D" #'+vterm/here
    "M-h" #'evil-window-left
    "M-j" #'evil-window-down
    "M-k" #'evil-window-up
    "M-l" #'evil-window-right
    "M-i" #'+workspace:switch-next
    "M-u" #'+workspace:switch-previous)
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Journal
(setq org-journal-date-prefix "#+TITLE: "
     org-journal-time-prefix "* "
     org-journal-date-format "%a, %Y-%m-%d"
     org-journal-file-format "%Y-%m-%d.org")

;; ORG-ROAM
(setq org-roam-directory "~/org/roam")
