;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;;
;;
(require 'loadhist)
(file-dependents (feature-file 'cl))
(add-to-list 'load-path "~/.emacs.d/site-lisp/websocket-bridge/")
(menu-bar-mode -1)
;; (prefer-coding-system 'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)

(when IS-MAC
  ;; set keys for Apple keyboard, for emacs in OS X
(setq mac-command-modifier 'meta) ; make cmd key do Meta
(setq mac-option-modifier 'super) ; make opt key do Super
(setq mac-control-modifier 'control) ; make Control key do Control
(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper
)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-mail-address "Samon6bl@gmail.com")
;; (add-to-list 'after-make-frame-functions
;;                 (lambda (new-frame)
;;                 (select-frame new-frame)
;;                 ;; English Font
                ;; (set-face-attribute 'default nil :font "Maple Mono SC NF" )))
                ;; (if (display-graphic-p)


;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face

      ;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(use-package modus-themes
  :init
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil
        modus-themes-region '(bg-only no-extend)
        modus-themes-org-blocks 'gray-background)

  ;; Load the theme files before enabling a theme
  (modus-themes-load-themes)
  :config
(setq modus-themes-headings
      '((1 . (variable-pitch 1.5))
        (2 . (rainbow 1.3))
        (3 . (1.1))
        (t . (monochrome))))
  ;; Load the theme of your choice:
  (modus-themes-load-operandi) ;; OR (modus-themes-load-vivendi)
  :bind ("<f5>" . modus-themes-toggle)
  )


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "/Users/Samon/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/")
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; System Config
(setq max-lisp-eval-depth 10000)

;;; roam v2 configuration

(use-package org-roam
  :after org
  :commands (org-roam-buffer
             org-roam-setup
             org-roam-capture
             org-roam-node-find)
  :init
  (setq org-roam-db-location (expand-file-name ".cache/org-roam.db" user-emacs-directory))
  (setq org-roam-file-extensions '("org" "md")) ; enable Org-roam for a markdown extension
  (setq org-id-link-to-org-use-id t)
  (setq org-roam-completion-everywhere t)
  (setq org-roam-directory (concat org-directory "pages/"))
  ;; disable V1 to V2
  (setq org-roam-v2-ack t)
  :config
  (setq org-roam-completion-everywhere nil))

(use-package md-roam
  :init
  (md-roam-mode 1)
  (setq md-roam-file-extension "md") ; default "md". Specify an extension such as "markdown"
  (org-roam-db-autosync-mode 1)
)
(add-hook 'org-mode-hook #'valign-mode)

;;     (defun my-org-download-method  (link)
;;       (let ((filename
;; 	     (file-name-nondirectory
;; 	      (car (url-path-and-query
;; 		    (url-generic-parse-url (org-link-unescape link))))))
;; 	    (dirname (file-name-sans-extension (buffer-name)) ))
;; 	;; if directory not exist, create it
;; 	(unless (file-exists-p dirname)
;; 	  (make-directory dirname))
;; 	;; return the path to save the download files
;; 	(expand-file-name filename dirname))
;;       )
;; (setq org-download-method 'my-org-download-method)

(use-package org-download
  :hook ((org-mode dired-mode) . org-download-enable)
  :bind (:map org-mode-map
              ("<f4>" . org-download-screenshot))
  :init
  (org-download-enable)
  :config
  (setq org-download-display-inline-images 'posframe)
  (setq org-download-screenshot-file (concat temporary-file-directory "image.png"))
  (setq org-download-method 'attach)
  (setq org-download-image-attr-list
      '("#+ATTR_ORG: :width 400px :align center"))
  (setq-default org-download-heading-lvl 'nil)
  (setq org-download-link-format "[[file:%s]]")
  )
;; 中文行内强调
(add-hook 'org-mode-hook 'separate-inline-mode)
(add-hook 'org-mode-hook
          '(lambda ()
            (add-hook 'separate-inline-mode-hook
                      'separate-inline-use-default-rules-for-org-local
                      nil 'make-it-local)))

(defun separate-inline-use-default-rules-for-org-local ()
  "A tested rules for Chinese user to separate inline in org-mode.
org-mode 中文行内分隔规格"
  (make-local-variable 'separate-inline-regexp-rules)
  (setq separate-inline-regexp-rules
        '(("[\*\+\/\~\=\$\_]\\cc+[\*\+\/\~\=\$\_]"
           "\\cc" . "\x200B")
          ("[\*\+\/\~\=\$\_]*[0-9A-Za-z]+[\-0-9A-Za-z\*\+\/\~\=\$\_]*"
           "\\cc" . " "))))
(defun my/remove-zero-width-space ()
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "[^=\\|*\\|+\\|~\\|/\\|_]\\(\u200b\\)[^=\\|*\\|+\\|~\\|/\\|_]" nil t)
        (replace-match "" t t nil 1)
        )
      )
    )
  )
(add-hook 'before-save-hook 'my/remove-zero-width-space)
;; Emacs的org-mode中文行内格式
(setq org-emphasis-regexp-components
      '("-[:multibyte:][:space:]('\"{"
        "-[:multibyte:][:space:].,:!?;'\")}\\["
        "[:space:]"
        "."
        1))
(add-hook 'org-mode-hook 'org-appear-mode)


(use-package org-journal
  :defer t
  :init
  ;; Change default prefix key; needs to be set before loading org-journal
  (setq org-journal-prefix-key "C-c j ")
  :config
  (setq org-journal-dir (concat org-directory "/journals"))
  (setq org-journal-file-format "%Y_%m_%d.org")
  (setq org-journal-file-type 'daily))

(after! org
  (setq org-agenda-files
        (directory-files-recursively
         (concat org-directory "/pages/Agenda") "\\.org$"))
(setq org-todo-keywords '((sequence "IDEA(i)" "TODO(t!)"  "LOOP(r)" "PROG(p!)" "WAIT(w@)" "HOLD(h@)" "|" "DONE(d@)" "KILL(k@)" "CANCLE(c@)"))
))


(server-start)
(use-package s)

;; org-capture-tmplates
(use-package org-protocol-capture-html)
(setq! org-capture-templates
       (doct '(("Todo task" :keys "t"
                :file "/Users/Samon/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/pages/Agenda/TODO_BOX.org"
                :type plain
                :template ("** %{todo-state} %^{Task}"
                           "DEADLINE: %^T SCHEDULE: %^T"
                           ":PROPERTIES:"
                           ":Created: %U"
                           ":END:"
                           "%?")
                :children (("Todo capture to box" :keys "i"
                            :todo-state "TODO")
                           ("Todo now" :keys "t"
                            :todo-state "DOING"
                            :clock-in t)))
               ("Get an idea" :keys "i"
                :file "/Users/Samon/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/pages/Agenda/Idea.org"
                :type plain
                :template ("** IDEA %^{Idea}"
                           ":PROPERTIES:"
                           ":Created: %U"
                           ":END:"
                           "%?"))
               ("Capture from Web" :keys "w"
                :file "/Users/Samon/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/pages/20221128142407-web_capture_inbox.org"
                :type plain
                :template ("** %a"
                           ":PROPERTIES:"
                           ":ID: %(org-id-uuid)"
                           ":END:"
                           "%:initial"))
               )))
(add-to-list 'org-capture-templates
             `("a" "Anki" entry
               (file+headline "/Users/Samon/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/pages/20221007211048-anki.org" "Inbox")
               ,(concat "** %i \n"
                        "%(generate-anki-note-body)\n")))
(add-to-list 'org-capture-templates
             `("x" "Anki Defalt" entry
               (file+headline "/Users/Samon/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/pages/20221007211048-anki.org" "Inbox")
               "** %f \n :PROPERTIES:\n:ANKI_DECK: Mega\n:ANKI_NOTE_TYPE: 三合一-new \n:END:\n*** 标题\n %?\n*** 摘录/正面\n%i\n*** 摘录/背面\n %i\n*** 挖空率\n*** 笔记\n*** Remarks\n*** MNLink\n*** MNMindMap"))
(defun generate-anki-note-body ()
  (interactive)
  (message "Fetching note types...")
  (let ((note-types (sort (anki-editor-note-types) #'string-lessp))
        (decks (sort (anki-editor-deck-names) #'string-lessp))
        deck note-type fields)
    (setq deck (completing-read "Choose a deck: " decks))
    (setq note-type (completing-read "Choose a note type: " note-types))
    (message "Fetching note fields...")
    (setq fields (anki-editor--anki-connect-invoke-result "modelFieldNames" `((modelName . ,note-type))))
    (concat "  :PROPERTIES:\n"
            "  :ANKI_DECK: " deck "\n"
            "  :ANKI_NOTE_TYPE: " note-type "\n"
            "  :END:\n\n"
            (mapconcat (lambda (str) (concat "** " str))
                       fields
                       "\n\n"))))
;; (use-package company
;;   :ensure t
;;   :init (global-company-mode)
;;   :config
;;   (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
;;   (setq company-tooltip-align-annotations t)
;;   (setq company-idle-delay 0.0)
;;   (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
;;   (setq company-selection-wrap-around t)
;;   (setq company-transformers '(company-sort-by-occurrence))) ; 根据选择的频率进行排序，读者如果不喜欢可以去掉
(use-package company
  :hook
  ((c++-mode python-mode clojure-mode web-mode) . company-mode)
  :config
  ;; (setq company-backends '(company-lsp company-files company-keywords)
  (setq company-backends '(company-capf company-files company-keywords)
	company-idle-delay 0.2)
  :commands company-mode)
 (use-package lsp-mode
  :hook
  ((c++-mode python-mode clojure-mode web-mode) . lsp)
  :config
  (setq lsp-enable-snippet nil)
  :commands lsp)
(use-package lsp-ui
  :config
  (setq lsp-ui-doc-show-with-cursor t)
  )

;; Org 下 Block美化
;; 如何在 Source Block 中像在语言 mode 中一样的缩进
(after! org
  (setq org-src-tab-acts-natively t)
  (setq org-src-preserve-indentation nil)
  (setq org-indent-mode nil))

;;如何禁用 evaluate code block 时的确认提示
(after! org
  (setq org-confirm-babel-evaluate nil))
;;如何美化 quote 和 verse block
(setq org-fontify-quote-and-verse-blocks t)
;;如何使用 Plantuml
;;(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
;; (setq org-plantuml-jar-path (expand-file-name "~/Documents/emacs/org/private/plantuml.jar"))
;; (setq plantuml-default-exec-mode 'jar)

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((plantuml . t)))
;;如何配置 block 默认参数
(setq org-babel-default-header-args
      '((:session . "none")
        (:results . "replace")))
;;如何配置导出 HTML 的样式
(setq org-html-coding-system 'utf-8)
(setq org-html-doctype "html5")
(setq org-html-head
      "<link rel='stylesheet' type='text/css' href='https://gongzhitaao.org/orgcss/org.css'/> ")
;;orgmode 的表格如何中英文混排对齐
(use-package! valign
  :config
  (setq valign-fancy-bar t)
  (add-hook 'org-mode-hook #'valign-mode))
;;如何在完成任务时自动打上完成时间的标签
(after! org
  (setq org-log-done t)
  (setq org-log-into-drawer t)
(setq org-hide-emphasis-markers t))
;; Possible values are:

;;   nil     Don't add anything, just change the keyword
;;   time    (or t) Add a time stamp to the task
;;   note    Prompt for a note and add it with template org-log-note-headings
;; 隐藏Org－emphaisis标记
;;如何设置记录 log 信息到 drawer 中?
;;让任务的Property可以被子任务继承
(after! org
  (setq org-use-property-inheritance t))
(map! :leader :n "j" #'avy-goto-char-2)
(map! :leader :n "I" #'org-capture)

;;如何跳转时支持汉字拼音
(use-package! ace-pinyin
  :config
  (ace-pinyin-global-mode +1))
(use-package dirvish
  :config
  (setq dirvish-hide-details nil)
  ;; Placement
;; (setq dirvish-use-header-line nil)     ; hide header line (show the classic dired header)
;; (setq dirvish-use-mode-line nil)       ; hide mode line
(setq dirvish-use-header-line 'global)    ; make header line span all panes

;; Height
;;; '(25 . 35) means
;;;   - height in single window sessions is 25
;;;   - height in full-frame sessions is 35
(setq dirvish-header-line-height '(25 . 35))
(setq dirvish-mode-line-height 25) ; shorthand for '(25 . 25)

;; Segments
;;; 1. the order of segments *matters* here
;;; 2. it's ok to place raw string inside
(setq dirvish-header-line-format
      '(:left (path) :right (free-space))
      dirvish-mode-line-format
      '(:left (sort file-time " " file-size symlink) :right (omit yank index))))
(dirvish-override-dired-mode)
(use-package hydra)
(use-package super-save
  :config
  (super-save-mode +1))
(setq org-confirm-babel-evaluate nil)
;; (use-package jupyter
;;   :demand t
;;   :after (:all org python))
;; (setq org-babel-default-header-args:jupyter-python '((:results . "output")(:kernel . "python3")(:async . "yes")))
(setq org-clock-watch-play-sound-command-str "mpv")
;; (use-package org-gtd
;;   :after org
;;   :demand t
;;   :custom
;;   (org-gtd-directory stag-org-gtd-directory)
;;   (org-edna-use-inheritance t)
;;   :config
;;   (org-edna-mode)
;;   :bind
;;   (("C-c d c" . org-gtd-capture)
;;    ("C-c d e" . org-gtd-engage)
;;    ("C-c d p" . org-gtd-process-inbox)
;;    ("C-c d n" . org-gtd-show-all-next)
;;    ("C-c d s" . org-gtd-show-stuck-projects)
;;    :map org-gtd-process-map
;;    ("C-c c" . org-gtd-choose)))
(use-package deft
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory org-roam-directory))
(use-package! org-transclusion
  :after org
  :init
  (map!
   :map global-map "<f3>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))
(use-package rime
  :custom
  (default-input-method "rime")
  (rime-librime-root "~/.emacs.d/librime/dist"))
(use-package treemacs
  :defer t
  :config
  (treemacs-tag-follow-mode)
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ;; ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag))
  (:map treemacs-mode-map
	("/" . treemacs-advanced-helpful-hydra)))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package lsp-treemacs
  :after (treemacs lsp))

(use-package shrface
  :defer t
  :config
  (shrface-basic)
  (shrface-trial)
  (shrface-default-keybindings) ; setup default keybindings
  (setq shrface-href-versatile t))

(use-package eww
  :defer t
  :init
  (add-hook 'eww-after-render-hook #'shrface-mode)
  :config
  (require 'shrface))
(use-package nov
  :defer t
  :init
  (add-hook 'nov-mode-hook #'shrface-mode)
  :config
  (require 'shrface)
  (setq nov-shr-rendering-functions '((img . nov-render-img) (title . nov-render-title)))
  (setq nov-shr-rendering-functions (append nov-shr-rendering-functions shr-external-rendering-functions)))
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
(use-package nov)
(use-package calibredb
  :defer t
  :config
  (setq calibredb-root-dir "/Users/Samon/Calibre 书库")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist '(("/Users/Samon/Calibre 书库"))))
(after! org-roam
  ;;* dynamic agenda https://github.com/brianmcgillion/doomd/blob/master/config.org
  ;; https://d12frosted.io/posts/2021-01-16-task-management-with-roam-vol5.html
  ;; The 'roam-agenda' tag is used to tell vulpea that there is a todo item in this file
  (add-to-list 'org-tags-exclude-from-inheritance "roam-agenda")

  (require 'vulpea)

  (defun vulpea-buffer-p ()
    "Return non-nil if the currently visited buffer is a note."
    (and buffer-file-name
         (string-prefix-p
          (expand-file-name (file-name-as-directory org-roam-directory))
          (file-name-directory buffer-file-name))))

  (defun vulpea-project-p ()
    "Return non-nil if current buffer has any todo entry.

TODO entries marked as done are ignored, meaning the this
function returns nil if current buffer contains only completed
tasks."
    (seq-find                                 ; (3)
     (lambda (type)
       (eq type 'todo))
     (org-element-map                         ; (2)
         (org-element-parse-buffer 'headline) ; (1)
         'headline
       (lambda (h)
         (org-element-property :todo-type h)))))

  (defun vulpea-project-update-tag (&optional arg)
    "Update PROJECT tag in the current buffer."
    (interactive "P")
    (when (and (not (active-minibuffer-window))
               (vulpea-buffer-p))
      (save-excursion
        (goto-char (point-min))
        (let* ((tags (vulpea-buffer-tags-get))
               (original-tags tags))
          (if (vulpea-project-p)
              (setq tags (cons "roam-agenda" tags))
            (setq tags (remove "roam-agenda" tags)))

          ;; cleanup duplicates
          (setq tags (seq-uniq tags))

          ;; update tags if changed
          (when (or (seq-difference tags original-tags)
                    (seq-difference original-tags tags))
            (apply #'vulpea-buffer-tags-set tags))))))

  ;; https://systemcrafters.net/build-a-second-brain-in-emacs/5-org-roam-hacks/
  (defun my/org-roam-filter-by-tag (tag-name)
    (lambda (node)
      (member tag-name (org-roam-node-tags node))))

  (defun my/org-roam-list-notes-by-tag (tag-name)
    (mapcar #'org-roam-node-file
            (seq-filter
             (my/org-roam-filter-by-tag tag-name)
             (org-roam-node-list))))

  (defun dynamic-agenda-files-advice (orig-val)
    (let ((roam-agenda-files (delete-dups (my/org-roam-list-notes-by-tag "roam-agenda"))))
      (cl-union orig-val roam-agenda-files :test #'equal)))

  (add-hook 'before-save-hook #'vulpea-project-update-tag)
  (advice-add 'org-agenda-files :filter-return #'dynamic-agenda-files-advice))

(use-package org-roam-timestamps
  :after org-roam
  :init
  (org-roam-timestamps-mode)
  :config
  (setq org-roam-timestamps-minimum-gap 3600))

(setq! word-wrap-by-category t)


(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(global-set-key [f12] 'fullscreen)

(setq! +zen-window-divider-size 10)
(defface org-bold
  '((t
     :weight bold))
  "Face for org-mode bold."
  :group 'org-faces )
;; Org 加粗、下划线标记样式
(setq org-emphasis-alist
      '(("*" org-bold)
        ("/" italic)
        ("_" underline)
        ("=" ;(:background "maroon" :foreground "white")
         org-verbatim verbatim)
        ("~"  (:background "deep sky blue" :foreground "MidnightBlue")
         org-code verbatim)
        ("+" (:strike-through t))))
(map! :v "m"  #'org-emphasize  )
(use-package wallabag
  :defer t
  :config
  (setq wallabag-host "https://pocket.samon6bl.xyz") ;; wallabag server host name
  (setq wallabag-username "samon6bl") ;; username
  (setq wallabag-password "lbl2272722") ;; password
  (setq wallabag-clientid "3_3urz3edqgj8kckg4s48o8w4so000kw8c8c4c00wo408cggoggg") ;; created with API clients management
  (setq wallabag-secret "6dhwf7c41bc48gs8kwwscgk8cskg040w00wwkk4000kw0oc0g8") ;; created with API clients management
  ;; (setq wallabag-db-file "~/OneDrive/Org/wallabag.sqlite") ;; optional, default is saved to ~/.emacs.d/.cache/wallabag.sqlite
  (run-with-timer 0 3540 'wallabag-request-token) ;; optional, auto refresh token, token should refresh every hour
  )

(defvar eldoc-posframe-buffer "*eldoc-posframe-buffer*"
"The posframe buffer name use by eldoc-posframe.")
(defvar eldoc-posframe-hide-posframe-hooks
'(pre-command-hook post-command-hook focus-out-hook)
"The hooks which should trigger automatic removal of the posframe.")
(defvar eldoc-posframe-delay 0.2
"Delay seconds to display `eldoc'.")
(defvar-local eldoc-posframe--timer nil)
(defun eldoc-posframe-hide-posframe ()
"Hide messages currently being shown if any."
(when eldoc-posframe--timer
        (cancel-timer eldoc-posframe--timer))
(posframe-hide eldoc-posframe-buffer)
(dolist (hook eldoc-posframe-hide-posframe-hooks)
        (remove-hook hook #'eldoc-posframe-hide-posframe t)))
(defun eldoc-posframe-show-posframe (str &rest args)
"Display STR with ARGS."
(when eldoc-posframe--timer
        (cancel-timer eldoc-posframe--timer))
(posframe-hide eldoc-posframe-buffer)
(dolist (hook eldoc-posframe-hide-posframe-hooks)
        (add-hook hook #'eldoc-posframe-hide-posframe nil t))
(setq eldoc-posframe--timer
        (run-with-idle-timer
        eldoc-posframe-delay nil
        (lambda ()
                (when str
                (posframe-show
                eldoc-posframe-buffer
                :string (apply #'format str args)
                :postion (point)
                :poshandler #'posframe-poshandler-point-bottom-left-corner-upward
                :left-fringe 8
                :right-fringe 8
                :internal-border-width 1
                :internal-border-color (face-attribute 'font-lock-comment-face :foreground)
                :background-color (face-background 'tooltip)))))))
(setq eldoc-message-function #'eldoc-posframe-show-posframe)
(use-package! org-noter-plus
  :commands (org-noter-plus--follow-nov-link)
  :config
  (setq org-noter-plus-image-dir (concat org-directory "assets/")) ;; Directory to store images extracted from pdf files
  )

(after! nov
  (org-link-set-parameters "nov"
                           ;; Replace the default nov link to work better with org-noter
                           :follow 'org-noter-plus--follow-nov-link)
  )
(use-package org-noter
  :config
  (require 'org-noter-pdftools)
  (map! :leader :n "i" 'org-noter-insert-note)
  )

(use-package org-pdftools
  :hook (org-mode . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :after org-noter
  :config
  ;; Add a function to ensure precise note is inserted
  (defun org-noter-pdftools-insert-precise-note (&optional toggle-no-questions)
    (interactive "P")
    (org-noter--with-valid-session
     (let ((org-noter-insert-note-no-questions (if toggle-no-questions
                                                   (not org-noter-insert-note-no-questions)
                                                 org-noter-insert-note-no-questions))
           (org-pdftools-use-isearch-link t)
           (org-pdftools-use-freepointer-annot t))
       (org-noter-insert-note (org-noter--get-precise-info)))))

  ;; fix https://github.com/weirdNox/org-noter/pull/93/commits/f8349ae7575e599f375de1be6be2d0d5de4e6cbf
  (defun org-noter-set-start-location (&optional arg)
    "When opening a session with this document, go to the current location.
With a prefix ARG, remove start location."
    (interactive "P")
    (org-noter--with-valid-session
     (let ((inhibit-read-only t)
           (ast (org-noter--parse-root))
           (location (org-noter--doc-approx-location (when (called-interactively-p 'any) 'interactive))))
       (with-current-buffer (org-noter--session-notes-buffer session)
         (org-with-wide-buffer
          (goto-char (org-element-property :begin ast))
          (if arg
              (org-entry-delete nil org-noter-property-note-location)
            (org-entry-put nil org-noter-property-note-location
                           (org-noter--pretty-print-location location))))))))
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))
(use-package! org-media-note
  :init(setq org-media-note-use-org-ref t)
  :hook (org-mode .  org-media-note-mode)
  :bind (
         ("H-v" . org-media-note-hydra/body))  ;; 主功能入口
  :config
  (setq org-media-note-screenshot-image-dir (concat org-directory "pages/image/"))  ;; 用于存储视频截图的目录
  (setq org-media-note-use-refcite-first t)  ;; 插入链接时，优先使用refcite链接
  )
(use-package mpv)
(use-package zotxt)
(use-package fanyi
  :config
  (setq read-extended-command-predicate #'command-completion-default-include-p)
  (set-fontset-font t 'emoji (font-spec :family "Apple Color Emoji") nil 'prepend)
  :custom
  (fanyi-providers '(;; 海词
                     fanyi-haici-provider
                     ;; 有道同义词词典
                     fanyi-youdao-thesaurus-provider
                     ;; Etymonline
                     fanyi-etymon-provider
                     ;; Longman
                     fanyi-longman-provider
                     ;; LibreTranslate
                     fanyi-libre-provider)))
(require 'pyim)
;; (require 'pyim-basedict)
;; (require 'pyim-cregexp-utils)
(global-set-key (kbd "M-f") 'pyim-forward-word)
(global-set-key (kbd "M-b") 'pyim-backward-word)
(setq pyim-page-tooltip 'posframe)

;; 如果使用 popup page tooltip, 就需要加载 popup 包。
;; (require 'popup nil t)
;; (setq pyim-page-tooltip 'popup)

;; 如果使用 pyim-dregcache dcache 后端，就需要加载 pyim-dregcache 包。
;; (require 'pyim-dregcache)
;; (setq pyim-dcache-backend 'pyim-dregcache)


(setq default-input-method "pyim")

;; 显示5个候选词。
(setq pyim-page-length 5)
(setq-default pyim-punctuation-translate-p '(auto))   ;中文使用全角标点，英文使用半角标点。

;; 金手指设置，可以将光标处的编码，比如：拼音字符串，转换为中文。
(global-set-key (kbd "M-i") 'pyim-convert-string-at-point)
;; 按 "C-<return>" 将光标前的 regexp 转换为可以搜索中文的 regexp.
(define-key minibuffer-local-map (kbd "C-<return>") 'pyim-cregexp-convert-at-point)

;; 我使用全拼
(pyim-default-scheme 'quanpin)
(use-package posframe)
(setq-default pyim-english-input-switch-functions
              '(pyim-probe-program-mode pyim-probe-org-structure-template pyim-probe-dynamic-english))
(define-key pyim-mode-map "." 'pyim-page-next-page)
(define-key pyim-mode-map "," 'pyim-page-previous-page)
(pyim-tsinghua-dict-enable)
(setq-default pyim-punctuation-half-width-functions
              '(pyim-probe-punctuation-after-punctuation))
;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

(use-package beancount
  :init
  (add-to-list 'auto-mode-alist '("\\.beancount\\'" . beancount-mode)))
(use-package org-ref)
(org-link-set-parameters "zotero" :follow
                         (lambda (zpath)
                           (browse-url
                            ;; we get the "zotero:"-less url, so we put it back.
                            (format "zotero:%s" zpath))))
(all-the-icons-completion-mode)
(use-package all-the-icons)
(use-package winner
 :init
 (winner-mode +1)
 (define-key winner-mode-map (kbd "<M-k>") #'winner-undo)
 (define-key winner-mode-map (kbd "<s-j>") #'winner-redo))
(setq org-image-actual-width '(400))

; C 语言lsp-mode 设置
(use-package lsp-clangd
  :init
  (setq lsp-clangd-binary-path "/usr/local/opt/llvm/bin/clangd"))
(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("-j=3"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=never"
          "--header-insertion-decorators=0"))
  (set-lsp-priority! 'clangd 2)
  )
(use-package org-excalidraw
  :config
  (setq org-excalidraw-directory (concat org-directory "pages/excalidraw/")))

(after! org
  (custom-set-faces!
    '(outline-1 :weight extra-bold :height 1.4)
    '(outline-2 :weight bold :height 1.15)
    '(outline-3 :weight bold :height 1.12)
    '(outline-4 :weight semi-bold :height 1.09)
    '(outline-5 :weight semi-bold :height 1.06)
    '(outline-6 :weight semi-bold :height 1.03)
    '(outline-8 :weight semi-bold)
    '(outline-9 :weight semi-bold))

  (custom-set-faces!
    '(org-document-title :height 1.2)))
(map! :n "<f3>" #'imenu-list-smart-toggle)

(org-remark-global-tracking-mode +1)

;; Key-bind `org-remark-mark' to global-map so that you can call it
;; globally before the library is loaded.

(define-key global-map (kbd "C-c n m") #'org-remark-mark)

;; The rest of keybidings are done only on loading `org-remark'
(with-eval-after-load 'org-remark
  (define-key org-remark-mode-map (kbd "C-c n o") #'org-remark-open)
  (define-key org-remark-mode-map (kbd "C-c n ]") #'org-remark-view-next)
  (define-key org-remark-mode-map (kbd "C-c n [") #'org-remark-view-prev)
  (define-key org-remark-mode-map (kbd "C-c n r") #'org-remark-remove))


;; (defun firemiles/display-inline-images ()
;;   (interactive)
;;   (condition-case nil
;;       (org-display-inline-images)
;;     (error nil)))

;; (defun firemiles/org-insert-screenshot (fullname)
;;   (interactive "P")
;;   (setq default-name
;;         (concat (file-name-directory (buffer-file-name))
;;                 "imgs/"
;;                 (file-name-base (buffer-file-name))
;;                 "_"
;;                 (format-time-string "%Y%m%d_%H%M%S")
;;                 ".png"))

;;   (setq fullname (read-from-minibuffer "Input image save path: " default-name))
;;   (unless (file-exists-p (file-name-directory fullname))
;;     (make-directory (file-name-directory fullname)))

;;   (call-process "pngpaste" nil nil nil fullname)

;;   (if (not (file-exists-p fullname))
;;       (message "Can't find screenshot in clipboard!")

;;     (insert "#+CAPTION:" (file-name-base fullname) "\n")
;;     (insert "#+ATTR_ORG: :width 300px\n")
;;     (insert (concat "[[file:" fullname "]]"))
;;     (org-display-inline-images)))
;;
(add-hook 'latex-mode-hook #'xenops-mode)
(add-hook 'LaTeX-mode-hook #'xenops-mode)
(use-package jupyter)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (julia . t)
   (python . t)
   (jupyter . t)))
  (setq org-latex-packages-alist
        '(("fontset=STKaiti,UTF8" "ctex" t))) ;;macnew
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-preview-latex-process-alist
        '((dvisvgm :programs
                   ("xelatex" "dvisvgm")
                   :description "xdv > svg" :message "you need to install the programs: xelatex and dvisvgm." :use-xcolor t :image-input-type "xdv" :image-output-type "svg" :image-size-adjust
                   (1.0 . 1.0)
                   :latex-compiler
                   ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
                   :image-converter
                   ("dvisvgm %f -n -b min -c %S -o %O"))
          (imagemagick :programs
                       ("xelatex" "convert")
                       :description "pdf > png" :message "you need to install the programs: xelatex and imagemagick." :use-xcolor t :image-input-type "pdf" :image-output-type "png" :image-size-adjust
                       (1.0 . 1.0)
                       :latex-compiler
                       ("xelatex -interaction nonstopmode -output-directory %o %f")
                       :image-converter
                       ("convert -density %D -trim -antialias %f -quality 100 %O"))))
(use-package org-fragtog
  :after org
  :hook
  (org-mode . org-fragtog-mode))
;; (setq url-proxy-services
;; '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;; ("http" . "http://127.0.0.1:7890")
;; ("https" . "http://127.0.0.1:7890")))

(use-package elfeed-goodies
  :init
  (elfeed-goodies/setup))

(use-package elfeed-org
  :init
  (elfeed-org)
  :config
(setq rmh-elfeed-org-files (list (concat org-roam-directory "20221017215851-elfeed.org"))))


(use-package ox-freemind)

(use-package doom-modeline
  :init
  (setq doom-modeline-icon t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t))
(with-eval-after-load "org"
  (require 'ob-html)
  (org-babel-html-enable-open-src-block-result-temporary))

(use-package org-preview-html
  :init
  (setq org-preview-html-viewer 'eww))

(use-package websocket-bridge)

(use-package org-roam-search
    :after (org-roam)
    ;:custom
    ;(org-roam-search-default-tags '("stub"))
    :bind (:map global-map
          (("C-c n f" . org-roam-search-node-find))
            :map org-mode-map
          (("C-c n i" . org-roam-search-node-insert)))
    )
(add-hook 'org-clock-in-hook (lambda () (call-process "/usr/bin/osascript" nil 0 nil "-e" (concat "tell application \"org-clock-statusbar\" to clock in \"" (replace-regexp-in-string "\"" "\\\\\"" org-clock-current-task) "\""))))
(add-hook 'org-clock-out-hook (lambda () (call-process "/usr/bin/osascript" nil 0 nil "-e" "tell application \"org-clock-statusbar\" to clock out")))
(use-package mixed-pitch
  :hook
  ;; If you want it in all text modes:
  (text-mode . mixed-pitch-mode))
(use-package sort-tab
  :init
  (sort-tab-mode 1)
  :config
(global-set-key (kbd "s-1") 'sort-tab-select-visible-tab)
(global-set-key (kbd "s-2") 'sort-tab-select-visible-tab)
(global-set-key (kbd "s-3") 'sort-tab-select-visible-tab)
(global-set-key (kbd "s-4") 'sort-tab-select-visible-tab)
(global-set-key (kbd "s-5") 'sort-tab-select-visible-tab)
(global-set-key (kbd "s-6") 'sort-tab-select-visible-tab)
(global-set-key (kbd "s-7") 'sort-tab-select-visible-tab)
(global-set-key (kbd "s-8") 'sort-tab-select-visible-tab)
(global-set-key (kbd "s-9") 'sort-tab-select-visible-tab)
(global-set-key (kbd "s-0") 'sort-tab-select-visible-tab)
(global-set-key (kbd "s-Q") 'sort-tab-close-all-tabs)
(global-set-key (kbd "s-q") 'sort-tab-close-mode-tabs)
(global-set-key (kbd "C-;") 'sort-tab-close-current-tab))
(setq org-superstar-headline-bullets-list '("◉" "⁑" "⁂" "❖" "✮" "✱" "✸")
      org-superstar-prettify-item-bullets nil)
(add-hook 'org-mode-hook #'org-superstar-mode)



;; hugo 导出
(use-package easy-hugo
:init
(setq easy-hugo-basedir "~/blog/blog/public/")
(setq easy-hugo-url "https://www.samon6bl.xyz/")
(setq easy-hugo-root "/home/blog/")
(setq easy-hugo-previewtime "300"))
(use-package ox-hugo
  :init
  (setq org-hugo-base-dir "~/blog/blog/")
  (setq org-hugo-section "blog"))


(use-package calfw
  :init
  (require 'calfw-org)
  :config
  (setq cfw:org-overwrite-default-keybinding t))
;; (use-package org-super-agenda
;;   :init
;;   (add-hook 'org-agenda-mode-hook #'org-super-agenda-mode)
;;   :config
;;   (let ((org-agenda-span 'day)
;;       (org-super-agenda-groups
;;        '((:name "Time grid items in all-uppercase with RosyBrown1 foreground"
;;                 :time-grid t
;;                 :transformer (--> it
;;                                   (upcase it)
;;                                   (propertize it 'face '(:foreground "RosyBrown1"))))
;;          (:name "Priority >= C items underlined, on black background"
;;                 :face (:background "black" :underline t)
;;                 :not (:priority>= "C")
;;                 :order 100))))
;;   (org-agenda nil "a")))
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package! svg-tag-mode
  :hook (org-mode . svg-tag-mode)
  :config
  (defun mk/svg-checkbox-empty()
    (let* ((svg (svg-create 14 14)))
      (svg-rectangle svg 0 0 14 14 :fill 'white :rx 2 :stroke-width 2.5 :stroke-color 'black)
      (svg-image svg :ascent 'center)
      ))

  (defun mk/svg-checkbox-filled()
    (let* ((svg (svg-create 14 14)))
      (svg-rectangle svg 0 0 14 14 :fill "#FFFFFF" :rx 2)
      (svg-polygon svg '((5.5 . 11) (12 . 3.5) (11 . 2) (5.5 . 9) (1.5 . 5) (1 . 6.5))
                   :stroke-color 'black :stroke-width 1 :fill 'black)
      (svg-image svg :ascent 'center)
      ))
  (defun mk/svg-checkbox-toggle()
    (interactive)
    (save-excursion
      (let* ((start-pos (line-beginning-position))
             (end-pos (line-end-position))
             (text (buffer-substring-no-properties start-pos end-pos))
             (case-fold-search t)  ; Let X and x be the same in search
             )
        (beginning-of-line)
        (cond ((string-match-p "\\[X\\]" text)
               (progn
                 (re-search-forward "\\[X\\]" end-pos)
                 (replace-match "[ ]")))
              ((string-match-p "\\[ \\]" text)
               (progn
                 (search-forward "[ ]" end-pos)
                 (replace-match "[X]")))
              ))))

  (defun svg-progress-percent (value)
    (svg-image (svg-lib-concat
                (svg-lib-progress-bar (/ (string-to-number value) 100.0)
                                      nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                (svg-lib-tag (concat value "%")
                             nil :stroke 0 :margin 0)) :ascent 'center))

  (defun svg-progress-count (value)
    (let* ((seq (mapcar #'string-to-number (split-string value "/")))
           (count (float (car seq)))
           (total (float (cadr seq))))
      (svg-image (svg-lib-concat
                  (svg-lib-progress-bar (/ count total) nil
                                        :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                  (svg-lib-tag value nil
                               :stroke 0 :margin 0)) :ascent 'center)))

  (defconst date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
  (defconst time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
  (defconst day-re "[A-Za-z]\\{3\\}")
  (defconst day-time-re (format "\\(%s\\)? ?\\(%s\\)?" day-re time-re))

  (setq svg-tag-action-at-point 'edit)

  (setq svg-lib-icon-collections
        `(("bootstrap" .
           "https://icons.getbootstrap.com/assets/icons/%s.svg")
          ("simple" .
           "https://raw.githubusercontent.com/simple-icons/simple-icons/develop/icons/%s.svg")
          ("material" .
           "https://raw.githubusercontent.com/Templarian/MaterialDesign/master/svg/%s.svg")
          ("octicons" .
           "https://raw.githubusercontent.com/primer/octicons/master/icons/%s-24.svg")
          ("boxicons" .
           "https://boxicons.com/static/img/svg/regular/bx-%s.svg")))

  (setq svg-tag-tags
        `(
          ;; Task priority
          ("\\[#[A-Z]\\]" . ( (lambda (tag)
                                (svg-tag-make tag :face 'org-priority
                                              :beg 2 :end -1 :margin 0))))

          ;; Progress
          ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
                                              (svg-progress-percent (substring tag 1 -2)))))
          ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
                                            (svg-progress-count (substring tag 1 -1)))))

          ;; Checkbox
          ("\\[ \\]" . ((lambda (_tag) (mk/svg-checkbox-empty))
                        (lambda () (interactive) (mk/svg-checkbox-toggle))
                        "Click to toggle."
                        ))
          ("\\(\\[[Xx]\\]\\)" . ((lambda (_tag) (mk/svg-checkbox-filled))
                                 (lambda () (interactive) (mk/svg-checkbox-toggle))
                                 "Click to toggle."))

          ;; Active date (with or without day name, with or without time)
          (,(format "\\(<%s>\\)" date-re) .
           ((lambda (tag)
              (svg-tag-make tag :beg 1 :end -1 :margin 0))))
          (,(format "\\(<%s \\)%s>" date-re day-time-re) .
           ((lambda (tag)
              (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0))))
          (,(format "<%s \\(%s>\\)" date-re day-time-re) .
           ((lambda (tag)
              (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0))))

          ;; Inactive date  (with or without day name, with or without time)
          (,(format "\\(\\[%s\\]\\)" date-re) .
           ((lambda (tag)
              (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))
          (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
           ((lambda (tag)
              (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :face 'org-date))))
          (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
           ((lambda (tag)
              (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :face 'org-date))))

          ;; Keywords
          ("TODO" . ((lambda (tag) (svg-tag-make tag :height 0.8 :inverse t
                                                 :face 'org-todo :margin 0 :radius 5))))
          ("WORK" . ((lambda (tag) (svg-tag-make tag :height 0.8
                                                 :face 'org-todo :margin 0 :radius 5))))
          ("DONE" . ((lambda (tag) (svg-tag-make tag :height 0.8 :inverse t
                                                 :face 'org-done :margin 0 :radius 5))))

          ("FIXME\\b" . ((lambda (tag) (svg-tag-make "FIXME" :face 'org-todo :inverse t :margin 0 :crop-right t))))

          ;; beautify pagebreak in orgmode
          ("\\\\pagebreak" . ((lambda (tag) (svg-lib-icon "file-break" nil :collection "bootstrap"
                                                          :stroke 0 :scale 1 :padding 0))))

          )))

(add-hook! org-mode :append
            #'visual-line-mode
            #'+org-pretty-mode  ;; Display UTF-8 symbols instead of plain text. Set org-hide-emphasis-markers t.
            #'variable-pitch-mode
            #'mixed-pitch-mode)  ;; Allow mixed fonts in a buffer, particularly useful for mixing source code and prose blocks in the same document.
(after! org
  (setq mixed-pitch-variable-pitch-cursor nil)
  (setq mixed-pitch-set-height t))

(after! mixed-pitch
  (setq mixed-pitch-set-height t))
(add-hook! mixed-pitch-mode #'solaire-mode-reset)

(setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . "†")
                                        ("#+END_SRC" . "†")
                                        ("#+begin_src" . "†")
                                        ("#+end_src" . "†")
                                        (">=" . "≥")
                                        ("=>" . "⇨")
                                        ("lambda"  . "?λ")
                                        ("#+begin_quote" . "?")
                                        ("#+end_quote" . "?")
                                        ("#+RESULTS:" . "?")))
  (setq prettify-symbols-unprettify-at-point 'right-edge)
  (add-hook 'org-mode-hook 'prettify-symbols-mode)

;; (use-package eaf
;;   :load-path "~/.emacs.d/site-lisp/emacs-application-framework"
;;   :custom
;;   ; See https://github.com/emacs-eaf/emacs-application-framework/wiki/Customization
;;   (eaf-browser-continue-where-left-off t)
;;   (eaf-browser-enable-adblocker t)
;;   (browse-url-browser-function 'eaf-open-browser)
;;   :config
;;   (require 'eaf-demo)
;;   (require 'eaf-pdf-viewer)
;;   (require 'eaf-browser)
;;   (require 'eaf-camera)
;;   (defalias 'browse-web #'eaf-open-browser)
;;   (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
;;   (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
;; (eaf-bind-key take_photo "p" eaf-camera-keybinding)
;;   (eaf-bind-key nil "M-q" eaf-browser-keybinding)) ;; unbind, see more in the Wiki
