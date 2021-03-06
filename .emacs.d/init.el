;; User Details - These should probably be set on a per-host basis
(setq user-full-name "Tom O'Shea")
(setq user-mail-address "teo26@cam.ac.uk")

;;;;
;; Packages
;;;;

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(
    ;; https://github.com/jwiegley/use-package
    use-package

    ;; http://web-mode.org
    ;web-mode
    ;; https://github.com/magnars/tagedit
    ;tagedit
    
    ;; https://github.com/clojure-emacs/clojure-mode
    ;clojure-mode
    ;; extra syntax highlighting for clojure
    ;clojure-mode-extra-font-locking
    ;; https://github.com/clojure-emacs/cider
    ;cider

    ;; Auto-Complete
    ;auto-complete

    ;;
    ;emmet-mode

    ;;
    ;ac-emmet
    
    ;;
    ;php-auto-yasnippets
        
    ;; https://github.com/flycheck/flycheck/
    ;; flycheck
    ;; https://github.com/ejmr/php-mode
    php-mode
    ;; https://github.com/xcwen/ac-php
    ;; ac-php
    ;; https://github.com/nishimaki10/emacs-phpcbf
    ;; phpcbf
    ;; https://github.com/purcell/flymake-php
    ;; flymake-php
    ;; https://blogs.oracle.com/opal/entry/quick_debugging_of_php_scripts (Quick Start)
    ;; geben

    ;; https://github.com/purcell/default-text-scale
    default-text-scale
    
    ;;PHPUnit
    ;phpunit
    
    ;;; Packages that make emacs easier to use in general

    ;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/navigation.el line 23 for a description
    ;; of ido
    ido-ubiquitous

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; git integration
    magit))


;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; Adding this code will make Emacs enter yaml mode whenever you open a .yml file
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;;;
;; Customization
;;;;

;; Store init.el in register i - so we can jump to this file with C-x r j i
(set-register ?i (cons 'file "~/.emacs.d/init.el"))

;; Add a directory to our load paths so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/custom")

;; Loads global functions
(load "global-functions.el")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For editing lisps
(load "elisp-editing.el")

       ;; Web-Mode
       ;;(load "setup-web-mode.el")
       ;; Auto-Complete
       ;;(load "setup-auto-complete.el")
       ;; Flycheck
       ;;(load "setup-flycheck.el")
       ;; AC-PHP
       ;;(load "setup-ac-php.el")
       ;; (load "setup-clojure.el")
       ;; (load "setup-js.el")

;;(autoload 'geben "geben" "DBGp protocol frontend, a script debugger" t)

;; Additional custom config for individual packages
(load "email-conf.el")
(load "org-mode-conf.el")
(load "php-mode-conf.el")
(load "keybindings.el")


;; Debug a simple PHP script.
;; Change the session key my-php-54 to any session key text you like
(defun my-php-debug ()
  "Run current PHP script for debugging with geben"
  (interactive)
  (call-interactively 'geben)
  (shell-command
    (concat "XDEBUG_CONFIG='idekey=my-php-54' /home/cjones/php54/bin/php "
    (buffer-file-name) " &"))
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-phpcs-standard "psr2")
 '(sql-postgres-login-params
   (quote
    ((user :default "damtpdb")
     password server
     (database :default "damptdb")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
