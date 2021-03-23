(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(projectile-generic-command
   '(closure
     (t)
     (_)
     (cond
      ((let*
           ((bin
             (and t
                  (if
                      (condition-case nil
                          (progn
                            (file-remote-p default-directory nil t))
                        (error nil))
                      (cl-find-if
                       (doom-rpartial #'executable-find t)
                       (list "fdfind" "fd"))
                    doom-projectile-fd-binary))))
         (if bin
             (concat
              (format "%s . -0 -H --color=never --type file --type symlink --follow --exclude .git --no-ignore" bin)
              (if IS-WINDOWS " --path-separator=/"))
           nil)))
      ((executable-find "rg" t)
       (concat "rg -0 --files --follow --color=never --hidden -g!.git --no-ignore"
               (if IS-WINDOWS " --path-separator=/")))
      ("find . -type f -print0")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
