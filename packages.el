;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
(package! valign)
(package! separate-inline
  :recipe (:host github :repo "ingtshan/separate-inline.el"))
(package! org-protocol-capture-html
  :recipe (:host github :repo "alphapapa/org-protocol-capture-html"))
(package! org-super-agenda)
(package! org-fragtog
  :recipe (:host github :repo "io12/org-fragtog"))
(package! svg-tag-mode)
(package! anki-editor
  :recipe (:host github :repo "louietan/anki-editor"))
(package! pandoc)
(package! dirvish)
(package! super-save)
(package! emacs-calfw
  :recipe (:host github :repo "kiwanami/emacs-calfw"))
(package! org-clock-watch
  :recipe (:host github :repo "wztdream/org-clock-watch"))
(package! emacs-ipython-notebook
  :recipe (:host github :repo "millejoh/emacs-ipython-notebook"))
(package! org-gtd.el
  :recipe (:host github :repo "Trevoke/org-gtd.el"))
(package! org-transclusion)
(package! rime)
(package! lsp-treemacs)
(package! shrface)
(package! nov-xwidget
  :recipe (:host github :repo "chenyanming/nov-xwidget"))
(package! org-roam-ui)
(package! elfeed-summary)
(package! calibredb)
(package! vulpea)
(package! org-roam-timestamps)
(package! org-preview-html)
(package! org-modern)
(package! org-modern-indent
  :recipe (:host github :repo "jdtsmith/org-modern-indent"))
(package! mindre-theme)
(package! modus-themes)
(package! separate-inline
  :recipe (:host github :repo "ingtshan/separate-inline.el"))
(package! org-appear)
(package! request)
(package! wallabag :recipe (:host github :repo "chenyanming/wallabag.el" :files ("*.el" "*.alist" "*.css")))
(package! emacsql)
(package! org-notion
  :recipe (:host github :repo "richardwesthaver/org-notion"))
(package! org-ref)
(package! doct)
(package! ivy-bibtex)
(package! easy-hugo)
(package! org-roam-bibtex)
(package! major-mode-hydra)
(package! org-noter-plus :recipe (:host github :repo "yuchen-lea/org-noter-plus"))
(package! org-pdftools)
(package! org-noter-pdftools)
(package! org-media-note :recipe (:host github :repo "yuchen-lea/org-media-note"))
(package! zotxt)
(package! fanyi)
(package! org-mode
  :recipe (:host github
           :repo "yantar92/org"
           :branch "feature/org-fold-universal-core"
           :files ("*.el" "lisp/*.el")
           :pre-build (with-temp-file (expand-file-name "org-version.el" (straight--repos-dir "org"))
                        (insert "(fset 'org-release (lambda () \"9.5\"))\n"
                                "(fset 'org-git-version #'ignore)\n"
                                "(provide 'org-version)\n"))
           :includes (org)))
(package! pyim-tsinghua-dict
  :recipe (:host github :repo "redguardtoo/pyim-tsinghua-dict"))
(package! org-remark)
(package! mct)
