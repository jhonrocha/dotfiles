;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


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
(let ((fontSize (if (> (display-pixel-width) 2000) 24 20)))
  (setq doom-font (font-spec :family "FiraMono Nerd Font" :size fontSize :weight 'semi-light)
        doom-variable-pitch-font (font-spec :family "sans" :size (+ fontSize 1))))
;; (set-frame-parameter (selected-frame) 'alpha '(95 . 95))
;; (add-to-list 'default-frame-alist '(alpha . (95 . 95)))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq dired-omit-files "\\`[.]?#\\|\\`[.][.]?\\'\\|^\\..+$")
(setq message-truncate-lines t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; (after! flycheck
;;   (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t)))

;; RESTCLIENT
(add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))
(add-to-list 'auto-mode-alist '("\\.props\\'" . sql-mode))

(setq-default word-wrap t)
(toggle-truncate-lines 1)

(setq-default tab-width 2)
(setq c-basic-offset 2)

(setq js-indent-level 2)
;; (after! projectile
;;   (setq projectile-generic-command "fd . -0 -H --color=never --type file --type symlink --follow --exclude .git --exclude node_modules --no-ignore"))

;; PROJECTILE
(setq find-file-visit-truename t)
      ;; +workspaces-switch-project-function #'counsel-projectile)

;; IVY
(after! ivy
  (add-to-list 'ivy-ignore-buffers "\\*"))

;; JS
(add-hook! tide-mode
  (setq eldoc-documentation-function #'ignore)
  (global-eldoc-mode -1))

;; Capture Templates
(after! org
  (setq org-capture-templates
        '(("t" "Task" entry
           (file+olp "~/org/Tasks.org" "Backlog")
           "** TODO %? %i" :unnarrowed t)
          ("w" "Work" entry (file+olp "~/org/Work.org" "Backlog")
           "* TODO %? %i" :unnarrowed t)
          ("c" "Compras Backlog" item (file+olp "~/org/Compras.org" "Backlog")
           "- [ ] %?" :unnarrowed t)
          ("o" "Compras Online" item (file+olp "~/org/Compras.org" "Online")
           "- [ ] %?" :unnarrowed t)
          ("m" "Compras Mercado" item (file+olp "~/org/Compras.org" "Mercado")
           "- [ ] %?" :unnarrowed t)
          ("j" "Journal" entry
           (file+olp+datetree "~/org/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1))
        org-startup-folded 'content))

(map!
      "<M-tab>" #'mode-line-other-buffer
      "M-d" #'+vterm/toggle
      :v "<tab>" #'indent-region
      :ginv "C-y" #'yank
      (:map vterm-mode-map
       "M-d" #'+workspace/close-window-or-workspace)
      "M-1" (lambda () (interactive)(jh/vterm-toggle "1"))
      "M-2" (lambda () (interactive)(jh/vterm-toggle "2"))
      "M-3" (lambda () (interactive)(jh/vterm-toggle "3"))
      "M-4" (lambda () (interactive)(jh/vterm-toggle "4"))
      "M-5" (lambda () (interactive)(jh/vterm-toggle "5"))
      "M-6" (lambda () (interactive)(jh/vterm-toggle "6"))
      "M-7" (lambda () (interactive)(jh/vterm-toggle "7"))
      "M-8" (lambda () (interactive)(jh/vterm-toggle "8"))
      "M-9" (lambda () (interactive)(jh/vterm-toggle "9"))
      "M-0" (lambda () (interactive)(jh/vterm-toggle "0"))
      "C-x C-j" #'dired-jump
      "C-s" #'swiper
      "M-i" #'+workspace:switch-next
      "M-u" #'+workspace:switch-previous
      (:map dired-mode-map
       :gn "h" #'dired-up-directory
       :gn "l" #'dired-find-file)
      (:map (ivy-minibuffer-map ivy-switch-buffer-map ivy-reverse-i-search-map)
       ("C-d" #'ivy-switch-buffer-kill)
       ("S-<return>" #'ivy-immediate-done))
      :leader
      (:ginv "d" #'delete-forward-char)
      ;; File management
      "x" nil
      (:prefix ("x" . "C-x")
      :desc "kill-buf-window" "k" #'kill-buffer-and-window)
      ;; Projectile
      :desc "counsel-projectile" "SPC" #'counsel-projectile
      :desc "Dired Root" "p h" #'projectile-dired
      ;; Org Agenda
      :desc "org-agenda" "a" #'org-agenda
      ;; Org Capture
      :desc "org-capture" "k" #'org-capture
      ;; ;; File Management
      :desc "copy-file-path" "j p" #'jh/copy-file-path
      ;; ;; Magit
      :desc "copy-magit-branch" "j b" #'jh/copy-magit-branch)

;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("pdf" . "zathura")
                              ("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(defun jh/copy-file-path ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (file-relative-name buffer-file-name (projectile-project-root))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun jh/copy-magit-branch ()
  "Show the current branch in the echo-area and add it to the `kill-ring'."
  (interactive)
  (let ((branch (magit-get-current-branch)))
    (if branch
        (progn (kill-new branch)
               (message "%s" branch))
      (user-error "There is not current branch"))))

(defun jh/vterm-toggle (arg)
  "Toggles a terminal popup window at project root.

If prefix ARG is non-nil, recreate vterm buffer in the current project's root."
  (interactive "P")
  (unless (fboundp 'module-load)
    (user-error "Your build of Emacs lacks dynamic modules support and cannot load vterm"))
  (let ((buffer-name
         (format "*doom:vterm-popup:%s:%s*"
                 (if (bound-and-true-p persp-mode)
                     (safe-persp-name (get-current-persp))
                   "main")
                 arg))
        confirm-kill-processes
        current-prefix-arg)
    (if-let (win (get-buffer-window buffer-name))
        (if (eq (selected-window) win)
            (delete-window win)
          (select-window win)
          (when (bound-and-true-p evil-local-mode)
            (evil-change-to-initial-state))
          (goto-char (point-max)))
      (setenv "PROOT" (or (doom-project-root) default-directory))
      (let ((buffer (get-buffer-create buffer-name)))
        (with-current-buffer buffer
          (unless (eq major-mode 'vterm-mode)
            (vterm-mode)
            (evil-insert-state)))
        (pop-to-buffer buffer)))))

