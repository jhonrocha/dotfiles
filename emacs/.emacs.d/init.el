  (setq-default custom-file (expand-file-name ".custom.el" user-emacs-directory))
  ;; store all backup and autosave files in the tmp dir
  (setq backup-directory-alist `((".*" . ,temporary-file-directory)))
  (setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

  (load custom-file t)
  (setq inhibit-startup-message t)
  (scroll-bar-mode -1)        ; Disable visible scrollbar
  (tool-bar-mode -1)          ; Disable the toolbar
  (tooltip-mode -1)           ; Disable tooltips
  (set-fringe-mode 10)        ; Give some breathing room
  (menu-bar-mode -1)          ; Disable the menu bar

  ;; Set up the visible bell
  (setq visible-bell t)

  (column-number-mode)
  (global-display-line-numbers-mode 1)

  (setq display-line-numbers-type 'relative)
  (setq split-width-threshold 80)

  ;; Disable line number for some modes
  (dolist (mode '(org-mode-hook
                  term-mode-hook
                  shell-mode-hook
                  eshell-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 0))))

  (setq gc-cons-threshold 20000000)

  ;; FONTS
  (set-face-attribute 'default nil :font "Iosevka NF" :height 150)

  ;; Set Transparency
  (set-frame-parameter (selected-frame) 'alpha '(95 . 95))
  (add-to-list 'default-frame-alist '(alpha . (95 . 95)))
  (defun jh/toggle-transparency ()
    (interactive)
    (let ((alpha (frame-parameter nil 'alpha)))
      (set-frame-parameter
       nil 'alpha
       (if (eql (cond ((numberp alpha) alpha)
                      ((numberp (cdr alpha)) (cdr alpha))
                      ;; Also handle undocumented (<active> <inactive>) form.
                      ((numberp (cadr alpha)) (cadr alpha)))
                100)
           '(95 . 95) '(100 . 100)))))
  ;; Set transparency of emacs
  (defun jh/transparency (value)
    "Sets the transparency of the frame window. 0=transparent/100=opaque"
    (interactive "nTransparency Value 0 - 100 opaque:")
    (set-frame-parameter (selected-frame) 'alpha value))

  ;; Initialize package sources
  (require 'package)

  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                           ("org" . "https://orgmode.org/elpa/")
                           ("elpa" . "https://elpa.gnu.org/packages/")))

  (package-initialize)
  (unless package-archive-contents
   (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
  (unless (package-installed-p 'use-package)
     (package-install 'use-package))

  (require 'use-package)
  (setq use-package-always-ensure t)

  ;; MODE-LINE
  (use-package all-the-icons)

  (use-package doom-modeline
    :ensure t
    :init (doom-modeline-mode 1)
    :custom ((doom-modeline-height 15)))

  (use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))

  ;; THEME
  (setq hour (string-to-number (substring (current-time-string) 11 13)))
  (use-package doom-themes
    :init
      (if (or (> hour 17) (< hour 6))
        (load-theme 'doom-one t)
      (load-theme 'doom-one t)))
      ;; (load-theme 'doom-one-light t)))

  ;; ORG LIFE
  (use-package org
    :hook (org-mode . org-indent-mode)
    :custom
    ;; AGENDA
    (org-agenda-start-with-log-mode t)
    (org-tag-alist
     '((:startgroup)
       (:endgroup)
       ("compras" . ?c)
       ("estudos" . ?e)
       ("work" . ?w)))
    (org-agenda-custom-commands
     '(("w" "Work Tasks" tags-todo "+work")
       ("c" "Compras Tasks" tags-todo "+compras")))
    (org-agenda-files '("~/org/Tasks.org"
                        "~/org/Compras.org"
                       "~/org/Work.org"
                       "~/org/Journal.org"
                       "~/org/Archive.org"
                       "~/org/Finance.org"))
    ;; Capture Templates
    (org-capture-templates
      `(("t" "Task" entry
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
             :empty-lines 1)))
    ;; Extra
    (org-refile-targets
     '((nil . (:maxlevel . 2))
       ("Archive.org" :maxlevel . 1)))
    (org-log-done 'time)
    (org-log-into-drawer t)
    (org-startup-folded 'content)
    (org-ellipsis " ▾")
    (org-src-tab-acts-natively t)
    (org-image-actual-width nil)
    (org-src-preserve-indentation t)
    :config
    (advice-add 'org-refile :after 'org-save-all-org-buffers)
    ;; Heading
    (set-face-attribute 'org-level-1 nil :font "Cantarell" :weight 'regular :height 1.20)
    (set-face-attribute 'org-level-2 nil :font "Cantarell" :weight 'regular :height 1.18)
    (set-face-attribute 'org-level-3 nil :font "Cantarell" :weight 'regular :height 1.16)
    (set-face-attribute 'org-level-4 nil :font "Cantarell" :weight 'regular :height 1.14)
    (set-face-attribute 'org-level-5 nil :font "Cantarell" :weight 'regular :height 1.12)
    (set-face-attribute 'org-level-6 nil :font "Cantarell" :weight 'regular :height 1.10)
    (set-face-attribute 'org-level-7 nil :font "Cantarell" :weight 'regular :height 1.08)
    (set-face-attribute 'org-level-8 nil :font "Cantarell" :weight 'regular :height 1.06))

    ;; Add list
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

  (use-package org-bullets
    :after org
    :hook (org-mode . org-bullets-mode)
    :custom
    (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

  ;; Focus
  (use-package olivetti
    :hook (org-mode . olivetti-mode)
    :custom
    (olivetti-body-width 0.8))

  (org-babel-do-load-languages
   'org-babel-load-languages
      '((emacs-lisp . t)))

  ;; Automatically tangle Emacs.org config file when it is saved
  (defun jh/emacs-org-tangle ()
    (when (string-equal (buffer-file-name)
    (expand-file-name "~/dotfiles/emacs/.emacs.d/Emacs.org"))

      ;; Dynamic scoping to the rescue
      (let ((org-confirm-babel-evaluate nil))
        (org-babel-tangle))))
      
    (add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'jh/emacs-org-tangle)))

  ;; EVIL Keyboard
  (use-package undo-fu)

  (use-package evil
    :init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-want-C-u-scroll t)
    (setq evil-want-C-i-jump nil)
    :custom ((evil-undo-system 'undo-fu))
    :config
    (evil-mode 1))

  (use-package evil-collection
    :after evil
    :config
    (evil-collection-init))

  (define-key evil-insert-state-map "\C-k" nil)
  (define-key evil-ex-completion-map "\C-k" nil)

  (use-package evil-commentary
    :ensure t
    :config
    (evil-commentary-mode 1))

  (use-package diminish
    :ensure t)

  ;; IVY Completion
  (use-package ivy
    :diminish
    :bind (("C-s" . swiper)
           :map ivy-minibuffer-map
           ("TAB" . ivy-alt-done)	
           ("C-l" . ivy-alt-done)
           ("C-j" . ivy-next-line)
           ("C-k" . ivy-previous-line)
           ("C-d" . ivy-switch-buffer-kill)
           ("S-<return>" . ivy-immediate-done)
           :map ivy-switch-buffer-map
           ("C-j" . ivy-next-line)
           ("C-k" . ivy-previous-line)
           ("C-l" . ivy-done)
           ("C-d" . ivy-switch-buffer-kill)
           :map ivy-reverse-i-search-map
           ("C-j" . ivy-next-line)
           ("C-k" . ivy-previous-line)
           ("C-d" . ivy-reverse-i-search-kill))
    :custom
    (ivy-on-del-error-function #'ignore)
    (ivy-initial-inputs-alist nil)
    :config
    (evil-collection-define-key 'normal 'evil-ex-completion-map
      "C-k" nil
      "C-j" nil)
    (add-to-list 'ivy-ignore-buffers "\\*")
    (setq ivy-re-builders-alist
     '((swiper . ivy--regex-plus)
       (t . ivy--regex-fuzzy)))
    (ivy-mode 1))

  (use-package ivy-rich
    :init
    (ivy-rich-mode 1))

  (use-package ivy-hydra)

  (use-package flx  ;; Improves sorting for fuzzy-matched results
    )
    ;; :defer t
    ;; :init
    ;; (setq ivy-flx-limit 10000))

  (use-package smex
    :defer t)

  (use-package swiper
    :ensure t
    :custom
    (swiper-goto-start-of-match t))

  (use-package counsel
    :ensure t
    :bind (("M-x" . counsel-M-x)
           ("C-x b" . counsel-ibuffer)
           ("C-x C-f" . counsel-find-file)
           :map minibuffer-local-map
           ("C-r" . counsel-minibuffer-history)))

  (use-package counsel-projectile
    :config (counsel-projectile-mode))

  (use-package which-key
    :init (which-key-mode)
    :diminish which-key-mode
    :custom
      (which-key-idle-delay 0.3))

  (use-package helpful
    :custom
    (counsel-describe-function-function #'helpful-callable)
    (counsel-describe-variable-function #'helpful-variable)
    :bind
    ([remap describe-function] . counsel-describe-function)
    ([remap describe-command] . helpful-command)
    ([remap describe-variable] . counsel-describe-variable)
    ([remap describe-key] . helpful-key))

    ;; DIRED
    (put 'dired-find-alternate-file 'disabled nil) ; disables warning

    (defun jh/dired-up ()
      (interactive)
      (find-alternate-file ".."))

    (defun kill-dired-buffers ()
      (interactive)
      (mapc (lambda (buffer) 
              (when (eq 'dired-mode (buffer-local-value 'major-mode buffer)) 
                (kill-buffer buffer))) 
            (buffer-list)))

    (use-package dired
      :ensure nil
      :commands (dired dired-jump)
      :bind (("C-c C-j" . dired-jump))
      :custom
      (dired-omit-files "\\`[.]?#\\|\\`[.][.]?\\'\\|^\\..+$")
      (dired-listing-switches "-agho --group-directories-first")
      (dired-dwim-target t)
      :config
      (evil-collection-define-key 'normal 'dired-mode-map
        "h" 'dired-up-directory
        "l" 'dired-open-file
        ;; "h" 'jh/dired-up
        ;; "l" 'dired-find-alternate-file
        "q" 'kill-dired-buffers))

    (use-package dired-subtree)

    (defun jh/dired-hook ()
      (all-the-icons-dired-mode)
      (dired-hide-details-mode))

     (use-package all-the-icons-dired
       :hook (dired-mode . jh/dired-hook))

    (use-package dired-open
      :custom
      (dired-open-extensions '(("png" . "sxiv")
                               ("jpg" . "sxiv")
                               ("pdf" . "zathura")
                               ("mp4" . "mp4")
                               ("mkv" . "mpv"))))
    (use-package dired-x
      :ensure nil
      :custom
      (dired-omit-files "\\`[.]?#\\|\\`[.][.]?\\'\\|^\\..+$")
      (dired-guess-shell-alist-user
       '(("\\.e?ps$" "gv" "xloadimage" "lpr")
         ("\\.chm$" "xchm")
         ("\\.e?ps\\.g?z$" "gunzip -qc * | gv -")
         ("\\.pdf$" "zathura")
         ("\\.flv$" "mpv")
         ("\\.mov$" "mpv")
         ("\\.3gp$" "mpv")
         ("\\.png$" "sxiv")
         ("\\.jpg$" "sxiv")
         ("\\.JPG$" "sxiv")
         ("\\.avi$" "mpv")))
      :config
      (evil-collection-define-key 'normal 'dired-mode-map
        "H" 'dired-omit-mode))

    (use-package dired-ranger)

    ;; PROJECTILE
    (use-package projectile
      :diminish projectile-mode
      :config
      (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
      (projectile-mode +1))
      ;; :custom 
      ;; (projectile-completion-system 'ivy))

  ;; Copy Path
  (defun jh/copy-file-path ()
    "Put the current file name on the clipboard"
    (interactive)
    (let ((filename (file-relative-name buffer-file-name (projectile-project-root))))
      (when filename
        (kill-new filename)
        (message "Copied buffer file name '%s' to the clipboard." filename))))

  (use-package neotree
    :custom
    (neo-show-hidden-files t)
    (neo-smart-open t))

  ;; MAGIT
  (use-package magit
    :custom
    (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

  (defun jh/copy-magit-branch ()
    "Show the current branch in the echo-area and add it to the `kill-ring'."
    (interactive)
    (let ((branch (magit-get-current-branch)))
      (if branch
          (progn (kill-new branch)
                 (message "%s" branch))
        (user-error "There is not current branch"))))

  ;; Languages Servers
  (use-package lsp-mode
    :commands (lsp lsp-deferred)
    :hook (js-mode . lsp-deferred)
    :custom
    (lsp-auto-guess-root t)
    (lsp-eldoc-hook nil)
    :init
    (setq lsp-keymap-prefix "C-c l")
    :config
    (lsp-enable-which-key-integration t))

  ;; Company
  (use-package company
    :after lsp-mode
    :hook (lsp-mode . company-mode)
    :bind (:map lsp-mode-map
            ("<tab>" . company-indent-or-complete-common))
    :custom
    (company-minimum-prefix-length 1)
    (company-idle-delay 0.0))

(use-package haskell-mode)

  (use-package js
    :custom
    (js-indent-level 2))

(use-package lua-mode)

  (use-package restclient)
  (add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))
  (use-package ob-restclient)

  ;; TERM
  (setq term-prompt-regexp ".*@.*]$ *")
  (setq explicit-shell-file-name "bash")

  (use-package vterm
    :commands vterm
    :custom
    (vterm-max-scrollback 10000))

  (defun jh/eshell-hook ()
      (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)
      (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)
      (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
      (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
      (evil-normalize-keymaps)

      (setq eshell-history-size 10000
            eshell-buffer-maximum-lines 10000
            eshell-hist-ignoredups t
            eshell-scroll-to-bottom-on-input t))

  (use-package eshell
    :hook (eshell-first-time-mode . jh/eshell-hook)
    :config
    (with-eval-after-load 'esh-opt
      (setq eshell-destroy-buffer-when-process-dies t
            eshell-visual-commands '("htop" "bash" "vim"))))

  (use-package shell-pop
    :custom
   (shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
   (shell-pop-universal-key "M-d")
   :bind
    ("M-1" . (lambda () (interactive)(shell-pop 1)))
    ("M-2" . (lambda () (interactive)(shell-pop 2)))
    ("M-3" . (lambda () (interactive)(shell-pop 3)))
    ("M-4" . (lambda () (interactive)(shell-pop 4)))
    ("M-5" . (lambda () (interactive)(shell-pop 5)))
    ("M-6" . (lambda () (interactive)(shell-pop 6)))
    ("M-7" . (lambda () (interactive)(shell-pop 7)))
    ("M-8" . (lambda () (interactive)(shell-pop 8)))
    ("M-9" . (lambda () (interactive)(shell-pop 9)))
    ("M-0" . (lambda () (interactive)(shell-pop 0)))
   )

  ;; Make ESC quit prompts
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
  (global-set-key (kbd "<M-tab>") 'mode-line-other-buffer)

  ;; KEYBINGDS
  (use-package hydra)

  (use-package general
    :config
    (general-create-definer jh/leader-keys
      :keymaps '(normal insert visual emacs)
      :prefix "SPC"
      :global-prefix "C-SPC")

    (jh/leader-keys
    "." '(find-file :which-key "find-file")
    "," '(counsel-projectile-switch-to-buffer :which-key "pj/switch-buffer")
    "SPC" '(counsel-switch-buffer :which-key "cs/switch-buffer")
    ;; Org Agenda
    "a" '(org-agenda :which-key "org-agenda")
    "c" '(org-capture :which-key "org-capture")
    "o" '(:ignore t :which-key "org-agenda")
    "of" '(org-cycle-agenda-files :which-key "agenda-files")
    "ol" '(org-agenda-list :which-key "org-agenda-list")
    ;; Search
    "s" '(:ignore s :which-key "search")
    "sp" '(counsel-projectile-rg :which-key "counsel-projectile-rg")
    "sl" '(browse-url :which-key "open link")
    ;; Simulating C-x
    "x" '(:ignore t :which-key "C-x")
    "xw" '(kill-buffer-and-window :which-key "kill buf/window")
    "xk" '(kill-this-buffer :which-key "kill buffer")
    ;; File Management
    "d" '(:ignore t :which-key "directory")
    "do" '(dired-open-xdg :which-key "open-xdg")
    "dd" '(neotree-toggle :which-key "neotree")
    "dc" '(dired-ranger-copy :which-key "dired-ranger-copy")
    "dp" '(dired-ranger-paste :which-key "dired-ranger-paste")
    "f" '(:ignore t :which-key "File")
    "fd" '(dired-jump :which-key "dired-jump")
    "fr" '(counsel-buffer-or-recentf :which-key "counsel-recent")
    "fp" '(jh/copy-file-path :which-key "copy-file-path")
    ;; Custom toggles
    "t" '(:ignore t :which-key "toggles")
    "to" '(olivetti-mode :which-key "olivetti-mode")
    "tt" '(counsel-load-theme :which-key "Load theme")
    "tb" '(jh/toggle-transparency :which-key "toogl transparency")
    "t1" '(jh/transparency :which-key "% transparency")
    ;; Magit
    "g" '(:ignore t :which-key "magit")
    "gg" '(magit-status :which-key "magit-status")
    "gc" '(jh/copy-magit-branch :which-key "copy-magit-branch")
    ;; Bookmarks
    "m" '(bookmark-map :which-key "bookmarks")
    ;; Projectile
    "p" '(projectile-command-map :which-key "projectile")
    "p SPC" '(counsel-projectile :which-key "cs/find-file")
    "po" '(projectile-switch-open-project :which-key "open projects")
    "pp" '(counsel-projectile-switch-project :which-key "switch-project")
    "pe" '(projectile-run-eshell :which-key "eshell")
    ;; ...
    ))

  ;; Org Maps
  (general-define-key
   :states '(normal insert visual emacs)
   :keymaps '(org-mode-map outline-mode-map)
   "M-j" 'org-metadown
   "M-k" 'org-metaup
   "M-J" 'org-shiftmetadown
   "M-K" 'org-shiftmetaup
   ;; ...
   )

  ;; Dired 
  (general-define-key
   :states '(normal insert visual emacs)
   :keymaps '(dired-mode-map)
   "SPC" nil
   )

  ;; Magit Clear SPC
  (general-define-key
   :keymaps '(magit-mode-map magit-blame-read-only-mode-map)
   "SPC" nil
   )
