;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Bolun Liu"
      user-mail-address "samon6bl@gmail.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(setq org-directory "~/Think/Org")
(setq org-noter-notes-search-path '("~/Think/Org/roam/"))
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


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
;;
;;Key Configuration for Doom as Vanilla Emacs


;; (setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 17))
;; (setq doom-font (font-spec :family "Sarasa Mono SC " :size 20))
(setq doom-font (font-spec :family "Source Code Pro" :size 16))


;; ------------------------------------------------ Org-mode 的配置 ---------------------------------------------------------
(add-hook 'org-mode-hook #'valign-mode)
(defun nolinum ()
  (interactive)
  (message "Deactivated linum mode")
  (display-line-numbers-mode 0)
  )
(add-hook 'org-mode-hook 'nolinum)
(use-package org-download
  :after org
  :config
  (setq-default org-download-image-dir "/home/samon/Think/Org/pic")
  :bind
  (:map org-mode-map
        (("s-Y" . org-download-screenshot)
         ("s-y" . org-download-clipboard))))

(use-package org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))
(use-package org-journal
  :ensure t
  :defer t
  :init
  ;; Change default prefix key; needs to be set before loading org-journal
  :config
  (setq org-journal-dir "~/Think/Org/journal/"
        org-journal-date-format "%A, %d %B %Y")
  (setq org-journal-time-prefix "** " ))
(server-start)
(require 'org-roam-protocol)
(require 'org-protocol-capture-html)
(require 'ox-freemind)
(setq org-export-backends '(freemind odt latex icalendar html ascii))
(add-to-list 'org-capture-templates
             '("w" "Web site" entry
              (file "~/Think/Org/web.org" )
              "* %a :website:\n\n%U %?\n\n%:initial"))
(use-package sdcv
  :bind ("C-c f" . sdcv-search-pointer+)
        ("C-c s" . sdcv-search-input+)
  :config
  (setq sdcv-say-word-p t)               ;say word after translation
  (setq sdcv-dictionary-data-dir "/usr/share/stardict/dic") ;setup directory of stardict dictionary
  (setq sdcv-dictionary-simple-list    ;setup dictionary list for simple search
      '("朗道汉英字典5.0"
        "朗道英汉字典5.0"))
  (setq sdcv-dictionary-complete-list     ;setup dictionary list for complete search
      '(
        "朗道汉英字典5.0"
        "牛津现代英汉双解词典"
        "朗道英汉字典5.0"
        )))
(map! :leader :n "e" 'elfeed)
(use-package org-super-agenda
  :after org-agenda
  :init
  (setq org-super-agenda-groups'((:name "Urgency"
                                  :time-grid t
                                  :property "A")))
  :config
  (org-super-agenda-mode))

(use-package calibredb
  :defer t
  :init
  (autoload 'calibredb "calibredb")
  :config
  (setq calibredb-root-dir "/home/samon/Calibre_Library/")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist '(("/home/samon/Calibre_Library/"))))

(use-package hypothesis
  :init
  (setq hypothesis-username "samon6bl")
  (setq hypothesis-token "6879-2sB-ygcUO2v4NRNfuunqiq1rnzFtfyPwFDx5QR9h0rc"))

;; org-roam任务动态添加到agenda
(defvar dynamic-agenda-files nil
  "dynamic generate agenda files list when changing org state")

(defun update-dynamic-agenda-hook ()
  (let ((done (or (not org-state) ;; nil when no TODO list
                  (member org-state org-done-keywords)))
        (file (buffer-file-name))
        (agenda (funcall (ad-get-orig-definition 'org-agenda-files)) ))
    (unless (member file agenda)
      (if done
          (save-excursion
            (goto-char (point-min))
            ;; Delete file from dynamic files when all TODO entry changed to DONE
            (unless (search-forward-regexp org-not-done-heading-regexp nil t)
              (customize-save-variable
               'dynamic-agenda-files
               (cl-delete-if (lambda (k) (string= k file))
                             dynamic-agenda-files))))
        ;; Add this file to dynamic agenda files
        (unless (member file dynamic-agenda-files)
          (customize-save-variable 'dynamic-agenda-files
                                   (add-to-list 'dynamic-agenda-files file)))))))
(use-package calfw-org
  :init
  (setq cfw:org-agenda-schedule-args '(:scheduled*))
 ;; (setq cfw:org-overwrite-default-keybinding t)
   :config
   (setq calendar-week-start-day 1)
   (custom-set-faces
  '(cfw:face-title ((t (:foreground "#f0dfaf" :weight bold :height 2.0 :inherit variable-pitch))))
  '(cfw:face-header ((t (:foreground "#d0bf8f" :weight bold))))
  '(cfw:face-sunday ((t :foreground "#cc9393" :background "grey10" :weight bold)))
  '(cfw:face-saturday ((t :foreground "#8cd0d3" :background "grey10" :weight bold)))
  '(cfw:face-holiday ((t :background "grey10" :foreground "#8c5353" :weight bold)))
  '(cfw:face-grid ((t :foreground "DarkGrey")))
  '(cfw:face-default-content ((t :foreground "#bfebbf")))
  '(cfw:face-periods ((t :foreground "cyan")))
  '(cfw:face-day-title ((t :background "grey10")))
  '(cfw:face-default-day ((t :weight bold :inherit cfw:face-day-title)))
  '(cfw:face-annotation ((t :foreground "RosyBrown" :inherit cfw:face-day-title)))
  '(cfw:face-disable ((t :foreground "DarkGray" :inherit cfw:face-day-title)))
  '(cfw:face-today-title ((t :background "#7f9f7f" :weight bold)))
  '(cfw:face-today ((t :background: "grey10" :weight bold)))
  '(cfw:face-select ((t :background "#2f2f2f")))
;;'(cfw:face-toolbar ((t :foreground "Steelblue4" :background "Steelblue4")))
  '(cfw:face-toolbar-button-off ((t :foreground "Gray10" :weight bold)))
  '(cfw:face-toolbar-button-on ((t :foreground "Gray50" :weight bold))))
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
   )
(use-package ox-hugo
  :after ox)
;; --------------------------------------------------------------------------------------------------------------------------

;; ------------------------------------------------- 快捷键的全部配置 ---------------------------------------------------------
