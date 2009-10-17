;; Anton Johansson
;; Time-stamp: "2009-10-17 19:18:27 anton"

;; Load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal"))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/yasnippet"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/color-theme-6.6.0"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/org-mode/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/magit"))

(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/lisp/auto-install/")

;; Modes
(require 'flymake)
(require 'magit)
(require 'anything-config)
(require 'git)
(require 'babel) ;; Translate with eg Google
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$\\|\\.yaml$" . yaml-mode))

;; Personal customizations
;;(require 'slime)
(require 'aj-generic)
(require 'aj-ediff)
(require 'aj-color)
(require 'aj-html)
(require 'aj-latex)
(require 'aj-irc)
(require 'aj-org)
(require 'aj-octave)
(require 'aj-mac)
(require 'aj-c)
(require 'aj-flymake)
(require 'aj-flymake-c)
(require 'aj-flymake-css)
(require 'aj-anything)
(require 'aj-compilation)
(require 'aj-ido)
(require 'aj-term)
;;(requireaj 'my-python)
;; (requiraje 'anything-match-plugin)
;; (set-variable 'anything-mp-highlight-delay nil)
;;(require 'fuzzy-match)

(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)

(load-file "~/.emacs.d/lisp/graphviz-dot-mode.el")

;; JDE ;; CEDET needs to be loaded first
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/jde/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/cedet-1.0pre6/common"))
(require 'aj-cedet)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/elib-1.0"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/ecb-2.40"))
(require 'ecb-autoloads)
(require 'jde)
(require 'aj-java)

;; Javascript
(autoload 'js2-mode "js2" nil t)

;; File assosiation
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Other customizations
(load "/Applications/Emacs.app/Contents/Resources/site-lisp/nxml-mode/rng-auto.el")
(require 'aj-nxml)
;;(load "~/.emacs.d/lisp/nxhtml/autostart.el")

(require 'rst)
(add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))

;; Yasnippet
(require 'yasnippet)
(yas/load-directory "~/.emacs.d/aj-snippets")
(add-to-list 'yas/extra-mode-hooks
             'rst-mode-hook)

(add-to-list 'yas/extra-mode-hooks
             'nxml-mode-hook)

(add-hook 'yas/after-exit-snippet-hook
          '(lambda ()
             (indent-region yas/snippet-beg
                            yas/snippet-end)))
(set-variable 'yas/trigger-key "")
(yas/initialize)

;; Find-file-not-found-hooks
(setq default-major-mode 'org-mode)

(add-hook 'find-file-not-found-hooks
          '(lambda ()
             (if (equal (file-name-extension (buffer-file-name)) "java")
                 (progn
                   (java-mode)
                   (insert-java-template)
                   (message "Inserted java template")))

             (if (equal (file-name-extension (buffer-file-name)) "html")
                 (progn
                   (nxml-mode)
                   (insert-xhtml-template)
                   (message "Inserted xhtml template")))))

(setq custom-file "~/.emacs.d/init-custom.el")
(load custom-file 'noerror)

;; Turn of debug
(setq debug-on-error nil)
;; Start server
(server-start)
(message "loaded init.el")